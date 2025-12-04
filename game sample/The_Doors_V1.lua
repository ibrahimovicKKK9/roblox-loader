local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")

-- Character
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

-- Logic
local noclip = false
local player = game.Players.LocalPlayer
local character, humanoidRootPart

local targetName = {}
local target = Players:FindFirstChild(targetName)

local walk = false
local walkspeed = 16

local function GetCheatValue()
    if humanoid then
        if walk then
            humanoid.WalkSpeed = walkspeed
        end
    end
    ---
    if noclip then
		character = player.Character
		if character then
			for _, part in pairs(character:GetDescendants()) do
				if part:IsA("BasePart") and part.CanCollide then
					part.CanCollide = false
				end
			end
		end
	else
		character = player.Character
		if character then
			for _, part in pairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
		end
	end
end
---

local Window = WindUI:CreateWindow({
    Title = "The Doors | V1",
    Icon = "globe", -- lucide icon
    Author = "created by IbrahimovicK77",
    Folder = "MySuperHub",
    
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,

    User = {
        Enabled = true,
        Anonymous = false,
    },
})

Window:EditOpenButton({
    Title = "Open/Close Menu",
    Icon = "minimize-2",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("FFFFFF"), 
        Color3.fromHex("000000")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

Window:Tag({
    Title = "Free Version",
    Color = Color3.fromHex("#30ff6a"),
    Radius = 13, -- from 0 to 13
})
Window:Tag({
    Title = "IN DEV",
    Color = Color3.fromHex("#ff0000"),
    Radius = 13, -- from 0 to 13
})

WindUI:Notify({
    Title = "Connection Info!",
    Content = "Script Succesfuly Loaded!",
    Duration = 3.8, -- 3 seconds
    Icon = "cloud-check",
})

-- Tabs
local AboutTab = Window:Tab({
    Title = "About",
    Icon = "info", -- optional
    Locked = false,
})
Window:Divider()
local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "user", -- optional
    Locked = false,
})
local EspTab = Window:Tab({
    Title = "ESP",
    Icon = "eye", -- optional
    Locked = false,
})
local ItemsTab = Window:Tab({
    Title = "Items",
    Icon = "axe", -- optional
    Locked = false,
})
local TeleportTab = Window:Tab({
    Title = "Teleport",
    Icon = "map-pin", -- optional
    Locked = false,
})
Window:Divider()
local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "settings", -- optional
    Locked = false,
})
SettingsTab:Keybind({
    Title = "Keybind Menu",
    Desc = "Keybind to open/close menu",
    Value = "K",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

--
AboutTab:Paragraph({
    Title = "Developer Cheat",
    Desc = "@ibrahimovick77",
    Image = "https://i.pinimg.com/736x/e3/de/66/e3de66742cbe1a90b98eae194b97cab6.jpg",
    ImageSize = 30,
    Thumbnail = "https://i.pinimg.com/1200x/18/24/86/182486c46fc5bc16997c224d7278ac5c.jpg",
    ThumbnailSize = 80,
})
AboutTab:Button({
    Title = "Youtube | Support my youtube channel <3",
    IconAlign = "Left", -- Left or Right of the text
    Icon = "youtube", -- removing icon
    Callback = function()
        syn.open_url("https://www.youtube.com/@ibrahimk2709")
    end
})
AboutTab:Button({
    Title = "Instagram | my instagram <<<",
    IconAlign = "Left", -- Left or Right of the text
    Icon = "instagram", -- removing icon
    Callback = function()
        syn.open_url("https://instagram.com")
    end
})
AboutTab:Button({
    Title = "Discord (Coming Soon!!)",
    IconAlign = "Left", -- Left or Right of the text
    Icon = "bot", -- removing icon
    Callback = function()
        
    end
})
----

PlayerTab:Section({ 
    Title = "Speed Boost",
    Icon = "gauge",
    TextSize = 16,
})
PlayerTab:Toggle({
    Title = "Enable Speed Boost",
    Desc = "Untuk mempercepat speed lari.",
    Icon = "",
    Type = "Toggle",
    Value = false, -- default value
    Callback = function(state) 
        walk = state
        if walk then
            humanoid.WalkSpeed = walkspeed
        else
            humanoid.WalkSpeed = 16
        end
    end
})
PlayerTab:Slider({
    Title = "SpeedBoost Value",
    Desc = "Atur kecepatan saat berlari.",
    
    -- To make float number supported, 
    -- make the Step a float number.
    -- example: Step = 0.1
    Step = 1,
    Value = {
        Min = 1,
        Max = 100,
        Default = 25,
    },
    Callback = function(value)
        walkspeed = value
        if walk then
            humanoid.WalkSpeed = walkspeed
        end
    end
})
PlayerTab:Divider()
PlayerTab:Section({ 
    Title = "Misc",
    Icon = "settings",
    TextSize = 16,
})
PlayerTab:Toggle({
    Title = "Enable No Clip",
    Desc = "Untuk menembus object-object.",
    Icon = "",
    Type = "Toggle",
    Value = false, -- default value
    Callback = function(state) 
        noclip = state
    end
})
PlayerTab:Toggle({
    Title = "Enable Anti-AFK",
    Desc = "Untuk AFK lah, buat apalagi.",
    Icon = "",
    Type = "Toggle",
    Value = false, -- default value
    Callback = function(state) 
    end
})
PlayerTab:Toggle({
    Title = "Enable Anti-Kick",
    Desc = "Untuk tidak dikick dari server.",
    Icon = "",
    Type = "Toggle",
    Value = false, -- default value
    Callback = function(state) 
    end
})
---
TeleportTab:Section({ 
    Title = "Teleport to Player",
    Icon = "user",
    TextSize = 16,
})
TeleportTab:Input({
    Title = "Nickname",
    Desc = "Masukan nama player yang akan di teleport!",
    Value = "",
    InputIcon = "search",
    Type = "Input", -- or "Textarea"
    Placeholder = "Nickname Roblox...",
    Callback = function(input) 
        targetName = input
        target = Players:FindFirstChild(targetName)
    end
})
TeleportTab:Button({
    Title = "Teleport to Player",
    IconAlign = "Right", -- Left or Right of the text
    Icon = "map-pin", -- removing icon
    Callback = function()
        if not target then
            for i,v in pairs(Players:GetPlayers()) do if v.DisplayName==targetName then target=v break end end
        end
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
        end
    end
})
TeleportTab:Divider()
TeleportTab:Section({ 
    Title = "Teleport Maps",
    Icon = "circle-star",
    TextSize = 16,
})
TeleportTab:Dropdown({
    Title = "Teleport to Point Maps",
    Desc = "Kamu bisa gunakan ini untuk teleportasi langsung ke titik yang sudah ditentukan.",
    Values = {
        {
            Title = "Boss 1",
            Icon = "library-big",
        },
        {
            Title = "Boss 2",
            Icon = "battery-charging",
        },
        {
            Title = "Miner",
            Icon = "pickaxe",
        },
    },
    Value = "Boss 1",
    Callback = function(option) 
        
    end
})
TeleportTab:Button({
    Title = "Teleport Maps (Click)",
    IconAlign = "Right", -- Left or Right of the text
    Icon = "goal", -- removing icon
    Callback = function()
        
    end
})
---
ItemsTab:Section({ 
    Title = "Backpack Items (Coming Soon)",
    Icon = "backpack",
    TextSize = 16,
})
ItemsTab:Dropdown({
    Title = "Items Backpack",
    Desc = "Kamu bisa gunakan ini untuk mengnambahkan Items langsung ke tas.",
    Values = {
        {
            Title = "Kunci Pintu",
            Icon = "key",
        },
        {
            Title = "Bandage",
            Icon = "bandage",
        },
        {
            Title = "First Aid",
            Icon = "briefcase-medical",
        },
        {
            Title = "Lock Pick",
            Icon = "lock",
        },
        {
            Title = "First Light",
            Icon = "spotlight",
        },
    },
    Value = "Kunci Pintu",
    Callback = function(option) 
        
    end
})
ItemsTab:Button({
    Title = "Add to backpack (Click)",
    IconAlign = "Right", -- Left or Right of the text
    Icon = "backpack", -- removing icon
    Callback = function()
        WindUI:Notify({
            Title = "Developer Note",
            Content = "Tunggu Proses Update yaa, Guys!!",
            Duration = 3, -- 3 seconds
            Icon = "info",
        })
    end
})
-----
EspTab:Section({ 
    Title = "ESP Player",
    Icon = "user",
    TextSize = 16,
})
EspTab:Toggle({
    Title = "Enable ESP Player",
    Desc = "",
    Icon = "",
    Type = "Toggle",
    Value = false, -- default value
    Callback = function(state) 
    end
})
EspTab:Toggle({
    Title = "Enable ESP Enty",
    Desc = "",
    Icon = "",
    Type = "Toggle",
    Value = false, -- default value
    Callback = function(state) 
    end
})
EspTab:Divider()
EspTab:Section({ 
    Title = "ESP Object",
    Icon = "axe",
    TextSize = 16,
})
EspTab:Toggle({
    Title = "Enable ESP Door",
    Desc = "",
    Icon = "",
    Type = "Toggle",
    Value = false, -- default value
    Callback = function(state) 
    end
})
EspTab:Toggle({
    Title = "Enable ESP Books (Boss 1)",
    Desc = "",
    Icon = "",
    Type = "Toggle",
    Value = false, -- default value
    Callback = function(state) 
    end
})

LocalPlayer.CharacterAdded:Connect(function(char)
    char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    hrp = char:WaitForChild("HumanoidRootPart")
    humanoid = char:WaitForChild("Humanoid")
 
    task.wait(0.1)
    GetCheatValue()
end)

game:GetService("RunService").Stepped:Connect(function()
	if noclip then
		character = player.Character
		if character then
			for _, part in pairs(character:GetDescendants()) do
				if part:IsA("BasePart") and part.CanCollide then
					part.CanCollide = false
				end
			end
		end
	else
		character = player.Character
		if character then
			for _, part in pairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
		end
	end
end)