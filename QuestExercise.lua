-- Define exercises
local exercises = {
    "Do 20 push-ups!",
    "Plank for 60 seconds!",
    "Do 20 squats!",
    "Do 5 chin-ups!",
    "Do 5 pull-ups!",
}

-- Create frame and register event
local f = CreateFrame("Frame")
f:RegisterEvent("QUEST_TURNED_IN")

-- Event handler
f:SetScript("OnEvent", function(self, event, ...)
    if event == "QUEST_TURNED_IN" then
        -- Randomly select exercise
        local exercise = exercises[math.random(#exercises)]
        
        -- Display message
        print("|cffffff00Exercise time! " .. exercise .. "|r")
    end
end)
