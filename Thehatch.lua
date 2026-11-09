loadstring([[
pcall(function() game:GetService("CoreGui").TheHatchCleanHub:Destroy() end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TheHatchCleanHub"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 180)
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -15, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Color3.fromRGB(0, 255, 170)
TitleText.TextSize = 13
TitleText.Font = Enum.Font.Code
TitleText.Text = "⚡ THE HATCH [TELEPORT HUB]"
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local function createButton(name, posY, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 34)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.BackgroundColor3 = color or Color3.fromRGB(35, 35, 48)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.Font = Enum.Font.Code
    btn.Text = name
    btn.Parent = MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    return btn
end

local bTeleBoat = createButton("⛵ Tele to Boat", 52, Color3.fromRGB(40, 70, 100))
local bTeleUGC  = createButton("🎁 Tele to UGC", 92, Color3.fromRGB(90, 50, 100))
local bClose    = createButton("❌ Đóng Hub", 132, Color3.fromRGB(70, 25, 25))

local statusLabel = Instance.new("TextLabel", MainFrame)
statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
statusLabel.Position = UDim2.new(0.05, 0, 0, 145)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(140, 140, 160)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.Code
statusLabel.Text = "Status: Ready..."

local plr = game:GetService("Players").LocalPlayer

bTeleBoat.MouseButton1Click:Connect(function()
    pcall(function()
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local collider = workspace:FindFirstChild("FTUXCutscene") 
            and workspace.FTUXCutscene:FindFirstChild("Surfer") 
            and workspace.FTUXCutscene.Surfer:FindFirstChild("Collider")
        
        if hrp and collider and collider:IsA("BasePart") then
            hrp.CFrame = collider.CFrame + Vector3.new(0, 3, 0)
            statusLabel.Text = "Status: Teleported to Boat!"
            statusLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
        else
            statusLabel.Text = "Status: 'Collider' not found!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        end
    end)
end)

bTeleUGC.MouseButton1Click:Connect(function()
    pcall(function()
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local finaleUGC = workspace:FindFirstChild("FinaleController") 
            and workspace.FinaleController:FindFirstChild("FinaleUGC")
        
        local targetPart = nil
        if finaleUGC then
            if finaleUGC:IsA("BasePart") then
                targetPart = finaleUGC
            elseif finaleUGC:IsA("Model") then
                targetPart = finaleUGC.PrimaryPart or finaleUGC:FindFirstChildWhichIsA("BasePart", true)
            else
                targetPart = finaleUGC:FindFirstChildWhichIsA("BasePart", true)
            end
        end
        
        if hrp and targetPart and targetPart:IsA("BasePart") then
            hrp.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0)
            statusLabel.Text = "Status: Teleported to UGC!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 170, 0)
        else
            statusLabel.Text = "Status: 'FinaleUGC' not found!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        end
    end)
end)

bClose.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
]])()