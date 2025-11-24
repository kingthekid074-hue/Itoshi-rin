local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({ Name = "itoshi hub",HidePremium = false,SaveConfig = true,ConfigFolder = "itoshi config"})
local MainTab = Window:MakeTab({Name = "Main",Icon = "rbxassetid://4483345998",PremiumOnly = false})
OrionLib:Init()
