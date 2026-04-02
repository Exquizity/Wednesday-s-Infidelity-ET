local PassedSteps = 0
local running = false
local pressed = false
local dodged = false
local itera = 0

function onCreatePost()
    makeAnimatedLuaSprite('syringemickey', 'characters/Suicide', -845, -50)
    addAnimationByPrefix('syringemickey', 'dodge', 'Hit Mouse', 24, false)
    setObjectOrder('syringemickey', getObjectOrder('boyfriendGroup') + 1)
    scaleObject('syringemickey', 1.27, 1.27, true)
    addOffset('syringemickey','dodge', 0, 0)
    addLuaSprite('syringemickey', true)

    setProperty('syringemickey.alpha', 0)
end

function onEvent(eventName, value1, value2)
    if eventName == "Throw Syringe" and not running then
        PassedSteps = 0
        running = true
        pressed = false
        dodged = false

        setProperty('dad.alpha', 0)
        setProperty('syringemickey.alpha', 1)
        objectPlayAnimation('syringemickey', 'dodge', true)

        if getProperty('RED') ~= nil then
            setProperty('RED.alpha', 1)
            doTweenAlpha('redtween', 'RED', 0, 0.5, 'sine')
        end

        setProperty('isCameraOnForcedPos', true)
        setVar('ignoreCam', true)
        doTweenX('camX', 'camFollow', 200, 0.1, 'sine')
        doTweenY('camY', 'camFollow', 400, 0.1, 'sine')
    end
end

function onUpdate(elapsed)
    if running and not pressed and keyJustPressed('dodge') then
        pressed = true
    end

    if running and getProperty('syringemickey.animation.curAnim.finished') then
        setProperty('dad.alpha', 1)
        setProperty('syringemickey.alpha', 0)
    end
end

function onStepHit()
    if running then
        PassedSteps = PassedSteps + 1
    end

    if running and PassedSteps >= 8 then
        dodged = pressed
        setProperty('boyfriend.specialAnim', true)

        if dodged then
            objectPlayAnimation('boyfriend', 'dodge', true)
        else
            objectPlayAnimation('boyfriend', 'hurt', true)

            if itera == 0 or itera == 1 or getPropertyFromClass('backend.ClientPrefs', 'data.NerfMechanics') == true then
                setProperty('health', getProperty('health') - 0.25)
            else
                setProperty('health', getProperty('health') - 0.8)
            end
        end

        runTimer('wait', 0.4)

        running = false
        PassedSteps = 0
    end
end

function onTimerCompleted(tag)
    if tag == 'wait' then
        setProperty('boyfriend.specialAnim', false)
        setProperty('isCameraOnForcedPos', false)
        setVar('ignoreCam', false)
        setProperty('dad.alpha', 1)
        setProperty('syringemickey.alpha', 0)
    end
end