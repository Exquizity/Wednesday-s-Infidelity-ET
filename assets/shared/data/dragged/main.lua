function onCreate()
    makeLuaSprite('Vignette', 'suicideStreet/vignette', 0, 0)
    setProperty('camHUD.alpha', 0)
    scaleLuaSprite('Vignette', 1, 1)
    setScrollFactor('Vignette', 1, 1)
    setObjectCamera('Vignette', 'other');
    addLuaSprite('Vignette', false)
    makeLuaSprite('void', '', -200, -200)
    makeGraphic('void', 1920, 1080, '000000')
    setScrollFactor('void', 0, 0)
    addLuaSprite('void', true)
    setProperty('void.alpha', 0)
    setProperty('gf.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('showComboNum', true)
    setProperty('showRating', true)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', true)
    setProperty('timeBarBG.visible', true)
    setProperty('timeTxt.visible', true)
end

function onCreatePost()
    scaleObject('dad', 1.3, 1.3) --whole new function for 1 line is so peak
    makeLuaSprite('void2', '', -200, -200)
    makeGraphic('void2', 1920, 1080, '000000')
    setScrollFactor('void2', 0, 0)
    addLuaSprite('void2', false)
    setProperty('void2.alpha', 0)
end

local function bgthing(val1, val2, val3) --val1 is the bg val 2 is bf val 3 is mickey 1 = visible 0 = invis
    setProperty('void2.alpha', val1)
    setProperty('bf.alpha', val2)
    setProperty('dad.alpha', val3)
end

function onSectionHit()
    if curSection == 7 then
        doTweenAlpha('hudtween', 'camHUD', 1, 1.2, 'linear')
    end
end
