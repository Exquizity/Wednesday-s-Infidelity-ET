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
    math.randomseed(os.time())
    
end

function onStepHit()
    if curStep == 54 or curStep == 125 or curStep == 196 or curStep == 267 then
        doTweenAlpha('voiddd', 'void', 0, 1, 'sine')
    end

    if curStep == 88 or curStep == 160 or curStep == 228 then
        doTweenAlpha('voiddd', 'void', 1, 1, 'sine')
    end

end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        setProperty('health', getProperty('health') + 0.008)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if getProperty('health') > 0.11 then
       setProperty('health', getProperty('health') - 0.016)
    end
end