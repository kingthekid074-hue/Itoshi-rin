if getgenv().ItoshiGuiLoaded then return end
getgenv().ItoshiGuiLoaded = true

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Player = Players.LocalPlayer

local Theme = {
    Main = Color3.fromRGB(20, 20, 25),
    Accent = Color3.fromRGB(255, 0, 80), -- لون أحمر هجومي (Itoshi Style)
    Text = Color3.fromRGB(255, 255, 255)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ItoshiTweenHub"
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = Player:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 200, 0, 280)
MainFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Theme.Main
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "ITOSHI TWEEN 🚀"
Title.TextColor3 = Theme.Accent
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 20
Title.Parent = MainFrame

local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, 0, 0.8, 0)
Container.Position = UDim2.new(0, 0, 0.2, 0)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 5)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.Parent = Container

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = text
    btn.TextColor3 = Theme.Text
    btn.Parent = Container
    
    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            btn.BackgroundColor3 = Theme.Accent
        else
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
        callback(enabled)
    end)
end

-- إعدادات الـ Tween (السرعة)
local TweenSpeed = 0.5 -- نصف ثانية للوصول للجوهرة (سريع جداً لكن ليس انتقال لحظي)

CreateButton("Auto Gems (Tween Mode)", function(state)
    getgenv().AutoGems = state
end)

CreateButton("Auto Hoops (Tween Mode)", function(state)
    getgenv().AutoHoops = state
end)

-- دالة الطيران (Tween Function)
local function TweenTo(targetCFrame)
    local char = Player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- حساب المسافة لضبط الوقت (عشان ما يطير بسرعة خيالية تسبب كيك)
    local distance = (root.Position - targetCFrame.Position).Magnitude
    local time = distance / 300 -- سرعة 300
    
    local info = TweenInfo.new(time, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(root, info, {CFrame = targetCFrame})
    tween:Play()
    tween.Completed:Wait() -- ننتظر حتى يصل
end

-- Main Loops
task.spawn(function()
    while task.wait() do
        if getgenv().AutoGems then
            pcall(function()
                local container = game.Workspace:FindFirstChild("Hoops") or game.Workspace
                local char = Player.Character
                
                if char and char:FindFirstChild("HumanoidRootPart") then
                    for _, v in pairs(container:GetChildren()) do
                        if not getgenv().AutoGems then break end
                        
                        -- شرط دقيق للجوهرة
                        if v.Name == "Gem" and v:FindFirstChild("outerGem") then
                            if v.outerGem.Transparency < 1 then -- نتأكد أنها مرئية
                                TweenTo(v.outerGem.CFrame)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if getgenv().AutoHoops then
            pcall(function()
                local container = game.Workspace:FindFirstChild("Hoops") or game.Workspace
                local char = Player.Character
                
                if char and char:FindFirstChild("HumanoidRootPart") then
                    for _, v in pairs(container:GetChildren()) do
                        if not getgenv().AutoHoops then break end
                        
                        if string.find(v.Name, "Hoop") then
                            TweenTo(v.CFrame)
                        end
                    end
                end
            end)
        end
    end
end)
