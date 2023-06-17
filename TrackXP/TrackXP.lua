local frame = CreateFrame("FRAME", "TrackXP")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")

local playerXpBeforeCombat
local playerXpAfterCombat = UnitXP("player")
local combatStartTime
local combatEndTime

local function UpdateXpInfo()
    if not playerXpBeforeCombat then
        return
    end
    local xpGain = playerXpAfterCombat - playerXpBeforeCombat
    if xpGain > 0 then
        local playerXpMax = UnitXPMax("player")
        local xpToLevelUp = playerXpMax - playerXpAfterCombat
        local mobsToKill = math.ceil(xpToLevelUp / xpGain)
        local timeToKill = combatEndTime - combatStartTime
        local timeToLevel = mobsToKill * timeToKill
        local timeInMinutes = math.ceil(timeToLevel / 60)
        DEFAULT_CHAT_FRAME:AddMessage("|cffffff00You need to kill about " .. mobsToKill .. " more of the same mob to level up.|r")
        -- DEFAULT_CHAT_FRAME:AddMessage("|cffffff00At current pace, it will take you approximately " .. timeInMinutes .. " minutes to level up.|r")
    end
end

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_REGEN_DISABLED" then
        playerXpBeforeCombat = UnitXP("player")
        combatStartTime = GetTime()
    elseif event == "PLAYER_REGEN_ENABLED" then
        combatEndTime = GetTime()
        C_Timer.After(1, function()
            playerXpAfterCombat = UnitXP("player")
            UpdateXpInfo()
        end)
    end
end)
