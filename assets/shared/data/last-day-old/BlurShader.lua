local shadername = "textureBlur"
local options = {BLUR_INTENSITY = 0.0, BLUR_SPEED = 3.0, POSITION_EFFECT = 0.5, SAMPLE_COUNT = 10, SAMPLE_OFFSET = 0.0005}
local started = false --ignore
local sysTime = 0 --ignore
local int = 2 -- Intensity
local Sectionofaffect = 120 -- Section
local duration = 5 -- Seconds

function onCreatePost()
    initLuaShader(shadername)
    setSpriteShader('boyfriend', shadername)
    for parameter, val in pairs(options) do
        setShaderFloat('boyfriend', parameter, val)
    end
end

function onSectionHit()
    if curSection == Sectionofaffect then
        started = true
        sysTime = os.clock()
    end
end

function onUpdatePost(elapsed)
    setShaderFloat('boyfriend', 'iTime', os.clock())
    if started == true then
        local timepassed = os.clock() - sysTime
        local prog = math.min(timepassed / duration, 1)
        setShaderFloat('boyfriend', 'BLUR_INTENSITY', prog * int)
    end
end