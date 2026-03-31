function onCreate()
    makeLuaSprite('fenceBg','backgrounds/BG_OSWALD', -600, -300)
    addLuaSprite('fenceBg',false)
    makeLuaSprite('dark','backgrounds/darkos', -600, -300)
    addLuaSprite('dark',false)
    setProperty('dark.alpha', 0)
end