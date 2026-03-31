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
    addLuaSprite('void2', false)
    setProperty('void.alpha', 0)
    setProperty('void2.alpha', 0)
    setProperty('gf.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('showComboNum', true)
    setProperty('showRating', true)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', true)
    setProperty('timeBarBG.visible', true)
    setProperty('timeTxt.visible', true)
end
function onSectionHit()
    if curSection == 41 then
        function opponentNoteHit()
            health = getProperty('health')
            if getProperty('health') > 0.1 then
                setProperty('health', health - 0.007);
            end
        end
    end
    if curSection > 40 and curSection < 53 or curSection > 57 and curSection < 65 then
        setProperty('void2.alpha', 1)
        doTweenAlpha('void2fadeout', 'void2', 0, 0.8)
    end
end
function onStepHit()
    if curStep == 656 then
        setProperty('dark.alpha', 1)
    end

    if curStep == 1624 then
        doTweenZoom('gamecamtween', 'camGame', 0.95, 5)
    end
    if curStep == 1642 then
        setProperty('void.alpha', 1)
    end
    if curStep == 1643 then
        setProperty('void.alpha', 0)
    end
    if curStep == 1644 then
        setProperty('void.alpha', 1)
    end
    if curStep == 1645 then
        setProperty('void.alpha', 0)
    end
    if curStep == 1646 then
        setProperty('void.alpha', 1)
    end
  
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        setProperty('health', getProperty('health') + 0.008)
    end
end