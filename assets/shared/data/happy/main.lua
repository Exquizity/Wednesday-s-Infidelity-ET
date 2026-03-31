local bounceonbeat = false
local flValue1 = 0.035
local flValue2 = 0.05
local maxzoom = 0.9

function onCreate()
    makeLuaText('Lyrics', "", 1250, 0, 480)
	setTextAlignment('Lyrics', 'Center')
	addLuaText('Lyrics')
	setTextSize('Lyrics', 28)

    makeLuaSprite('Vignette', 'suicideStreet/vignette', 0, 0)
    scaleLuaSprite('Vignette', 1, 1)
    setScrollFactor('Vignette', 1, 1)
    setObjectCamera('Vignette', 'other')
    addLuaSprite('Vignette', false)

    makeLuaSprite('streetBroken', 'suicideStreet/streetBroken', -1100, -200)
    scaleLuaSprite('streetBroken', 1, 1)
    setScrollFactor('streetBroken', 1, 1)
    addLuaSprite('streetBroken', false)
    setProperty('streetBroken.alpha', 0)

    makeLuaSprite('BGdark', 'suicideStreet/streetDark', -1100, -200)
    scaleLuaSprite('BGdark', 1, 1)
    setScrollFactor('BGdark', 1, 1)
    addLuaSprite('BGdark', false)
    setProperty('BGdark.alpha', 0)

    makeLuaSprite('void', '', -200, -200)
    makeGraphic('void', 4000, 4000, '000000') 
    setScrollFactor('void', 0, 0)
    addLuaSprite('void', true) 
    setProperty('void.alpha', 0) 

    setProperty('gf.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('showComboNum', false)
    setProperty('showRating', false)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeTxt.visible', false)
end

function onCreatePost()
    if not savedBasePositions then
        baseHudPositionX = getProperty('camHUD.x') or 0
        baseHudPositionY = getProperty('camHUD.y') or 0
        baseGamePositionX = getProperty('camGame.x') or 0
        baseGamePositionY = getProperty('camGame.y') or 0
        savedBasePositions = true
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

function onPause()
	return Function_Continue;
end

function onSectionHit()
    if curSection == 3 then
        for i = 0, 7 do
            noteTweenAlpha('oppFade'..i, i, 0, 1, 'linear')
        end
        doTweenAlpha('healthBarFade', 'healthBar', 0, 1, 'linear')
        doTweenAlpha('healthBarBGFade', 'healthBarBG', 0, 1, 'linear')
        doTweenAlpha('iconP1Fade', 'iconP1', 0, 1, 'linear')
        doTweenAlpha('iconP2Fade', 'iconP2', 0, 1, 'linear')
    end
    if curSection == 8 then
        for i = 0, 7 do
            noteTweenAlpha('oppFade'..i, i, 1, 0.2, 'linear')
        end
        doTweenAlpha('healthBarFade', 'healthBar', 1, 0.2, 'linear')
        doTweenAlpha('healthBarBGFade', 'healthBarBG', 1, 0.2, 'linear')
        doTweenAlpha('iconP1Fade', 'iconP1', 1, 0.2, 'linear')
        doTweenAlpha('iconP2Fade', 'iconP2', 1, 0.2, 'linear')
        --[[if getProperty('health') > 0.15 then
            setProperty('health', getProperty('health') - 0.004)
        end--]]
    end

end

function onBeatHit()
    if curBeat == 30 then
        setProperty('void.alpha', 1)
    end

    if curBeat == 32 then
        setProperty('void.alpha', 0)
    end
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

function onStepHit()
    if curStep == 64 then
        setTextString('Lyrics', "Let me ask you something.")
    end
    
    if curStep == 80 then
        setTextString('Lyrics', "Have you considered the possibility,")
    end

    if curStep == 99 then
        setTextString('Lyrics', "that without happiness,")
    end

    if curStep == 113 then
        setTextString('Lyrics', "you will know peace?")
    end

    if curStep == 120 then
        setTextString('Lyrics', "peace?")
    end

    if curStep == 122 then
        doTweenAlpha('lyricfade', 'Lyrics', 0, 0.8, 'linear')
    end

    if curStep == 612 then
        doTweenAlpha('lyricfade', 'Lyrics', 1, 0.5, 'linear')
        setTextString('Lyrics', "Well, well")
    end

    if curStep == 624 then
        setTextString('Lyrics', "Thats more like it.")
    end

    if curStep == 635 then
        doTweenAlpha('lyricfade', 'Lyrics', 0, 0.75, 'linear')
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        setProperty('health', getProperty('health') + 0.008)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    local currentDadCharacter = getProperty('dad.curCharacter') or getProperty('dad.character') or ''
    if currentDadCharacter == 'mickeyUS1' then
        shakeCameras(1, 1, 0.1)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'shake_return' then
        pcall(function() doTweenX('shake_hud_x_in', 'camHUD', baseHudPositionX, 0.1 / 2, 'quadInOut') end)
        pcall(function() doTweenY('shake_hud_y_in', 'camHUD', baseHudPositionY, 0.1 / 2, 'quadInOut') end)
        pcall(function() doTweenX('shake_game_x_in', 'camGame', baseGamePositionX, 0.1 / 2, 'quadInOut') end)
        pcall(function() doTweenY('shake_game_y_in', 'camGame', baseGamePositionY, 0.1 / 2, 'quadInOut') end)
    end
end
