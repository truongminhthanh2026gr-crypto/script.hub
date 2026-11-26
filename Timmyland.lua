local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local keysFolder = workspace:WaitForChild("MorozKeys", 10)

local autoKeys = false
local TP_SPEED = 32
local AFTER_TP_DELAY = 0.25

local SCRIPT_NAME = "THÀNH SCRIPT"
local CHANNEL_NAME = "THÀNH SCRIPT"
local CHANNEL_LINK = "https://youtube.com/@minhthanhtruong-h8k?si=WG-lgHk8EKnyKg9q"
local GUI_OBJECT_NAME = "ThanhScriptGui"

local function attachGui(gui)
	if typeof(gethui) == "function" then
		local ok, res = pcall(gethui)
		if ok and typeof(res) == "Instance" and pcall(function() gui.Parent = res end) then return end
	end
	local okCore, core = pcall(function() return game:GetService("CoreGui") end)
	if okCore and typeof(core) == "Instance" and pcall(function() gui.Parent = core end) then return end
	gui.Parent = player:WaitForChild("PlayerGui")
end

local old = player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild(GUI_OBJECT_NAME)
if old then old:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = GUI_OBJECT_NAME
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999999

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 210, 0, 224)
mainFrame.Position = UDim2.new(0, 14, 0.24, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
mainFrame.BackgroundTransparency = 0.08
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(48, 48, 54)
stroke.Thickness = 1

local headerLbl = Instance.new("TextLabel", mainFrame)
headerLbl.Size = UDim2.new(1, -16, 0, 24)
headerLbl.Position = UDim2.new(0, 10, 0, 6)
headerLbl.BackgroundTransparency = 1
headerLbl.Text = SCRIPT_NAME
headerLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
headerLbl.TextXAlignment = Enum.TextXAlignment.Left
headerLbl.Font = Enum.Font.GothamBold
headerLbl.TextSize = 13

-- Nút 1: Auto Collect Keys (slow TP + nhặt)
local toggleBtn = Instance.new("TextButton", mainFrame)
toggleBtn.Size = UDim2.new(1, -12, 0, 32)
toggleBtn.Position = UDim2.new(0, 6, 0, 36)
toggleBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "AUTO COLLECT KEYS   [OFF]"
toggleBtn.TextColor3 = Color3.fromRGB(225, 225, 230)
toggleBtn.TextXAlignment = Enum.TextXAlignment.Left
toggleBtn.Font = Enum.Font.GothamSemibold
toggleBtn.TextSize = 11

local btn1Pad = Instance.new("UIPadding", toggleBtn)
btn1Pad.PaddingLeft = UDim.new(0, 8)

-- Nút 2: Tele instant tới nhà Giáng Sinh (không nhặt)
local tpHouseBtn = Instance.new("TextButton", mainFrame)
tpHouseBtn.Size = UDim2.new(1, -12, 0, 32)
tpHouseBtn.Position = UDim2.new(0, 6, 0, 74)
tpHouseBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
tpHouseBtn.BorderSizePixel = 0
tpHouseBtn.Text = "TP TO CHRISTMAS HOUSE"
tpHouseBtn.TextColor3 = Color3.fromRGB(225, 225, 230)
tpHouseBtn.TextXAlignment = Enum.TextXAlignment.Left
tpHouseBtn.TextTruncate = Enum.TextTruncate.AtEnd
tpHouseBtn.Font = Enum.Font.GothamSemibold
tpHouseBtn.TextSize = 11

local btn2Pad = Instance.new("UIPadding", tpHouseBtn)
btn2Pad.PaddingLeft = UDim.new(0, 8)

-- Nút 3: Sao chép liên kết kênh
local copyBtn = Instance.new("TextButton", mainFrame)
copyBtn.Size = UDim2.new(1, -12, 0, 30)
copyBtn.Position = UDim2.new(0, 6, 0, 112)
copyBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
copyBtn.BorderSizePixel = 0
copyBtn.Text = "COPY YT LINK"
copyBtn.TextColor3 = Color3.fromRGB(225, 225, 230)
copyBtn.TextXAlignment = Enum.TextXAlignment.Left
copyBtn.Font = Enum.Font.GothamSemibold
copyBtn.TextSize = 11

local btn3Pad = Instance.new("UIPadding", copyBtn)
btn3Pad.PaddingLeft = UDim.new(0, 8)

local statusLbl = Instance.new("TextLabel", mainFrame)
statusLbl.Size = UDim2.new(1, -16, 0, 22)
statusLbl.Position = UDim2.new(0, 10, 0, 148)
statusLbl.BackgroundTransparency = 1
statusLbl.Text = "Status: Idle"
statusLbl.TextColor3 = Color3.fromRGB(165, 165, 175)
statusLbl.TextXAlignment = Enum.TextXAlignment.Left
statusLbl.TextTruncate = Enum.TextTruncate.AtEnd
statusLbl.Font = Enum.Font.Gotham
statusLbl.TextSize = 10

local divider = Instance.new("Frame", mainFrame)
divider.Size = UDim2.new(1, -16, 0, 1)
divider.Position = UDim2.new(0, 8, 1, -28)
divider.BackgroundColor3 = Color3.fromRGB(40, 40, 46)
divider.BorderSizePixel = 0

local channelLbl = Instance.new("TextLabel", mainFrame)
channelLbl.Size = UDim2.new(1, -16, 0, 20)
channelLbl.Position = UDim2.new(0, 10, 1, -24)
channelLbl.BackgroundTransparency = 1
channelLbl.Text = CHANNEL_NAME
channelLbl.TextColor3 = Color3.fromRGB(190, 190, 200)
channelLbl.TextXAlignment = Enum.TextXAlignment.Left
channelLbl.Font = Enum.Font.GothamBold
channelLbl.TextSize = 10

attachGui(screenGui)

local function getTargetPart(obj)
	if not obj then return nil end
	if obj:IsA("BasePart") then return obj end
	for _, desc in ipairs(obj:GetDescendants()) do
		if desc:IsA("BasePart") then return desc end
	end
	return nil
end

local function slowTpTo(cf, shouldContinueFn)
	local char = player.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not root or not hum or hum.Health <= 0 then return false end

	local dist = (root.Position - cf.Position).Magnitude
	local dur = math.clamp(dist / TP_SPEED, 0.2, 15)

	local bv = Instance.new("BodyVelocity", root)
	bv.Velocity = Vector3.zero
	bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)

	local tw = TweenService:Create(root, TweenInfo.new(dur, Enum.EasingStyle.Linear), { CFrame = cf })
	tw:Play()

	while tw.PlaybackState == Enum.PlaybackState.Playing do
		if (shouldContinueFn and not shouldContinueFn()) or not root.Parent or hum.Health <= 0 then
			tw:Cancel()
			bv:Destroy()
			return false
		end
		task.wait(0.05)
	end

	bv:Destroy()
	return true
end

local function instantTpTo(cf)
	local char = player.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not root or not hum or hum.Health <= 0 then return false end

	pcall(function()
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
		root.CFrame = cf
	end)
	return true
end

local function touchPart(root, part)
	if not root or not root.Parent or not part or not part.Parent then return end
	if firetouchinterest then
		pcall(function()
			firetouchinterest(root, part, 0)
			task.wait(0.06)
			firetouchinterest(root, part, 1)
		end)
	end
end

local function copyToClipboard(text)
	if typeof(setclipboard) == "function" then
		pcall(setclipboard, text)
		return true
	elseif typeof(toclipboard) == "function" then
		pcall(toclipboard, text)
		return true
	end
	return false
end

toggleBtn.MouseButton1Click:Connect(function()
	autoKeys = not autoKeys
	if autoKeys then
		toggleBtn.Text = "AUTO COLLECT KEYS   [ON]"
		toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 120, 75)
		statusLbl.Text = "Status: Slow TP..."
	else
		toggleBtn.Text = "AUTO COLLECT KEYS   [OFF]"
		toggleBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
		statusLbl.Text = "Status: Idle"
	end
end)

tpHouseBtn.MouseButton1Click:Connect(function()
	local house = workspace:FindFirstChild("DedMorozHouse")
	local collisionObj = house and house:FindFirstChild("Collision")
	local targetPart = getTargetPart(collisionObj)

	if not targetPart then
		statusLbl.Text = "Status: Collision not found"
		return
	end

	statusLbl.Text = "Instant TP: Christmas House"
	instantTpTo(targetPart.CFrame + Vector3.new(0, (targetPart.Size.Y * 0.5) + 2, 0))
end)

copyBtn.MouseButton1Click:Connect(function()
	local ok = copyToClipboard(CHANNEL_LINK)
	if ok then
		statusLbl.Text = "Status: Copied YT Link!"
	else
		statusLbl.Text = "Status: No clipboard API"
	end
end)

task.spawn(function()
	while true do
		if autoKeys then
			keysFolder = keysFolder or workspace:FindFirstChild("MorozKeys")
			local char = player.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")

			if keysFolder and root then
				local parts = {}
				for _, desc in ipairs(keysFolder:GetDescendants()) do
					if desc:IsA("BasePart") and desc.Parent and desc.Transparency < 0.99 then
						table.insert(parts, desc)
					end
				end

				for i, part in ipairs(parts) do
					if not autoKeys then break end
					char = player.Character
					root = char and char:FindFirstChild("HumanoidRootPart")
					if root and part.Parent and part.Transparency < 0.99 then
						statusLbl.Text = string.format("TP (%d/%d): %s", i, #parts, part.Name)
						local arrived = slowTpTo(part.CFrame + Vector3.new(0, 1.5, 0), function()
							return autoKeys
						end)
						if arrived and autoKeys then
							touchPart(root, part)
							task.wait(AFTER_TP_DELAY)
						end
					end
				end
			end
		end
		task.wait(0.25)
	end
end)
