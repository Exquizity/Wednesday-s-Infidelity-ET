function onCreate()
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Screamer' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'SCREAMERNOTE_assets')
            if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
                setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
            end
        end
    end
    makeAnimatedLuaSprite('Screamer', 'SCREAMER', 0, 0)
    setGraphicSize('Screamer', 1280, 720)
    updateHitbox('Screamer')
    setObjectCamera('Screamer', 'other')
    addLuaSprite('Screamer', true)
    addAnimationByPrefix('Screamer', 'scream', 'SCREAMER instancia', 40, false)
    setProperty('Screamer.visible', false)
end


function onSpawnNote(id, noteData, noteType, isSustainNote)
	if noteType == 'Screamer' then
		local prefixes = {'purple', 'blue', 'green', 'red'}
		local prefix = prefixes[noteData + 1]
		runHaxeCode([[
			var note = game.notes.members[]]..id..[[];
			note.animation.addByPrefix('idle', ']]..prefix..[[ instancia 1000', 24, true);
			note.animation.addByPrefix('confirm', ']]..prefix..[[ instancia 1000', 24, false);
			note.animation.play('idle');
		]])
	end
end


function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Screamer' then
        if getPropertyFromClass('backend.ClientPrefs', 'data.NerfMechanics') == true then
            setProperty('health', getProperty('health') - 0.25)
        else
            setProperty('health', getProperty('health') - 0.65)
        end
		setProperty('Screamer.visible', true)
		playAnim('Screamer', 'scream', true)
        playSound('static')
	end
end

function onUpdate()
    if getProperty('Screamer.animation.curAnim.finished') then
        setProperty('Screamer.visible', false)
    end
end


function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'Screamer' then

	end
end