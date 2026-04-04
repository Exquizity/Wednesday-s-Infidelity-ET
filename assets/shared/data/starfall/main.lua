function onCreate()
    makeLuaSprite('Vignette', 'suicideStreet/vignette', 0, 0)
    scaleLuaSprite('Vignette', 1, 1)
    setScrollFactor('Vignette', 1, 1)
    setObjectCamera('Vignette', 'other')
    addLuaSprite('Vignette', true)
    setProperty('gf.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('showComboNum', false)
    setProperty('showRating', false)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeTxt.visible', false)
end

-- (0 = invisible, , 1 = visible)
-- (0 = invisible, , 1 = visible)
-- (0 = invisible, , 1 = visible)

function onSectionHit()
    if curSection == 24 then
        setProperty('phase3.alpha', 1)
    end
end


function opponentNoteHit(id, direction, noteType, isSustainNote)
    if not isSustainNote then
        local newAlpha = getProperty('Vignette.alpha') - 0.00735
        doTweenAlpha('vignetteFade', 'Vignette', math.max(0, newAlpha), 0.1, 'linear')
    end
end