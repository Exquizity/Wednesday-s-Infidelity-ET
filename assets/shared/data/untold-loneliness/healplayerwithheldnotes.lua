local damageAmount = 0.01
local sustainHeal = 0.008 

function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        setProperty('health', getProperty('health') + sustainHeal)
    end
end