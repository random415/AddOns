local f = CreateFrame("Frame")

-- Event handler function
f:SetScript("OnEvent", function(self, event, arg1)
    if event == "QUEST_ACCEPTED" then
        local questIndex = arg1
        AddQuestWatch(questIndex, true)
        DEFAULT_CHAT_FRAME:AddMessage("New quest added to the tracker!")
    end
end)

-- Register event
f:RegisterEvent("QUEST_ACCEPTED")
