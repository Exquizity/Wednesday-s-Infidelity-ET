local bounceonbeat = false
local flValue1 = 0.065
local flValue2 = 0.08
local maxzoom = 0.75

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
     makeLuaSprite('bgvoid', '', -200, -200)
    makeGraphic('bgvoid', 1920, 1080, '000000')
    setScrollFactor('bgvoid', 0, 0)
    addLuaSprite('bgvoid', false)
    makeLuaSprite('whitescreen', '', -200, -200)
    makeGraphic('whitescreen', 1920, 1080, 'FFFFFF')
    setScrollFactor('whitescreen', 0, 0)
    addLuaSprite('whitescreen', true)
    makeLuaSprite('whitescreenr', '', -200, -200)
    makeGraphic('whitescreenr', 1920, 1080, 'FFFFFF')
    setScrollFactor('whitescreenr', 0, 0)
    addLuaSprite('whitescreenr', false)
    setProperty('void.alpha', 1)
    setProperty('whitescreen.alpha', 0)
    setProperty('whitescreenr.alpha', 0)
    setProperty('LVignette.alpha', 0)
    setProperty('camHUD.alpha', 0)
    setProperty('gf.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('showComboNum', true)
    setProperty('showRating', true)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', true)
    setProperty('timeBarBG.visible', true)
    setProperty('timeTxt.visible', true)
    setProperty('Vignette.alpha', 0)
    setProperty('bgvoid.alpha', 0)
end

function onCreatePost()
    makeLuaSprite('broken', 'suicideStreet/streetVeryBroken', -1000, -200)
    scaleLuaSprite('broken', 1, 1)
    setScrollFactor('broken', 1, 1)
    addLuaSprite('broken', false)
    makeLuaSprite('red', 'suicideStreet/streetVeryBrokenRed', -1000, -200)
    scaleLuaSprite('red', 1, 1)
    setScrollFactor('red', 1, 1)
    addLuaSprite('red', false)
    setProperty('broken.alpha', 0)
    setProperty('red.alpha', 0)
end

function onStepHit()
    if curStep == 30 then
        doTweenAlpha('whitetween', 'whitescreen', 1, 3)
    end

    if curStep == 63 then
        setProperty('void.alpha', 0)
        setProperty('whitescreenr.alpha', 1)
        setProperty('boyfriend.color', getColorFromHex('000000'))
        setProperty('dad.color', getColorFromHex('000000'))
        doTweenAlpha('whitetween', 'whitescreen', 0, 0.5)
    end

    if curStep == 184 then
        doTweenAlpha('whitetween', 'whitescreen', 1, 0.67)
    end

    if curStep == 192 then
        doTweenAlpha('whitetween', 'whitescreen', 0, 2)
        setProperty('whitescreenr.alpha', 0)
        setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
        setProperty('dad.color', getColorFromHex('FFFFFF'))
    end

    if curStep == 300 then
        setObjectCamera('whitescreen', 'other');
    end

    if curStep == 304 then
        doTweenAlpha('whitetween', 'whitescreen', 1, 1.4)
    end

    if curStep == 320 then
        setProperty('health', 1.25)
        setProperty('whitescreen.alpha', 0)
        setProperty('camHUD.alpha', 1)
        setProperty('Vignette.alpha', 1)
        setProperty('bg.alpha', 1)
    end

    if curStep == 1604 then
        setProperty('void.alpha', 1)
    end

    if curStep == 1617 then
        setProperty('void.alpha', 0)
    end

    if curStep == 2124 then
        doTweenAlpha('whitetweentween', 'whitescreenr', 1, 0.15, 'sine')
    end

    if curStep == 2129 then 
        setProperty('timeBar.visible', false)
        setProperty('timeBarBG.visible', false)
        setProperty('timeTxt.visible', false)
        for i = 0, 3 do
            noteTweenAlpha('fade'..i, i, 0.15, 1, 'linear')
        end

        for i = 4, 7 do
            noteTweenAlpha('fade'..i, i, 1, 0.01, 'linear')
        end
        doTweenAlpha('healthBarFade', 'healthBar', 0, 1, 'linear')
        doTweenAlpha('healthBarBGFade', 'healthBarBG', 0, 1, 'linear')
        doTweenAlpha('iconP1Fade', 'iconP1', 0, 1, 'linear')
        doTweenAlpha('iconP2Fade', 'iconP2', 0, 1, 'linear')
        doTweenAlpha('whitetweentween', 'whitescreenr', 0, 0.01, 'sine')
        setProperty('bgvoid.alpha', 1)

        local centerX = screenWidth / 2 - 2 * 112

        for i = 0, 3 do
            noteTweenX('dadMiddle'..i, i, centerX + (i * 112), 1.5, 'quartInOut')
        end

        for i = 4, 7 do
            noteTweenX('bfMiddle'..i, i, centerX + ((i - 4) * 112), 1.5, 'quartInOut')
        end
    end

    if curStep == 2385 then
        setProperty('bgvoid.alpha', 0)
        setProperty('broken.alpha', 1)
        setProperty('BG.alpha', 0)
    end

    if curStep == 2513 then
        doTweenAlpha('redtween', 'red', 1, 30, 'sine')
    end

    if curStep == 2890 then
        setVar('ignoreCam', true)
        doTweenX('camX', 'camFollow', 200, 0.9, 'sine')
        doTweenY('camY', 'camFollow', 400, 0.9, 'sine')
    end

    if curStep == 2897 then
        setProperty('BG.alpha', 1)
        setProperty('broken.alpha', 0)
        setProperty('red.alpha', 0)
    end

    if curStep == 3153 then
        setProperty('void.alpha', 1)
        setProperty('camHUD.alpha', 0)
        for i = 0, 3 do
            noteTweenAlpha('fade'..i, i, 0, 0.01, 'linear')
        end
    end
end

function onUpdate(elapsed)
    if curStep >= 2898 then
        doTweenX('camX', 'camFollow', 200, 0.1, 'sine')
        doTweenY('camY', 'camFollow', 400, 0.1, 'sine')
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if curStep < 450 then
        setProperty('health', getProperty('health') + 0.00995)
    end
    if isSustainNote then
        setProperty('health', getProperty('health') + 0.0079)
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

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if curStep >= 2120 then
        setProperty('health', getProperty('health') - 0.0045)
    else
        setProperty('health', getProperty('health') - 0.0165)
    end
    shakeCameras(0.66, 0.66, 0.11)
end
