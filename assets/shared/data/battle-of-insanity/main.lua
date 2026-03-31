function onCreate()
    setProperty("skipCountdown", true)
    makeLuaSprite('Vignette', 'suicideStreet/vignette', 0, 0)
    scaleLuaSprite('Vignette', 1, 1)
    setScrollFactor('Vignette', 1, 1)
    setObjectCamera('Vignette', 'other');
    addLuaSprite('Vignette', false)
    makeLuaSprite('LVignette', 'suicideStreet/vignetteLight', 0, 0)
    scaleLuaSprite('LVignette', 1, 1)
    setScrollFactor('LVignette', 1, 1)
    setObjectCamera('LVignette', 'other');
    addLuaSprite('LVignette', false)
    makeLuaSprite('void', '', -200, -200)
    makeGraphic('void', 1920, 1080, '000000')
    setScrollFactor('void', 0, 0)
    addLuaSprite('void', true)
    setProperty('void.alpha', 1)
    setProperty('LVignette.alpha', 0)
    setProperty('gf.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('showComboNum', true)
    setProperty('showRating', true)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', true)
    setProperty('timeBarBG.visible', true)
    setProperty('timeTxt.visible', true)
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

function onSectionHit()

end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if getProperty('dad.curCharacter') == "mickeyUS1" or getProperty('dad.curCharacter') == "mickeyUS2"  then
        if getProperty('health') > 0.25 then
            setProperty('health', getProperty('health') - 0.013)
        end
    end

    if getProperty('dad.curCharacter') == "mickeyUS3" then
        if getProperty('health') > 0.3 then
            setProperty('health', getProperty('health') - 0.015)
        end
    end

    if getProperty('dad.curCharacter') == "SuicideMouseUS" then
        if getProperty('health') > 0.25 then
            setProperty('health', getProperty('health') - 0.005)
        end
    end

    local currentDadCharacter = getProperty('dad.curCharacter') or getProperty('dad.character') or ''
    if currentDadCharacter == 'mickeyUS1' or currentDadCharacter == 'mickeyUS2' or currentDadCharacter == 'mickeyUS3' then
        shakeCameras(0.7, 0.7, 0.1)
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
function onBeatHit()
    if bounceonbeat == true then
        local gameZoom = getProperty('camGame.zoom')
        local hudZoom = getProperty('camHUD.zoom')
        triggerEvent('Add Camera Zoom', '0.02', '0')
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