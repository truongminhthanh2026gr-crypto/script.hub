loadstring([[
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

_G.AutoShard = false

local function getGuiParent()
	local ok, res = pcall(function()
		if gethui then return gethui() end
		return nil
	end)
	if ok and res then return res end

	local okCore = pcall(function()
		local t = Instance.new("Folder")
		t.Name = "_CheckGui"
		t.Parent = CoreGui
		t:Destroy()
	end)
	if okCore then return CoreGui end

	return PlayerGui
end

local GuiRoot = getGuiParent()

pcall(function()
	local old1 = PlayerGui:FindFirstChild("ThanhScript_UI")
	if old1 then old1:Destroy() end
	local old2 = GuiRoot:FindFirstChild("ThanhScript_UI")
	if old2 then old2:Destroy() end
end)

local function fireTouch(part)
	if part and part:IsA("BasePart") then
		local character = LocalPlayer.Character
		local rootPart = character and character:FindFirstChild("HumanoidRootPart")
		if rootPart then
			rootPart.CFrame = part.CFrame
			if firetouchinterest then
				firetouchinterest(rootPart, part, 0)
				task.wait()
				firetouchinterest(rootPart, part, 1)
			end
		end
	end
end

local function enterPortalB()
	local tamagotchi = Workspace:FindFirstChild("Tamagotchi")
	local newYork = tamagotchi and tamagotchi:FindFirstChild("NewYork")
	local portalNY = newYork and newYork:FindFirstChild("Portal_NewYork")
	local portalFolder = portalNY and portalNY:FindFirstChild("Portal")
	local portalB = portalFolder and portalFolder:FindFirstChild("Portal_B")

	if portalB then
		local portalPart = portalB:IsA("BasePart") and portalB or portalB:FindFirstChildWhichIsA("BasePart", true)
		if portalPart then
			fireTouch(portalPart)
			task.wait(1)
		end
	end
end

-- === GIAO DIỆN THÀNH SCRIPT ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ThanhScript_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = GuiRoot

local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 120, 0, 32)
OpenBtn.Position = UDim2.new(0, 14, 0.25, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
OpenBtn.TextColor3 = Color3.fromRGB(240, 244, 255)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 11
OpenBtn.Text = "Thành script"
OpenBtn.Visible = false
OpenBtn.Parent = ScreenGui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 8)
local openStroke = Instance.new("UIStroke", OpenBtn)
openStroke.Color = Color3.fromRGB(65, 70, 95)
openStroke.Thickness = 1.2

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 112)
MainFrame.Position = UDim2.new(0, 14, 0.18, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", MainFrame)
mainStroke.Color = Color3.fromRGB(50, 52, 70)
mainStroke.Thickness = 1.2

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 36)
Header.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
Header.BorderSizePixel = 0
Header.Parent = MainFrame
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local TitleLbl = Instance.new("TextLabel")
TitleLbl.Size = UDim2.new(1, -70, 1, 0)
TitleLbl.Position = UDim2.new(0, 12, 0, 0)
TitleLbl.BackgroundTransparency = 1
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.Font = Enum.Font.GothamBold
TitleLbl.TextSize = 12
TitleLbl.TextColor3 = Color3.fromRGB(245, 247, 255)
TitleLbl.Text = "Thành script"
TitleLbl.Parent = Header

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 24, 0, 24)
MinBtn.Position = UDim2.new(1, -56, 0.5, -12)
MinBtn.BackgroundColor3 = Color3.fromRGB(34, 35, 48)
MinBtn.TextColor3 = Color3.fromRGB(220, 224, 240)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 14
MinBtn.Text = "-"
MinBtn.Parent = Header
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -28, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(54, 24, 30)
CloseBtn.TextColor3 = Color3.fromRGB(255, 118, 132)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 11
CloseBtn.Text = "X"
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

do
	local dragging, dragStart, startPos
	Header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
			local delta = input.Position - dragStart
			MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
end

local Row = Instance.new("Frame")
Row.Size = UDim2.new(1, -16, 0, 42)
Row.Position = UDim2.new(0, 8, 0, 44)
Row.BackgroundColor3 = Color3.fromRGB(23, 23, 32)
Row.BorderSizePixel = 0
Row.Parent = MainFrame
Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 8)

local RowLbl = Instance.new("TextLabel")
RowLbl.Size = UDim2.new(1, -68, 1, 0)
RowLbl.Position = UDim2.new(0, 10, 0, 0)
RowLbl.BackgroundTransparency = 1
RowLbl.TextXAlignment = Enum.TextXAlignment.Left
RowLbl.Font = Enum.Font.GothamMedium
RowLbl.TextSize = 11
RowLbl.TextColor3 = Color3.fromRGB(228, 232, 248)
RowLbl.Text = "Auto Portal_B & Shards"
RowLbl.Parent = Row

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 50, 0, 24)
ToggleBtn.Position = UDim2.new(1, -58, 0.5, -12)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 10
ToggleBtn.Text = "OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(38, 40, 52)
ToggleBtn.TextColor3 = Color3.fromRGB(160, 168, 190)
ToggleBtn.Parent = Row
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

local StatusLbl = Instance.new("TextLabel")
StatusLbl.Size = UDim2.new(1, -16, 0, 16)
StatusLbl.Position = UDim2.new(0, 10, 0, 90)
StatusLbl.BackgroundTransparency = 1
StatusLbl.TextXAlignment = Enum.TextXAlignment.Left
StatusLbl.Font = Enum.Font.GothamMedium
StatusLbl.TextSize = 9
StatusLbl.TextColor3 = Color3.fromRGB(140, 146, 172)
StatusLbl.Text = "Trạng thái: Đang tắt"
StatusLbl.Parent = MainFrame

local runId = 0

local function startFarmLoop(id)
	task.spawn(function()
		pcall(enterPortalB)
		while task.wait(0.3) do
			if not _G.AutoShard or id ~= runId or not ScreenGui.Parent then
				break
			end
			pcall(function()
				local character = LocalPlayer.Character
				local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")
				if humanoidRootPart and humanoid and humanoid.Health > 0 then
					local tamagotchi = Workspace:FindFirstChild("Tamagotchi")
					local shardsFolder = tamagotchi and tamagotchi:FindFirstChild("Shards")
					if shardsFolder then
						for _, shardModel in pairs(shardsFolder:GetChildren()) do
							local targetPart = shardModel:FindFirstChildWhichIsA("BasePart", true)
							if targetPart and _G.AutoShard and id == runId then
								StatusLbl.Text = "Đang nhặt: " .. shardModel.Name
								fireTouch(targetPart)
								task.wait(0.1)
							end
						end
					end
				end
			end)
		end
	end)
end

ToggleBtn.MouseButton1Click:Connect(function()
	_G.AutoShard = not _G.AutoShard
	runId += 1
	if _G.AutoShard then
		ToggleBtn.Text = "ON"
		ToggleBtn.BackgroundColor3 = Color3.fromRGB(16, 185, 129)
		ToggleBtn.TextColor3 = Color3.fromRGB(10, 18, 15)
		StatusLbl.Text = "Đang vào Portal_B..."
		startFarmLoop(runId)
	else
		ToggleBtn.Text = "OFF"
		ToggleBtn.BackgroundColor3 = Color3.fromRGB(38, 40, 52)
		ToggleBtn.TextColor3 = Color3.fromRGB(160, 168, 190)
		StatusLbl.Text = "Trạng thái: Đang tắt"
	end
end)

MinBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
	OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = true
	OpenBtn.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
	_G.AutoShard = false
	runId += 1
	ScreenGui:Destroy()
end)
]])()
