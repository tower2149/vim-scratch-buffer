scriptencoding utf-8
scriptversion 3

" Params:
"   file_ext: {string} a file extension without '.', e.g., 'md', 'ts', or 'sh'
"   (second argument): {'sp' | 'vsp' | undefined} An open method. How to open the new buffer
"   (third argument): {number} A positive number to `:resize buffer_size`
function! scratch_buffer#open(file_ext, ...) abort
  const file_name = s:find_fresh_tmp_file($'{g:scratch_buffer_tmp_file_pattern}.{a:file_ext}')
  if file_name is v:null
    throw 'No fresh scratch file found.'
  endif

  const open_method = get(a:000, 0, 'vsp')
  const buffer_size = get(a:000, 1, v:null)

  execute 'silent' open_method file_name
  setl noswapfile

  if buffer_size !=# v:null
    execute (open_method ==# 'vsp' ? 'vertical' : '') 'resize' buffer_size
  endif
endfunction

function! s:find_fresh_tmp_file(pattern) abort
  const all_buffer_names = scratch_buffer#helper#get_all_buffer_names()

  for i in range(0, 100000)
    let scratch = expand(printf(a:pattern, i))
    if !filereadable(scratch) && !all_buffer_names->scratch_buffer#helper#contains(scratch)
      return scratch
    endif
  endfor
  return v:null
endfunction

" Params:
"   file_ext: {string} same as scratch_buffer#open's file_ext
function! scratch_buffer#clean_all_of(file_ext) abort
  const all_buffer_names = scratch_buffer#helper#get_all_buffer_names()
  const pattern = $'{g:scratch_buffer_tmp_file_pattern}.{a:file_ext}'

  for i in range(0, 100000)
    let scratch = expand(printf(pattern, i))
    let file_exists = filereadable(scratch)
    let buffer_exists = all_buffer_names->scratch_buffer#helper#contains(scratch)

    if !file_exists && !buffer_exists
      return
    endif

    if file_exists
      call delete(scratch)
    endif

    if buffer_exists
      execute ':bwipe' bufnr(scratch)
    endif
  endfor
endfunction
