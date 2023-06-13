local frame = CreateFrame("Frame")

-- Function to track a quest
local function TrackQuest(questIndex)
    AddQuestWatch(questIndex, true)
end

-- Event handler function
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "QUEST_ACCEPTED" then
        TrackQuest(arg1)
    elseif event == "QUEST_LOG_UPDATE" or event == "PLAYER_LOGIN" then
        for questIndex = 1, GetNumQuestLogEntries() do
            if not IsQuestWatched(questIndex) then
                TrackQuest(questIndex)
            end
        end
    end
end)

-- Register events
frame:RegisterEvent("QUEST_ACCEPTED")
frame:RegisterEvent("QUEST_LOG_UPDATE")
frame:RegisterEvent("PLAYER_LOGIN")

