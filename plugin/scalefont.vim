" vim: ff=unix
" scalefont.vim -- Change the font size while maintaining the window geometry
" @Author:      Thomas Link (samul AT web.de)
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     18-Mai-2004.
" @Last Change: 19-Dez-2004.
" @Revision:    1.0.1

if &cp || exists("s:loaded_scalefont")
    finish
endif
let s:loaded_scalefont = 100

if !exists("g:scaleFontSize") || !exists("g:scaleFont")
    echomsg "ScaleFont: Please set g:scaleFontSize and g:scaleFont. Abort loading!"
    finish
endif

if !exists("g:scaleFontWidth")
    let g:scaleFontWidth = g:scaleFontSize
endif

let g:scaleFontSize_Normal  = g:scaleFontSize
let g:scaleFontWidth_Normal = g:scaleFontWidth
let g:scaleFont_Normal      = g:scaleFont
let g:scaleFontLines_Normal = &lines
let g:scaleFontCols_Normal  = &co
" let g:scaleFontWinX_Normal  = getwinposx()
" let g:scaleFontWinY_Normal  = getwinposy()

let g:scaleFontSize_0  = g:scaleFontSize
let g:scaleFontWidth_0 = g:scaleFontWidth
let g:scaleFont_0      = g:scaleFont
let g:scaleFontLines_0 = &lines
let g:scaleFontCols_0  = &co

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

let g:scaleFontSize_small  = g:scaleFontSize  - 2
let g:scaleFontWidth_small = g:scaleFontWidth - 1
let g:scaleFont_small      = g:scaleFont
let g:scaleFontLines_small = 0
let g:scaleFontCols_small  = 0

let g:scaleFontSize_tiny  = g:scaleFontSize  - 4
let g:scaleFontWidth_tiny = g:scaleFontWidth - 3
let g:scaleFont_tiny      = g:scaleFont
let g:scaleFontLines_tiny = 0
let g:scaleFontCols_tiny  = 0


" user defined modes should be indexed in g:scaleFontModes
let s:scaleFontModes = "Normal\nNormalMax\n".
            \ "NormalWide\nNormalWideTop\nNormalNarrow\nNormalNarrowLeft\n".
            \ "big\nbigMax\nlarge\nlargeMax\nLarge\nLargeMax\n".
            \ "small\ntiny"

let s:scaleFontMode        = 0
let s:scaleFontCols        = 0
let s:scaleFontLines       = 0
let s:scaleFontWinHeight   = 0
let s:scaleFontWinWidth    = 0
let s:scaleFontScaledSize  = 0
let s:scaleFontScaledWidth = 0

if !exists("*ScaleFontMaximizeWindow")
    if has("win16") || has("win32")
        fun! ScaleFontMaximizeWindow()
            simalt ~x
        endfun
    else
        fun! ScaleFontMaximizeWindow()
            echom "ScaleFont: Don't know how to maximize windows. Please redefine 'ScaleFontMaximizeWindow()'."
        endfun
    endif
endif

fun! <SID>ScaleFontSetScaledWidthSize(...)
    let s:scaleFontScaledSize  = a:0 >= 1 ? a:1 : g:scaleFontSize * 100
    let s:scaleFontScaledWidth = a:0 >= 2 ? a:2 : g:scaleFontWidth * 100
endfun

fun! ScaleFontSetLinesCols(setIt, lines, cols, ...)
    let s = a:0 >= 1 ? a:1 : g:scaleFontSize
    let w = a:0 >= 2 ? a:2 : g:scaleFontWidth
    let s:scaleFontLines = a:lines * (s + &linespace)
    let s:scaleFontCols  = a:cols  *  w
    if a:setIt
        let &lines = a:lines
        let &co    = a:cols
    endif
endfun

command! -nargs=* ScaleFontSetLinesCols call ScaleFontSetLinesCols(1, <f-args>)

" ScaleFontSetSize(size, width, ?mode="")
fun! ScaleFontSetSize(size, width, ...)
    let mode = a:0 >= 1 ? a:1 : ""

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
        call ScaleFontSetLinesCols(0, &lines, &co)
    endif
    if mode != "" && exists("g:scaleFontWinX_". mode) && exists("g:scaleFontWinY_". mode)
        let winx = g:scaleFontWinX_{mode}
        if match("\n". s:scaleFontModes . "\n", "\n". winx ."\n") >= 0
            if exists("g:scaleFontWinX_".winx)
                let winx = g:scaleFontWinX_{winx}
            else
                let winx = ""
            end
        endif
        let winy = g:scaleFontWinY_{mode}
        if match("\n". s:scaleFontModes . "\n", "\n". winy ."\n") >= 0
            if exists("g:scaleFontWinY_".winy)
                let winy = g:scaleFontWinY_{winy}
            else
                let winy = ""
            end
        endif
        if winx != "" && winy != ""
            exec 'winpos '. winx ." ". winy
        else
            echoerr "ScaleFont: Can't set window position for ". mode .": X=". winx ." Y=". winy
        endif
    endif
endfun

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
endfun

command! ScaleFontBigger  :call ScaleFont(1)
command! ScaleFontSmaller :call ScaleFont(-1)

if !exists("g:scaleFontDontSetOnStartup")
    call ScaleFontSetSize(g:scaleFontSize, g:scaleFontWidth, "Normal")
endif

