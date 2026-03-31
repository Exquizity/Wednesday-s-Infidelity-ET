local saved = false
local blinkEndTime = 0

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
    addLuaSprite('void2', false)
    setObjectCamera('void2', 'camGame')
    makeLuaSprite('void3', '', -200, -200)
    makeGraphic('void3', 1920, 1080, '000000')
    setScrollFactor('void3', 0, 0)
    addLuaSprite('void3', false)
    setObjectCamera('void2', 'camGame')
    setProperty('void.alpha', 1)
    setProperty('void2.alpha', 0)
    setProperty('void3.alpha', 0)
    setProperty('gf.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('showComboNum', true)
    setProperty('showRating', true)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', true)
    setProperty('timeBarBG.visible', true)
    setProperty('timeTxt.visible', true)
    setProperty('camHUD.alpha', 0)
    math.randomseed(os.time())
end

function onCreatePost()
    if not saved then
        baseX = getProperty('camHUD.x')
        baseY = getProperty('camHUD.y')
        saved = true
    end
end

function onSectionHit()
    if curSection == 9 then
        doTweenAlpha('voidtween', 'void', 0, 3, 'linear')
    end

    if curSection == 16 then
        doTweenAlpha('hudtween', 'camHUD', 1, 1, 'linear')
    end

    if curSection == 81 then
        doTweenAlpha('hell', 'BGdark', 1, 0.1, 'linear')
    end

    if curSection >= 98 and curSection <= 114 then
        setProperty('void2.alpha', 1)
        doTweenAlpha('oid22', 'void2', 0, 0.7, 'linear')
    end

    if curSection == 186 then
        doTweenAlpha('gamtween', 'camGame', 5, 0.65, 'linear') -- only time i tween gamecam in here
    end

    if curSection == 190 then
        doTweenAlpha('hell', 'BGdark', 0, 6.1, 'linear')
    end

    if curSection == 194 then
        doTweenAlpha('voidtween', 'void', 1, 0.01, 'linear')
    end
end

function onTimerCompleted(tag, loops, loopsleft)
    if tag == "returnch" then
        setProperty('camHUD.alpha', 1)
    end
    if tag == "rsh" then
        resetHUD()
    end
    if tag == "bringthemback" then
        setProperty('bf.alpha', 1)
        setProperty('dad.alpha', 1)
    end
    if tag == "stopv3" then
        setProperty('void3.alpha', 0)
    end
    if tag == "stopv" then
        setProperty('void.alpha', 0)
    end
end

function instanttransmission()
    blinkEndTime = getSongPosition() + 0.08 * 1000

    local rx = getRandomFloat(-350, 350)
    local ry = getRandomFloat(-350, 350)

    setProperty('camHUD.x', 0 + rx)
    setProperty('camHUD.y', 0 + ry)
    runTimer('rsh', 0.09)
end

function resetHUD()
    setProperty('camHUD.x', 0)
    setProperty('camHUD.y', 0)
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        setProperty('health', getProperty('health') + 0.008)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if getProperty('health') > 0.25 then
       setProperty('health', getProperty('health') - 0.0095)
    end
end

function onBeatHit()
    if curBeat > 392 and curBeat < 745 then

        if math.random(1, 13) == 1 then -- Dejection Hud Glitch
            instanttransmission()
        end

        if math.random(1, 15) == 1 then -- Hud vanishing
            setProperty('camHUD.alpha', 0)
            runTimer('returnch', 0.09)
        end

        if math.random(1, 17) == 1 then -- Dissapearing Mickey/Bf
            if math.random(1, 2) == 1 then
                setProperty('dad.alpha', 0)
            else
                setProperty('bf.alpha', 0)
            end
            runTimer('bringthemback', 0.078)
        end

        if math.random(1, 16) == 1 then -- Black GAMECAM overlay
            setProperty('void3.alpha', 1)
            runTimer('stopv3', math.random(0.19, 0.192))
        end

        if math.random(1, 19) == 1 then -- Black GAMECAM overlay abovech
            setProperty('void.alpha', 1)
            runTimer('stopv', math.random(0.19, 0.199))
        end
    end
end