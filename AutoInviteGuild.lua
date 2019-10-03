local addonName, addonTable = ...
local enable = false
local ticktime=150;
local runtick=GetTime()
AutoInviteGroup = addonTable

function print(msg) DEFAULT_CHAT_FRAME:AddMessage(msg) end


function IsPlayerInGuild(playerName)
    return GetGuildInfo(playerName)
end

function timerproc()
    if (enable) then
		if (runtick <= GetTime()) then
			runtick = GetTime() + ticktime
			for key,value in ipairs({"大脚世界频道","交易","世界频道","寻求组队"}) do
				id = GetChannelName(value)
				SendChatMessage("《Hello World》公会诚招各路IT人士，打造一个和谐，友爱，文明的公会，将于10月下旬打造一个团结高效的纯DKP团队，活动时间每周六下午1-5点，欢迎IT人士的加盟,扰屏见谅", "CHANNEL", nil, id)
			end
			
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
		AutoInviteGroup:Initialize()
	end

	if event == "CHAT_MSG_WHISPER" then
	
		AutoInviteGroup:ProcessWhisper(...)
	end
end)


function AutoInviteGroup:Initialize()
	if AutoInviteSettings == nil then
		AutoInviteGroup:LoadDefaults()
	else
		AutoInviteGroup:ApplySavedVariables()
	end
end



function AutoInviteGroup:LoadDefaults()
	enable = false
end



function AutoInviteGroup:ProcessWhisper(text, playerName)
	if not enable then
		return
	end
	if text == "123" then
		canInvite = CanGuildInvite()
		if canInvite then
			print("can")
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
SLASH_AUTOINVITEGROUP2 = "/aig help"
SLASH_AUTOINVITEGROUP3 = "/aig enable"
SLASH_AUTOINVITEGROUP4 = "/aig disable"
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

	if subCommand == "enable" then
		enable = true
		runtick=GetTime()
		stopit = 0
	end

	if subCommand == "disable" then
		enable = false
		stopit = 1
	end
end

function AutoInviteGroup:StringIsNullOrEmpty(s)
	if s == nil or s == '' then
		return true
	end
end

function AutoInviteGroup:PrintHelpInformation()
	print("AutoInviteGroup Help Information")
	print("/aig, /aig help -- Displays help information for AutoInviteGroup addon.")
	print("/aig enable -- Turns on the AutoInviteGroup functionality.")
	print("/aig disable -- Turns off the AutoInviteGroup functionality.")
end



function AutoInviteGroup:SplitString(slashCommand, delimiter)
	result = {}

	for match in (slashCommand .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end

	return result
end

print("密我邀请进公会插件加载，默认关闭，开启请输入/aig enable")


GuildInvite("Nodejs-沙尔图拉")