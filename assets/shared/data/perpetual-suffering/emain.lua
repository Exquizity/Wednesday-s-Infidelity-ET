local bounceonbeat = false
local flValue1 = 0.165
local flValue2 = 0.08
local maxzoom = 0.8
local defpos = {}

function onCreate()
    setProperty("skipCountdown", false)
    
    makeLuaSprite('Vignette', 'suicideStreet/vignette', 0, 0)
    scaleLuaSprite('Vignette', 1, 1)
    setScrollFactor('Vignette', 1, 1)
    setObjectCamera('Vignette', 'other')
    addLuaSprite('Vignette', false)

    makeLuaSprite('USVoid', 'suicideStreet/USVoid', -1100, -200)
    scaleLuaSprite('USVoid', 1, 1)
    setScrollFactor('USVoid', 1, 1)
    addLuaSprite('USVoid', false)
    setProperty('USVoid.alpha', 0)

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

    makeLuaSprite('lightthing', 'suicideStreet/light', -800, -200)
	scaleLuaSprite('lightthing', 0.85, 1)
	setScrollFactor('lightthing', 0.8, 1)
	addLuaSprite('lightthing', false)
    setProperty('lightthing.alpha', 0)

    makeLuaSprite('whitescreen', '', -200, -200)
    makeGraphic('whitescreen', 4000, 4000, 'FFFFFF')
    setScrollFactor('whitescreen', 0, 0)
    addLuaSprite('whitescreen', false)

    makeLuaSprite('void', '', -200, -200)
    makeGraphic('void', 4000, 4000, '000000') 
    setScrollFactor('void', 0, 0)
    addLuaSprite('void', true) 
    setProperty('void.alpha', 1) 

    setProperty('gf.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('showComboNum', true)
    setProperty('showRating', true)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', true)
    setProperty('timeBarBG.visible', true)
    setProperty('timeTxt.visible', true)
    setProperty('camHUD.alpha', 1)
end

function onCreatePost()
    if not savedBasePositions then
        baseHudPositionX = getProperty('camHUD.x') or 0
        baseHudPositionY = getProperty('camHUD.y') or 0
        baseGamePositionX = getProperty('camGame.x') or 0
        baseGamePositionY = getProperty('camGame.y') or 0
        savedBasePositions = true
    end
    doTweenZoom('tweenthegamecamsoitsnotinthecharacters', 'camGame', 0.85, 0.01)
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

function onSongStart()
    setProperty('boyfriend.color', getColorFromHex('000000'))
    setProperty('dad.color', getColorFromHex('000000'))
    doTweenAlpha('voidtween', 'void', 0, 0.5)
end


function onSectionHit()
    if curSection == 8 then
        setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
        setProperty('dad.color', getColorFromHex('FFFFFF'))
        setProperty('whitescreen.alpha', 0)
    end

    if curSection == 17 or curSection == 34 or curSection == 147 then
        bounceonbeat = true
    end

    if curSection == 25 then
        bounceonbeat = false
        setProperty('void.alpha', 1)
    end

    if curSection == 26 then
        bounceonbeat = true
        setProperty('void.alpha', 0)
    end

    if curSection == 33 or curSection == 52 then
        bounceonbeat = false
    end

    if curSection == 68 then
        doTweenAlpha('voidtween', 'void', 1, 1)
    end

    if curSection == 70 then
        doTweenAlpha('hudtween', 'camHUD', 0.2, 0.35, 'sine')
        setProperty('BGdark.alpha', 1)
        setProperty('boyfriend.alpha', 0)
    end

    if curSection == 71 or curSection == 73 or curSection == 75 then
        setProperty('void.alpha', 0)
        doTweenAlpha('voidtween', 'void', 1, 1.8)
    end

    if curSection == 77 then
        setProperty('void.alpha', 0)
        doTweenAlpha('voidtween', 'void', 1, 0.9)
    end

    if curSection == 78 then
        setProperty('boyfriend.alpha', 1)
        doTweenAlpha('voidtween', 'void', 0, 0.9)
        doTweenAlpha('hudtween', 'camHUD', 1, 1, 'sine')
    end

    if curSection == 87 then
        setProperty('void.alpha', 1)
        for i = 0, 7 do
            noteTweenAlpha('fade'..i, i, 0, 1, 'linear')
        end
        doTweenAlpha('healthBarFade', 'healthBar', 0, 1, 'linear')
        doTweenAlpha('healthBarBGFade', 'healthBarBG', 0, 1, 'linear')
        doTweenAlpha('iconP1Fade', 'iconP1', 0, 1, 'linear')
        doTweenAlpha('iconP2Fade', 'iconP2', 0, 1, 'linear')
    end

    if curSection == 94 then
        setProperty('void.alpha', 0)
    end

    if curSection == 95 then
        for i = 0, 7 do
            noteTweenAlpha('fade'..i, i, 1, 1, 'linear')
        end
        doTweenAlpha('healthBarFade', 'healthBar', 1, 1, 'linear')
        doTweenAlpha('healthBarBGFade', 'healthBarBG', 1, 1, 'linear')
        doTweenAlpha('iconP1Fade', 'iconP1', 1, 1, 'linear')
        doTweenAlpha('iconP2Fade', 'iconP2', 1, 1, 'linear')
        bounceonbeat = true
    end

    if curSection == 127 then
        bounceonbeat = false
    end

    if curSection == 163 then
        bounceonbeat = false
        setProperty('void.alpha', 1)
    end
end

function onUpdate(elapsed)
    if curSection > 1000 then
        local songPos = getSongPosition()
        local currentBeat = (songPos / 1000) * (bpm / 60) / 4
        if #defpos == 8 then
            for i = 0, 7 do
                local noteX = defpos[i + 1][1] + 20 * math.sin((currentBeat + i * 0.25) * math.pi)
                local noteY = defpos[i + 1][2] + 30 * math.cos((currentBeat + i * 0.25) * math.pi)

                setPropertyFromGroup('strumLineNotes', i, 'x', noteX)
                setPropertyFromGroup('strumLineNotes', i, 'y', noteY)
            end
        end
    end

    if curStep < 128 then
        setProperty('boyfriend.color', getColorFromHex('000000'))
        setProperty('dad.color', getColorFromHex('000000'))
    else
        setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
        setProperty('dad.color', getColorFromHex('FFFFFF'))
    end
end

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

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        setProperty('health', getProperty('health') + 0.008)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if getProperty('dad.curCharacter') == "mickeyUS1" or getProperty('dad.curCharacter') == "mickeyUS2"  then
        if getProperty('health') > 0.102 then
            setProperty('health', getProperty('health') - 0.0155)
        end
    end

    local currentDadCharacter = getProperty('dad.curCharacter') or getProperty('dad.character') or ''
    if currentDadCharacter == 'mickeyUS1' or currentDadCharacter == 'mickeyUS2' or currentDadCharacter == 'mickeyUS3' then
        shakeCameras(0.73, 0.73, 0.1)
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
