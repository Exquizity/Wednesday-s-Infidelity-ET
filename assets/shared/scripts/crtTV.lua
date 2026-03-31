--[[
    Simplified RGB Shift and Noise Shader by mr_chaoss
    - Constant RGB split on all three channels
    - Static film grain noise

    Original Shader: https://www.shadertoy.com/view/sl3GDr
]]

local shaderName = "crtTV"

local params = {
    -- RGB Parameters (initial values, will be updated dynamically)
    RGB_SHIFT_R = 0.0005,
    RGB_SHIFT_G = -0.0005,
    RGB_SHIFT_B = 0.0,
    
    -- Noise Parameters
    NOISE_SCALE = 75.0,
    NOISE_INTENSITY = 0.06,
    REFRESH_FLICKER = 5.0  -- Controls noise animation speed; lower for slower
}

local fixedMagnitude = nil
local minMagnitude = 0.0005
local maxAdded = 0.0033

function onCreate()
    initLuaShader(shaderName)
    
    makeLuaSprite("screenShader")
    makeGraphic("screenShader", screenWidth, screenHeight)
    setSpriteShader("screenShader", shaderName)
    addHaxeLibrary("ShaderFilter", "openfl.filters")
    
    runHaxeCode([[
        var shader = game.getLuaObject("screenShader").shader;
        var filter = new ShaderFilter(shader);
        game.camGame.setFilters([filter]);
        game.camHUD.setFilters([filter]);
    ]])

    for param, value in pairs(params) do
        setShaderFloat("screenShader", param, value)
    end
    
    -- Fixed logic for specific songs using proper Psych Engine songName variable
    local songLower = string.lower(songName):gsub(' ', '-')
    if songLower == 'last-day' then
        fixedMagnitude = minMagnitude + 0.65 * maxAdded
    elseif songLower == 'cruel-world' then
        fixedMagnitude = minMagnitude + 0.35 * maxAdded
    end
end

function onUpdate(elapsed)
    local time = os.clock()
    setShaderFloat("screenShader", "iTime", time)
    
    local magnitude
    if fixedMagnitude ~= nil then
        magnitude = fixedMagnitude
    else
        local health = getProperty('health')
        magnitude = 0.0005 + ((2 - health) / 2) * 0.0033
    end
    
    local shift_r = magnitude
    local shift_g = -magnitude
    local shift_b = 0.0
    
    setShaderFloat("screenShader", "RGB_SHIFT_R", shift_r)
    setShaderFloat("screenShader", "RGB_SHIFT_G", shift_g)
    setShaderFloat("screenShader", "RGB_SHIFT_B", shift_b)
end