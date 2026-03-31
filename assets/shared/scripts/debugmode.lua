function onCreatePost()
    if debug == true then
        luaDebugMode = true
        luaDeprecatedWarnings = true
        debugPrint([[



Debug Keybinds:
Z = Show UI
X = Practice Mode
C = Botplay Toggle
End = End Level
2 = Skip Level by 10s

]])
    debugPrint('NerfMechanics = ' .. tostring(getPropertyFromClass('backend.ClientPrefs', 'data.NerfMechanics')))
    end
end
