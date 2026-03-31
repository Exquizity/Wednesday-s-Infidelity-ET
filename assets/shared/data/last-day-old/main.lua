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
    setProperty('void.alpha', 0)
    setProperty('gf.visible', false)
    setProperty('scoreTxt.alpha', 0)
    setProperty('showComboNum', false)
    setProperty('showRating', false)
    setProperty('scoreTxt.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeTxt.visible', false)
    doTweenZoom('camGameTween', 'camGame', 0.8, 0.01)
    makeLuaText('Lyrics', '', 1250, 0, 480)
	setTextAlignment('Lyrics', 'Center')
	addLuaText('Lyrics')
	setTextSize('Lyrics', 28)
    precacheImage('whitebg')
end

function onStartCountdown()
	return Function_Continue;
end

function onSectionHit()
    if curSection == 8 then
        doTweenZoom('camGameTween', 'camGame', 0.87, 3)
    end

    if curSection == 64 then
        doTweenAlpha('voidtween', 'void', 1, 0.8, 'linear')
    end

    if curSection == 65 then
        doTweenAlpha('voidtween', 'void', 0, 1, 'linear')
    end

    if curSection == 137 then
        doTweenAlpha('fadebf', 'boyfriend', 0, 2.8, 'linear')
        for i = 4, 7 do
            noteTweenAlpha('bffadenotes'..i, i, 0, 2.8, 'linear')
        end
    end

    if curSection == 145 then
        for i = 0, 3 do
            noteTweenAlpha('bffadenotes'..i, i, 0, 2.8, 'linear')
        end
    end

    if curSection == 147 then
        doTweenAlpha('voidtween', 'void', 1, 0.5, 'linear')
    end
end  


function onBeatHit()
    if curBeat == 258 then
        setTextString('Lyrics', '(Gun Loading)');
        doTweenAlpha('Lyricstween', 'Lyrics', 0, 1.6, 'linear')

    end


end

-- other scripts

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        setProperty('health', getProperty('health') + 0.008)
    end
end



