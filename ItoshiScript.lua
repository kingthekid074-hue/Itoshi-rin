if getgenv().MyGuiLoaded then return end
getgenv().MyGuiLoaded = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Player = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ItoshiHub"
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = Player:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 200, 0, 250)
MainFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
Title.Text = "⚡ Itoshi Hub ⚡"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 18
Title.Parent = MainFrame

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -30, 0, 0)
MinBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.TextSize = 20
MinBtn.Parent = MainFrame

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -30)
ContentFrame.Position = UDim2.new(0, 0, 0, 30)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local IsMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    IsMinimized = not IsMinimized
    ContentFrame.Visible = not IsMinimized
    if IsMinimized then
        MainFrame.Size = UDim2.new(0, 200, 0, 30)
        MinBtn.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 200, 0, 250)
        MinBtn.Text = "-"
    end
end)

local function CreateButton(text, order, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, 10 + (order * 40))
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.Parent = ContentFrame
    
    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            btn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        else
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        end
        callback(enabled)
    end)
end

getgenv().AutoGems = false
CreateButton("Auto Gems", 0, function(state)
    getgenv().AutoGems = state
end)

getgenv().AutoHoops = false
CreateButton("Auto Hoops", 1, function(state)
    getgenv().AutoHoops = state
end)

getgenv().AutoRebirth = false
CreateButton("Auto Rebirth", 2, function(state)
    getgenv().AutoRebirth = state
end)

getgenv().SuperSpeed = false
CreateButton("Super Speed (300)", 3, function(state)
    getgenv().SuperSpeed = state
end)

getgenv().InfJump = false
CreateButton("Infinite Jump", 4, function(state)
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
                    for _, v in pairs(container:GetChildren()) do
                        if v.Name == "Gem" and v:FindFirstChild("outerGem") then
                            root.CFrame = v.outerGem.CFrame
                            break 
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
                        if string.find(v.Name, "Hoop") then
                            root.CFrame = v.CFrame
                            break 
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
            Player.Character.Humanoid.WalkSpeed = 300
        end)
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
