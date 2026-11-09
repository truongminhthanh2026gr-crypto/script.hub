loadstring([[
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("KynaroidObbyOnlyHub") then
    CoreGui.KynaroidObbyOnlyHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KynaroidObbyOnlyHub"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 130)
MainFrame.Position = UDim2.new(0.02, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextSize, Title.Font = 11, Enum.Font.SourceSansBold
Title.Text = "Open (made by: @TrươngMinhThành)"
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

local function makeBtn(name, posY, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.92, 0, 0, 32)
    btn.Position = UDim2.new(0.04, 0, 0, posY)
    btn.BackgroundColor3 = color or Color3.fromRGB(45, 45, 55)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize, btn.Font = 11, Enum.Font.SourceSansBold
    btn.Text = name
    btn.Parent = MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    return btn
end

local bObby = makeBtn("⚡ Instant *Khối Bạc* (Obby UGC)", 45, Color3.fromRGB(35, 95, 95))
local bClose = makeBtn("Close GUI", 85, Color3.fromRGB(80, 35, 35))

local function noclip()
    pcall(function()
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

bObby.MouseButton1Click:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local hrp = char.HumanoidRootPart
        
        local finalPlat = Workspace.End_Obby.Prize_Platform.FinalPlatform
        if finalPlat then
            noclip()
            hrp.CFrame = finalPlat.CFrame + Vector3.new(0, 5, 0)
            task.wait(0.3)
            for _, p in ipairs(Workspace:GetDescendants()) do
                if p:IsA("ProximityPrompt") then 
                    pcall(function() fireproximityprompt(p) end) 
                end
            end
        end
    end)
end)

bClose.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
]])()