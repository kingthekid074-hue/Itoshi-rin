-- إشعار بداية التشغيل
game.StarterGui:SetCore("SendNotification", {
    Title = "Loading Script...",
    Text = "Using Kavo UI (Stable Version)",
    Duration = 5,
})

if getgenv().MyScriptLoaded then return end
getgenv().MyScriptLoaded = true

-- الخدمات والمتغيرات
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- تحديث الشخصية عند الموت
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    RootPart = newChar:WaitForChild("HumanoidRootPart")
end)

-- منع الفصل (Anti-AFK)
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- --- تحميل مكتبة KAVO UI (الأخف والأضمن) ---
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Legends Of Speed | Mobile Master", "Midnight")

-- [Tab 1] Farming
local FarmTab = Window:NewTab("Farming")
local FarmSection = FarmTab:NewSection("Auto Collect")

FarmSection:NewToggle("Auto Gems (الجواهر)", "Teleports to gems", function(state)
    getgenv().AutoGems = state
end)

FarmSection:NewToggle("Auto Hoops (الدوائر)", "Collects Red/Blue/Yellow Hoops", function(state)
    getgenv().AutoHoops = state
end)

-- [Tab 2] Stats
local StatsTab = Window:NewTab("Stats")
local StatsSection = StatsTab:NewSection("Level Up")

StatsSection:NewToggle("Auto Rebirth", "Auto buy rebirths", function(state)
    getgenv().AutoRebirth = state
end)

-- [Tab 3] Player
local PlayerTab = Window:NewTab("Player")
local PlayerSection = PlayerTab:NewSection("Local Player")

PlayerSection:NewSlider("WalkSpeed", "Change your speed", 500, 16, function(s)
    if Humanoid then
        Humanoid.WalkSpeed = s
    end
end)

PlayerSection:NewToggle("Infinite Jump", "Jump in air", function(state)
    getgenv().InfJump = state
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if getgenv().InfJump and Humanoid then
        Humanoid:ChangeState("Jumping")
    end
end)

-- [Tab 4] Credits
local CreditTab = Window:NewTab("Info")
local CreditSection = CreditTab:NewSection("Created by You")
CreditSection:NewButton("Toggle UI (Right Shift)", "Click to hide/show", function()
    Library:ToggleUI()
end)

-- --- تشغيل اللوبات (Loops) ---

-- 1. تجميع الجواهر
task.spawn(function()
    while task.wait() do
        if getgenv().AutoGems then
            pcall(function()
                local container = game.Workspace:FindFirstChild("Hoops") or game.Workspace
                for _, item in pairs(container:GetChildren()) do
                    if item.Name == "Gem" and item:FindFirstChild("outerGem") then
                        if RootPart then
                            RootPart.CFrame = item.outerGem.CFrame
                            task.wait()
                        end
                    end
                end
            end)
        end
    end
end)

-- 2. تجميع الحلقات
task.spawn(function()
    while task.wait() do
        if getgenv().AutoHoops then
            pcall(function()
                local hoopsFolder = game.Workspace:FindFirstChild("Hoops")
                if hoopsFolder then
                    for _, hoop in pairs(hoopsFolder:GetChildren()) do
                        if string.find(hoop.Name, "Hoop") then
                            if RootPart then
                                RootPart.CFrame = hoop.CFrame
                                task.wait()
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- 3. Auto Rebirth
task.spawn(function()
    while task.wait(2) do
        if getgenv().AutoRebirth then
            pcall(function()
                local remote = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("rebirthEvent")
                if remote then
                    remote:FireServer("rebirthRequest")
                end
            end)
        end
    end
end)

-- 4. God Mode Hook
local success, err = pcall(function()
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()

        if method == "FireServer" and self.Name == "TakeDamage" then
            return nil 
        end
        
        return oldNamecall(self, ...)
    end)
    setreadonly(mt, truetruetruetruetruetruetruetretrutruerueاueالeالتلتشغ
