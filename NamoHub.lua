--// Services        
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer

--// GUI Setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "NamoHubGui"
screenGui.ResetOnSpawn = false

-- Toggle Button
local toggleButton = Instance.new("ImageButton", screenGui)
toggleButton.Size = UDim2.new(0, 60, 0, 60)
toggleButton.Position = UDim2.new(0, 20, 0, 100)
toggleButton.Image = "rbxassetid://85482448718741"
toggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
toggleButton.AutoButtonColor = true
toggleButton.Draggable = true
toggleButton.ScaleType = Enum.ScaleType.Fit
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 12)

-- Main Frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 330, 0, 400)
mainFrame.Position = UDim2.new(0.5, -165, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
mainFrame.Visible = true

-- Header
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(0, 250, 0, 30)
title.Position = UDim2.new(0.5, 0, 0.5, 6)
title.AnchorPoint = Vector2.new(0.5, 0.5)
title.Text = "✨ Namo Hub ✨"
title.TextColor3 = Color3.fromRGB(255, 225, 85)
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.BackgroundTransparency = 1
title.TextWrapped = true

local closeButton = Instance.new("TextButton", header)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0.5, -15)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 65, 65)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.BorderSizePixel = 0
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6)

-- Container
local buttonContainer = Instance.new("Frame", mainFrame)
buttonContainer.Size = UDim2.new(1, -40, 0, 260)
buttonContainer.Position = UDim2.new(0, 20, 0, 60)
buttonContainer.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", buttonContainer)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 6)

-- Theme Colors
local themeColors = {
	Farm = Color3.fromRGB(255, 85, 0),               -- Lava
	Speed = Color3.fromRGB(100, 180, 255),           -- ไฟฟ้า
	["Auto Rebirth"] = Color3.fromRGB(100, 255, 150), -- ธรรมชาติ
	["Auto Hoop"] = Color3.fromRGB(180, 90, 255),    -- เวทมนตร์
	["Anti-AFK"] = Color3.fromRGB(255, 100, 150),    -- หัวใจ
	["Join Discord"] = Color3.fromRGB(90, 120, 255), -- น้ำเงินหรู
}

local emojiMap = {
	Farm = "🌋",
	Speed = "⚡",
	["Auto Rebirth"] = "🌱",
	["Auto Hoop"] = "🏀",
	["Anti-AFK"] = "🛡️",
	["Join Discord"] = "💬"
}

-- Create Button Function
local function createButton(name)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 45)
	btn.BackgroundColor3 = themeColors[name] or Color3.fromRGB(150, 150, 150)
	btn.Text = name .. " [" .. (name == "Anti-AFK" and "ON" or "OFF") .. "] " .. (emojiMap[name] or "")
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
	return btn
end

-- Speed Mode
local speedIndex = 2
local speedModes = {"Slow", "Normal", "Fast", "Insane"}
local speedDelays = {2.5, 1, 0.5, 0.2}
local speedColors = {
	Slow = Color3.fromRGB(150, 255, 180),
	Normal = Color3.fromRGB(100, 200, 255),
	Fast = Color3.fromRGB(255, 180, 60),
	Insane = Color3.fromRGB(255, 70, 70)
}

-- State Variables
local isFarming = false
local isRebirthing = false
local isHoop = false
local isAntiAfk = true

-- Farm Button
local farmButton = createButton("Farm")
farmButton.Parent = buttonContainer
farmButton.MouseButton1Click:Connect(function()
	isFarming = not isFarming
	farmButton.Text = "Farm [" .. (isFarming and "ON" or "OFF") .. "] 🌋"
	if isFarming then
		task.spawn(function()
			while isFarming do
				task.wait(speedDelays[speedIndex])
				for i = 1, 2 do
					if not isFarming then break end
					ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "City")
					ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Blue Orb", "City")
					ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", "Orange Orb", "City")
				end
			end
		end)
	end
end)

-- Speed Button
local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(1, 0, 0, 45)
speedButton.BackgroundColor3 = speedColors[speedModes[speedIndex]]
speedButton.Text = "Speed Mode: " .. speedModes[speedIndex] .. " ⚡"
speedButton.Font = Enum.Font.GothamBold
speedButton.TextSize = 16
speedButton.TextColor3 = Color3.new(1, 1, 1)
speedButton.BorderSizePixel = 0
Instance.new("UICorner", speedButton).CornerRadius = UDim.new(0, 10)
speedButton.Parent = buttonContainer

speedButton.MouseButton1Click:Connect(function()
	speedIndex = speedIndex % #speedModes + 1
	local mode = speedModes[speedIndex]
	speedButton.Text = "Speed Mode: " .. mode .. " ⚡"
	speedButton.BackgroundColor3 = speedColors[mode]
end)

-- Auto Rebirth
local rebirthButton = createButton("Auto Rebirth")
rebirthButton.Parent = buttonContainer
rebirthButton.MouseButton1Click:Connect(function()
	isRebirthing = not isRebirthing
	rebirthButton.Text = "Auto Rebirth [" .. (isRebirthing and "ON" or "OFF") .. "] 🌱"
	if isRebirthing then
		task.spawn(function()
			while isRebirthing do
				task.wait(3)
				ReplicatedStorage.rEvents.rebirthEvent:FireServer("rebirthRequest")
			end
		end)
	end
end)

-- Auto Hoop
local hoopButton = createButton("Auto Hoop")
hoopButton.Parent = buttonContainer
hoopButton.MouseButton1Click:Connect(function()
	isHoop = not isHoop
	hoopButton.Text = "Auto Hoop [" .. (isHoop and "ON" or "OFF") .. "] 🏀"
	if isHoop then
		task.spawn(function()
			while isHoop do
				task.wait(1)
				local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
				if hrp and workspace:FindFirstChild("Hoops") then
					for _, hoop in pairs(workspace.Hoops:GetDescendants()) do
						if not isHoop then break end
						if hoop:IsA("BasePart") then
							firetouchinterest(hoop, hrp, 0)
							firetouchinterest(hoop, hrp, 1)
						end
					end
				end
			end
		end)
	end
end)

-- Anti AFK
local antiAfkButton = createButton("Anti-AFK")
antiAfkButton.Parent = buttonContainer
antiAfkButton.MouseButton1Click:Connect(function()
	isAntiAfk = not isAntiAfk
	antiAfkButton.Text = "Anti-AFK [" .. (isAntiAfk and "ON" or "OFF") .. "] 🛡️"
end)

-- Discord Button
local discordButton = createButton("Join Discord")
discordButton.Text = "Join Discord 💬"
discordButton.Parent = buttonContainer
discordButton.MouseButton1Click:Connect(function()
	local discordInvite = "https://discord.gg/7ZmAgAFfBH"
	if setclipboard then
		setclipboard(discordInvite)
		game.StarterGui:SetCore("SendNotification", {
			Title = "📋 Discord Invite Copied!",
			Text = "Paste in your browser to join.",
			Duration = 5
		})
	else
		warn("This executor does not support setclipboard.")
	end
end)

-- Anti-AFK System
task.spawn(function()
	while true do
		task.wait(60)
		if isAntiAfk then
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
		end
	end
end)

-- Credit
local credit = Instance.new("TextLabel", mainFrame)
credit.Size = UDim2.new(1, 0, 0, 24)
credit.Position = UDim2.new(0.5, 0, 1, -10) -- ขยับขึ้นนิดนึง
credit.AnchorPoint = Vector2.new(0.5, 1)
credit.BackgroundTransparency = 1
credit.Text = "Created by Fourth696969"
credit.TextColor3 = Color3.fromRGB(200, 200, 200)
credit.TextSize = 14
credit.Font = Enum.Font.GothamBold
credit.TextXAlignment = Enum.TextXAlignment.Center

-- Toggle GUI
toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

closeButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)
