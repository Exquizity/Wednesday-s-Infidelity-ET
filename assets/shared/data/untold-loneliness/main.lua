local _t=''
local bounceonbeat = false
local flValue1 = 0.065
local flValue2 = 0.08
local maxzoom = 0.8
local defpos = {}
function onCreate()
    makeLuaSprite('Vignette', 'suicideStreet/vignette', 0, 0)
    scaleLuaSprite('Vignette', 1, 1)
    setScrollFactor('Vignette', 1, 1)
    setObjectCamera('Vignette', 'other')
    addLuaSprite('Vignette', true)

    makeLuaSprite('VignetteExpanded', 'suicideStreet/vignetteExpanded', 0, 0)
    scaleLuaSprite('VignetteExpanded', 1, 1)
    setScrollFactor('VignetteExpanded', 1, 1)
    setObjectCamera('VignetteExpanded', 'other')
    addLuaSprite('VignetteExpanded', true)
    setProperty('VignetteExpanded.alpha', 0)

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
    makeLuaSprite('whitescreen', '', -250, -250)
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


local function attemptCameraShake(camera, intensity, duration)
    if type(cameraShake) == "function" then
        local success, _ = pcall(cameraShake, camera, intensity, duration)
        return success
    end
    return false
end



local function performPixelShake(offsetX, offsetY, duration)
    if type(cancelTween) == "function" then
        pcall(cancelTween, 'shake_hud_x_out')
        pcall(cancelTween, 'shake_hud_y_out')
        pcall(cancelTween, 'shake_game_x_out')
        pcall(cancelTween, 'shake_game_y_out')
        pcall(cancelTween, 'shake_hud_x_in')
        pcall(cancelTween, 'shake_hud_y_in')
        pcall(cancelTween, 'shake_game_x_in')
        pcall(cancelTween, 'shake_game_y_in')
    end

    local randomX = (math.random() * 2 - 1) * offsetX
    local randomY = (math.random() * 2 - 1) * offsetY

    local halfDuration = duration / 2

    pcall(function() doTweenX('shake_hud_x_out', 'camHUD', baseHudPositionX + randomX, halfDuration, 'quadInOut') end)
    pcall(function() doTweenY('shake_hud_y_out', 'camHUD', baseHudPositionY + randomY, halfDuration, 'quadInOut') end)
    pcall(function() doTweenX('shake_game_x_out', 'camGame', baseGamePositionX + randomX, halfDuration, 'quadInOut') end)
    pcall(function() doTweenY('shake_game_y_out', 'camGame', baseGamePositionY + randomY, halfDuration, 'quadInOut') end)

    if type(runTimer) == "function" then
        pcall(runTimer, 'shake_return', halfDuration)
    end
end

local function shakeCameras(pixelOffsetX, pixelOffsetY, duration)
    pixelOffsetX = pixelOffsetX or 0.7
    pixelOffsetY = pixelOffsetY or 0.7
    duration = duration or 0.1

    local successHudShake = attemptCameraShake('camHUD', math.max(pixelOffsetX, pixelOffsetY) / 100, duration)
    local successGameShake = attemptCameraShake('camGame', math.max(pixelOffsetX, pixelOffsetY) / 100, duration)
    if successHudShake and successGameShake then return end

    performPixelShake(pixelOffsetX, pixelOffsetY, duration)
end

function onSectionHit()
    if curSection == 18 then
    setProperty('dad.alpha', 0.9)
    setProperty('boyfriend.alpha', 0.9)
    setProperty('void.alpha', 0.7 )
    for i = 0, 7 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 0.85)
    end
    end
    if curSection == 36 then
    setProperty('dad.alpha', 1)
    setProperty('boyfriend.alpha', 1)
    setProperty('void.alpha', 0 )
    for i = 0, 7 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
    end
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
    if curSection == 103 then
        setProperty('dad.color', getColorFromHex('000000'))
    end
    if curSection == 104 then
        setProperty('dad.animation.curAnim.curFrame', 60)
        for i = 0, 3 do
            noteTweenAlpha('oppFade'..i, i, 1, 1.2, 'linear')
        end
    end
    if curSection == 105 then
        setProperty('dad.color', getColorFromHex('000000'))
    end
    if curSection == 107 then
        bounceonbeat = true
        setProperty('healthBar.alpha', 1)
        setProperty('healthBarBG.alpha', 1)
        setProperty('iconP1.alpha', 1)
        setProperty('iconP2.alpha', 1)
        setProperty('scoreTxt.alpha', 1)
        setProperty('whitescreen.alpha', 0)
        setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
        setProperty('dad.color', getColorFromHex('FFFFFF'))
    end
    if curSection == 153 then
    for i = 0, 7 do
        noteTweenAlpha('notes'..i, i, 1.2, 0, 'linear')
    end
    end
    if curSection == 154 then
        bounceonbeat = false
        setProperty('void.alpha', 1)
        setProperty('healthBar.alpha', 0)
        setProperty('healthBarBG.alpha', 0)
        setProperty('iconP1.alpha', 0)
        setProperty('iconP2.alpha', 0)
        doTweenAlpha('vignettetw', 'Vignette', 0, 1.2, 'linear')
        doTweenAlpha('vignetteexpandtw', 'VignetteExpanded', 1, 1.2, 'linear')
        setProperty('dark.alpha', 1)
    end
    if curSection == 155 then
        
        setProperty('void.alpha', 0)
    for i = 0, 7 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 1)
    end   
    end
    if curSection == 162 then
        for i = 0,7 do
            local x = getPropertyFromGroup('strumLineNotes', i, 'x')
            local y = getPropertyFromGroup('strumLineNotes', i, 'y')

            table.insert(defpos, {x, y})
        end
        setProperty('healthBar.alpha', 1)
        setProperty('healthBarBG.alpha', 1)
        setProperty('iconP1.alpha', 1)
        setProperty('iconP2.alpha', 1)
        setProperty('scoreTxt.alpha', 1)
        setProperty('void.alpha', 1)
        doTweenAlpha('vignettetw', 'Vignette', 1, 1.2, 'linear')
        doTweenAlpha('vignetteexpandtw', 'VignetteExpanded', 0, 1.2, 'linear')
    for i = 0, 7 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
    end   
    end
    if curSection == 163 then
        bounceonbeat = true
        setProperty('void.alpha', 0)
    for i = 0, 7 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 1)
    end   
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
    bounceonbeat = true
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
if curStep == 1120 then
    bounceonbeat = false
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
    setTextString('text', 'DIE.')
    setProperty('text.color', getColorFromHex('FF0000'))
        setProperty('whitescreen.color', getColorFromHex('770000'))
    doTweenColor('ws', 'whitescreen', getColorFromHex('FFFFFF'), 1.2, 'linear')
end
if curStep == 1424 then
        setProperty('text.color', getColorFromHex('FFFFFF'))
    _t = "None of us is worth a try"
    _fa = 0      
    _fd = 1   
    for i=1,#_t do runTimer('tw'..i, i*0.064, 1) end
    runTimer('twfade', #_t*0.1 + 111, 1)
end
if curStep == 1446 then
    setProperty('whitescreen.color', getColorFromHex('770000'))
    doTweenColor('ws', 'whitescreen', getColorFromHex('FFFFFF'), 1.2, 'linear')
end
if curStep == 1456 then
    _t = "Guiding me where the life does end"
    _fa = 0      
    _fd = 1   
    for i=1,#_t do runTimer('tw'..i, i*0.053, 1) end
    runTimer('twfade', #_t*0.09 + 111, 1)
end
if curStep == 1486 then
        setProperty('text.color', getColorFromHex('FF0000'))
    _t = "THE LOOP OF SUFFERING DOES NEVER END."
    _fa = 0      
    _fd = 1   
    for i=1,#_t do runTimer('tw'..i, i*0.05, 1) end
    runTimer('twfade', #_t*0.09 + 0.5, 4)
end
if curStep == 1495 then
    setProperty('whitescreen.color', getColorFromHex('770000'))
    doTweenColor('ws', 'whitescreen', getColorFromHex('FFFFFF'), 1.2, 'linear')
end
if curStep == 1506 then
for i = 4, 7 do
    noteTweenAlpha('plrFade'..i, i, 1, 1, 'linear')
end
end
if curStep == 1520 then
    doTweenColor('ws', 'whitescreen', '770000', 7, 'linear')
end
if curStep == 1639 then
    setProperty('text.alpha', 1)
    _t = "FUCK"
    _fa = 0      
    _fd = 1   
    for i=1,#_t do runTimer('tw'..i, i*0.07, 1) end
    runTimer('twfade', #_t*0.09 + 0.01, 1)
end
if curStep == 1648 then
    setProperty('dad.color', getColorFromHex('000000'))
end
if curStep >= 1904 and curStep <= 1920 then
    if curStep % 3 == 0 then
        setProperty('void2.alpha', 1)
    else
        setProperty('void2.alpha', 0)
    end
elseif curStep == 1921 then
    setProperty('void2.alpha', 0)
end
if curStep == 1910 then
    setProperty('dad.danceEveryNumBeats', 9999)
    setProperty('dad.animation.curAnim.paused', true)
end
if curStep == 2432 then
    for i = 0, 7 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
    end
end
if curStep == 2437 then
    for i = 0, 7 do
        noteTweenAlpha('notes'..i, i, 1, 0.6, 'linear')
    end
end
if curStep == 3104 then
    bounceonbeat = false
    setProperty('dark.alpha', 0)
    setProperty('void.alpha', 1)  
    setProperty('text.color', getColorFromHex('FFFFFF'))
    doTweenAlpha('healthBarFade', 'healthBar', 0, 3, 'linear')
    doTweenAlpha('healthBarBGFade', 'healthBarBG', 0, 3, 'linear')
    doTweenAlpha('iconP1Fade', 'iconP1', 0, 3, 'linear')
    doTweenAlpha('iconP2Fade', 'iconP2', 0, 3, 'linear')
    doTweenAlpha('scoreTxtFade', 'scoreTxt', 0, 3, 'linear')
for i = 0, 7 do
    noteTweenAlpha('notes'..i, i, 0, 3, 'linear')
end
end
if curStep == 3124 then
doTweenAlpha('texttween', 'text', 1, 0.5, 'sine')
    _t = "And?"
    _fa = 0      
    _fd = 1   
    for i=1,#_t do runTimer('tw'..i, i*0.07, 1) end
runTimer('twfade', #_t*0.09 + 111, 1)
end
if curStep == 3144 then
    _t = "Was it worth it?"
    _fa = 0      
    _fd = 1   
    for i=1,#_t do runTimer('tw'..i, i*0.05, 1) end
runTimer('twfade', #_t*0.09 + 111, 1)
end
if curStep == 3169 then
    _t = "Did you expect any good ending you pathetic boy?"
    _fa = 0      
    _fd = 1   
    for i=1,#_t do runTimer('tw'..i, i*0.055, 1) end
runTimer('twfade', #_t*0.09 + 111, 1)
end
if curStep == 3250 then
    _t = "There is no place for me in this world"
    _fa = 0      
    _fd = 0.8 
    for i=1,#_t do runTimer('tw'..i, i*0.053, 1) end
    runTimer('twfade', #_t*0.09 + 0.2, 1)
end
if curStep == 3326 then
    setTextString('text', '')
    setProperty('text.color', getColorFromHex('FF6666'))
    setProperty('text.alpha', 1)
    _t = "Let"
    _fa = 0      
    _fd = 1   
    for i=1,#_t do runTimer('tw'..i, i*0.2, 1) end
    runTimer('twfade', #_t*0.09 + 111, 1)
end
if curStep == 3342 then
    setTextString('text', '')
    setProperty('text.color', getColorFromHex('FF2222'))
    _t = "Me"
    _fa = 0      
    _fd = 1   
    for i=1,#_t do runTimer('tw'..i, i*0.16, 1) end
    runTimer('twfade', #_t*0.09 + 111, 1)
end
if curStep == 3358 then
    setTextString('text', '')
    setProperty('text.color', getColorFromHex('FF0000'))
    _t = "Leave."
    _fa = 0      
    _fd = 2   
    for i=1,#_t do runTimer('tw'..i, i*0.08, 1) end
    runTimer('twfade', #_t*0.09 + 0.1, 2)
end
end -- closes onStepHit

function onBeatHit()
    if bounceonbeat == true then
        local gameZoom = getProperty('camGame.zoom')
        local hudZoom = getProperty('camHUD.zoom')
        if gameZoom < maxzoom then
            gameZoom = gameZoom + flValue1
            if gameZoom > maxzoom then gameZoom = maxzoom end
            setProperty('camGame.zoom', gameZoom)
        end
        if hudZoom ~= nil then
            setProperty('camHUD.zoom', hudZoom + flValue2)
        end
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if getProperty('dad.curCharacter') == 'oswaldDejection' then
        if getProperty('health') > 0.25 then
            setProperty('health', getProperty('health') - 0.013)
        end
    end

    if getProperty('dad.curCharacter') == 'oswaldUL' then
        if getProperty('health') > 0.3 then
            setProperty('health', getProperty('health') - 0.015)
        end
        shakeCameras(0.12, 0.122, 0.1)
    end

    if getProperty('dad.curCharacter') == 'OswaldUL2' then
        if getProperty('health') > 0.25 then
            setProperty('health', getProperty('health') - 0.005)
        end
        shakeCameras(0.5, 0.5, 0.1)
    end
end


function onUpdate(elapsed)
    if curSection > 162 then
        local songPos = getSongPosition()
        local curbeat = (songPos / 1000) * (bpm / 60) / 4

        if #defpos == 8 then
            for i = 0, 7 do
                local noteX = defpos[i + 1][1] + 20 * math.sin((curbeat + i * 0.25) * math.pi)
                local noteY = defpos[i + 1][2] + 30 * math.cos((curbeat + i * 0.25) * math.pi)

                setPropertyFromGroup('strumLineNotes', i, 'x', noteX)
                setPropertyFromGroup('strumLineNotes', i, 'y', noteY)
            end
        end
    end
end