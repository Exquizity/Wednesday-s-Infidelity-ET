local font = 'vcr.ttf'
local colour = '9B9B9B'
local activationstep = 1

local songName = 'Dejection (Old)'
local info = --Song Author, Sprite Maker, Charters, Extra Info
    '\nMusic Composed By: AlexStep8'..
    '\nSprites By: Wednesdays Infidelity'..
    '\nCharted By: Exquizity'..
    '\nVery old version of Dejection, VERY similar to Dejection in AlexStep8s Infidelity Pack'

function onCreatePost()
    makeLuaText('songname', songName, screenWidth, 0, screenHeight/2-100)
    setTextSize('songname', '65')
    setTextFont('songname', font)
    setTextAlignment('songname', 'center')
    setTextColor('songname', color)
    setTextBorder('songname', '000000')
	setObjectCamera('songname', 'other')
	setProperty('songname.antialiasing', false)
	setProperty('songname.alpha', 0)
    addLuaText('songname', true)
    makeLuaText('desc', info, screenWidth, 0, screenHeight/2-20)
	setTextSize('desc', 35)
	setTextFont('desc', font)
	setTextAlignment('desc', 'center')
	setTextColor('desc', colour)
	setTextBorder('desc', 0, '000000')
	setObjectCamera('desc', 'other')
	setProperty('desc.antialiasing', false)
	setProperty('desc.alpha', 0)
    addLuaText('desc', true)
end

function onStepHit()
    if curStep == activationstep then
        doTweenAlpha('songtween', 'songname', 1, 1, 'linear')
        doTweenAlpha('desctween', 'desc', 1, 1, 'linear')
        runTimer('finish', 6.5, 1)
    end
end

function onTimerCompleted(tag)
    if tag == 'finish' then
        doTweenAlpha('songtween', 'songname', 0, 1, 'linear')
        doTweenAlpha('desctween', 'desc', 0, 1, 'linear')
    end
end
