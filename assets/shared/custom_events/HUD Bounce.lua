local hudBopIntensity = 0;
local bopShit = false
local firstRun = true
local runEvery = 2

function onEvent(eventName, value1, value2)
    if eventName == 'HUD Bounce' then
	
        if value1 == '' then
            bopShit = false
		else
            bopShit = true
			if firstRun then
				runEvery = 2
				firstRun = false
			else
				runEvery = 1
			end
        end
		
		if value2 == '' then
			hudBopIntensity = 1
		else
			hudBopIntensity = tonumber(value2)
		end
		
    end
end

function onBeatHit()
	if bopShit == true then

		if runEvery == 2 then
			if curBeat % 2 == 0 then
				local angle = 2 * hudBopIntensity
				local zoom = tostring(0.03 * hudBopIntensity)
				if curBeat % 4 == 2 then
					angle = -angle
					zoom = tostring(0.01 * hudBopIntensity)
				end
				setProperty('camHUD.angle', angle)
				doTweenAngle('hudTween', 'camHUD', 0, 0.8, 'backOut')
				triggerEvent('Add Camera Zoom', '0.07', zoom)
			end
		else
			if curBeat % 2 == 0 then
				setProperty('camHUD.angle', 2*hudBopIntensity)
				doTweenAngle('hudTween', 'camHUD', 0, 0.8, 'backOut')
				triggerEvent('Add Camera Zoom', '0.07', tostring(0.03 * hudBopIntensity))
			end
			
			if curBeat % 2 == 1 then
				setProperty('camHUD.angle', 2*-hudBopIntensity)
				doTweenAngle('hudTween', 'camHUD', 0, 0.8, 'backOut')
                triggerEvent('Add Camera Zoom', '0.07', tostring(0.01 * hudBopIntensity))
			end
		end
		
	end
end