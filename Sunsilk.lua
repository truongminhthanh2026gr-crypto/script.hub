loadstring([[
-- Sunsilk Script Instant 3 UGC (All-in-One Pro Edition)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("SunsilInstantUGCUI") then
    CoreGui.SunsilInstantUGCUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SunsilInstantUGCUI"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 225)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 38)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.TextColor3 = Color3.fromRGB(255, 100, 180)
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Sunsilk Script Instant 3 UGC"
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

local function createButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, posY, 0)
    btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name .. ": TẮT"
    btn.Parent = MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    return btn
end

local ToggleCash = createButton("Auto ATM (Collider)", 0.21)
local ToggleNPC = createButton("Auto NPC Greeter (Train)", 0.44)
local ToggleTycoon = createButton("Auto Tycoon (Super Fast)", 0.67)

local cashRunning = false
local npcRunning = false
local tycoonRunning = false

ToggleCash.MouseButton1Click:Connect(function()
    cashRunning = not cashRunning
    ToggleCash.BackgroundColor3 = cashRunning and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    ToggleCash.Text = "Auto ATM: " .. (cashRunning and "BẬT" or "TẮT")
end)

ToggleNPC.MouseButton1Click:Connect(function()
    npcRunning = not npcRunning
    ToggleNPC.BackgroundColor3 = npcRunning and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    ToggleNPC.Text = "Auto NPC Greeter: " .. (npcRunning and "BẬT" or "TẮT")
end)

ToggleTycoon.MouseButton1Click:Connect(function()
    tycoonRunning = not tycoonRunning
    ToggleTycoon.BackgroundColor3 = tycoonRunning and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    ToggleTycoon.Text = "Auto Tycoon: " .. (tycoonRunning and "BẬT" or "TẮT")
end)

task.spawn(function()
    while true do
        task.wait(1.2)
        pcall(function()
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local hrp = char.HumanoidRootPart

            local userId = tostring(LocalPlayer.UserId)
            local tycoon = Workspace:FindFirstChild("Tycoons") and Workspace.Tycoons:FindFirstChild(userId)
            
            local weaverButton = nil
            local upgradeEvent = nil
            pcall(function()
                weaverButton = ReplicatedStorage["$_Weaver"].Behavior.Button.Pressed
                upgradeEvent = ReplicatedStorage["$_Weaver"].Behavior.PassiveIncome.Upgrade
            end)

            if not tycoon then return end

            if cashRunning then
                local collider = tycoon:FindFirstChild("entrance_atm") and tycoon.entrance_atm:FindFirstChild("Collider")
                if collider and collider:IsA("BasePart") then
                    hrp.CFrame = collider.CFrame + Vector3.new(0, 2, 0)
                    if weaverButton then weaverButton:InvokeServer(tycoon.entrance_atm) end
                end
            end

            if npcRunning then
                local greeter = tycoon:FindFirstChild("entrance_greeter")
                if greeter then
                    local targetPart = greeter:IsA("Model") and greeter.PrimaryPart or greeter:FindFirstChildWhichIsA("BasePart")
                    if targetPart then
                        hrp.CFrame = targetPart.CFrame + Vector3.new(0, 2, 2)
                        if upgradeEvent then
                            upgradeEvent:InvokeServer(greeter, 1)
                        elseif weaverButton then
                            weaverButton:InvokeServer(greeter)
                        end
                    end
                end
            end

            if tycoonRunning then
                for _, obj in ipairs(tycoon:GetDescendants()) do
                    if not tycoonRunning then break end
                    local n = obj.Name:lower()
                    if n:find("button") or n:find("buy") then
                        local targetPart = obj:IsA("Model") and obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                        if targetPart and targetPart:IsA("BasePart") then
                            hrp.CFrame = targetPart.CFrame + Vector3.new(0, 2, 0)
                            if weaverButton then weaverButton:InvokeServer(obj) end
                            task.wait(0.06)
                        end
                    end
                end
            end
        end)
    end
end)
]])()