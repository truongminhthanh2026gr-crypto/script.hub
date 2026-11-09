loadstring([[
local p = game:GetService("Players").LocalPlayer
local c = {}
local function r()
    local ch = p.Character or p.CharacterAdded:Wait()
    local h = ch:WaitForChild("HumanoidRootPart", 5)
    local hu = ch:WaitForChild("Humanoid", 5)
    if not h or not hu then return end
    for _, o in ipairs(workspace:GetDescendants()) do
        if o.Name:lower():find("banana") and not c[o] then
            if hu.Health <= 0 then break end
            local t = o:IsA("BasePart") and o.CFrame or (o:IsA("Model") and o.PrimaryPart and o.PrimaryPart.CFrame)
            if t then
                h.CFrame = t + Vector3.new(0, 2.5, 0)
                task.wait(0.6)
                local pr = o:FindFirstChildOfClass("ProximityPrompt") or (o.Parent and o.Parent:FindFirstChildOfClass("ProximityPrompt"))
                if pr then fireproximityprompt(pr) end
                if o:IsA("BasePart") then firetouchinterest(h, o, 0) firetouchinterest(h, o, 1) end
                c[o] = true
                task.wait(0.4)
            end
        end
    end
end
p.CharacterAdded:Connect(function() task.wait(2) task.spawn(r) end)
task.spawn(r)
]])()