local bounceonbeat = false
local flValue1 = 0.065
local flValue2 = 0.08
local maxzoom = 0.75


function onCreate()
    makeLuaSprite('Vignette', 'suicideStreet/vignette', 0, 0)
    scaleLuaSprite('Vignette', 1, 1)
    setScrollFactor('Vignette', 1, 1)
    setObjectCamera('Vignette', 'other');
    addLuaSprite('Vignette', false)
    makeLuaSprite('void', '', -200, -200)
    makeGraphic('void', 1920, 1080, '000000')
    setScrollFactor('void', 0, 0)
    addLuaSprite('void', true)
    makeLuaSprite('void2', '', -200, -200)
    makeGraphic('void2', screenWidth * 2, screenHeight * 2, '000000')
    setScrollFactor('void2', 0, 0)
    addLuaSprite('void2', false) -- Changed to true for front layering, though 'other' is already top-level
    setObjectCamera('void2', 'other') 
    setProperty('void.alpha', 0)
    setProperty('void2.alpha', 0)
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

function darkflash()
    setProperty('void2.alpha', 1)
    doTweenAlpha('cooldarktween', 'void2', 0, 0.5)
end

function onSectionHit()
    if curSection == 5 then
        function opponentNoteHit()
            health = getProperty('health')
            if getProperty('health') > 0.15 then
                setProperty('health', health - 0.01);
            end
        end
    end

    if curSection == 49 then
        bounceonbeat = true
    end

    if curSection == 82 then
        bounceonbeat = false
    end

    if curSection == 111 then
        function opponentNoteHit()
            health = getProperty('health')
            if getProperty('health') > 0.15 then
                setProperty('health', health - 0.015);
            end
        end
    end

    if curSection == 32 or curSection == 34 or curSection == 36 or curSection == 38 then --holy repetition
        darkflash()
    end

    if curSection == 98 then
        for i = 0, 7 do
            noteTweenAlpha('oppFade'..i, i, 0, 0.5, 'linear')
        end
        doTweenAlpha('healthBarFade', 'healthBar', 0, 0.5, 'linear')
        doTweenAlpha('healthBarBGFade', 'healthBarBG', 0, 0.5, 'linear')
        doTweenAlpha('iconP1Fade', 'iconP1', 0, 0.5, 'linear')
        doTweenAlpha('iconP2Fade', 'iconP2', 0, 0.5, 'linear')
    end

    if curSection == 105 then
        for i = 4, 7 do
            noteTweenAlpha('oppFade'..i, i, 1, 1, 'linear')
        end
    end
    
    if curSection == 112 then
        for i = 4, 7 do
            noteTweenAlpha('oppFade'..i, i, 0, 0.0001, 'linear')
        end
    end

    if curSection == 113 then
        for i = 0, 7 do
            noteTweenAlpha('oppFade'..i, i, 1, 1, 'linear')
        end
        doTweenAlpha('healthBarFade', 'healthBar', 1, 1, 'linear')
        doTweenAlpha('healthBarBGFade', 'healthBarBG', 1, 1, 'linear')
        bounceonbeat = true
    end

    if curSection == 181 then
        bounceonbeat = false
    end

    if curSection == 197 then
        setProperty('void2.alpha', 1)
    end
end

function onBeatHit()
    if curBeat == 38 then
        for i = 0, 3 do
            noteTweenAlpha('oppFade'..i, i, 1, 0.5, 'linear')
        end
    end
    if curBeat == 115 then
        for i = 0, 7 do
            noteTweenAlpha('oppFade'..i, i, 0, 0.5, 'linear')
        end
        doTweenAlpha('healthBarFade', 'healthBar', 0, 0.5, 'linear')
        doTweenAlpha('healthBarBGFade', 'healthBarBG', 0, 0.5, 'linear')
        doTweenAlpha('iconP1Fade', 'iconP1', 0, 0.5, 'linear')
        doTweenAlpha('iconP2Fade', 'iconP2', 0, 0.5, 'linear')
    end

    if curBeat == 128 then
        for i = 0, 7 do
            noteTweenAlpha('oppFade'..i, i, 1, 1, 'linear')
        end
        doTweenAlpha('healthBarFade', 'healthBar', 1, 1, 'linear')
        doTweenAlpha('healthBarBGFade', 'healthBarBG', 1, 1, 'linear')
        doTweenAlpha('iconP1Fade', 'iconP1', 1, 1, 'linear')
        doTweenAlpha('iconP2Fade', 'iconP2', 1, 1, 'linear')
    end

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

function onStepHit()
    if curStep >= 13 and curStep <= 30 then
        if curStep % 2 == 1 then
            setProperty('void2.alpha', 1)
                for i = 0, 3 do
        noteTweenAlpha('oppFade'..i, i, 0, 0.5, 'linear')
    end
        else
            setProperty('void2.alpha', 0)
        end
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    local currentDadCharacter = getProperty('dad.curCharacter') or getProperty('dad.character') or ''
    if currentDadCharacter == 'OswaldUL2' or currentDadCharacter == 'OswaldUL2' or currentDadCharacter == 'OswaldUL2' then
        shakeCameras(0.7, 0.7, 0.1)
    end
end