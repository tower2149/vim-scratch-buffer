scriptencoding utf-8

if exists('g:loaded_scratch_buffer')
  finish
endif
let g:loaded_scratch_buffer = v:true

" Example:
" `:ScratchBufferOpen`
" `:ScratchBufferOpen --no-filetype`
" `:ScratchBufferOpen sh`
" `:ScratchBufferOpen ts vsp`
" `:ScratchBufferOpen md sp 5`
command! -bar -nargs=* ScratchBufferOpen call scratch_buffer#open(<f-args>)

command! -bar -nargs=0 ScratchBufferClean call scratch_buffer#clean()

let g:scratch_buffer_tmp_file_pattern = '/tmp/vim-scratch-buffer-%d'
