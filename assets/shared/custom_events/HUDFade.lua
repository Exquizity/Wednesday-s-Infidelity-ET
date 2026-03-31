function onEvent(name, value1, value2)
    if name ~= 'HUDFade' then return end

    local fadeIn = tonumber(value1) == 1
    local duration = tonumber(value2) or 1

    -- Target alpha depending on fade direction
    local target = fadeIn and 1 or 0

    -- Fade alpha-based objects
    doTweenAlpha('hudAlpha', 'camHUD', target, duration, 'linear')
    doTweenAlpha('scoreAlpha', 'scoreTxt', target, duration, 'linear')

    -- Visibility-based objects (combo, rating, etc.)
    -- Psych Engine doesn't tween booleans, so we fake it with alpha
    setProperty('showComboNum', fadeIn)
    setProperty('showRating', fadeIn)

    -- Time bar elements
    doTweenAlpha('timeBarAlpha', 'timeBar', target, duration, 'linear')
    doTweenAlpha('timeBarBGAlpha', 'timeBarBG', target, duration, 'linear')
    doTweenAlpha('timeTxtAlpha', 'timeTxt', target, duration, 'linear')
end
