let s:plugin_path = expand("<sfile>:p:h:h")
let s:default_command = "bundle exec cucumber {spec}"
let s:force_gui = 0

if !exists("g:cucumber_runner")
  let g:cucumber_runner = "os_x_terminal"
endif

function! RunCucumberAllSpecs()
  let s:last_spec = ""
  call s:RunCucumberSpecs(s:last_spec)
endfunction

function! RunCucumberCurrentSpecFile()
  if s:InSpecFile()
    let s:last_spec_file = s:CurrentFilePath()
    let s:last_spec = s:last_spec_file
    call s:RunCucumberSpecs(s:last_spec_file)
  elseif exists("s:last_spec_file")
    call s:RunCucumberSpecs(s:last_spec_file)
  endif
endfunction

function! RunCucumberNearestSpec()
  if s:InSpecFile()
    let s:last_spec_file = s:CurrentFilePath()
    let s:last_spec_file_with_line = s:last_spec_file . ":" . line(".")
    let s:last_spec = s:last_spec_file_with_line
    call s:RunCucumberSpecs(s:last_spec_file_with_line)
  elseif exists("s:last_spec_file_with_line")
    call s:RunCucumberSpecs(s:last_spec_file_with_line)
  endif
endfunction

function! RunCucumberLastSpec()
  if exists("s:last_spec")
    call s:RunCucumberSpecs(s:last_spec)
  endif
endfunction

" === local functions ===

function! s:RunCucumberSpecs(spec_location)
  let s:cucumber_command = substitute(s:CucumberCommand(), "{spec}", a:spec_location, "g")

  execute s:cucumber_command
endfunction

function! s:InSpecFile()
  return (match(expand("%"), ".feature$") != -1)
endfunction

function! s:CucumberCommand()
  if s:CucumberCommandProvided() && s:IsMacGui()
    let l:command = s:GuiCommand(g:cucumber_command)
  elseif s:CucumberCommandProvided()
    let l:command = g:cucumber_command
  elseif s:IsMacGui()
    let l:command = s:GuiCommand(s:default_command)
  else
    let l:command = s:DefaultTerminalCommand()
  endif

  return l:command
endfunction

function! s:CucumberCommandProvided()
  return exists("g:cucumber_command")
endfunction

function! s:DefaultTerminalCommand()
  return "!" . s:ClearCommand() . " && echo " . s:default_command . " && " . s:default_command
endfunction

function! s:CurrentFilePath()
  return @%
endfunction

function! s:GuiCommand(command)
  return "silent ! '" . s:plugin_path . "/bin/" . g:cucumber_runner . "' '" . a:command . "'"
endfunction

function! s:ClearCommand()
  if s:IsWindows()
    return "cls"
  else
    return "clear"
  endif
endfunction

function! s:IsMacGui()
  return s:force_gui || (has("gui_running") && has("gui_macvim"))
endfunction

function! s:IsWindows()
  return has("win32") && fnamemodify(&shell, ':t') ==? "cmd.exe"
endfunction

" begin vspec config
function! vim_cucumber#scope()
  return s:
endfunction

function! vim_cucumber#sid()
    return maparg('<SID>', 'n')
endfunction
nnoremap <SID> <SID>
" end vspec config
