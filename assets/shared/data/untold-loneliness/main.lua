function onCreate()
    makeLuaSprite('Vignette', 'suicideStreet/vignette', 0, 0)
    scaleLuaSprite('Vignette', 1, 1)
    setScrollFactor('Vignette', 1, 1)
    setObjectCamera('Vignette', 'other');
    addLuaSprite('Vignette', false)
    makeLuaSprite('void', '', -300, -300)
    makeGraphic('void', 2200, 2200, '000000')
    setScrollFactor('void', 0, 0)
    addLuaSprite('void', true)
    makeLuaSprite('void2', '', -200, -200)
    makeGraphic('void2', screenWidth * 2, screenHeight * 2, '000000')
    setScrollFactor('void2', 0, 0)
    addLuaSprite('void2', false) -- Changed to true for front layering, though 'other' is already top-level
    setObjectCamera('void2', 'other') 
    setProperty('void.alpha', 0.9)
    setProperty('void2.alpha', 0)
    setProperty('gf.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('showComboNum', false)
    setProperty('showRating', false)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('dad.alpha', 0.8)
    setProperty('boyfriend.alpha', 0.8)
end
function onSectionHit()
    if curSection == 18 then
    setProperty('dad.alpha', 0.9)
    setProperty('boyfriend.alpha', 0.9)
    setProperty('void.alpha', 0.7 )
    end
    if curSection == 36 then
    setProperty('dad.alpha', 1)
    setProperty('boyfriend.alpha', 1)
    setProperty('void.alpha', 0 )
    end
end