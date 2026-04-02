function onCreate()
    makeLuaSprite('whiteflash', '', -200, -200)
    makeGraphic('whiteflash', 1920, 1080, 'FFFFFF')
    setScrollFactor('whiteflash', 0, 0)
    setObjectCamera('whiteflash', 'other')
    addLuaSprite('whiteflash', true)
    setProperty('whiteflash.alpha', 0)

    makeLuaSprite('blackflash', '', -200, -200) --jjk reference trust
    makeGraphic('blackflash', 1920, 1080, 'FFFFFF')
    setScrollFactor('blackflash', 0, 0)
    setObjectCamera('blackflash', 'other')
    addLuaSprite('blackflash', true)
    setProperty('blackflash.alpha', 0)
end

function onEvent(name, value1, value2)
  if name == 'White Flash' then
      if string.lower(value1) ~= 'b' then
          setProperty('whiteflash.alpha', 1)
          doTweenAlpha('whiteflashbye', 'whiteflash', 0, 1, 'linear')
      else
          setProperty('whiteflash.alpha', 1)
          doTweenAlpha('whiteflashbye', 'whiteflash', 0, 1, 'linear')
      end
   end
end
