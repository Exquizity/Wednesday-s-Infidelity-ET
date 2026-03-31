local bgdarkonzoom = false
local lastBFChar = ''
local draininghealthdamage = 0.006

function onCreate()
    removeLuaSprite('BG')
    setProperty('gf.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('skipCountdown', true)
    setProperty('showComboNum', true)
    setProperty('showRating', true)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', true)
    setProperty('timeBarBG.visible', true)
    setProperty('timeTxt.visible', true)
    setProperty('camHUD.alpha', 0)
    makeLuaSprite('void', '', -200, -200)
    makeGraphic('void', 1920, 1080, '000000')
    setScrollFactor('void', 0, 0)
    addLuaSprite('void', true)
    setProperty('bg.color', 0xFF000000)

    makeLuaSprite('void2', '', -200, -200)
    makeGraphic('void2', 1920, 1080, 'ffffff')
    setScrollFactor('void2', 0, 0)
    addLuaSprite('void2', false)
    setProperty('bg.color', 0xFF000000)
    setProperty('void2.alpha', 0)

    makeLuaText('Lyrics', '', 1250, 0, 480)
	setTextAlignment('Lyrics', 'Center')
	addLuaText('Lyrics')
	setTextSize('Lyrics', 28)

    makeLuaSprite('Vignette', 'suicideStreet/vignette', 0, 0)
    scaleLuaSprite('Vignette', 1, 1)
    setScrollFactor('Vignette', 1, 1)
    addLuaSprite('Vignette', false)
    setObjectCamera('Vignette', 'other')

    makeLuaSprite('VignetteLight', 'suicideStreet/vignetteLight', 0, 0)
    scaleLuaSprite('VignetteLight', 1, 1)
    setScrollFactor('VignetteLight', 1, 1)
    addLuaSprite('VignetteLight', false)
    setObjectCamera('VignetteLight', 'other')
    setProperty('VignetteLight.alpha', 0)

    makeLuaSprite('BGdark', 'suicideStreet/streetDark', -1100, -200)
    scaleLuaSprite('BGdark', 1, 1)
    setScrollFactor('BGdark', 1, 1)
    addLuaSprite('BGdark', false)
    setProperty('BGdark.alpha', 0)

    makeLuaSprite('streetBroken', 'suicideStreet/streetBroken', -1100, -200)
    scaleLuaSprite('streetBroken', 1, 1)
    setScrollFactor('streetBroken', 1, 1)
    addLuaSprite('streetBroken', false)
    setProperty('streetBroken.alpha', 1)

    makeLuaSprite('streetBrokenDark', 'suicideStreet/streetBrokenDark', -1100, -200)
    scaleLuaSprite('streetBrokenDark', 1, 1)
    setScrollFactor('streetBrokenDark', 1, 1)
    addLuaSprite('streetBrokenDark', false)
    setProperty('streetBrokenDark.alpha', 0)
end

function onEvent(name, value1, value2)
    if name == 'Add Camera Zoom' and bgdarkonzoom then
        setProperty('streetBrokenDark.alpha', 0.2)
        doTweenAlpha('streetDarkTween', 'streetBrokenDark', 1, 0.8)
    end
end
function onUpdate(elapsed)
    local curChar = getProperty('boyfriend.curCharacter')
    if curChar ~= lastBFChar then
        lastBFChar = curChar
        if curChar == 'WistfulMouse' then
            addOffset('boyfriend', 'singDOWN', -89, -137)
            addOffset('boyfriend', 'singLEFT', -142, 57)
            addOffset('boyfriend', 'singRIGHT', -91, 34)
            addOffset('boyfriend', 'singUP', -149, 3)
        elseif curChar == 'mickeyDejection' then
            addOffset('boyfriend', 'singLEFT', -70, 13)
            addOffset('boyfriend', 'singDOWN', -8, -76)
            addOffset('boyfriend', 'singUP', 8, -46)
            addOffset('boyfriend', 'singRIGHT', -2, -12)
        elseif curChar == 'GoodEndingMouse' then
            addOffset('boyfriend', 'singLEFT', -166, -5)
            addOffset('boyfriend', 'singDOWN', -126, -254)
            addOffset('boyfriend', 'singUP', -213, -29)
            addOffset('boyfriend', 'singRIGHT', -61, -18)
        end
    end
end
function opponentNoteHit(id, direction, noteType, isSustainNote)
    local dad = getProperty('dad.curCharacter')
    if dad == 'mickeyLastDay' or dad == 'mickeyLastDayNM6' then
        if getProperty('health') > 0.1 then
            setProperty('health', getProperty('health') - healthDrainRate)
        end
    end
end

function onSectionHit()
    if curSection == 5 then
        doTweenAlpha('voidtween', 'void', 0, 5, 'linear')
    end
    if curSection == 6 then
        doTweenAlpha('hudtween', 'camHUD', 1, 4, 'linear')
    end
    if curSection == 65 then
        setProperty('void.alpha', 0)
        setProperty('healthBar.alpha', 1)
        setProperty('healthBarBG.alpha', 1)
        setProperty('iconP1.alpha', 1)
        setProperty('iconP2.alpha', 1)
        setProperty('scoreTxt.alpha', 1)
        removeLuaSprite('streetBroken')
        setProperty('streetBrokenDark.alpha', 1)
        bgdarkonzoom = true
    end
    if curSection == 138 then
        healthDrainRate = 0
        doTweenAlpha('fadebf', 'boyfriend', 0, 3, 'linear')
        doTweenAlpha('hudtween', 'camHUD', 0, 3, 'linear')
        doTweenZoom('slowZoom', 'camGame', 1.05, 4, 'sineInOut')
    end
    if curSection == 139 then
        setProperty('cpuControlled', true)
    end
    if curSection == 140 then
        doTweenAlpha('fadebf', 'boyfriend', 0.4, 0.8, 'linear')
        doTweenAlpha('darkfade', 'Vignette', 0, 0.8, 'linear')
        doTweenAlpha('lightfade', 'VignetteLight', 1, 0.8, 'linear')
        doTweenAlpha('dadFade', 'dad', 0.9, 3, 'linear')
    end
    if curSection == 141 then
        doTweenAlpha('fadebf', 'boyfriend', 0, 0.8, 'linear')
        doTweenAlpha('darkfade', 'Vignette', 1, 0.8, 'linear')
        doTweenAlpha('lightfade', 'VignetteLight', 0, 0.8, 'linear')
    end
    if curSection == 142 then
        doTweenAlpha('fadebf', 'boyfriend', 0.4, 0.8, 'linear')
        doTweenAlpha('darkfade', 'Vignette', 0, 0.8, 'linear')
        doTweenAlpha('lightfade', 'VignetteLight', 1, 0.8, 'linear')
        doTweenAlpha('dadFade', 'dad', 0.85, 3, 'linear')
    end
    if curSection == 143 then
        doTweenAlpha('fadebf', 'boyfriend', 0, 0.8, 'linear')
        doTweenAlpha('darkfade', 'Vignette', 1, 0.8, 'linear')
        doTweenAlpha('lightfade', 'VignetteLight', 0, 0.8, 'linear')
    end
    if curSection == 144 then
        doTweenAlpha('fadebf', 'boyfriend', 0.5, 1.5, 'linear')
        doTweenAlpha('darkfade', 'Vignette', 0, 1.5, 'linear')
        doTweenAlpha('lightfade', 'VignetteLight', 1, 1.5, 'linear')
        doTweenAlpha('dadFade', 'dad', 0.8, 3, 'linear')
    end
    if curSection == 145 then
        doTweenAlpha('fadebf', 'boyfriend', 0, 3, 'linear')
        doTweenAlpha('darkfade', 'Vignette', 1, 3, 'linear')
        doTweenAlpha('lightfade', 'VignetteLight', 0, 3, 'linear')
    end
if curSection == 146 then
    doTweenZoom('finalZoom', 'camGame', 1.2, 2.6, 'sineIn')
    addLuaSprite('void', false)
    doTweenAlpha('voidtween2', 'void2', 1, 2.2, 'linear')
    doTweenAlpha('streetFade', 'streetBrokenDark', 0, 2.2, 'linear')
    doTweenColor('dadBlack', 'dad', '000000', 2.2, 'linear')
end
    if curSection == 148 then
        setProperty('void.alpha', 1)
        setProperty('camHUD.alpha', 0)
    end
end

function onStepHit()
    if curStep == 1020 then
        setProperty('void.alpha', 1)
        for i = 0, 7 do
            noteTweenAlpha("note" .. i, i, 0, 1, "linear")
        end
        setProperty('healthBar.alpha', 0)
        setProperty('healthBarBG.alpha', 0)
        setProperty('iconP1.alpha', 0)
        setProperty('iconP2.alpha', 0)
        setProperty('scoreTxt.alpha', 0)
    end
    if curStep == 1032 then
        setTextString('Lyrics', '(Gun Loading)');
        doTweenAlpha('Lyricstween', 'Lyrics', 0, 1.6, 'linear')
        for i = 0, 7 do
            noteTweenAlpha("note" .. i, i, 1, 1, "linear")
        end
    end
end