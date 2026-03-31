local cutscened = false
local isFadingNoise = false
local fadeProgress = 0

function onCreate()
	setProperty("skipCountdown", false)
	setProperty('isCameraOnForcedPos', true)
	makeLuaSprite('Vignette', 'suicideStreet/vignette', 0, 0)
	scaleLuaSprite('Vignette', 1, 1)
	setScrollFactor('Vignette', 1, 1)
	setObjectCamera('Vignette', 'other')
	addLuaSprite('Vignette', false)
	makeLuaSprite('BGdark', 'suicideStreet/streetDark', -1100, -200)
	scaleLuaSprite('BGdark', 1, 1)
	setScrollFactor('BGdark', 1, 1)
	addLuaSprite('BGdark', false)
	setProperty('BGdark.alpha', 0)
	makeLuaSprite('whitescreen', '', -200, -200)
	makeGraphic('whitescreen', 4000, 4000, 'FFFFFF')
	setScrollFactor('whitescreen', 0, 0)
	addLuaSprite('whitescreen', false)
	setProperty('whitescreen.alpha', 0)
	makeLuaSprite('void', '', -200, -200)
	makeGraphic('void', 4000, 4000, '000000')
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
	setProperty('camHUD.alpha', 1)
	doTweenZoom('camGameTween', 'camGame', 0.70, 0.01)
	doTweenX('camX', 'camFollow', 175, 0.01, 'circInOut')
	doTweenY('camY', 'camFollow', 400, 0.01, 'circInOut')
end

function onCreatePost()
	triggerEvent('Set RTX Data', '0,0,0,0,0,0,0,0.1972386549938,1,1,1,0.43828116887704,351.85554332893,3.40463938045', '')
end

function onSectionHit()
	if curSection == 3 then
		doTweenX('camX', 'camFollow', -200, 2, 'circInOut')
		doTweenY('camY', 'camFollow', 322, 2, 'circInOut')
	end
	if curSection == 4 then
		setProperty('isCameraOnForcedPos', false)
	end
end

function onBeatHit()
	if curBeat == 242 or curBeat == 258 or curBeat == 274 or curBeat == 290 or curBeat == 306 then
		setShaderFloat("screenShader", "NOISE_INTENSITY", 1)
		isFadingNoise = true
		fadeProgress = 0
        if curBeat == 306 then
            setProperty('void.alpha', 1)
        end
	end
end

function onStartCountdown()
    if isStoryMode then
        if cutscened == false then
            cutscened = true
            startVideo('IntroStory')
            return Function_Stop
        end
    end

    return Function_Continue
end

function onVideoFinished()
    startCountdown()
end

function onUpdate(elapsed)
	if isFadingNoise then
		fadeProgress = fadeProgress + elapsed
		if fadeProgress >= 1 then
			setShaderFloat("screenShader", "NOISE_INTENSITY", 0.3)
			isFadingNoise = false
		else
			local intensity = 1 - 0.7 * fadeProgress
			setShaderFloat("screenShader", "NOISE_INTENSITY", intensity)
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if isSustainNote then
		setProperty('health', getProperty('health') + 0.008)
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if getProperty('health') > 0.102 then
		setProperty('health', getProperty('health') - 0.0115)
	end
end