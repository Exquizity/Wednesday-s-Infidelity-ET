function onCreate()
    makeLuaSprite('Vignette', 'suicideStreet/vignette', 0, 0)
    scaleLuaSprite('Vignette', 1, 1)
    setScrollFactor('Vignette', 1, 1)
    setObjectCamera('Vignette', 'other');
    addLuaSprite('Vignette', false)
    makeLuaSprite('BGdark', 'suicideStreet/streetDark', -1100, -200)
	scaleLuaSprite('BGdark', 1, 1)
	setScrollFactor('BGdark', 1, 1)
	addLuaSprite('BGdark', false)
    setProperty('BGdark.alpha', 0)
    makeLuaSprite('void', '', -200, -200)
    makeGraphic('void', 1920, 1080, '000000')  
    setScrollFactor('void', 0, 0)
    addLuaSprite('void', true)
    makeLuaSprite('void2', '', -200, -200)
    makeGraphic('void2', 1920, 1080, '000000')
    setScrollFactor('void2', 0, 0)
    addLuaSprite('void2', true)
    setObjectCamera('void2', 'other')
    makeLuaSprite('whitescreen', '', -200, -200)
    makeGraphic('whitescreen', 1920, 1080, 'FFFFFF')
    setScrollFactor('whitescreen', 0, 0)
    addLuaSprite('whitescreen', true)
    setProperty('whitescreen.alpha', 0)
    setProperty('void.alpha', 1)
    setProperty('void2.alpha', 0)
    setProperty('gf.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('showComboNum', true)
    setProperty('showRating', true)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', true)
    setProperty('timeBarBG.visible', true)
    setProperty('timeTxt.visible', true)
    math.randomseed(os.time())
    
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'shake_return' then
        pcall(function() doTweenX('shake_hud_x_in', 'camHUD', baseHudPositionX, 0.1 / 2, 'quadInOut') end)
        pcall(function() doTweenY('shake_hud_y_in', 'camHUD', baseHudPositionY, 0.1 / 2, 'quadInOut') end)
        pcall(function() doTweenX('shake_game_x_in', 'camGame', baseGamePositionX, 0.1 / 2, 'quadInOut') end)
        pcall(function() doTweenY('shake_game_y_in', 'camGame', baseGamePositionY, 0.1 / 2, 'quadInOut') end)
    end

    if tag == 'flicker' then
        doTweenAlpha('flickertween', 'void2', 0, 0.03, 'sine')
    end
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

local function flickercam()
    setProperty('void2.alpha', 1)
    runTimer('flicker', 0.02)
end


function onStepHit()
    if curStep == 48 or curStep == 113 or curStep == 177 or curStep == 241 then
        doTweenAlpha('voiddd', 'void', 0, 1, 'sine')
    end

    if curStep == 72 or curStep == 136 or curStep == 200 then
        doTweenAlpha('voiddd', 'void', 1, 1, 'sine')
    end

    if curStep == 633 then
        setVar('ignoreCam', true)
        setProperty('isCameraOnForcedPos', true)
        doTweenX('camX', 'camFollow', 75, 0.01, 'circInOut')
        doTweenY('camY', 'camFollow', 133.33333, 0.01, 'circInOut')
    end

    if curStep == 635 then
        doTweenX('camX', 'camFollow', 150, 0.01, 'circInOut')
        doTweenY('camY', 'camFollow', 266.666, 0.01, 'circInOut')
    end

    if curStep == 637 then
        doTweenX('camX', 'camFollow', 225, 1, 'circInOut')
        doTweenY('camY', 'camFollow', 400, 1, 'circInOut')
    end

    if curStep == 705 then
        doTweenX('camX', 'camFollow', 15, 1.5, 'sine')
        doTweenY('camY', 'camFollow', 470, 1, 'circInOut')
    end

    if curStep == 760 then
        doTweenX('camX', 'camFollow', 325, 1.5, 'sine')
        doTweenY('camY', 'camFollow', 460, 1, 'circInOut')
    end

    if curStep == 870 then
        setVar('ignoreCam', false)
        setProperty('isCameraOnForcedPos', false)
    end

    if curStep == 1089 or curStep == 1096 or curStep == 1104 or curStep == 1112 or curStep == 1121 or curStep == 1125 or curStep == 1129 or curStep == 1133 or curStep == 1137 or curStep == 1345 or curStep == 1353 or curStep == 1361 or curStep == 1369 or curStep == 1377 or curStep == 1381 or curStep == 1385 or curStep == 1389 or curStep == 1393 then
        -- OH MY GOD I REGRET NOT MAKING A TABLE IVE SPENT LIKE 5 MINUTES JUST TYPING ALLAT
        flickercam()
    end

    if curStep == 1423 then
        triggerEvent('HUD Bounce', '', '0.7')
        doTweenAlpha('flickertween', 'void2', 1, 0.16, 'sine')
    end

    if curStep == 1528 then
        doTweenAlpha('flickertween', 'void2', 0, 1, 'sine')
    end

    if curStep == 1633 then
        doTweenAlpha('WHITEEE', 'whitescreen', 1, 1, 'sine')
    end

    if curStep == 1648 then
        doTweenAlpha('WHITEEE', 'whitescreen', 0, 0.01, 'sine')
        setProperty('void.alpha', 1)
    end

    if curStep == 1665 then
        setProperty('void.alpha', 0)
    end

    if curStep == 1855 then
        setVar('ignoreCam', true)
        setProperty('isCameraOnForcedPos', true)
        doTweenX('camX', 'camFollow', 125, 1, 'sine')
        doTweenY('camY', 'camFollow', 420, 1, 'circInOut')
    end

end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        setProperty('health', getProperty('health') + 0.008)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if getProperty('dad.curCharacter') == "mickeyUS3" then
        if getProperty('health') > 0.2 then
            setProperty('health', getProperty('health') - 0.0141)
        end
    end

    shakeCameras(0.65, 0.65, 0.1)
end
