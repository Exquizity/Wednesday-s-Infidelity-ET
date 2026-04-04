function onCreate()
    makeLuaSprite('fenceBg','backgrounds/BG_OSWALD', -700, -300)
    scaleLuaSprite('fenceBg', 1.02, 1.02)
    addLuaSprite('fenceBg',false)
    makeLuaSprite('dark','backgrounds/darkos', -700, -300)
    addLuaSprite('dark',false)
    setProperty('dark.alpha', 0)

    makeLuaSprite('phase3','backgrounds/OSWALD-STARFALL-PHASES/PHASE3', -700, -300)
    addLuaSprite('phase3',false)
    setProperty('phase3.alpha', 0)
end