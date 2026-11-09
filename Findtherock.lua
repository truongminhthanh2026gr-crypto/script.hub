loadstring([[
pcall(function() game:GetService("CoreGui").SmoothRockClickHub:Destroy() end)
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "SmoothRockClickHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 240, 0, 215)
frame.Position = UDim2.new(0.05, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.Active, frame.Draggable = true, true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
title.TextColor3 = Color3.fromRGB(0, 255, 128)
title.TextSize, title.Font = 11, Enum.Font.Code
title.Text = "🪨 Smooth & Slow Auto Rock 🪨"
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

local function makeBtn(text, posY, color)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(0.9, 0, 0, 30)
    b.Position = UDim2.new(0.05, 0, 0, posY)
    b.BackgroundColor3 = color or Color3.fromRGB(45, 45, 55)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize, b.Font = 11, Enum.Font.Code
    b.Text = text
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    return b
end

local bAuto    = makeBtn("⚡ Auto Farm Chậm & Chắc: [OFF]", 40, Color3.fromRGB(80, 40, 40))
local bReset   = makeBtn("🔄 Xóa Bộ Nhớ Đã Hốt", 75, Color3.fromRGB(50, 50, 80))
local bClose   = makeBtn("❌ Đóng Hub", 115, Color3.fromRGB(100, 30, 30))

bClose.Position = UDim2.new(0.05, 0, 0, 115)

local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Size = UDim2.new(0.9, 0, 0, 35)
statusLabel.Position = UDim2.new(0.05, 0, 0, 160)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.TextSize, statusLabel.Font = 10, Enum.Font.Code
statusLabel.Text = "Trạng thái: Sẵn sàng (Tốc độ mượt)..."

local plr = game:GetService("Players").LocalPlayer
local autoActive = false
local collectedRocks = {}

bAuto.MouseButton1Click:Connect(function()
    autoActive = not autoActive
    if autoActive then
        bAuto.Text = "⚡ Trạng thái: [ĐANG FARM CHẬM & CHẮC]"
        bAuto.BackgroundColor3 = Color3.fromRGB(40, 100, 60)
        statusLabel.Text = "Trạng thái: Đang tìm và đứng chờ click..."
        statusLabel.TextColor3 = Color3.fromRGB(255, 220, 0)
        
        task.spawn(function()
            while autoActive do
                pcall(function()
                    local char = plr.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local rocksFolder = workspace:FindFirstChild("Rocks")
                    
                    if hrp and rocksFolder then
                        local rocksList = rocksFolder:GetChildren()
                        local foundNew = false
                        
                        for _, rock in ipairs(rocksList) do
                            if not autoActive then break end
                            
                            if not collectedRocks[rock] then
                                local targetPart = rock:IsA("Model") and (rock.PrimaryPart or rock:FindFirstChildWhichIsA("BasePart")) or (rock:IsA("BasePart") and rock)
                                
                                if targetPart then
                                    foundNew = true
                                    
                                    hrp.CFrame = targetPart.CFrame + Vector3.new(0, 2, 0)
                                    task.wait(0.3) 
                                    if not autoActive then break end
                                    
                                    local clickDetector = rock:FindFirstChildWhichIsA("ClickDetector", true)
                                    if clickDetector then
                                        for i = 1, 3 do 
                                            if not autoActive then break end
                                            pcall(function()
                                                fireclickdetector(clickDetector)
                                            end)
                                            task.wait(0.1)
                                        end
                                    end
                                    
                                    collectedRocks[rock] = true
                                    statusLabel.Text = "Đã hốt xong: " .. rock.Name
                                    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
                                    task.wait(0.5) 
                                end
                            end
                        end
                        
                        if not foundNew then
                            statusLabel.Text = "Hết vật phẩm! Đang chờ respawn..."
                            statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
                            task.wait(3)
                            collectedRocks = {} 
                        end
                    end
                end)
                task.wait(0.5)
            end
        end)
    else
        bAuto.Text = "⚡ Auto Farm Chậm & Chắc: [OFF]"
        bAuto.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
        statusLabel.Text = "Trạng thái: Đã tắt."
        statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

bReset.MouseButton1Click:Connect(function()
    collectedRocks = {}
    statusLabel.Text = "Đã làm sạch lịch sử hốt đồ!"
    statusLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
end)

bClose.MouseButton1Click:Connect(function()
    autoActive = false
    gui:Destroy()
end)
]])()