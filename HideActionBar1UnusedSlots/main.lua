-- Create an addon frame to handle events
local addon = CreateFrame("Frame")

-- Function to update action bar buttons visibility
local function UpdateActionBarButtons()
    for i = 1, 12 do -- Loop through action bar slots 1 to 12
        local actionButton = _G["ActionButton" .. i]
        local actionType, spellID = GetActionInfo(actionButton.action)

        if actionType == "spell" and spellID then
            actionButton:Show()
        else
            actionButton:Hide()
        end
    end
end

-- Function to handle shapeshift events
local function OnShapeshiftChanged()
    UpdateActionBarButtons()
end

-- Register events for updating buttons when spells are cast, cooldowns change, or shapeshifts occur
addon:RegisterEvent("PLAYER_ENTERING_WORLD")
addon:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
addon:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")

-- Set up event handlers
addon:SetScript("OnEvent", function(_, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        UpdateActionBarButtons()
    elseif event == "UPDATE_SHAPESHIFT_FORM" or event == "UPDATE_SHAPESHIFT_FORMS" then
        OnShapeshiftChanged()
    end
end)