if getgenv().ItoshiGuiLoaded then return end
getgenv().ItoshiGuiLoaded = true

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Player = Players.LocalPlayer

local Theme = {
    Main = Color3.fromRGB(20, 20, 25),
    Accent = Color3.fromRGB(0, 255, 255),
    Button = Color3.fromRGB(40, 40, 45),
    Text = Color3.fromRGB(255, 255, 255),
    On = Color3.fromRGB(0, 255, 100)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ItoshiHub_FinalFix"
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = Player:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 320)
MainFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Theme.Main
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Theme.Accent
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "ITOSHI HUB (FIX) 💎"
Title.TextColor3 = Theme.Accent
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

local Container = Instance.new("ScrollingFrame")
Container.Name = "Container"
Container.Size = UDim2.new(1, -20, 0.82, 0)
Container.Position = UDim2.new(0, 10, 0.16, 0)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.ScrollBarThickness = 2
Container.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 8)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.Parent = Container

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = Theme.Button
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = Container

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = btn
    
    local BtnTitle = Instance.new("TextLabel")
    BtnTitle.Size = UDim2.new(1, 0, 1, 0)
    BtnTitle.BackgroundTransparency = 1
    BtnTitle.Text = text
    BtnTitle.TextColor3 = Theme.Text
    BtnTitle.Font = Enum.Font.GothamSemibold
    BtnTitle.TextSize = 14
    BtnTitle.Parent = btn

    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        callback(enabled)
        if enabled then
            btn.BackgroundColor3 = Theme.Accent
            BtnTitle.TextColor3 = Color3.new(0,0,0)
        else
            btn.BackgroundColor3 = Theme.Button
            BtnTitle.TextColor3 = Theme.Text
        end
    end)
end

CreateButton("AUTO GEMS (SHAKE FIX)", function(state)
    getgenv().AutoGems = state
end)

CreateButton("Auto Hoops", function(state)
    getgenv().AutoHoops = state
end)

CreateButton("Auto Rebirth", function(state)
    getgenv().AutoRebirth = state
end)

CreateButton("Super Speed", function(state)
    getgenv().SuperSpeed = state
end)

CreateButton("Infinite Jump", function(state)
    getgenv().InfJump = state
end)

-- --- GEM FIX LOGIC ---
task.spawn(function()
    while task.wait() do
        if getgenv().AutoGems then
            pcall(function()
                local container = game.Workspace:FindFirstChild("Hoops") or game.Workspace
                local char = Player.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                
                if root then
                    for _, v in pairs(container:GetChildren()) do
                        if not getgenv().AutoGems then break end
                        
                        -- شرط الجوهرة
                        if v.Name == "Gem" and v:FindFirstChild("outerGem") then
                            local part = v.outerGem
                            if part.Transparency < 1 then -- تأكد أنها مرئية
                                
                                -- 1. الانتقال
                                root.CFrame = part.CFrame
                                
                                -- 2. الاهتزاز (Wiggle) لإجبار التلامس
                                root.CFrame = root.CFrame * CFrame.new(0, 2, 0)
                                task.wait(0.05)
                                root.CFrame = root.CFrame * CFrame.new(0, -2, 0)
                                
                                -- 3. محاولة إرسال Remote Event يدوياً (Bypass)
                                if ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("orbEvent") then
                                     ReplicatedStorage.rEvents.orbEvent:FireServer("collect", "Gem")
                                end

                                -- 4. استخدام firetouchinterest اذا كان مدعوما
                                if firetouchinterest then
                                    firetouchinterest(root, part, 0)
                                    firetouchinterest(root, part, 1)
                                end
                                
                                task.wait(0.15) -- انتظار أطول قليلاً لضمان التسجيل
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
                local root = Player.Character.HumanoidRootPart
                for _, v in pairs(container:GetChildren()) do
                    if not getgenv().AutoHoops then break end
                    if string.find(v.Name, "Hoop") and v:IsA("BasePart") then
                        root.CFrame = v.CFrame
                        if firetouchinterest then
                            firetouchinterest(root, v, 0)
                            firetouchinterest(root, v, 1)
                        end
                        task.wait()
                    end
                end
            end)
        end
    end
end)

RunService.Stepped:Connect(function()
    if getgenv().SuperSpeed and Player.Character then
        local hum = Player.Character:FindFirstChild("Humanoid")
        if hum then hum.WalkSpeed = 300 end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if getgenv().AutoRebirth then
            pcall(function()
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            end)
        end
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if getgenv().InfJump and Player.Character then
        Player.Character.Humanoid:ChangeState("Jumping")
    end
end)
