-- Define exercises
local exercises = {
    "Do 20 push-ups!",
    "Plank for 60 seconds!",
    "Do 20 squats!",
    "Do 5 chin-ups!",
    "Do 5 pull-ups!",
}

-- Create frame and register events
local f = CreateFrame("Frame")
f:RegisterEvent("QUEST_TURNED_IN")
f:RegisterEvent("PLAYER_LEVEL_UP")
f:RegisterEvent("ADDON_LOADED")

-- Initialize exercise list
ExerciseList = ExerciseList or {}

-- Create UI Frame
local uiFrame = CreateFrame("Frame", "ExerciseAddonFrame", UIParent, "BasicFrameTemplateWithInset")
uiFrame:SetSize(200, 300)
uiFrame:SetPoint("CENTER")
uiFrame.title = uiFrame:CreateFontString(nil, "OVERLAY")
uiFrame.title:SetFontObject("GameFontHighlight")
uiFrame.title:SetPoint("LEFT", uiFrame.TitleBg, "LEFT", 5, 0)
uiFrame.title:SetText("Exercise List")
uiFrame.scrollFrame = CreateFrame("ScrollFrame", nil, uiFrame, "UIPanelScrollFrameTemplate")
uiFrame.scrollFrame:SetSize(150, 200)
uiFrame.scrollFrame:SetPoint("TOPLEFT", uiFrame, "TOPLEFT", 20, -30)
uiFrame.scrollChild = CreateFrame("Frame")
uiFrame.scrollChild:SetSize(150, 200)
uiFrame.scrollFrame:SetScrollChild(uiFrame.scrollChild)
uiFrame.scrollFrame.ScrollBar:ClearAllPoints()
uiFrame.scrollFrame.ScrollBar:SetPoint("TOPLEFT", uiFrame.scrollFrame, "TOPRIGHT", -12, -18)
uiFrame.scrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", uiFrame.scrollFrame, "BOTTOMRIGHT", -7, 18)
uiFrame:Hide()

-- Event handler
f:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...
        if name == "ExerciseAddon" then
            -- Restore saved exercise list, or default to empty list
            ExerciseList = ExerciseList or {}
        end
    elseif event == "QUEST_TURNED_IN" or event == "PLAYER_LEVEL_UP" then
        -- Randomly select exercise and add to list
        local exercise = exercises[math.random(#exercises)]
        table.insert(ExerciseList, exercise)

        -- Display message
        print("|cffffff00Exercise time! (" .. #ExerciseList .. " pending) " .. exercise .. "|r")
    end
end)

-- Create slash command to reset list
SLASH_EXERCISED1 = "/exercised"
SlashCmdList["EXERCISED"] = function(msg)
    -- Reset exercise list
    ExerciseList = {}
    print("|cffffff00Exercise list reset!|r")
end

-- Create slash command to show exercise list
SLASH_EXERCISE1 = "/exercise"
SlashCmdList["EXERCISE"] = function(msg)
    -- Clear old data
    for i = uiFrame.scrollChild:GetNumChildren(), 1, -1 do
        local child = select(i, uiFrame.scrollChild:GetChildren())
        child:Hide()
    end

    -- Create text fields for each exercise
    for i, exercise in ipairs(ExerciseList) do
        local textField = uiFrame.scrollChild:CreateFontString(nil, "OVERLAY")
        textField:SetFontObject("GameFontHighlight")
        textField:SetPoint("TOPLEFT", uiFrame.scrollChild, "TOPLEFT", 0, -(i-1)*15)
        textField:SetText(exercise)
    end

    -- Show frame
    uiFrame:Show()
end

