loadstring([[
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

_G.AutoShard = true

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

task.spawn(function()
    while task.wait(0.3) do
        if _G.AutoShard then
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
                            if targetPart and _G.AutoShard then
                                fireTouch(targetPart)
                                task.wait(0.1)
                            end
                        end
                    end
                end
            end)
        end
    end
end)
]])()