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
    setProperty('void.alpha', 1)
    setProperty('LVignette.alpha', 0)
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

    if curSection == 4 then
        doTweenAlpha('voidFadeOut', 'void', 0, 10)
    end

    if curSection == 54 then
        doTweenAlpha('VignetteIn', 'Vignette', 1, 3)
        doTweenAlpha('LVignetteIn', 'LVignette', 1, 3) 
    end 

    if curSection == 86 then
        setProperty('void.alpha', 1)
        doTweenAlpha('voidFadeOut2', 'void', 0, 5)
        doTweenAlpha('LVignetteOut', 'LVignette', 0, 0.2) 
        doTweenAlpha('VignetteStrong', 'Vignette', 1, 0.2)
    end

    if curSection == 94 then
    doTweenAlpha('healthBarFade', 'healthBar', 0, 1)
    doTweenAlpha('healthBarBGFade', 'healthBarBG', 0, 1)
    doTweenAlpha('iconP1Fade', 'iconP1', 0, 1)
    doTweenAlpha('iconP2Fade', 'iconP2', 0, 1)

    for i = 4, 7 do
        noteTweenAlpha('playerNotes'..i, i, 0, 1)
    end

    for i = 0, 3 do
        noteTweenAlpha('oppNotes'..i, i, 0, 1)
    end
end
    if curSection == 102 then
        doTweenAlpha('voidFlash', 'void', 1, 0.1)
        doTweenAlpha('VignetteOff', 'Vignette', 0, 0.1)
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        setProperty('health', getProperty('health') + 0.008)
    end
end