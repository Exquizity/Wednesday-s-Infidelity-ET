function onCreate()
    makeLuaSprite('whiteflash', '', -200, -200)
    makeGraphic('whiteflash', 1920, 1080, 'FFFFFF')
    setScrollFactor('whiteflash', 0, 0)
    setObjectCamera('whiteflash', 'other')
    addLuaSprite('whiteflash', true)
    setProperty('whiteflash.alpha', 0)

    makeLuaSprite('blackflash', '', -200, -200) --jjk reference trust
    makeGraphic('blackflash', 1920, 1080, '000000')
    setScrollFactor('blackflash', 0, 0)
    setObjectCamera('blackflash', 'other')
    addLuaSprite('blackflash', true)
    setProperty('blackflash.alpha', 0)
end

function onEvent(name, value1, value2)
  if name == 'White Flash' then
      if value1 == 'b' or value1 == 'B' then
          setProperty('blackflash.alpha', 1)
          doTweenAlpha('blackflashff', 'blackflash', 0, 1, 'linear')
      else
          setProperty('whiteflash.alpha', 1)
          doTweenAlpha('whiteflashbye', 'whiteflash', 0, 1, 'linear')
      end
   end
end
