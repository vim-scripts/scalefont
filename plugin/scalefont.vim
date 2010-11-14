" vim: ff=unix
" scalefont.vim -- Change the font size while maintaining the window geometry
" @Author:      Thomas Link (micathom AT gmail com)
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     18-Mai-2004.
" @Last Change: 2008-03-07.
" @Revision:    1.2.230
" 
" GetLatestVimScripts: 1030 1 scalefont.vim

if &cp || exists("loaded_scalefont") || !has("gui_running") "{{{2
    finish
endif
let loaded_scalefont = 102


" Configuration {{{1

if !exists("g:scaleFontSize") || !exists("g:scaleFont") "{{{2
    echomsg "ScaleFont: Please set g:scaleFont, g:scaleFontSize (g:scaleFontWidth) in ~/.vimrc."
    if has("gui_gtk2")
        let g:scaleFont='Luxi\ Mono\ #{SIZE}'
    elseif has("x11")
        " Also for GTK 1
        let g:scaleFont='*-lucidatypewriter-medium-r-normal-*-#{SIZE}-180-*-*-m-*-*'
    elseif has("gui_win32")
        let g:scaleFont='Lucida_Sans_Typewriter:h#{SIZE}:cANSI'
    endif
    let g:scaleFontSize=12
    let g:scaleFontWidth=9
    echomsg 'ScaleFont: Proposed setting: let g:scaleFont='. string(g:scaleFont)
    echomsg 'ScaleFont: Proposed setting: let g:scaleFontSize='. g:scaleFontSize
    echomsg 'ScaleFont: Proposed setting: let g:scaleFontWidth='. g:scaleFontWidth
    echomsg "ScaleFont: Abort loading!"
    finish
endif

if !exists("g:scaleFontWidth") "{{{2
    let g:scaleFontWidth = g:scaleFontSize
endif

if !exists("g:scaleFontMenu") "{{{2
    let g:scaleFontMenu = "Plugin.ScaleFont"
endif

if !exists("g:scaleFontAlwaysResetGuioptions") "{{{2
    let g:scaleFontAlwaysResetGuioptions = 1
endif

fun! ScaleFontSaveOptions(...) "{{{3
    let i = 1
    let acc = ''
    while i <= a:0
        exec 'let name = a:'. i
        exec 'let val  = &'. name
        " exec "let s:". name ."='". val -"'"
        let save = 'let &'. name .'="'. escape(val, '"\') .'"'
        if acc == ''
            let acc = save
        else
            let acc = acc .'|'. save
        endif
        let i = i + 1
    endwh
    return acc
endf

let g:scaleFontConf = {}

function! ScaleFontGet(mode, ...) "{{{3
    let key = a:0 >= 1 ? a:1 : ''
    if key == 'Font' && exists('g:scaleFont_'. a:mode)
        return g:scaleFont_{a:mode}
    elseif exists('g:scaleFont'. key .'_'. a:mode)
        return g:scaleFont{key}_{a:mode}
    elseif has_key(g:scaleFontConf, a:mode)
        let o = g:scaleFontConf[a:mode]
        if empty(key)
            return o
        elseif has_key(o, key)
            return o[key]
        endif
    endif
    return a:0 >= 2 ? a:2 : ''
endf

function! ScaleFontSet(mode, opts) "{{{3
    if has_key(g:scaleFontConf, a:mode)
        call extend(g:scaleFontConf[a:mode], a:opts)
    else
        let g:scaleFontConf[a:mode] = a:opts
    end
endf

let g:scaleFontSize_0  = g:scaleFontSize
let g:scaleFontWidth_0 = g:scaleFontWidth
let g:scaleFont_0      = g:scaleFont
let g:scaleFontLines_0 = &lines
let g:scaleFontCols_0  = &co
let g:scaleFontWinX_0  = -1
let g:scaleFontWinY_0  = -1
" if !exists("g:scaleFontExec_0") | let g:scaleFontExec_0 = 'set guioptions='. s:scaleFontGuioptions .'| set laststatus='. s:lastStatus | endif
if !exists("g:scaleFontExec_0") | let g:scaleFontExec_0 = ScaleFontSaveOptions('guioptions', 'laststatus', 'fdc') | endif "{{{2



" Modes {{{1

call ScaleFontSet('Normal', {
            \ 'Size': g:scaleFontSize,
            \ 'Width': g:scaleFontWidth,
            \ 'Font': g:scaleFont,
            \ 'Lines': &lines,
            \ 'Cols': &co,
            \ 'WinX': 0,
            \ 'WinY': 0,
            \ 'MaintainFrameSize': 1,
            \ })

call ScaleFontSet('NormalWide', copy(ScaleFontGet('Normal')))
call ScaleFontSet('NormalWide', {
            \ 'Lines': &lines / 2,
            \ 'Cols': &co * 2,
            \ })

call ScaleFontSet('NormalWideTop', copy(ScaleFontGet('NormalWide')))
call ScaleFontSet('NormalWide', {
            \ 'WinX': 1,
            \ 'WinY': 1,
            \ })

call ScaleFontSet('NormalNarrow', copy(ScaleFontGet('Normal')))
call ScaleFontSet('NormalNarrow', {
            \ 'Cols': &co / 2,
            \ })

call ScaleFontSet('NormalNarrowLeft', copy(ScaleFontGet('NormalNarrow')))
call ScaleFontSet('NormalNarrowLeft', {
            \ 'WinX': 1,
            \ 'WinY': 1,
            \ })

call ScaleFontSet('NormalMax', copy(ScaleFontGet('Normal')))
call ScaleFontSet('NormalMax', {
            \ 'Lines': -1,
            \ 'Cols': -1,
            \ })

call ScaleFontSet('NormalFull', copy(ScaleFontGet('NormalMax')))
call ScaleFontSet('NormalFull', {
            \ 'Exec': 'let &guioptions=substitute(&guioptions, "\\C[mrlRLbT]", "", "g")|set fdc=0|set laststatus=0',
            \ })

call ScaleFontSet('NormalSingle', copy(ScaleFontGet('NormalMax')))
call ScaleFontSet('NormalSingle', {
            \ 'Exec': 'let &guioptions=substitute(&guioptions, "\\C[rlRLbT]", "", "g")|set fdc=12|set laststatus=0',
            \ })



call ScaleFontSet('big', copy(ScaleFontGet('Normal')))
call ScaleFontSet('big', {
            \ 'Size':  g:scaleFontSize  + 2,
            \ 'Width': g:scaleFontWidth + 1,
            \ 'Lines': 0,
            \ 'Cols':  0,
            \ })

call ScaleFontSet('bigger', copy(ScaleFontGet('big')))
call ScaleFontSet('bigger', {'MaintainFrameSize': 0})

call ScaleFontSet('bigMax', copy(ScaleFontGet('big')))
call ScaleFontSet('bigMax', {
            \ 'Lines': -1,
            \ 'Cols': -1,
            \ })



call ScaleFontSet('large', copy(ScaleFontGet('Normal')))
call ScaleFontSet('large', {
            \ 'Size':  g:scaleFontSize  + 4,
            \ 'Width': g:scaleFontWidth + 3,
            \ 'Lines': 0,
            \ 'Cols':  0,
            \ })

call ScaleFontSet('largeMax', copy(ScaleFontGet('large')))
call ScaleFontSet('largeMax', {
            \ 'Lines': -1,
            \ 'Cols': -1,
            \ })

call ScaleFontSet('largeFull', copy(ScaleFontGet('largeMax')))
call ScaleFontSet('largeFull', {'Exec': ScaleFontGet('NormalFull', 'Exec')})

call ScaleFontSet('largeSingle', copy(ScaleFontGet('largeMax')))
call ScaleFontSet('largeSingle', {'Exec': ScaleFontGet('NormalSingle', 'Exec')})



call ScaleFontSet('Large', copy(ScaleFontGet('Normal')))
call ScaleFontSet('Large', {
            \ 'Size':  g:scaleFontSize  + 6,
            \ 'Width': g:scaleFontWidth + 5,
            \ 'Lines': 0,
            \ 'Cols':  0,
            \ })

call ScaleFontSet('LargeMax', copy(ScaleFontGet('Large')))
call ScaleFontSet('LargeMax', {
            \ 'Lines': -1,
            \ 'Cols': -1,
            \ })

call ScaleFontSet('LargeFull', copy(ScaleFontGet('LargeMax')))
call ScaleFontSet('LargeFull', {'Exec': ScaleFontGet('NormalFull', 'Exec')})



call ScaleFontSet('Small', copy(ScaleFontGet('Normal')))
call ScaleFontSet('Small', {
            \ 'Size':  g:scaleFontSize  - 1,
            \ 'Width': g:scaleFontWidth - 1,
            \ 'Lines': 0,
            \ 'Cols':  0,
            \ })

call ScaleFontSet('SmallMax', copy(ScaleFontGet('Small')))
call ScaleFontSet('SmallMax', {
            \ 'Lines': -1,
            \ 'Cols': -1,
            \ })

call ScaleFontSet('SmallFull', copy(ScaleFontGet('SmallMax')))
call ScaleFontSet('SmallFull', {'Exec': ScaleFontGet('NormalFull', 'Exec')})



call ScaleFontSet('small', copy(ScaleFontGet('Normal')))
call ScaleFontSet('small', {
            \ 'Size':  g:scaleFontSize  - 2,
            \ 'Width': g:scaleFontWidth - 1,
            \ 'Lines': 0,
            \ 'Cols':  0,
            \ })

call ScaleFontSet('smallMax', copy(ScaleFontGet('small')))
call ScaleFontSet('smallMax', {
            \ 'Lines': -1,
            \ 'Cols': -1,
            \ })

call ScaleFontSet('smallFull', copy(ScaleFontGet('smallMax')))
call ScaleFontSet('smallFull', {'Exec': ScaleFontGet('NormalFull', 'Exec')})



call ScaleFontSet('tiny', copy(ScaleFontGet('Normal')))
call ScaleFontSet('tiny', {
            \ 'Size':  g:scaleFontSize  - 4,
            \ 'Width': g:scaleFontWidth - 3,
            \ 'Lines': 0,
            \ 'Cols':  0,
            \ })

call ScaleFontSet('tinyMax', copy(ScaleFontGet('tiny')))
call ScaleFontSet('tinyMax', {
            \ 'Lines': -1,
            \ 'Cols': -1,
            \ })

call ScaleFontSet('tinyFull', copy(ScaleFontGet('tinyMax')))
call ScaleFontSet('tinyFull', {'Exec': ScaleFontGet('NormalFull', 'Exec')})



" Functions {{{1

let s:scaleFontMode        = ""
let s:scaleFontCols        = 0
let s:scaleFontLines       = 0
let s:scaleFontWinHeight   = 0
let s:scaleFontWinWidth    = 0
let s:scaleFontScaledSize  = 0
let s:scaleFontScaledWidth = 0
let s:scaleMenuBuilt       = 0

if !exists("*ScaleFontMaximizeWindow") "{{{2
    if has("win16") || has("win32") || has("win64")
        fun! ScaleFontMaximizeWindow() "{{{3
            simalt ~x
        endf
    else
        " I took the following function from a posting on the vim mailing 
        " list. I think the original poster was AJ Mechelynck though I'm not 
        " sure about this.
        fun! ScaleFontMaximizeWindow() "{{{3
            " echom "ScaleFont: Don't know how to maximize windows. Please redefine 'ScaleFontMaximizeWindow()'."
            if exists(":winpos") == 2
                winpos 0 0
            endif
            set lines=99999 columns=99999 
        endf
    endif
endif

fun! s:ScaleFontSetScaledWidthSize(...) "{{{3
    let s:scaleFontScaledSize  = a:0 >= 1 ? a:1 : g:scaleFontSize * 100
    let s:scaleFontScaledWidth = a:0 >= 2 ? a:2 : g:scaleFontWidth * 100
endf

fun! s:ScaleFontSetLinesCols(setIt, lines, cols, ...) "{{{3
    let s = a:0 >= 1 ? a:1 : g:scaleFontSize
    let w = a:0 >= 2 ? a:2 : g:scaleFontWidth
    let s:scaleFontLines = a:lines * (s + &linespace)
    let s:scaleFontCols  = a:cols  *  w
    if a:setIt
        let &lines = a:lines
        let &co    = a:cols
    endif
endf

" s:ScaleFontSetSize(mode, ?size, ?width)
fun! s:ScaleFontSetSize(mode, ...) "{{{3
    if a:mode == ''
        let size  = a:1
        let width = a:2
        let mfs   = 1
    else
        let size  = ScaleFontGet(a:mode, 'Size')
        let width = ScaleFontGet(a:mode, 'Width')
        let mfs   = ScaleFontGet(a:mode, 'MaintainFrameSize')
    endif

    if s:scaleFontMode == '0' || s:scaleFontMode == 'Normal'
        let g:scaleFontWinX_0  = getwinposx()
        let g:scaleFontWinY_0  = getwinposy()
    endif

    let incr = g:scaleFontSize < size
    let g:scaleFontSize  = size
    let g:scaleFontWidth = width
    
    let fnt = a:mode != '' ? ScaleFontGet(a:mode, 'Font') : g:scaleFont
    let fnt = substitute(fnt, '\V#{SIZE}',  g:scaleFontSize,  'g')
    let fnt = substitute(fnt, '\V#{WIDTH}', g:scaleFontWidth, 'g')
    
    if s:scaleFontCols == 0
        call s:ScaleFontSetLinesCols(0, &lines, &co)
    endif
    if a:mode != ''
        let evalexec = ScaleFontGet(a:mode, 'Exec')
        " TLogVAR evalexec
        if g:scaleFontAlwaysResetGuioptions || empty(evalexec)
            call s:BufExec(ScaleFontGet(0, 'Exec'))
        endif
        if !empty(evalexec)
            call s:BufExec(evalexec)
        endif
        if mfs
            call s:ScaleFontSetScaledWidthSize()
        endif
    endif

    let cols  = ScaleFontGet(a:mode, 'Cols')
    let lines = ScaleFontGet(a:mode, 'Lines')
    " TLogVAR cols, lines
    if a:mode != '' && cols && lines
        " TLogVAR &guifont
        if cols == 0 || lines == 0
            call s:ScaleFontSetLinesCols(0,
                        \ ScaleFontGet(0, 'Lines'),
                        \ ScaleFontGet(0, 'Cols'),
                        \ ScaleFontGet(0, 'Size'),
                        \ ScaleFontGet(0, 'Width'))
            let nco = s:scaleFontCols / g:scaleFontWidth
            let nli = s:scaleFontLines / (g:scaleFontSize + &linespace)
        elseif cols == -1 || lines == -1
            let &guifont=fnt
            call ScaleFontMaximizeWindow()
            let nco=0
        else
            let nco=cols
            let nli=lines
        endif
    elseif mfs
        let nco = s:scaleFontCols / g:scaleFontWidth
        let nli = s:scaleFontLines / (g:scaleFontSize + &linespace)
    else
        let nco = 0
    endif
    " TLogVAR nco, nli, fnt
    if nco > 0
        if incr
            let &co=nco
            let &lines=nli
            let &guifont=fnt
        else
            let &guifont=fnt
            let &co=nco
            let &lines=nli
        endif
    elseif !mfs
        let &guifont=fnt
    endif

    if a:mode != ''
        let s:scaleFontMode = a:mode
        call s:ScaleFontSetLinesCols(0, &lines, &co)

        let winx = ScaleFontGet(a:mode, 'WinX')
        let winy = ScaleFontGet(a:mode, 'WinY')
        " TLogVAR winx, winy
        if winx && winy
            let winx = ScaleFontGet(winx, 'WinX', winx)
            let winy = ScaleFontGet(winy, 'WinY', winy)
            " TLogVAR winx, winy
            if winx =~ '^[1-9][0-9]*$' && winy =~ '^[1-9][0-9]*$'
                exec 'winpos '. winx ." ". winy
            elseif winx != -1 && winy != -1
                " echoerr "ScaleFont: Bad mode definition: ". a:mode ." winx=". winx ." winy=". winy
                echoerr "ScaleFont: Can't set window position for ". a:mode .": X=". winx ." Y=". winy
            endif
        endif
    endif
endf

function! s:BufExec(exec) "{{{3
    let bn = bufnr('%')
    " TLogVAR bn, a:exec
    exec 'bufdo '. a:exec
    exec 'buffer! '. bn
endf

fun! s:ScaleFontCompleteModes(ArgLead, CmdLine, CursorPos) "{{{3
    let modes = join(keys(g:scaleFontConf), "\n")
    if exists("g:scaleFontModes")
        return g:scaleFontModes ."\n". modes
    else
        return modes
    endif
endf

fun! ScaleFontBuildMenu() "{{{3
    if g:scaleFontMenu != ''
        if s:scaleMenuBuilt
            exec 'aunmenu '. g:scaleFontMenu
        endif
        for t in sort(split(s:ScaleFontCompleteModes('', '', ''), '\n'))
            exec 'amenu '. g:scaleFontMenu .'.'. t .' :ScaleFontMode '. t .'<cr>'
        endfor
        let s:scaleMenuBuilt = 1
    endif
endf
            
fun! s:ScaleFontShift(val) "{{{3
    let rv = a:val / 100
    let rest = a:val % 100
    if rest > 50
        return rv + 1
    else
        return rv
    end
endf

fun! s:ScaleFont(delta) "{{{3
    if s:scaleFontScaledSize == 0 || s:scaleFontScaledWidth == 0
        let nfs = (g:scaleFontSize + a:delta) * 100
        let r   = 100 * g:scaleFontWidth / g:scaleFontSize
        let nfw = (g:scaleFontWidth * 100) + (a:delta * r)
    else
        let nfs = s:scaleFontScaledSize + (a:delta * 100)
        let r   = 100 * s:scaleFontScaledWidth / s:scaleFontScaledSize
        let nfw = s:scaleFontScaledWidth + (a:delta * r)
    endif
    call s:ScaleFontSetScaledWidthSize(nfs, nfw)
    let s = s:ScaleFontShift(nfs)
    let w = s:ScaleFontShift(nfw)
    call s:ScaleFontSetSize('', s, w)
    ScaleFontInfo
endf



" Commands {{{1

command! -nargs=* ScaleFontSetLinesCols call s:ScaleFontSetLinesCols(1, <f-args>)

command! -nargs=1 -complete=custom,s:ScaleFontCompleteModes ScaleFontMode 
            \ call s:ScaleFontSetSize(<q-args>)

command! -nargs=1 -complete=custom,s:ScaleFontCompleteModes ScaleFont 
            \ call s:ScaleFontSetSize(<q-args>)

command! ScaleFontInfo echom "Font: ". g:scaleFontWidth ."x". g:scaleFontSize 
            \ .", window: ". &co ."x". &lines

command! ScaleFontBigger  :call s:ScaleFont(1)
command! ScaleFontSmaller :call s:ScaleFont(-1)



" Initialization {{{1

if !exists("g:scaleFontDontSetOnStartup") "{{{2
    call s:ScaleFontSetSize("Normal")
endif

call ScaleFontBuildMenu()



finish "{{{1
_______________________________________________________________________

* Change History

0.1 :: Initial release

0.2 :: Take care of whether the font size is increased or decreased; command 
line completion for ScaleFontMode; ability to define the desired lines and 
cols parameters per mode (if one of these variables is -1, the window will be 
maximized; on non-Windows systems you have to define ScaleFontMaximizeWindow() 
first); new standard modes "largeMax" and 
"LargeMax" (maximize the window)

1.0 :: New standard modes: NormalMax, NormalNarrowLeft, NormalWideTop, bigMax; 
:ScaleFont as an alias to :ScaleFontMode; we can now set the window/frame 
position too (e.g.  NormalNarrowLeft and NormalWideTop); removed mode "0" from 
the mode list

1.1 :: New variable g:scaleFontExec_{MODE}, the content of which will be 
executed before reconfiguring the window geometry. This can be used to set 
guioptions as needed (e.g., for a full screen mode without menu bar and all as 
for NormalFull). If this variable isn't set, the variable g:scaleFontExec_0 
will be executed that resets the guioptions to its initial value.  
ScaleFontMaximizeWindow() is defined for OS other than Windows too (kind of). 
Build modes menu (see g:scaleFontMenuPrefix).

1.2
- On mode changes, always evaluate g:scaleFontExec__0 unless 
g:scaleFontAlwaysResetGuioptions is 0.

1.3
- Error when switching back to Normal.
- Partial rewrite for vim7.0
- Default configuration is now done with a dictionary.
- g:scaleFontMenuPrefix was replaced with g:scaleFontMenu
- Load only in gui
- s:ScaleFontSetSize(mode, ...): Arguments have changed

