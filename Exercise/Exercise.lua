-- Create a frame to handle events
local frame = CreateFrame("Frame")

-- Register event handlers for quest completion and player leveling up
frame:RegisterEvent("QUEST_TURNED_IN")
frame:RegisterEvent("PLAYER_LEVEL_UP")

-- Define the possible exercises
local exercises = {
    "20 pushups",
    "60 seconds plank",
    "20 squats",
    "5 chin-ups",
    "5 pull-ups"
}

-- Initialize a count of each exercise
local exercise_count = {
    pushups = 0,
    plank = 0,
    squats = 0,
    chin_ups = 0,
    pull_ups = 0
}

-- Define event handler function
frame:SetScript("OnEvent", function(self, event)
    -- Select a random exercise
    local random_exercise = exercises[math.random(#exercises)]
    
    -- Update the count for the selected exercise
    if random_exercise == "20 pushups" then
        exercise_count.pushups = exercise_count.pushups + 20
    elseif random_exercise == "60 seconds plank" then
        exercise_count.plank = exercise_count.plank + 60
    elseif random_exercise == "20 squats" then
        exercise_count.squats = exercise_count.squats + 20
    elseif random_exercise == "5 chin-ups" then
        exercise_count.chin_ups = exercise_count.chin_ups + 5
    elseif random_exercise == "5 pull-ups" then
        exercise_count.pull_ups = exercise_count.pull_ups + 5
    end
end)

-- Define slash command to show current exercises
SLASH_EXERCISE1 = "/exercise"
SlashCmdList["EXERCISE"] = function(msg)
    -- Print current exercises in chat
    DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Push-ups: " .. exercise_count.pushups .. "|r")
    DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Plank (seconds): " .. exercise_count.plank .. "|r")
    DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Squats: " .. exercise_count.squats .. "|r")
    DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Chin-ups: " .. exercise_count.chin_ups .. "|r")
    DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Pull-ups: " .. exercise_count.pull_ups .. "|r")
end

-- Define slash command to reset exercises
SLASH_EXERCISED1 = "/exercised"
SlashCmdList["EXERCISED"] = function(msg)
    -- Reset exercises
    exercise_count = {
        pushups = 0,
        plank = 0,
        squats = 0,
        chin_ups = 0,
        pull_ups = 0
    }
    
    -- Print message indicating exercises have been reset
    DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Exercises reset!|r")
end