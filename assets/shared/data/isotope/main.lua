local bounceonbeat = false
function onCreate()
    setProperty('isCameraOnForcedPos', true)
    makeLuaSprite('Vignette', 'suicideStreet/vignette', 0, 0)
    scaleLuaSprite('Vignette', 1, 1)
    setScrollFactor('Vignette', 1, 1)
    setObjectCamera('Vignette', 'other');
    addLuaSprite('Vignette', false)
    makeLuaSprite('normal', 'suicideStreet/street', -1100, -200)
	scaleLuaSprite('normal', 1, 1)
	setScrollFactor('normal', 1, 1)
	addLuaSprite('normal', false)
    setProperty('normal.alpha', 0)
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
    makeLuaSprite('REDDD', '', -200, -200)
    makeGraphic('REDDD', 1920, 1080, 'ff001f')
    setScrollFactor('REDDD', 0, 0)
    addLuaSprite('REDDD', false)
    setProperty('REDDD.alpha', 0)
    setProperty('void.alpha', 0)
    setProperty('void2.alpha', 0)
    makeLuaSprite('lightthing', 'suicideStreet/light', -800, -200)
	scaleLuaSprite('lightthing', 0.85, 1)
	setScrollFactor('lightthing', 0.8, 1)
    makeLuaText('text', '', 1250, 0, 650)
	setTextAlignment('text', 'Center')
	addLuaText('text')
	setTextSize('text', 28)
	addLuaSprite('lightthing', false)
    setProperty('lightthing.alpha', 0)
    setProperty('gf.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('showComboNum', true)
    setProperty('showRating', true)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', true)
    setProperty('timeBarBG.visible', true)
    setProperty('timeTxt.visible', true)
    math.randomseed(os.time())
    doTweenZoom('camGameTween', 'camGame', 0.7, 0.01)
    setProperty('camHUD.alpha', 0)
    setVar('ignoreCam', true)
    doTweenX('camX', 'camFollow', 200, 0.01, 'circInOut')
    doTweenY('camY', 'camFollow', 400, 0.01, 'circInOut')
    doTweenZoom('camGameTween', 'camGame', 0.75, 10)
    initLuaShader('textureBlur')
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

-- DONT USE THIS FUNCTION, ITS BUGGY AF
local function CenterCam(tweentime, finish) -- put anything in finish to finish
    if finish == '' or finish == nil then
        setVar('ignoreCam', true)
        setProperty('isCameraOnForcedPos', true)
        doTweenX('camX', 'camFollow', 200, tweentime, 'circInOut')
        doTweenY('camY', 'camFollow', 400, tweentime, 'circInOut')
    else
        setVar('ignoreCam', false)
        setProperty('isCameraOnForcedPos', false)
    end
end
-- DONT USE THIS FUNCTION, ITS BUGGY AF

function onStepHit()
    if bounceonbeat == true and curStep % 4 == 2 then
        local gameZoom = getProperty('camGame.zoom')
        local hudZoom = getProperty('camHUD.zoom')
        triggerEvent('Add Camera Zoom', '0.02', '0')
        if gameZoom < 0.7 then
            gameZoom = gameZoom + 0.035
            if gameZoom > 0.7 then gameZoom = 0.7 end
            setProperty('camGame.zoom', gameZoom)
        end
        if hudZoom ~= nil then
            setProperty('camHUD.zoom', hudZoom + 0.04)
        end
    end

    if curStep == 129 then
        doTweenAlpha('heavenstween', 'lightthing', 0.5, 9)
        doTweenZoom('camGameTween', 'camGame', 0.68, 3, 'sineOut')
    end

    if curStep == 227 then
        doTweenZoom('camGameTween', 'camGame', 0.9, 3.5, 'circInOut')
    end

    if curStep == 249 then
        setProperty('void.alpha', 1)
        doTweenAlpha('heavenstween', 'lightthing', 0, 0.01)
    end

    if curStep == 257 then
        doTweenZoom('camGameTween', 'camGame', 0.7, 1.25, 'circOut')
        setProperty('BG.alpha', 0)
        setProperty('normal.alpha', 1)
        setProperty('void.alpha', 0)
        local options = {BLUR_INTENSITY = 0.25, POSITION_EFFECT = 0.5, SAMPLE_COUNT = 10, SAMPLE_OFFSET = 0.0005}
        setSpriteShader('dad', 'textureBlur')
        for param, val in pairs(options) do
            setShaderFloat('dad', param, val)
        end
    end

    if curStep == 321 then
        doTweenAlpha('hud', 'camHUD', 1, 1.5)
        setVar('ignoreCam', false)
        setProperty('isCameraOnForcedPos', false)
    end

    if curStep == 347 then
        doTweenAlpha('texttween', 'text', 1, 0.25, 'sine')
        setTextString('text', 'Do I look fine to you?')
    end

    if curStep == 365 then
        doTweenAlpha('texttween', 'text', 0, 0.5, 'sine')
    end

    if curStep == 369 then
        local options = {BLUR_INTENSITY = 0.25, POSITION_EFFECT = 0.5, SAMPLE_COUNT = 10, SAMPLE_OFFSET = 0.0005}
        setSpriteShader('dad', 'textureBlur')
        for param, val in pairs(options) do
            setShaderFloat('dad', param, val)
        end
    end

    if curStep == 385 then
        local options = {BLUR_INTENSITY = 0.25, POSITION_EFFECT = 0.5, SAMPLE_COUNT = 10, SAMPLE_OFFSET = 0.0005}
        setSpriteShader('dad', 'textureBlur')
        for param, val in pairs(options) do
            setShaderFloat('dad', param, val)
        end
    end

    if curStep == 482 then
        CenterCam(0.25, '')
    end
    
    if curStep == 514 then
        CenterCam(1, 'tt')
    end

    if curStep == 641 then
        CenterCam(1)
    end

    if curStep == 703 then
        doTweenX('camX', 'camFollow', 30, 0.3, 'sine')
        CenterCam(1, 'end')
    end

    if curStep == 704 or curStep == 851 then
        bounceonbeat = true
    end

    if curStep == 832 or curStep == 1152 then
        bounceonbeat = false
    end

    if curStep == 1217 then
        setProperty('camHUD.alpha', 0)
        setProperty('REDDD.alpha', 1)
        setProperty('boyfriend.color', getColorFromHex('000000'))
        setProperty('dad.color', getColorFromHex('000000'))
    end

    if curStep == 1228 or curStep == 1230 or curStep == 1232 then
        setProperty('void.alpha', 1) 
    end

    if curStep == 1227 or curStep == 1229 or curStep == 1231 then
        setProperty('void.alpha', 0) 
    end

    if curStep == 1233 then
        setProperty('void.alpha', 0)
        setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
        setProperty('dad.color', getColorFromHex('FFFFFF'))
        setProperty('REDDD.alpha', 0)
        setProperty('camHUD.alpha', 1)
        doTweenAlpha('BGdarktween', 'BGdark', 1, 3.5, 'sine')
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        setProperty('health', getProperty('health') + 0.008)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if getProperty('dad.curCharacter') == "mickeyDejection" then
        if getProperty('health') > 0.15 then
            setProperty('health', getProperty('health') - 0.006)
        end
    end

    if getProperty('dad.curCharacter') == "mickeyUS1P1" then
        if getProperty('health') > 0.15 then
            setProperty('health', getProperty('health') - 0.009)
        end
    end
    
    if getProperty('dad.curCharacter') == "mickeyUS1" or getProperty('dad.curCharacter') == "mickeyUS2" or getProperty('dad.curCharacter') == "mickeySyringe" then
        if getProperty('health') > 0.25 then
            setProperty('health', getProperty('health') - 0.013)
        end
    end

    if getProperty('dad.curCharacter') == "mickeyUS3" then
        if getProperty('health') > 0.3 then
            setProperty('health', getProperty('health') - 0.015)
        end
    end

    local currentDadCharacter = getProperty('dad.curCharacter')
    if currentDadCharacter == 'mickeyUS1' or currentDadCharacter == 'mickeyUS2' or currentDadCharacter == 'mickeyUS3' or currentDadCharacter == 'mickeyUS1P1' then
        shakeCameras(0.6, 0.6, 0.1)
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
