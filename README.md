## Introduction

_Notes: This is a fork from [thoughtbot/vim-rspec](https://github.com/thoughtbot/vim-rspec)_

Run cucumber features from vim in iTerm2 with shortcuts.

## Installation

Recommended installation with [vundle](https://github.com/gmarik/vundle):

```vim
Plugin 'tam-vo/vim-cucumber'
```

If using zsh on OS X it may be necessary to move `/etc/zshenv` to `/etc/zshrc`.

## Configuration

### Key mappings

Add your preferred key mappings to your `.vimrc` file.

```vim
" Cucumber.vim mappings
map <Leader>ct :call RunCucumberCurrentSpecFile()<CR>
map <Leader>cs :call RunCucumberNearestSpec()<CR>
map <Leader>cl :call RunCucumberLastSpec()<CR>
map <Leader>ca :call RunCucumberAllSpecs()<CR>
```

### Custom command

Overwrite the `g:cucumber_command` variable to execute a custom command.

Example:

```vim
let g:cucumber_command = "!cucumber --drb {spec}"
```

This `g:cucumber_command` variable can be used to support any number of test
runners or pre-loaders. For example, to use
[Dispatch](https://github.com/tpope/vim-dispatch):

```vim
let g:cucumber_command = "Dispatch cucumber {spec}"
```
Or, [Dispatch](https://github.com/tpope/vim-dispatch) and
[Zeus](https://github.com/burke/zeus) together:

```vim
let g:cucumber_command = "compiler cucumber | set makeprg=zeus | Make cucumber {spec}"
```

### Custom runners

Overwrite the `g:cucumber_runner` variable to set a custom launch script. At the
moment there are two MacVim-specific runners, i.e. `os_x_terminal` and
`os_x_iterm`. The default is `os_x_terminal`, but you can set this to anything
you want, provided you include the appropriate script inside the plugin's
`bin/` directory.

#### iTerm instead of Terminal

If you use iTerm, you can set `g:cucumber_runner` to use the included iterm
launching script. This will run the specs in the last session of the current
terminal.

```vim
let g:cucumber_runner = "os_x_iterm"
```

If you use the iTerm2 nightlies, the `os_x_iterm` runner will not work
(due to AppleScript incompatibilities between the old and new versions of iTerm2).

Instead use the `os_x_iterm2` runner, configure it like so:

```vim
let g:cucumber_runner = "os_x_iterm2"
```

## Running tests

Tests are written using [`vim-vspec`](https://github.com/kana/vim-vspec)
and run with [`vim-flavor`](https://github.com/kana/vim-flavor).

Install the `vim-flavor` gem, install the dependencies and run the tests:

```
gem install vim-flavor
vim-flavor install
rake
```

Credits
-------

![thoughtbot](https://thoughtbot.com/logo.png)

cucumber.vim is maintained by [thoughtbot's Vim enthusiasts](https://thoughtbot.com/upcase/vim)
and [contributors](https://github.com/thoughtbot/vim-cucumber/graphs/contributors)
like you. Thank you!

It was strongly influenced by Gary Bernhardt's [Destroy All
Software](https://www.destroyallsoftware.com/screencasts) screencasts.

## License

cucumber.vim is copyright © 2016 thoughtbot. It is free software, and may be
redistributed under the terms specified in the `LICENSE` file.

The names and logos for thoughtbot are trademarks of thoughtbot, inc.
