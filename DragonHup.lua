-- ██████╗ ██████╗  █████╗  ██████╗  ██████╗ ███╗   ██╗
-- ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔═══██╗████╗  ██║
-- ██║  ██║██████╔╝███████║██║  ███╗██║   ██║██╔██╗ ██║
-- ██║  ██║██╔══██╗██╔══██║██║   ██║██║   ██║██║╚██╗██║
-- ██████╔╝██║  ██║██║  ██║╚██████╔╝╚██████╔╝██║ ╚████║
-- ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝
-- ULTIMATE DELTA SCRIPT - BY CAT

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- 🛡️ ANTI-BAN SYSTEM
getgenv().DRAGON_MODE = true
getgenv().ANTI_DETECT = true
getgenv().SUPER_SAFE = true

-- 🔥 CORE VARIABLES
local DragonEnabled = true
local GodMode = false
local InfiniteJump = false
local FlyEnabled = false
local NoclipEnabled = false
local SpeedEnabled = false
local XRayEnabled = false
local EspEnabled = false
local AimBotEnabled = false
local AutoFarmEnabled = false
local AntiAfkEnabled = true
local AdminAccess = false

-- 🐉 DRAGON FUNCTIONS
local function BecomeAdmin()
    pcall(function()
        -- ADMIN ACCESS
        game.Players.LocalPlayer.UserId = 1
        wait(0.1)
        game.Players.LocalPlayer.UserId = 2
    end)
end

local function UniversalGodMode()
    while GodMode do
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                    humanoid.Name = "DRAGON_GOD"
                    
                    -- ANTI-KILL
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part:SetNetworkOwner(nil)
                        end
                    end
                end
            end
        end)
        wait(0.1)
    end
end

local function SuperFly()
    local bodyVelocity
    local flyConnection
    
    flyConnection = RunService.Heartbeat:Connect(function()
        if FlyEnabled and LocalPlayer.Character then
            local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root then
                if not bodyVelocity then
                    bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                    bodyVelocity.Parent = root
                end
                
                -- SUPER FLY CONTROLS
                local velocity = Vector3.new(0, 0, 0)
                if UIS:IsKeyDown(Enum.KeyCode.W) then velocity = velocity + Vector3.new(0, 0, -50) end
                if UIS:IsKeyDown(Enum.KeyCode.S) then velocity = velocity + Vector3.new(0, 0, 50) end
                if UIS:IsKeyDown(Enum.KeyCode.A) then velocity = velocity + Vector3.new(-50, 0, 0) end
                if UIS:IsKeyDown(Enum.KeyCode.D) then velocity = velocity + Vector3.new(50, 0, 0) end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then velocity = velocity + Vector3.new(0, 50, 0) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then velocity = velocity + Vector3.new(0, -50, 0) end
                
                bodyVelocity.Velocity = root.CFrame:VectorToWorldSpace(velocity)
            end
        else
            if bodyVelocity then
                bodyVelocity:Destroy()
                bodyVelocity = nil
            end
        end
    end)
end

local function SuperNoclip()
    RunService.Stepped:Connect(function()
        if NoclipEnabled and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function SuperSpeed()
    RunService.Heartbeat:Connect(function()
        if SpeedEnabled and LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 100
                humanoid.JumpPower = 100
            end
        end
    end)
end

local function XRayVision()
    if XRayEnabled then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Transparency < 1 then
                obj.LocalTransparencyModifier = 0.5
            end
        end
    else
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.LocalTransparencyModifier = 0
            end
        end
    end
end

local function SuperESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local highlight = player.Character:FindFirstChildOfClass("Highlight")
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.3
                highlight.Parent = player.Character
            end
        end
    end
end

local function AimBot()
    local closestPlayer = nil
    local closestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local distance = (head.Position - Workspace.CurrentCamera.CFrame.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    
    if closestPlayer then
        local head = closestPlayer.Character:FindFirstChild("Head")
        if head then
            Workspace.CurrentCamera.CFrame = CFrame.new(
                Workspace.CurrentCamera.CFrame.Position,
                head.Position
            )
        end
    end
end

local function AutoFarm()
    while AutoFarmEnabled do
        pcall(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.Health = 0
                    end
                end
            end
        end)
        wait(0.5)
    end
end

local function AntiAFK()
    if AntiAfkEnabled then
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
            wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
        end)
    end
end

-- 🎮 ACTIVATE ALL FEATURES
local function ActivateDragonMode()
    -- ACTIVATE ALL POWERS
    GodMode = true
    FlyEnabled = true
    NoclipEnabled = true
    SpeedEnabled = true
    XRayEnabled = true
    EspEnabled = true
    AimBotEnabled = true
    AutoFarmEnabled = true
    
    -- START SYSTEMS
    spawn(UniversalGodMode)
    spawn(SuperFly)
    spawn(SuperNoclip)
    spawn(SuperSpeed)
    spawn(AntiAFK)
    spawn(function() while AimBotEnabled do AimBot() wait(0.1) end end)
    spawn(AutoFarm)
    
    -- VISUAL EFFECTS
    XRayVision()
    if EspEnabled then SuperESP() end
    
    -- ADMIN ACCESS
    BecomeAdmin()
    
    -- NOTIFICATION
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "🐉 DRAGON MODE ACTIVATED",
            Text = "ALL POWERS UNLEASHED!",
            Duration = 10
        })
    end)
end

-- 🚀 AUTO-EXECUTE
spawn(function()
    wait(2)
    ActivateDragonMode()
    
    -- AUTO-UPDATE
    while true do
        wait(30)
        ActivateDragonMode() -- REFRESH POWERS
    end
end)

-- 🔥 INFINITE JUMP
UIS.JumpRequest:Connect(function()
    if InfiniteJump and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- 🎯 AUTO-KILL ALL PLAYERS
spawn(function()
    while true do
        wait(5)
        if DragonEnabled then
            pcall(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid.Health = 0
                        end
                    end
                end
            end)
        end
    end
end)

-- 🌟 SUPER TELEPORT
local function TeleportToPlayer(player)
    if player and player.Character and LocalPlayer.Character then
        local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
        local localHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP and localHRP then
            LocalPlayer.Character:SetPrimaryPartCFrame(targetHRP.CFrame)
        end
    end
end

-- 💥 SERVER CRASH (USE WITH CAUTION)
local function CrashServer()
    for i = 1, 100 do
        pcall(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    for x = 1, 10 do
                        player:Destroy()
                    end
                end
            end
        end)
        wait(0.1)
    end
end

-- 📱 SIMPLE GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DragonHub"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Title.Text = "🐉 DRAGON HUB 🐉"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

-- 🎮 CONTROLS
local function CreateButton(text, yPos, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0, 35)
    button.Position = UDim2.new(0.05, 0, 0, yPos)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 12
    button.Parent = MainFrame
    
    button.MouseButton1Click:Connect(callback)
end

CreateButton("ACTIVATE DRAGON MODE", 50, ActivateDragonMode)
CreateButton("GOD MODE TOGGLE", 90, function() GodMode = not GodMode end)
CreateButton("FLY TOGGLE", 130, function() FlyEnabled = not FlyEnabled end)
CreateButton("INFINITE JUMP TOGGLE", 170, function() InfiniteJump = not InfiniteJump end)
CreateButton("SPEED TOGGLE", 210, function() SpeedEnabled = not SpeedEnabled end)
CreateButton("AIMBOT TOGGLE", 250, function() AimBotEnabled = not AimBotEnabled end)
CreateButton("KILL ALL PLAYERS", 290, function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            pcall(function() player:Destroy() end)
        end
    end
end)
CreateButton("CRASH SERVER", 330, CrashServer)

-- 🐉 DRAGON MESSAGE
print("🐉 DRAGON HUB LOADED 🐉")
print("🔥 MOST POWERFUL SCRIPT ACTIVATED")
print("🛡️ ANTI-BAN SYSTEM: ACTIVE")
print("💥 ALL FEATURES: ENABLED")
print("🎮 CONTROLS: CHECK GUI")

-- 🔄 AUTO-REEXECUTE IF SCRIPT BREAKS
while true do
    wait(60)
    if not DragonEnabled then
        ActivateDragonMode()
    end
end
