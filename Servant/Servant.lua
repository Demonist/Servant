-- It is a updated version of 'Servant' addon
-- The original addon was writed by Andrew O'Hara in 2009.

----------------------------
-- Sounds to play on leave of a combat --
----------------------------
local endCombat = {
	"EH_LichKing_Chapter1Whisper13.ogg",
	"EH_LichKing_Chapter1Whisper01.ogg",
	"EH_LichKing_Chapter1Whisper04.ogg",
	"EH_LichKing_Chapter3Shout03.ogg",
	"EH_LichKing_Chapter1Whisper03.ogg",
	"EH_LichKing_Chapter1Whisper05.ogg",
	"EH_LichKing_Chapter1Whisper12.ogg",
	"EH_LichKing_Chapter1Whisper13.ogg"
}
	
--------------------------------------
-- Sounds to play on new achievement --
--------------------------------------
local achievsounds = {
	"EH_LichKing_Greeting2.ogg",
	"EH_LichKing_Chapter3Shout13.ogg",
	"EH_LichKing_Farewell3.ogg",
	"EH_LichKing_Farewell4.ogg",
	"EH_LichKing_Chapter3Shout02.ogg"
}	

--------------------------------
-- Sounds to play on level up --
--------------------------------
local lvlsounds = { 
	"EH_LichKing_Farewell1.ogg",
	"EH_LichKing_Farewell2.ogg",
	"EH_LichKing_Greeting4.ogg",
	"EH_LichKing_Chapter3Shout16.ogg"
}	

-----------------------------
-- Sounds to play on death --
-----------------------------
local deathsounds = {
	"EH_LichKing_Chapter1Whisper08.ogg",
	"EH_LichKing_Chapter1Whisper07.ogg",
	"EH_LichKing_Chapter1Whisper09.ogg",
	"EH_LichKing_Chapter1Whisper15.ogg",
	"EH_LichKing_Chapter1Whisper16.ogg"
}	

local time = GetTime()
	
local function OnEvent(self, event)	
	if GetTime() > time + 3 then
		if event == "PLAYER_LEVEL_UP" then
			PlaySoundFile("Sound\\Creature\\LichKing\\"..lvlsounds[math.random(#lvlsounds)])
		elseif event == "ACHIEVEMENT_EARNED" then
			PlaySoundFile("Sound\\Creature\\LichKing\\"..achievsounds[math.random(#achievsounds)])
		elseif event == "PLAYER_DEAD" then
			if LichServantStorage["arena"] == false and IsActiveBattlefieldArena() then return; end
			PlaySoundFile("Sound\\Creature\\LichKing\\"..deathsounds[math.random(#deathsounds)])
		elseif event == "PLAYER_REGEN_ENABLED" and (math.random(4)) == 1 then
			PlaySoundFile("Sound\\Creature\\LichKing\\"..endCombat[math.random(#endCombat)])
		end
		
		time = GetTime()
	end
end

local eventFrame = CreateFrame("Frame")
eventFrame:SetScript("OnEvent", OnEvent)
eventFrame:RegisterEvent("PLAYER_LEVEL_UP")
eventFrame:RegisterEvent("ACHIEVEMENT_EARNED")
eventFrame:RegisterEvent("PLAYER_DEAD")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

if not LichServantStorage then LichServantStorage = {}; end
if not LichServantStorage["arena"] then LichServantStorage["arena"] = false; end

SLASH_LICHSERVANT1 = "/lichservant"
function SlashCmdList.LICHSERVANT(msg)
	if msg == "version" then
		DEFAULT_CHAT_FRAME:AddMessage("|cFFffff00Servant of the Lich King:|r Version - "..GetAddOnMetadata("Servant", "Version"))
	elseif msg == "arena" then
		if LichServantStorage["arena"] == true then
			LichServantStorage["arena"] = false
			DEFAULT_CHAT_FRAME:AddMessage("|cFFffff00Servant of the Lich King:|r PvP arena dead sounds are |cFFffc0c0disabled|r")
		else
			LichServantStorage["arena"] = true
			DEFAULT_CHAT_FRAME:AddMessage("|cFFffff00Servant of the Lich King:|r PvP arena dead sounds are |cFFc0ffc0enabled|r")
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("|cFFffff00Servant of the Lich King|r commands:")
		DEFAULT_CHAT_FRAME:AddMessage("   |cFFffff00/lichservant arena|r - toogle dead sounds on PvP arens")
		DEFAULT_CHAT_FRAME:AddMessage("   |cFFffff00/lichservant version|r - print the addon version")
	end
end
