const s:suite = themis#suite('scratch_buffer')
const s:expect = themis#helper('expect')

function! s:suite.before() abort
  let g:scratch_buffer_tmp_file_pattern = '/tmp/scratch-%d'
endfunction

function! s:suite.before_each() abort
  " Clean all created scratch files
  for i in range(0, 100000)
    let file = printf(g:scratch_buffer_tmp_file_pattern, i)
    if !filereadable(expand(file))
      return
    endif
    call delete(file)
  endfor
endfunction

function! s:suite.can_make_buffer() abort
  ScratchBufferOpen md

  const current_file_name = expand('%:p')
  const expected = printf(g:scratch_buffer_tmp_file_pattern, 0)
  call s:expect(current_file_name).to_equal(expected)
endfunction

function! s:suite.can_make_multiple_buffer() abort
  ScratchBufferOpen md
  ScratchBufferOpen md
  ScratchBufferOpen md

  const current_file_name = expand('%:p')
  const expected = printf(g:scratch_buffer_tmp_file_pattern, 3)
  call s:expect(current_file_name).to_equal(expected)
endfunction

function! s:suite.accept_open_method() abort
  ScratchBufferOpen md sp
  ScratchBufferOpen md vsp
endfunction

function! s:suite.accept_buffer_size() abort
  ScratchBufferOpen md sp 5
  ScratchBufferOpen md vsp 50
endfunction
