function onCreate()
    setProperty("skipCountdown", false)
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
    setProperty('void.alpha', 0)
    setProperty('LVignette.alpha', 0)
    setProperty('gf.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('showComboNum', true)
    setProperty('showRating', true)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', true)
    setProperty('timeBarBG.visible', true)
    setProperty('timeTxt.visible', true)
    makeLuaText('text', 'test', 1250, 0, 625)
	setTextAlignment('text', 'Center')
	addLuaText('text')
	setTextSize('text', 40)
    setTextFont('vcr')
    setProperty('text.alpha', 0)
end

function onSectionHit()
    if curSection == 71 then
        doTweenAlpha('voidtweenors', 'void', 1, 0.2, 'linear')
    end
end

function onStepHit()
    if curStep == 80 then
        doTweenAlpha('texttween', 'text', 1, 0.5, 'sine')
        setTextString('text', 'Alright, alright,')
    end

    if curStep == 102 then
        setTextString('text', "Let's get this over with.")
    end

    if curStep == 125 then
        doTweenAlpha('texttween', 'text', 0, 0.5, 'sine')
    end

end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        setProperty('health', getProperty('health') + 0.008)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if getProperty('health') > 0.15 then
        setProperty('health', getProperty('health') - 0.016)
    end
end
