" vim: ff=unix
" scalefont.vim -- Change the font size while maintaining the window geometry
" @Author:      Thomas Link (samul AT web.de)
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     18-Mai-2004.
" @Last Change: 03-Apr-2005.
" @Revision:    1.1.55
" 
" vimscript #1030

if &cp || exists("s:loaded_scalefont")
    finish
endif
let s:loaded_scalefont = 101

if !exists("g:scaleFontSize") || !exists("g:scaleFont")
    echomsg "ScaleFont: Please set g:scaleFontSize and g:scaleFont. Abort loading!"
    finish
endif

if !exists("g:scaleFontWidth")
    let g:scaleFontWidth = g:scaleFontSize
endif

if !exists("g:scaleFontMenuPrefix")
    let g:scaleFontMenuPrefix = "Plugin."
endif

fun! ScaleFontSaveOptions(...)
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

let g:scaleFontSize_0  = g:scaleFontSize
let g:scaleFontWidth_0 = g:scaleFontWidth
let g:scaleFont_0      = g:scaleFont
let g:scaleFontLines_0 = &lines
let g:scaleFontCols_0  = &co
let g:scaleFontWinX_0  = -1
let g:scaleFontWinY_0  = -1
" if !exists("g:scaleFontExec_0") | let g:scaleFontExec_0 = 'set guioptions='. s:scaleFontGuioptions .'| set laststatus='. s:lastStatus | endif
if !exists("g:scaleFontExec_0") | let g:scaleFontExec_0 = ScaleFontSaveOptions('guioptions', 'laststatus') | endif

let g:scaleFontSize_Normal  = g:scaleFontSize
let g:scaleFontWidth_Normal = g:scaleFontWidth
let g:scaleFont_Normal      = g:scaleFont
let g:scaleFontLines_Normal = &lines
let g:scaleFontCols_Normal  = &co
let g:scaleFontWinX_Normal  = 0
let g:scaleFontWinY_Normal  = 0

let g:scaleFontSize_NormalWide  = g:scaleFontSize
let g:scaleFontWidth_NormalWide = g:scaleFontWidth
let g:scaleFont_NormalWide      = g:scaleFont
let g:scaleFontLines_NormalWide = &lines / 2
let g:scaleFontCols_NormalWide  = &co * 2

let g:scaleFontSize_NormalWideTop  = g:scaleFontSize_NormalWide
let g:scaleFontWidth_NormalWideTop = g:scaleFontWidth_NormalWide
let g:scaleFont_NormalWideTop      = g:scaleFont_NormalWide
let g:scaleFontLines_NormalWideTop = g:scaleFontLines_NormalWide
let g:scaleFontCols_NormalWideTop  = g:scaleFontCols_NormalWide
let g:scaleFontWinX_NormalWideTop  = 1
let g:scaleFontWinY_NormalWideTop  = 1

let g:scaleFontSize_NormalNarrow  = g:scaleFontSize
let g:scaleFontWidth_NormalNarrow = g:scaleFontWidth
let g:scaleFont_NormalNarrow      = g:scaleFont
let g:scaleFontLines_NormalNarrow = &lines
let g:scaleFontCols_NormalNarrow  = &co / 2

let g:scaleFontSize_NormalNarrowLeft  = g:scaleFontSize_NormalNarrow
let g:scaleFontWidth_NormalNarrowLeft = g:scaleFontWidth_NormalNarrow
let g:scaleFont_NormalNarrowLeft      = g:scaleFont_NormalNarrow
let g:scaleFontLines_NormalNarrowLeft = g:scaleFontLines_NormalNarrow
let g:scaleFontCols_NormalNarrowLeft  = g:scaleFontCols_NormalNarrow
let g:scaleFontWinX_NormalNarrowLeft  = 1
let g:scaleFontWinY_NormalNarrowLeft  = 1

let g:scaleFontSize_NormalMax  = g:scaleFontSize
let g:scaleFontWidth_NormalMax = g:scaleFontWidth
let g:scaleFont_NormalMax      = g:scaleFont
let g:scaleFontLines_NormalMax = -1
let g:scaleFontCols_NormalMax  = -1

let g:scaleFontSize_NormalFull  = g:scaleFontSize
let g:scaleFontWidth_NormalFull = g:scaleFontWidth
let g:scaleFont_NormalFull      = g:scaleFont
let g:scaleFontLines_NormalFull = -1
let g:scaleFontCols_NormalFull  = -1
let g:scaleFontExec_NormalFull  = 'let &guioptions=substitute(&guioptions, "\\C[mrlbT]", "", "g")|set laststatus=0'

let g:scaleFontSize_big  = g:scaleFontSize  + 2
let g:scaleFontWidth_big = g:scaleFontWidth + 1
let g:scaleFont_big      = g:scaleFont
let g:scaleFontLines_big = 0
let g:scaleFontCols_big  = 0

let g:scaleFontSize_bigMax  = g:scaleFontSize_big
let g:scaleFontWidth_bigMax = g:scaleFontWidth_big
let g:scaleFont_bigMax      = g:scaleFont_big
let g:scaleFontLines_bigMax = -1
let g:scaleFontCols_bigMax  = -1

let g:scaleFontSize_large  = g:scaleFontSize  + 4
let g:scaleFontWidth_large = g:scaleFontWidth + 3
let g:scaleFont_large      = g:scaleFont
let g:scaleFontLines_large = 0
let g:scaleFontCols_large  = 0

let g:scaleFontSize_largeMax  = g:scaleFontSize_large
let g:scaleFontWidth_largeMax = g:scaleFontWidth_large
let g:scaleFont_largeMax      = g:scaleFont_large
let g:scaleFontLines_largeMax = -1
let g:scaleFontCols_largeMax  = -1

let g:scaleFontSize_Large  = g:scaleFontSize  + 6
let g:scaleFontWidth_Large = g:scaleFontWidth + 5
let g:scaleFont_Large      = g:scaleFont
let g:scaleFontLines_Large = 0
let g:scaleFontCols_Large  = 0

let g:scaleFontSize_LargeMax  = g:scaleFontSize_Large
let g:scaleFontWidth_LargeMax = g:scaleFontWidth_Large
let g:scaleFont_LargeMax      = g:scaleFont_Large
let g:scaleFontLines_LargeMax = -1
let g:scaleFontCols_LargeMax  = -1

let g:scaleFontSize_Small  = g:scaleFontSize  - 1
let g:scaleFontWidth_Small = g:scaleFontWidth - 1
let g:scaleFont_Small      = g:scaleFont
let g:scaleFontLines_Small = 0
let g:scaleFontCols_Small  = 0

let g:scaleFontSize_SmallMax  = g:scaleFontSize_Small
let g:scaleFontWidth_SmallMax = g:scaleFontWidth_Small
let g:scaleFont_SmallMax      = g:scaleFont_Small
let g:scaleFontLines_SmallMax = -1
let g:scaleFontCols_SmallMax  = -1

let g:scaleFontSize_small  = g:scaleFontSize  - 2
let g:scaleFontWidth_small = g:scaleFontWidth - 1
let g:scaleFont_small      = g:scaleFont
let g:scaleFontLines_small = 0
let g:scaleFontCols_small  = 0

let g:scaleFontSize_smallMax  = g:scaleFontSize_small
let g:scaleFontWidth_smallMax = g:scaleFontWidth_small
let g:scaleFont_smallMax      = g:scaleFont_small
let g:scaleFontLines_smallMax = -1
let g:scaleFontCols_smallMax  = -1

let g:scaleFontSize_tiny  = g:scaleFontSize  - 4
let g:scaleFontWidth_tiny = g:scaleFontWidth - 3
let g:scaleFont_tiny      = g:scaleFont
let g:scaleFontLines_tiny = 0
let g:scaleFontCols_tiny  = 0

let g:scaleFontSize_tinyMax  = g:scaleFontSize_tiny
let g:scaleFontWidth_tinyMax = g:scaleFontWidth_tiny
let g:scaleFont_tinyMax      = g:scaleFont_tiny
let g:scaleFontLines_tinyMax = -1
let g:scaleFontCols_tinyMax  = -1


" user defined modes should be indexed in g:scaleFontModes
let s:scaleFontModes = "Normal\nNormalMax\nNormalFull\n".
            \ "NormalWide\nNormalWideTop\nNormalNarrow\nNormalNarrowLeft\n".
            \ "big\nbigMax\nlarge\nlargeMax\nLarge\nLargeMax\n".
            \ "Small\nSmallMax\nsmall\nsmallMax\ntiny\ntinyMax"

let s:scaleFontMode        = ""
let s:scaleFontCols        = 0
let s:scaleFontLines       = 0
let s:scaleFontWinHeight   = 0
let s:scaleFontWinWidth    = 0
let s:scaleFontScaledSize  = 0
let s:scaleFontScaledWidth = 0
let s:scaleMenuBuilt       = 0

if !exists("*ScaleFontMaximizeWindow")
    if has("win16") || has("win32") || has("win64")
        fun! ScaleFontMaximizeWindow()
            simalt ~x
        endf
    else
        fun! ScaleFontMaximizeWindow()
            " echom "ScaleFont: Don't know how to maximize windows. Please redefine 'ScaleFontMaximizeWindow()'."
            if exists(":winpos") == 2
                winpos 0 0
            endif
            set lines=99999 columns=99999 
        endf
    endif
endif

fun! <SID>ScaleFontSetScaledWidthSize(...)
    let s:scaleFontScaledSize  = a:0 >= 1 ? a:1 : g:scaleFontSize * 100
    let s:scaleFontScaledWidth = a:0 >= 2 ? a:2 : g:scaleFontWidth * 100
endf

fun! ScaleFontSetLinesCols(setIt, lines, cols, ...)
    let s = a:0 >= 1 ? a:1 : g:scaleFontSize
    let w = a:0 >= 2 ? a:2 : g:scaleFontWidth
    let s:scaleFontLines = a:lines * (s + &linespace)
    let s:scaleFontCols  = a:cols  *  w
    if a:setIt
        let &lines = a:lines
        let &co    = a:cols
    endif
endf

command! -nargs=* ScaleFontSetLinesCols call ScaleFontSetLinesCols(1, <f-args>)

" ScaleFontSetSize(size, width, ?mode="")
fun! ScaleFontSetSize(size, width, ...)
    let mode = a:0 >= 1 ? a:1 : ""

    if s:scaleFontMode == "0" || s:scaleFontMode == "Normal"
        let g:scaleFontWinX_0  = getwinposx()
        let g:scaleFontWinY_0  = getwinposy()
    endif

    let incr = g:scaleFontSize < a:size
    let g:scaleFontSize  = a:size
    let g:scaleFontWidth = a:width
    
    let fnt = mode != "" ? g:scaleFont_{mode} : g:scaleFont
    let fnt = substitute(fnt, '\V#{SIZE}',  g:scaleFontSize,  "g")
    let fnt = substitute(fnt, '\V#{WIDTH}', g:scaleFontWidth, "g")
    
    if s:scaleFontCols == 0
        call ScaleFontSetLinesCols(0, &lines, &co)
    endif
    if mode != ""
        if exists("g:scaleFontExec_". mode)
            exec g:scaleFontExec_{mode}
        else
            exec g:scaleFontExec_0
        endif
        call <SID>ScaleFontSetScaledWidthSize()
    endif

    if mode != "" && exists("g:scaleFontLines_". mode) && exists("g:scaleFontCols_". mode)
        let cols  = g:scaleFontCols_{mode}
        let lines = g:scaleFontLines_{mode}
        if cols == 0 || lines == 0
            call ScaleFontSetLinesCols(0, g:scaleFontLines_0, g:scaleFontCols_0, 
                        \ g:scaleFontSize_0, g:scaleFontWidth_0)
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
    else
        let nco = s:scaleFontCols / g:scaleFontWidth
        let nli = s:scaleFontLines / (g:scaleFontSize + &linespace)
    endif
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
    endif
    if mode != "" 
        let s:scaleFontMode = mode
        call ScaleFontSetLinesCols(0, &lines, &co)
    endif
    if mode != "" && exists("g:scaleFontWinX_". mode) && exists("g:scaleFontWinY_". mode)
        let winx = g:scaleFontWinX_{mode}
        if exists("g:scaleFontWinX_".winx)
            let winx = g:scaleFontWinX_{winx}
        endif
        let winy = g:scaleFontWinY_{mode}
        if exists("g:scaleFontWinY_".winy)
            let winy = g:scaleFontWinY_{winy}
        endif
        if winx != "" && winy != ""
            if winx =~ '^[1-9][0-9]*$' && winy =~ '^[1-9][0-9]*$'
                exec 'winpos '. winx ." ". winy
            endif
        else
            echoerr "ScaleFont: Can't set window position for ". mode .": X=". winx ." Y=". winy
        endif
    endif
endf

fun! ScaleFontCompleteModes(ArgLead, CmdLine, CursorPos)
    if exists("g:scaleFontModes")
        return g:scaleFontModes ."\n". s:scaleFontModes
    else
        return s:scaleFontModes
    endif
endf

command! -nargs=1 -complete=custom,ScaleFontCompleteModes ScaleFontMode 
            \ call ScaleFontSetSize(g:scaleFontSize_{<q-args>}, 
            \ g:scaleFontWidth_{<q-args>}, <q-args>)

command! -nargs=1 -complete=custom,ScaleFontCompleteModes ScaleFont 
            \ call ScaleFontSetSize(g:scaleFontSize_{<q-args>}, 
            \ g:scaleFontWidth_{<q-args>}, <q-args>)

command! ScaleFontInfo echom "Font: ". g:scaleFontWidth ."x". g:scaleFontSize 
            \ .", window: ". &co ."x". &lines

" command! ScaleFontDebugInfo echom "Font: ". g:scaleFontWidth ."x". g:scaleFontSize 
            " \ ." (". s:scaleFontScaledWidth ."x". s:scaleFontScaledSize .")"
            " \ .", window: ". &co ."x". &lines
            " \ ." (". s:scaleFontCols ."x". s:scaleFontLines .")"

fun! ScaleFontBuildMenu()
    if g:scaleFontMenuPrefix != ""
        if s:scaleMenuBuilt
            exec "aunmenu ". g:scaleFontMenuPrefix ."ScaleFont"
        endif
        let i = 0
        let m = ScaleFontCompleteModes("", "", "") . "\n"
        while 1
            let e = matchend(m, '.\{-}\n', i)
            if e == -1
                break
            else
                let t = strpart(m, i, e - i - 1)
                exec "amenu ". g:scaleFontMenuPrefix ."ScaleFont.". t ." :ScaleFontMode ". t ."<cr>"
                let i = e
            end
        endwh
        let s:scaleMenuBuilt = 1
    endif
endf
            
fun! <SID>ScaleFontShift(val)
    let rv = a:val / 100
    let rest = a:val % 100
    if rest > 50
        return rv + 1
    else
        return rv
    end
endf

fun! ScaleFont(delta)
    if s:scaleFontScaledSize == 0 || s:scaleFontScaledWidth == 0
        let nfs = (g:scaleFontSize + a:delta) * 100
        let r   = 100 * g:scaleFontWidth / g:scaleFontSize
        let nfw = (g:scaleFontWidth * 100) + (a:delta * r)
    else
        let nfs = s:scaleFontScaledSize + (a:delta * 100)
        let r   = 100 * s:scaleFontScaledWidth / s:scaleFontScaledSize
        let nfw = s:scaleFontScaledWidth + (a:delta * r)
    endif
    call <SID>ScaleFontSetScaledWidthSize(nfs, nfw)
    let s = <SID>ScaleFontShift(nfs)
    let w = <SID>ScaleFontShift(nfw)
    call ScaleFontSetSize(s, w)
    ScaleFontInfo
endf

command! ScaleFontBigger  :call ScaleFont(1)
command! ScaleFontSmaller :call ScaleFont(-1)

if !exists("g:scaleFontDontSetOnStartup")
    call ScaleFontSetSize(g:scaleFontSize, g:scaleFontWidth, "Normal")
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

