function onCreate()
	makeAnimatedLuaSprite('Filter', 'suicideStreet/filter', 0, 0)
	addAnimationByPrefix('Filter', 'filter', 'pantalla', 24, true);
	playAnim('Filter', 'filter', true);
	scaleLuaSprite('Filter', 0.75, 0.75)
	setScrollFactor('Filter', 1, 1)
	setObjectCamera('Filter', 'other');
	addLuaSprite('Filter', false)

	makeLuaSprite('BG', 'versiculus/INFERNO_SKY', -500, -850)
	scaleLuaSprite('BG', 1, 1)
	setScrollFactor('BG', 1, 1)
	addLuaSprite('BG', false)

	makeLuaSprite('ground', 'versiculus/ROCK_BG', -500, 200)
	scaleLuaSprite('ground', 1, 1)
	setScrollFactor('ground', 1, 1)
	addLuaSprite('ground', false)
end
