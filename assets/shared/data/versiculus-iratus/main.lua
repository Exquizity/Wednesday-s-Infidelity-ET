local bounceonbeat = false
local flValue1 = 0.065
local flValue2 = 0.08
local maxzoom = 0.8
local phase = 0 --testing stuff lol
local hp = 2.0
local cd = false
local misses = 5
local cutscened = false

function onCreate()
    setProperty('isCameraOnForcedPos', true)
    setProperty("skipCountdown", true)
    
    makeLuaSprite('Vignette', 'suicideStreet/vignette', 0, 0)
    scaleLuaSprite('Vignette', 1, 1)
    setScrollFactor('Vignette', 1, 1)
    setObjectCamera('Vignette', 'other')
    addLuaSprite('Vignette', false)

    makeLuaSprite('LVignette', 'suicideStreet/vignetteLight', 0, 0)
    scaleLuaSprite('LVignette', 1, 1)
    setScrollFactor('LVignette', 1, 1)
    setObjectCamera('LVignette', 'other');
    addLuaSprite('LVignette', false)
    setProperty('LVignette.alpha', 0)

    makeLuaSprite('RedVingette', 'suicideStreet/RedVingette', 0, 0)
    setGraphicSize('RedVingette', 1280, 720)  
    scaleLuaSprite('RedVingette', 1, 1)
    setScrollFactor('RedVingette', 1, 1)
    setObjectCamera('RedVingette', 'other');
    addLuaSprite('RedVingette', false)
    setProperty('RedVingette.alpha', 0)

    makeLuaSprite('Warning', 'suicideStreet/Warning', 0, 0)
    setGraphicSize('Warning', 1280, 720)  
    setScrollFactor('Warning', 0, 0)
    setObjectCamera('Warning', 'other')
    addLuaSprite('Warning', true)  
    setProperty('Warning.alpha', 0)  

    makeLuaSprite('void', '', -200, -200)
    makeGraphic('void', 4000, 4000, '000000') 
    setScrollFactor('void', 0, 0)
    addLuaSprite('void', true) 
    setProperty('void.alpha', 1) 
end

function onCreatePost()
    if not savedBasePositions then
        baseHudPositionX = getProperty('camHUD.x') or 0
        baseHudPositionY = getProperty('camHUD.y') or 0
        baseGamePositionX = getProperty('camGame.x') or 0
        baseGamePositionY = getProperty('camGame.y') or 0
        savedBasePositions = true
            setProperty('gf.visible', false)
    setProperty('dad.alpha', 0)
    setProperty('scoreTxt.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('missesTxt.visible', false)
    setProperty('missesTxt.alpha', 0)
    setProperty('accuracyTxt.visible', false)
    setProperty('accuracyTxt.alpha', 0)
    setProperty('healthBar.visible', false)
    setProperty('healthBar.alpha', 0)
    setProperty('healthBarBG.visible', false)
    setProperty('healthBarBG.alpha', 0)
    setProperty('iconP1.visible', false)
    setProperty('iconP1.alpha', 0)
    setProperty('iconP2.visible', false)
    setProperty('iconP2.alpha', 0)
    setProperty('timeBar.visible', false)
    setProperty('timeBar.alpha', 0)
    setProperty('timeBarBG.visible', false)
    setProperty('timeBarBG.alpha', 0)
    setProperty('timeTxt.visible', false)
    setProperty('timeTxt.alpha', 0)
    setProperty('showComboNum', false)
    setProperty('showRating', false)
    makeLuaText('Lyrics', '', 1250, 0, 480)
	setTextAlignment('Lyrics', 'Center')
	addLuaText('Lyrics')
	setTextSize('Lyrics', 28)
    for i = 0, 7 do
        noteTweenAlpha('fade'..i, i, 0, 0.01, 'linear')
    end
    setProperty('camHUD.alpha', 0)
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

function onStartCountdown()
    if isStoryMode then
        if cutscened == false then
            cutscened = true
            startVideo('IratusCutscene')
            return Function_Stop
        end
    end

    return Function_Continue
end

function onVideoFinished()
    startCountdown()
end

function onUpdate(elapsed)
    if phase ~= 0 then
        setProperty('health', hp)
    end

    if curStep < 41 then
    for i = 0, 7 do
        noteTweenAlpha('fade'..i, i, 0, 0.01, 'linear')
    end
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
    if cd == false --[[and phase ~= 0--]] then
        hp = hp - 0.4
        cd = true
        --[[if misses == 1 then
            setTextString('Lyrics', 'You can only miss one more time. Lock in.')
        else
            setTextString('Lyrics', 'You can only miss ' .. miss .. ' more times')
        end
        doTweenAlpha('cantbebothered', 'Lyrics', 0, 2.4, 'linear')--]]
        runTimer("MissCooldown", 2.5, 0)
        if getPropertyFromClass('backend.ClientPrefs', 'data.NerfMechanics') == true then
            runTimer("MissCooldown", 5, 0)
        else
            runTimer("MissCooldown", 2.5, 0)
        end

    end
end

function onSectionHit()
    if curSection == 7 then
        doTweenX('camX', 'camFollow', 600, 0.01, 'circInOut')
        doTweenY('camY', 'camFollow', 100, 0.01, 'circInOut')
        setProperty('camHUD.alpha', 1)
    end

    if curSection == 8 then
        doTweenAlpha('voidtween', 'void', 0, 3, 'linear')
        doTweenX('camX', 'camFollow', 600, 7, 'sine')
        doTweenY('camY', 'camFollow', 410, 7, 'sine')
    end

    if curSection == 14 then
        doTweenX('camX', 'camFollow', 1000, 0.9, 'sine')
        doTweenY('camY', 'camFollow', 450, 0.9, 'sine')
    end

    if curSection == 15 then
        for i = 4, 7 do
            noteTweenAlpha('fade'..i, i, 1, 1, 'linear')
        end

    end

    if curSection == 24 or curSection == 40 or curSection == 56 or curSection == 69 or curSection == 76 then
        setProperty('isCameraOnForcedPos', false)
        for i = 0, 3 do
            noteTweenAlpha('fade'..i, i, 0.25, 3, 'linear')
        end
        doTweenAlpha('fakeminnietween', 'dad', 0.45, 3, 'linear')
        doTweenAlpha('VignetteStrong', 'LVignette', 0.5, 3)
    end

    if curSection == 32 or curSection == 48 or curSection == 64 or curSection == 72 or curSection == 95 then
        for i = 0, 3 do
            noteTweenAlpha('fade'..i, i, 0, 1.5, 'linear')
        end
        doTweenAlpha('fakeminnietween', 'dad', 0, 1.5, 'linear')
        doTweenAlpha('VignetteStrong', 'LVignette', 0, 1.5)
    end

    if curSection == 97 then
        phase = 999 --cl idk what to make it
        bounceonbeat = true
        for i = 0, 3 do
            noteTweenAlpha('fade'..i, i, 1, 0.001, 'linear')
        end
        setProperty('RedVingette.alpha', 1)
        doTweenAlpha('redddddd', 'RedVingette', 0, 6, 'linear')
        doTweenAlpha('dadtween', 'dad', 1, 0.001, 'linear')
        doTweenAlpha('WarningFadeIn', 'Warning', 1, 1, 'linear')  
        runTimer('WarningFadeOutDelay', 7, 1)  
    end

    if curSection == 169 then
        bounceonbeat = false
        doTweenAlpha('voidtween', 'void', 1, 3, 'linear')
        for i = 0, 7 do
            noteTweenAlpha('fade'..i, i, 0, 3, 'linear')
        end
    end

    if curSection == 173 then
        phase = 2
        doTweenAlpha('voidtween', 'void', 0, 1, 'linear')
        doTweenAlpha('fakeminnietween', 'dad', 0.45, 1, 'linear')
        for i = 4, 7 do
            noteTweenAlpha('fade'..i, i, 1, 1, 'linear')
        end
        for i = 0, 3 do
            noteTweenAlpha('fade'..i, i, 0.1, 1, 'linear')
        end
    end

    if curSection == 181 then
        doTweenAlpha('fakeminnietween', 'dad', 0, 1, 'linear')
        for i = 0, 3 do
            noteTweenAlpha('fade'..i, i, 0, 1, 'linear')
        end
    end

    if curSection == 189 then
        doTweenAlpha('fakeminnietween', 'dad', 0.45, 1, 'linear')
        for i = 0, 3 do
            noteTweenAlpha('fade'..i, i, 0.1, 1, 'linear')
        end
    end

    if curSection == 197 then
        doTweenAlpha('fakeminnietween', 'dad', 0, 11, 'linear')
        for i = 0, 3 do
            noteTweenAlpha('fade'..i, i, 0, 11, 'linear')
        end
    end

    if curSection == 205 then
        bounceonbeat = true
        phase = 3
        doTweenAlpha('fakeminnietween', 'dad', 1, 0.01, 'linear')
        for i = 0, 3 do
            noteTweenAlpha('fade'..i, i, 1, 0.01, 'linear')
        end
    end

    if curSection == 289 then
        doTweenAlpha('voidtween', 'void', 1, 21, 'linear')
        doTweenAlpha('theend...', 'camHUD', 0, 21, 'linear')
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
    local currentBfCharacter = getProperty('boyfriend.curCharacter') or getProperty('boyfriend.character') or ''
    if isSustainNote then
        setProperty('health', getProperty('health') + 0.008)
    end
    if phase == 2 then
        shakeCameras(0.2, 0.2, 0.1)
    end

    if phase == 3 then
        shakeCameras(0.25, 0.25, 0.1)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    local currentDadCharacter = getProperty('dad.curCharacter') or getProperty('dad.character') or ''
    if currentDadCharacter == 'Demon' then
        shakeCameras(0.7, 0.7, 0.1)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "MissCooldown" then
        cd = false
    end

    if tag == 'WarningFadeOutDelay' then
        doTweenAlpha('WarningFadeOut', 'Warning', 0, 1, 'linear')  -- fade out over 1 second
    end

    if tag == 'shake_return' then
        pcall(function() doTweenX('shake_hud_x_in', 'camHUD', baseHudPositionX, 0.1 / 2, 'quadInOut') end)
        pcall(function() doTweenY('shake_hud_y_in', 'camHUD', baseHudPositionY, 0.1 / 2, 'quadInOut') end)
        pcall(function() doTweenX('shake_game_x_in', 'camGame', baseGamePositionX, 0.1 / 2, 'quadInOut') end)
        pcall(function() doTweenY('shake_game_y_in', 'camGame', baseGamePositionY, 0.1 / 2, 'quadInOut') end)
    end
end