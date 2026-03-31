local baseX = 0
local baseY = 0
local saved = false
local blinkActive = false
local blinkEndTime = 0
local blinkdur = 0.08 
local maxX = 350
local maxY = 350

function onCreatePost()
    if not saved then
        baseX = getProperty('camHUD.x')
        baseY = getProperty('camHUD.y')
        saved = true
    end
end

function instanttransmission()
    if blinkActive then return end

    blinkActive = true
    blinkEndTime = getSongPosition() + blinkdur * 1000

    local rx = getRandomFloat(-maxX, maxX)
    local ry = getRandomFloat(-maxY, maxY)

    setProperty('camHUD.x', baseX + rx)
    setProperty('camHUD.y', baseY + ry)
end

function resetHUD()
    setProperty('camHUD.x', baseX)
    setProperty('camHUD.y', baseY)
end

function onUpdate(elapsed)
    if blinkActive then
        if getSongPosition() >= blinkEndTime then
            blinkActive = false
            resetHUD()
        end
    end
end

function onEvent(name, v1, v2)
    if name == 'DejectionHudGlitch' then
        instanttransmission()
    end
end
