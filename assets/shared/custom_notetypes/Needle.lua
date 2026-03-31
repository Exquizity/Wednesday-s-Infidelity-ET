function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Needle' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'nedle_assets'); 
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then 
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); 
				setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0.46);
			end
		end
	end
	--debugPrint('Script started!')
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if noteType == 'Needle' then
        characterPlayAnim('boyfriend', 'dodge', true)
    end
end

function noteMiss(id, noteData, noteType, isSustainNote)
    if noteType == 'Needle' then
        characterPlayAnim('boyfriend', 'hurt', true)
    end
end