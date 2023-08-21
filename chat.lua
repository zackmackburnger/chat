runFunction(function()
    local chattag = {Enabled = false}
    chattag = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
        Name = "ChatTag",
        Function = function(callback)
            if callback then
				local githubURL = "https://raw.githubusercontent.com/zackmackburnger/coolerwhitelist/main/whitelist.json"
				local githubData = game:GetService("HttpService"):JSONDecode(game:HttpGet(githubURL))
				
				local textChatService = game:GetService("TextChatService")
				local players = game:GetService("Players")
				
				local private = {4930903778}
				local users = {4930903778}
				
				local function checkIfPrivatePlayer(userId)
					for prefix, data in pairs(githubData) do
						for _, id in ipairs(data.users) do
							if id == userId then
								return true, prefix
							end
						end
					end
					return false, nil
				end
				local Players = game:GetService("Players")
				local textChatService = game:GetService("TextChatService")
				textChatService.OnIncomingMessage = function(message)
					local properties = Instance.new("TextChatMessageProperties")
					if message.TextSource then
						local player = game:GetService("Players"):GetPlayerByUserId(message.TextSource.UserId)
						local userId = tostring(message.TextSource.UserId)
						local username2 = Players:GetNameFromUserIdAsync(userId)
						for prefix, data in pairs(githubData) do
							for _, id in ipairs(data.users) do
								if id == userId then
									properties.PrefixText = "<font color='" .. data.color .. "'>[" .. prefix .. "]</font> " .. message.PrefixText
									return properties
								else
									properties.PrefixText = "<font color='#A908B5'>[]</font> " .. message.PrefixText
								end
							end
						end
					end
					return properties
				end
			end
        end,
        HoverText = "For Vape V4 whitelisted users only | This will not work for non whitelisted users"
    })
end)
