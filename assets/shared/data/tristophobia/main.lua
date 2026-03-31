function onCreate()
    setProperty('skipCountdown', true)
    setProperty('isCameraOnForcedPos', true)
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
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeTxt.visible', false)
    
end

function onCreatePost()
    for i = 0, 7 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
    end

    setProperty('healthBar.alpha', 0)
    setProperty('healthBarBG.alpha', 0)
    setProperty('iconP1.alpha', 0)
    setProperty('iconP2.alpha', 0)
end

function onStepHit()
    if curStep == 20 then
        doTweenAlpha('healthBarFade', 'healthBar', 1, 1, 'linear')
        doTweenAlpha('healthBarBGFade', 'healthBarBG', 1, 1, 'linear')
        doTweenAlpha('iconP1Fade', 'iconP1', 1, 1, 'linear')
        doTweenAlpha('iconP2Fade', 'iconP2', 1, 1, 'linear')
        doTweenZoom('camhameTween', 'camHUD', 2.5, 0.01)
        setVar('ignoreCam', true)
        doTweenX('camX', 'camFollow', 225, 0.01, 'circInOut')
        doTweenY('camY', 'camFollow', 400, 0.01, 'circInOut')
        doTweenZoom('camGameTween', 'camGame', 0.73, 1)
    end

    if curStep == 64 then
        doTweenAlpha('voidtwen', 'void', 0, 0.1, 'sine')
        doTweenZoom('camGameTween', 'camGame', 0.8, 8, 'sine')
    end

    if curStep == 128 then
        setProperty('timeBar.visible', true)
        setProperty('timeBarBG.visible', true)
        setProperty('timeTxt.visible', true)
        setProperty('isCameraOnForcedPos', false)
        setVar('ignoreCam', false)
        for i = 0, 7 do
            setPropertyFromGroup('strumLineNotes', i, 'alpha', 1)
        end
    end

    if curStep == 640 then
        setProperty('isCameraOnForcedPos', true)
        setVar('ignoreCam', true)
        doTweenX('camX', 'camFollow', 225, 1, 'circInOut')
        doTweenY('camY', 'camFollow', 400, 1, 'circInOut')
    end

    if curStep >= 656 and curStep < 896 then
        doTweenX('camX', 'camFollow', 225, 0.01, 'circInOut')
        doTweenY('camY', 'camFollow', 400, 0.01, 'circInOut')
    end


    if curStep == 897 then
        setProperty('isCameraOnForcedPos', false)
        setVar('ignoreCam', false)
    end

    if curStep == 1288 then
        doTweenAlpha('voidtwen', 'void', 1, 1, 'sine')
        doTweenZoom('camGameTween', 'camGame', 0.5, 8, 'sine')
    end

end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        setProperty('health', getProperty('health') + 0.008)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if getProperty('health') > 0.2 then
       setProperty('health', getProperty('health') - 0.011)
    end
end