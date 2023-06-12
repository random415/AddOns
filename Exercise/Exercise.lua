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

-- Event handler
f:SetScript("OnEvent", function(self, event, ...)
    if event == "QUEST_TURNED_IN" or event == "PLAYER_LEVEL_UP" then
        -- Randomly select exercise and display message
        local exercise = exercises[math.random(#exercises)]
        print("|cffffff00Exercise time! " .. exercise .. "|r")
    end
end)
