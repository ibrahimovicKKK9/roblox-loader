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

local walk = false
local walkspeed = 16
local anti_afk = false
local auto_summit = false

local Checkpoint = {
    ["Checkpoint 1"] = CFrame.new(3357.65967, 9030.76074, 5635.41992),
    ["Checkpoint 2"] = CFrame.new(3075.56323, 9107.51074, 4456.625),
    ["Checkpoint 3"] = CFrame.new(1877.01196, 9551.70996, 3488.43994),
    ["Checkpoint 4"] = CFrame.new(1369.3075, 9775.25098, 3126.55444),
    ["Checkpoint 5"] = CFrame.new(1188.35291, 10120.5303, 2295.79541),
    ["Summit"] = CFrame.new(-98.0654373, 10812.9629, 3049.2312),
}
local CheckpointSelected = "Checkpoint 1"

local function GetCheatValue()
    if humanoid then
        if walk then
            humanoid.WalkSpeed = walkspeed
        end
    end
end
--

local Window = WindUI:CreateWindow({
    Title = "MOUNT RINJANI | V1",
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
local MainTab = Window:Tab({
    Title = "Main",
    Icon = "crown", -- optional
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


-- 
MainTab:Section({ 
    Title = "Player",
    Icon = "user",
    TextSize = 16,
})
MainTab:Toggle({
    Title = "Enable SpeedBoost",
    Desc = "Jika ini diaktifkan kamu akan berlari sangat cepat.",
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
MainTab:Slider({
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

MainTab:Divider()
MainTab:Section({ 
    Title = "Teleport",
    Icon = "box",
    TextSize = 16,
})
MainTab:Dropdown({
    Title = "Teleport to Checkpoint",
    Desc = "Kamu bisa gunakan ini untuk teleportasi dari checkpoint 1 ke checkpoint lain.",
    Values = {
        {
            Title = "Checkpoint 1",
            Icon = "flag",
        },
        {
            Title = "Checkpoint 2",
            Icon = "flag",
        },
        {
            Title = "Checkpoint 3",
            Icon = "flag",
        },
        {
            Title = "Checkpoint 4",
            Icon = "flag",
        },
        {
            Title = "Checkpoint 5",
            Icon = "flag",
        },
        {
            Title = "Summit",
            Icon = "flag",
        },
    },
    Value = "Checkpoint 1",
    Callback = function(option) 
        CheckpointSelected = option.Title
    end
})
MainTab:Button({
    Title = "Teleport to Checkpoint",
    IconAlign = "Right", -- Left or Right of the text
    Icon = "goal", -- removing icon
    Callback = function()
        hrp.CFrame = Checkpoint[CheckpointSelected] + Vector3.new(0,3,0)
    end
})
MainTab:Space()
MainTab:Input({
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
MainTab:Button({
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
MainTab:Space()
MainTab:Toggle({
    Title = "Auto Summit",
    Desc = "Aktifkan/Matikan AutoSummit",
    Icon = "",
    Type = "Toggle",
    Value = false, -- default value
    Callback = function(state)
        auto_summit = state
        if auto_summit then
            task.spawn(function()
                while auto_summit do
                    task.wait(1)
                    hrp.CFrame = CFrame.new(3357.65967, 9030.76074, 5635.41992) + Vector3.new(0,3,0) --- Check 1
                    task.wait(1)
                    hrp.CFrame = CFrame.new(3075.56323, 9107.51074, 4456.625) + Vector3.new(0,3,0) --- Check 2
                    task.wait(1)
                    hrp.CFrame = CFrame.new(1877.01196, 9551.70996, 3488.43994) + Vector3.new(0,3,0) --- Check 3
                    task.wait(1)
                    hrp.CFrame = CFrame.new(1369.3075, 9775.25098, 3126.55444) + Vector3.new(0,3,0) --- Check 4
                    task.wait(1)
                    hrp.CFrame = CFrame.new(1188.35291, 10120.5303, 2295.79541) + Vector3.new(0,3,0) --- Check 5
                end
            end)
            print("Auto Summit Stopped")
        else
            auto_summit = false
        end
    end
})
MainTab:Divider()
MainTab:Section({
    Title = "Misc",
    Icon = "settings",
    TextSize = 16,
})
MainTab:Toggle({
    Title = "Enable Anti-AFK",
    Desc = "Aktifkan/Matikan Anti-AFK",
    Icon = "",
    Type = "Toggle",
    Value = false, -- default value
    Callback = function(state) 
        anti_afk = state
        if anti_afk then
            local VirtualInput = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                VirtualInput:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                VirtualInput:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        else
            print("Anti-AFK Disabled")
        end
    end
})

-- Get Value Nilai Cheat Kembali
LocalPlayer.CharacterAdded:Connect(function(char)
    char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    hrp = char:WaitForChild("HumanoidRootPart")
    humanoid = char:WaitForChild("Humanoid")
 
    task.wait(0.1)
    GetCheatValue()
end)