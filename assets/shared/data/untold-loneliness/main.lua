local _t=''
function onCreate()
    makeLuaSprite('Vignette', 'suicideStreet/vignette', 0, 0)
    scaleLuaSprite('Vignette', 1, 1)
    setScrollFactor('Vignette', 1, 1)
    setObjectCamera('Vignette', 'other');
    addLuaSprite('Vignette', false)
    makeLuaSprite('void', '', -300, -300)
    makeGraphic('void', 2200, 2200, '000000')
    setScrollFactor('void', 0, 0)
    addLuaSprite('void', true)
    makeLuaSprite('void2', '', -200, -200)
    makeGraphic('void2', screenWidth * 2, screenHeight * 2, '000000')
    setScrollFactor('void2', 0, 0)
    addLuaSprite('void2', false) -- Changed to true for front layering, though 'other' is already top-level
    setObjectCamera('void2', 'other') 
    setProperty('void.alpha', 0.9)
    setProperty('void2.alpha', 0)
    makeLuaSprite('whitescreen', '', -200, -200)
    makeGraphic('whitescreen', 4000, 4000, 'FFFFFF')
    setProperty('whitescreen.alpha', 0)
    setScrollFactor('whitescreen', 0, 0)
    addLuaSprite('whitescreen', false)
    setProperty('gf.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('showComboNum', false)
    setProperty('showRating', false)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('dad.alpha', 0.8)
    setProperty('boyfriend.alpha', 0.8)
    makeLuaText('text', 'test', 1250, 0, 625)
	setTextAlignment('text', 'Center')
    setTextString('text', '')
	addLuaText('text')
	setTextSize('text', 40)
    setTextFont('vcr')
    setProperty('text.alpha', 0)
end

function onTimerCompleted(tag,l,ll)
    if tag:sub(1,2)=='tw' then local i=tonumber(tag:sub(3)) setTextString('text',_t:sub(1,i)) end
    if tag=='twfade' then doTweenAlpha('texttween','text',_fa,_fd,'sine') end
    if tag == 'twred' then
    doTweenColor('textcolor', 'text', 'FF0000', 0.3, 'sine')
    end
end

function onSectionHit()
    if curSection == 18 then
    setProperty('dad.alpha', 0.9)
    setProperty('boyfriend.alpha', 0.9)
    setProperty('void.alpha', 0.7 )
    end
    if curSection == 36 then
    setProperty('dad.alpha', 1)
    setProperty('boyfriend.alpha', 1)
    setProperty('void.alpha', 0 )
    end
    if curSection == 87 then
    for i = 0, 7 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
    end   
        setProperty('void.alpha', 1)
        setProperty('healthBar.alpha', 0)
        setProperty('healthBarBG.alpha', 0)
        setProperty('iconP1.alpha', 0)
        setProperty('iconP2.alpha', 0)
        setProperty('scoreTxt.alpha', 0)
    end
end

-- (0 = invisible, , 1 = visible)
-- (0 = invisible, , 1 = visible)
-- (0 = invisible, , 1 = visible)


function onStepHit()
if curStep == 498 then
    doTweenAlpha('texttween', 'text', 1, 0.5, 'sine')
    _t = 'Alright, alright'
    _fa = 0      
    _fd = 0.1   
    for i=1,#_t do runTimer('tw'..i, i*0.08, 1) end
    runTimer('twfade', #_t*0.09 + 0.2, 1)
end
if curStep == 519 then
    doTweenAlpha('texttween', 'text', 1, 0.5, 'sine')
    _t = "Let's get this over with."
    _fa = 0      
    _fd = 1   
    for i=1,#_t do runTimer('tw'..i, i*0.06, 1) end
    runTimer('twfade', #_t*0.09 + 0.3, 1)
runTimer('twred', 16*0.06 + 0.3, 1)
end
if curStep == 832 then
for i = 0, 7 do
    setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
end
    setProperty('text.color', getColorFromHex('FFFFFF'))
    setProperty('text.alpha', 1)
    setProperty('healthBar.alpha', 0)
    setProperty('healthBarBG.alpha', 0)
    setProperty('iconP1.alpha', 0)
    setProperty('iconP2.alpha', 0)
    setProperty('scoreTxt.alpha', 0)
    setProperty('void.alpha', 1)
    setTextString('text', 'UN')
end
if curStep == 835 then
    setTextString('text', 'UNTOLD')
end
if curStep == 839 then
    setTextString('text', 'UNTOLD LONE')
end
if curStep == 842 then
    setTextString('text', 'UNTOLD LONELI')
end
if curStep == 844 then
    setTextString('text', 'UNTOLD LONELINESS')
end
if curStep == 848 then
    for i = 0, 7 do
    setPropertyFromGroup('strumLineNotes', i, 'alpha', 1)
end
    setProperty('text.alpha', 0)
    setProperty('healthBar.alpha', 1)
    setProperty('healthBarBG.alpha', 1)
    setProperty('iconP1.alpha', 1)
    setProperty('iconP2.alpha', 1)
    setProperty('scoreTxt.alpha', 1)
    setProperty('void.alpha', 0)
    setTextString('text', '')
end
if curStep == 1391 then
    setProperty('void.alpha', 0)
end
if curStep == 1392 then
    setProperty('boyfriend.color', getColorFromHex('000000'))
    setProperty('dad.color', getColorFromHex('000000'))
    setProperty('whitescreen.alpha', 1)
end
if curStep == 1392 then
        doTweenAlpha('texttween', 'text', 1, 0.5, 'sine')
    _t = "All of us will all"
    _fa = 0      
    _fd = 1   
    for i=1,#_t do runTimer('tw'..i, i*0.07, 1) end
    runTimer('twfade', #_t*0.09 + 111, 1)
end
if curStep == 1416 then
    setTextString('text', 'DIE')
    setProperty('text.color', getColorFromHex('FF0000'))
        setProperty('whitescreen.color', getColorFromHex('770000'))
    doTweenColor('ws', 'whitescreen', getColorFromHex('FFFFFF'), 1.2, 'linear')
end
end