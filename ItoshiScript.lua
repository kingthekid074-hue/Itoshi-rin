if getgenv().ItoshiGuiLoaded then return end
getgenv().ItoshiGuiLoaded = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Player = Players.LocalPlayer

local Theme = {
    Main = Color3.fromRGB(25, 25, 30),
    Accent = Color3.fromRGB(0, 255, 200),
    Button = Color3.fromRGB(40, 40, 45),
    Text = Color3.fromRGB(255, 255, 255),
    On = Color3.fromRGB(0, 255, 150),
    Off = Color3.fromRGB(40, 40, 45)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ItoshiHub_Ultimate"
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
Title.Text = "ITOSHI HUB ⚡"
Title.TextColor3 = Theme.Accent
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = MainFrame

local Line = Instance.new("Frame")
Line.Size = UDim2.new(0.8, 0, 0, 1)
Line.Position = UDim2.new(0.1, 0, 0.13, 0)
Line.BackgroundColor3 = Theme.Accent
Line.BorderSizePixel = 0
Line.Parent = MainFrame

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(0.85, 0, 0.02, 0)
MinBtn.BackgroundTransparency = 1
MinBtn.Text = "-"
MinBtn.TextColor3 = Theme.Text
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 24
MinBtn.Parent = MainFrame

local Container = Instance.new("ScrollingFrame")
Container.Name = "Container"
Container.Size = UDim2.new(1, -20, 0.82, 0)
Container.Position = UDim2.new(0, 10, 0.16, 0)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.ScrollBarThickness = 2
Container.ScrollBarImageColor3 = Theme.Accent
Container.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 8)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.Parent = Container

local IsMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    IsMinimized = not IsMinimized
    if IsMinimized then
        MainFrame:TweenSize(UDim2.new(0, 220, 0, 40), "Out", "Quad", 0.3, true)
        Container.Visible = false
        Line.Visible = false
        MinBtn.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 220, 0, 320), "Out", "Quad", 0.3, true)
        task.wait(0.2)
        Container.Visible = true
        Line.Visible = true
        MinBtn.Text = "-"
    end
end)

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
    BtnTitle.Size = UDim2.new(1, -40, 1, 0)
    BtnTitle.Position = UDim2.new(0, 10, 0, 0)
    BtnTitle.BackgroundTransparency = 1
    BtnTitle.Text = text
    BtnTitle.TextColor3 = Theme.Text
    BtnTitle.Font = Enum.Font.GothamSemibold
    BtnTitle.TextSize = 14
    BtnTitle.TextXAlignment = Enum.TextXAlignment.Left
    BtnTitle.Parent = btn
    
    local Status = Instance.new("Frame")
    Status.Size = UDim2.new(0, 10, 0, 10)
    Status.Position = UDim2.new(1, -25, 0.5, -5)
    Status.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Status.BorderSizePixel = 0
    Status.Parent = btn
    
    local StatusCorner = Instance.new("UICorner")
    StatusCorner.CornerRadius = UDim.new(1, 0)
    StatusCorner.Parent = Status

    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        callback(enabled)
        
        if enabled then
            TweenService:Create(Status, TweenInfo.new(0.2), {BackgroundColor3 = Theme.On}):Play()
            TweenService:Create(BtnTitle, TweenInfo.new(0.2), {TextColor3 = Theme.Accent}):Play()
            TweenService:Create(MainStroke, TweenInfo.new(0.5), {Color = Theme.On}):Play()
        else
            TweenService:Create(Status, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
            TweenService:Create(BtnTitle, TweenInfo.new(0.2), {TextColor3 = Theme.Text}):Play()
            TweenService:Create(MainStroke, TweenInfo.new(0.5), {Color = Theme.Accent}):Play()
        end
    end)
end

CreateButton("Auto Gems (Smart)", function(state)
    getgenv().AutoGems = state
end)

CreateButton("Auto Hoops (All)", function(state)
    getgenv().AutoHoops = state
end)

CreateButton("Auto Rebirth", function(state)
    getgenv().AutoRebirth = state
end)

CreateButton("Super Speed (300)", function(state)
    getgenv().SuperSpeed = state
end)

CreateButton("Infinite Jump", function(state)
    getgenv().InfJump = state
end)

task.spawn(function()
    while task.wait() do
        if getgenv().AutoGems then
            pcall(function()
                local container = game.Workspace:FindFirstChild("Hoops") or game.Workspace
                local char = Player.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                
                if root then
                    for _, gemModel in pairs(container:GetChildren()) do
                        if not getgenv().AutoGems then break end
                        if gemModel.Name == "Gem" then
                            for _, part in pairs(gemModel:GetDescendants()) do
                                if part:IsA("BasePart") and part:FindFirstChild("TouchInterest") then
                                    root.CFrame = part.CFrame
                                    if firetouchinterest then
                                        firetouchinterest(root, part, 0)
                                        firetouchinterest(root, part, 1)
                                    end
                                    task.wait()
                                    break 
                                end
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
                local root = char and char:FindFirstChild("HumanoidRootPart")
                
                if root then
                    for _, v in pairs(container:GetChildren()) do
                        if not getgenv().AutoHoops then break end
                        
                        if string.find(v.Name, "Hoop") then
                            if v:IsA("BasePart") then
                                root.CFrame = v.CFrame
                                if firetouchinterest then
                                    firetouchinterest(root, v, 0)
                                    firetouchinterest(root, v, 1)
                                end
                                task.wait()
                            end
                        end
                    end
                end
            end)
        end
    end
end)

RunService.Stepped:Connect(function()
    if getgenv().SuperSpeed then
        pcall(function()
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.WalkSpeed = 300
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(1) do
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

UserInputService.JumpRequest:Connect(function()
    if getgenv().InfJump and Player.Character then
        if Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid:ChangeState("Jumping")
        end
    end
end)
