function onCreate()
	makeLuaSprite('sky', 'hellhole/SKY', -400, -230)
	scaleLuaSprite('sky', 1, 1)
	setScrollFactor('sky', 1, 1)
	addLuaSprite('sky', false)

	makeLuaSprite('back', 'hellhole/Back', -400, -30)
	scaleLuaSprite('back', 1, 1)
	setScrollFactor('back', 1, 1)
	addLuaSprite('back', false)

    makeLuaSprite('ground', 'hellhole/infernogroundp1', -400, 30)
	scaleLuaSprite('ground', 1, 1)
	setScrollFactor('ground', 1, 1)
	addLuaSprite('ground', false)

	makeAnimatedLuaSprite('Filter', 'suicideStreet/filter', 0, 0)
	addAnimationByPrefix('Filter', 'filter', 'pantalla', 24, true);
	playAnim('Filter', 'filter', true);
	scaleLuaSprite('Filter', 0.75, 0.75)
	setScrollFactor('Filter', 1, 1)
	setObjectCamera('Filter', 'other');
	addLuaSprite('Filter', false)
end
