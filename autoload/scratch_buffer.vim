scriptencoding utf-8
scriptversion 3

" Params:
" - (first argument) {string | undefined} (Optional)
"     - File extension without '.', e.g., 'md', 'ts', or 'sh'
"     - Or '--no-file-ext' to create a buffer without file extension
"     - If omitted, creates a buffer without file extension
" - (second argument) {'sp' | 'vsp' | undefined} (Optional) An open method. How to open the new buffer
" - (third argument) {number | undefined} (Optional) A positive number to `:resize buffer_size`
function! scratch_buffer#open(...) abort
  const file_ext = get(a:000, 0, '--no-file-ext')
  const file_pattern = (file_ext ==# '--no-file-ext' || file_ext ==# '')
    \ ? $'{g:scratch_buffer_tmp_file_pattern}'
    \ : $'{g:scratch_buffer_tmp_file_pattern}.{file_ext}'

  const file_name = s:find_fresh_tmp_file(file_pattern)
  if file_name is v:null
    throw 'No fresh scratch file found.'
  endif

  const open_method = get(a:000, 1, 'vsp')
  const buffer_size = get(a:000, 2, v:null)

  execute 'silent' open_method file_name
  setlocal noswapfile
  setlocal buftype=nofile
  setlocal bufhidden=hide

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

" Clean up all scratch buffers and files
function! scratch_buffer#clean() abort
  const all_buffer_names = scratch_buffer#helper#get_all_buffer_names()

  const base_pattern = printf(g:scratch_buffer_tmp_file_pattern, '*')
  const files = glob(base_pattern .. '*', 0, 1)
  for scratch in files
    " Delete file if exists
    if filereadable(scratch)
      call delete(scratch)
    endif

    " Delete buffer if exists
    if all_buffer_names->scratch_buffer#helper#contains(scratch)
      execute ':bwipe' bufnr(scratch)
    endif
  endfor
endfunction
