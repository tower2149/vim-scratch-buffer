function! scratch_buffer#helper#get_all_buffer_names() abort
  return getbufinfo()->map({ _, info -> info.name })
endfunction

function! scratch_buffer#helper#contains(xs, x) abort
  return index(a:xs, a:x) isnot -1
endfunction
