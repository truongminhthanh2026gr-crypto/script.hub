loadstring([[
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

_G.AutoMilkXP = true

local noclipConnection
noclipConnection = RunService.Stepped:Connect(function()
    if not _G.AutoMilkXP then
        if noclipConnection then noclipConnection:Disconnect() end
        return
    end
    local character = LocalPlayer.Character
    if character then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

local function safeTeleport(targetCF)
    local character = LocalPlayer.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if rootPart and humanoid and humanoid.Health > 0 then
        rootPart.CFrame = targetCF
        rootPart.Velocity = Vector3.new(0, 0, 0)
    end
end

local function autoClickContinue()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return end
    local startTime = tick()
    while tick() - startTime < 3.5 do
        if not _G.AutoMilkXP then break end
        local clickedAny = false
        for _, gui in ipairs(playerGui:GetDescendants()) do
            if (gui:IsA("TextButton") or gui:IsA("ImageButton")) and gui.Visible and gui.AbsoluteSize.X > 0 then
                local btnText = (gui:IsA("TextButton") and gui.Text) or gui.Name
                if string.find(string.lower(btnText), "continue") or string.find(string.lower(gui.Name), "continue") then
                    pcall(function()
                        for _, conn in ipairs(getconnections(gui.MouseButton1Click)) do conn:Fire() end
                        for _, conn in ipairs(getconnections(gui.Activated)) do conn:Fire() end
                    end)
                    clickedAny = true
                end
            end
        end
        task.wait(0.25)
        if not clickedAny and (tick() - startTime > 1) then break end
    end
end

local function getItemPrompt(itemObj)
    if not itemObj or not itemObj.Parent then return nil end
    for _, prompt in ipairs(itemObj:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") and prompt.Enabled then return prompt end
    end
    return nil
end

task.spawn(function()
    while task.wait(0.4) do
        if _G.AutoMilkXP then
            pcall(function()
                local character = LocalPlayer.Character
                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    local itemSpawns = Workspace:FindFirstChild("ItemSpawns")
                    local cashNPCs = Workspace:FindFirstChild("CashNPCs")
                    if itemSpawns then
                        for _, spawnFolder in ipairs(itemSpawns:GetChildren()) do
                            if not _G.AutoMilkXP then break end
                            local itemObj = spawnFolder:FindFirstChild("Item")
                            local prompt = getItemPrompt(itemObj)
                            if itemObj and prompt then
                                local targetPart = itemObj:FindFirstChild("Outline") or itemObj:IsA("BasePart") and itemObj or itemObj:FindFirstChildWhichIsA("BasePart", true)
                                if targetPart and targetPart.Transparency < 0.9 then
                                    safeTeleport(targetPart.CFrame + Vector3.new(0, 1, 0))
                                    task.wait(0.25)
                                    pcall(function() fireproximityprompt(prompt) end)
                                    task.wait(0.35)
                                    if cashNPCs then
                                        for _, npc in ipairs(cashNPCs:GetChildren()) do
                                            if not _G.AutoMilkXP then break end
                                            local npcPart = npc:IsA("BasePart") and npc or npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Head") or npc:FindFirstChildWhichIsA("BasePart", true)
                                            if npcPart then
                                                safeTeleport(npcPart.CFrame + Vector3.new(0, 1.5, 2.5))
                                                task.wait(0.35)
                                                for _, npcPrompt in ipairs(npc:GetDescendants()) do
                                                    if npcPrompt:IsA("ProximityPrompt") and npcPrompt.Enabled then pcall(function() fireproximityprompt(npcPrompt) end) end
                                                end
                                                autoClickContinue()
                                                task.wait(0.5)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)
]])()