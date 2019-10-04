local addonName, addonTable = ...
local rotenable = false
local annoenable = false
local ticktime=60;
local runtick=GetTime()
local count = 0
AutoInviteGroup = addonTable

function print(msg) DEFAULT_CHAT_FRAME:AddMessage(msg) end


function IsPlayerInGuild(playerName)
    return GetGuildInfo(playerName)
end

function timerproc()
    if (annoenable) then
		if (runtick <= GetTime()) then
			runtick = GetTime() + ticktime
			local ids = {}
			count = count+1
			for key,value in ipairs({"大脚世界频道","世界频道","寻求组队","综合","交易","公会招募","世界防务"}) do
				id = GetChannelName(value)
				table.insert(ids,id)
				SendChatMessage("{三角}{三角}《Hello World》公会诚招各路IT精英，打造一个和谐，友爱，文明的公会，将于10月下旬打造一个团结高效的纯DKP团队，活动时间每周六下午1-5点，扰屏见谅{三角}{三角}"..count, "CHANNEL", nil, id)
			end
			print("已在"..table.concat(ids,",").."频道中喊话");
			
		end
    end
end


AutoInviteGroup.autoInviteFrame = CreateFrame("Frame", "AutoInviteGroup", UIParent)
AutoInviteGroup.autoInviteFrame:RegisterEvent("PLAYER_LOGIN")
AutoInviteGroup.autoInviteFrame:RegisterEvent("CHAT_MSG_WHISPER")
AutoInviteGroup.autoInviteFrame:SetScript("OnUpdate", function(self, event, ...)
	timerproc(arg);
end)
AutoInviteGroup.autoInviteFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		-- AutoInviteGroup:Initialize()
	end

	if event == "CHAT_MSG_WHISPER" then
	
		AutoInviteGroup:ProcessWhisper(...)
	end
end)


-- function AutoInviteGroup:Initialize()
-- 	if AutoInviteSettings == nil then
-- 		AutoInviteGroup:LoadDefaults()
-- 	else
-- 		AutoInviteGroup:ApplySavedVariables()
-- 	end
-- end






function AutoInviteGroup:ProcessWhisper(text, playerName)
	if not rotenable then
		return
	end
	if text == "123" then
		canInvite = CanGuildInvite()
		if canInvite then
			GuildInvite(playerName)
		end
		
	else
		SendChatMessage("我是自动喊话机器人，Hello World公会诚招各路IT人士，励志打造一个和谐，友爱，文明的公会，组织一个进度高效的副本团队和一个能打胜战的PVP团队", "WHISPER", nil, playerName)
		SendChatMessage("准备在10月下旬开组40人纯DKP团本，活动时间每周六下午1-5点，招最聪明的人，打最效率的魔兽！", "WHISPER", nil, playerName)
		SendChatMessage("具体细节可以私聊Typescript,如果他在线的话,公会官网github點com/classicalwow/homepage,里面有微信群，欢迎您的加入", "WHISPER", nil, playerName)
		SendChatMessage("在这里，您将拥有最先进的魔兽插件和辅助功能，如果您热爱魔兽，团结友爱，请先加入微信群，我再拉你们入公会", "WHISPER", nil, playerName)
	end
end

SLASH_AUTOINVITEGROUP1 = "/aig"
SLASH_AUTOINVITEGROUP2 = "/aig announce enable"
SLASH_AUTOINVITEGROUP3 = "/aig announce disable"
SLASH_AUTOINVITEGROUP4 = "/aig robot enable"
SLASH_AUTOINVITEGROUP5 = "/aig robot disable"
SLASH_AUTOINVITEGROUP6 = "/aig help"
SlashCmdList["AUTOINVITEGROUP"] = function(msg)
	if AutoInviteGroup:StringIsNullOrEmpty(msg) then
		AutoInviteGroup:PrintHelpInformation()
	end

	local slashCommandMsg = AutoInviteGroup:SplitString(msg, " ")
	local subCommand = slashCommandMsg[1]
	local subCommandMsg = nil

	if table.getn(slashCommandMsg) > 1 then
		subCommandMsg = slashCommandMsg[2]
	end

	if subCommand == "help" then
		AutoInviteGroup:PrintHelpInformation()
	end

	if subCommand == "announce" then
		if slashCommandMsg[2] == "enable" then
			runtick=GetTime()
			annoenable = true
			print("自动喊话已开启")
		end
		if slashCommandMsg[2] == "disable" then
			annoenable = false
			print("自动喊话已关闭")
		end
	end
	

	if subCommand == "robot" then
		if slashCommandMsg[2] == "enable" then
			rotenable = true
			print("自动机器人已开启")
		end
		if slashCommandMsg[2] == "disable" then
			rotenable = false
			print("自动机器人已关闭")
		end
	end
end

function AutoInviteGroup:StringIsNullOrEmpty(s)
	if s == nil or s == '' then
		return true
	end
end

function AutoInviteGroup:PrintHelpInformation()
	print("AutoInviteGroup Help Information")
	print("/aig, /aig help -- 帮助指令.")
	print("/aig announce enable -- 开启自动喊话.")
	print("/aig announce disable -- 关闭自动喊话.")
	print("/aig robot enable -- 如果挂机不在的情况，开启机器人对话.")
	print("/aig robot disable -- 关闭机器人对话.")
end



function AutoInviteGroup:SplitString(slashCommand, delimiter)
	result = {}
	for match in (slashCommand .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end

	return result
end

print("密我邀请进公会插件加载，默认关闭,更多帮助,开启请输入/aig,开启喊话前先确认加入了3个频道 /join 世界频道  /join 寻求组队 /join 大脚世界频道")