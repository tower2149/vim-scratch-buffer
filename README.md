# :sparkles: scratch-buffer.vim :sparkles:

:rocket: **No more hassle with file paths!** The fastest way to open an instant scratch buffer.

## :wrench: Quick Start

```vim
" Open a random file with Markdown filetype
:ScratchBufferOpen md
```

```vim
" Open a small buffer at the top for quick notes
:ScratchBufferOpen md sp 5
```

Of course, you can open other file types too!

```vim
" Open a TypeScript buffer
:ScratchBufferOpen ts
```

## :fire: Why scratch-buffer.vim?

- **Open instantly!** Just run `:ScratchBufferOpen`!
- **No file management!** Perfect for quick notes and testing code snippets.
- **Works anywhere!** Whether in terminal Vim or GUI, it's always at your fingertips.

## :zap: Supercharge with vim-quickrun!

:bulb: **Combine it with [vim-quickrun](https://github.com/thinca/vim-quickrun) to execute code instantly!**

```vim
" Write TypeScript code...
:ScratchBufferOpen ts vsp

" ...and run it immediately!
:QuickRun
```

## :gear: Other Features

```vim
" Delete all scratch files and Markdown buffers that is opened by :ScratchBufferOpen
:ScratchBufferCleanAllOf md
```

:dart: **Try it now and give it a :star: if you like it!** :wink: :sparkles:
