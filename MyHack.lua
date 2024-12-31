local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "AcidSoul Hub V1", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/SimpleHighlightESP.lua"))()

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CoreGui = game:GetService("CoreGui");
local Players = game:GetService("Players");
local Workspace = game:GetService("Workspace");
local Lighting = game:GetService("Lighting");
local VirtualInputManager = game:GetService("VirtualInputManager");
Tycoondir = game.Workspace.Tycoons

local player = game.Players.LocalPlayer


leaderstats = player:WaitForChild("leaderstats")

function ServerHop()
    if _G.ServerHopping == true then
        local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")()

        module:Teleport(game.PlaceId)
    end
end

function Ulqiorrainteract()
    if _G.ulquiorra == true then
        local player = game:GetService("Players").LocalPlayer
        local proximityPrompt = -- the reference to the proximity prompt you want to interact with

        proximityPrompt.Triggered:Fire(player)

        local args = {
            [1] = game:GetService("Players").LocalPlayer.PlayerGui.UlquiorraShikaiUI.Frame
        }

        game:GetService("ReplicatedStorage").PNJ.Ulquiorra.initGUI:FireServer(unpack(args))
    end
end

function moneytest()
    if _G.infmoneytest == true then
        local args = {
            [1] = 3000
        }

        game:GetService("ReplicatedStorage").Events.CurrencyChange.currencyChangeEvent:FireServer(unpack(args))
    end
end


local function tptooneballoon(Value)
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    local balloonContainer = game.Workspace:GetChildren()
    local tweenSpeed = Value
    local maxTweens = _G.balloonstotpto

    local function getAllBoxDrops()
        local boxDrops = {}
        for _, part in pairs(Workspace:GetChildren()) do
            if part.Name == "BoxDrop" then
                table.insert(boxDrops, part)  -- Add BoxDrop parts to list
            end
        end
        return boxDrops
    end

    -- Function to tween towards the target BoxDrop part
    local function tweenToTarget(targetPart, speed)
        if targetPart and speed then
            local distance = (humanoidRootPart.Position - targetPart.Position).magnitude
            local time = distance / speed  -- Calculate time to reach the target
            local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear)
            local goal = {CFrame = CFrame.new(targetPart.Position)}  -- Goal position is the BoxDrop's position
            
            local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
            tween:Play()
            
            -- Wait for the tween to finish before continuing to the next part
            tween.Completed:Wait()
        else
            warn("targetPart or speed is nil")
        end
    end

    -- Get all BoxDrop parts and tween to them one by one
    local allBoxDrops = getAllBoxDrops()
    local totalBoxDrops = #allBoxDrops

    if totalBoxDrops == 0 then
        warn("No BoxDrop parts found in the game!")
        return
    end

    -- Loop through each BoxDrop part and teleport to it
    for i, boxDrop in ipairs(allBoxDrops) do
        print("Teleporting to BoxDrop #" .. i)
        tweenToTarget(boxDrop, tweenSpeed)
    end
end

local function tpballoons(Value)
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    if not Value then
        warn("Tween speed (Value) is nil!")
        return
    end
    
    local balloonContainer = game.Workspace:GetChildren()
    local tweenSpeed = Value
    local maxTweens = _G.balloonstotpto

    local function getNearestBalloon()
        local nearestBalloon = nil
        local shortestDistance = math.huge
        
        for _, part in pairs(balloonContainer) do
            if part.Name == "BoxDrop" then
                local distance = (humanoidRootPart.Position - part.Position).magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestBalloon = part
                end
            end
        end
        
        if not nearestBalloon then
            warn("No BoxDrop part found!")
        end
        
        return nearestBalloon
    end

    local function tweenToTarget(targetPart, speed)
        if targetPart and speed then
            local distance = (humanoidRootPart.Position - targetPart.Position).magnitude
            local time = distance / speed
            local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear)
            local goal = {CFrame = CFrame.new(targetPart.Position)}
            
            local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
            tween:Play()
            
            tween.Completed:Wait()
        else
            warn("targetPart or speed is nil")
        end
    end

    for i = 1, maxTweens do
        local nearestBalloon = getNearestBalloon()
        
        if nearestBalloon then
            tweenToTarget(nearestBalloon, tweenSpeed)
        else
            break
        end
    end
end

local function isNumber(value)
    return tonumber(value) ~= nil
end

function wlkspeed(speed)
    if isNumber(speed) then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').WalkSpeed = speed
    end
end
--Tycoondir = game.Workspace.Tycoons
local player = game.Players.LocalPlayer
local teams = game:GetService("Teams")

local function getPlayerInfo()
    local playerTeam = player.Team
    return playerTeam
end

local function onCharacterAdded(character)
    -- Re-initialize humanoidRootPart or other necessary parts after character reset
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    -- Restart the autofarm loop if it's enabled
    if _G.Autofarmingon then
        Startautofarm()  -- Start the auto-farming loop
    end
end

function rebirth()
local player = game.Players.LocalPlayer
local button = player.PlayerGui.RebirthBar.RebirthButton.button

if button and button:IsA("GuiButton") then
    local clickEvent = button.MouseButton1Click

    if clickEvent then
        local function onButtonClick()
            print("Simulated Button Click!")
        end

        clickEvent:Connect(onButtonClick)
        onButtonClick()

        local rebirthRemote = game.ReplicatedStorage.Events.Rebirth:WaitForChild("Rebirth")
        if rebirthRemote then
            rebirthRemote:FireServer()
        end
    end
end
end

playerteam = getPlayerInfo()
Team = "NA"

if playerteam and playerteam.Name == "Ulquarro" then Team = "TycoonUlquiorra" elseif playerteam.Name == "Byaku" then Team = "TycoonByakuya" elseif playerteam.Name == "Yamo" then Team = "TycoonYamamoto" end

print("Team: " .. Team)

if Tycoondir:FindFirstChild(Team).CollectMoney then
    print("FOUND OKK")
end

_G.Autofarmingon = false
local autofarmThread

function Startautofarm()
    if autofarmThread then
        return
    end
    autofarmThread = task.spawn(function()
        while _G.Autofarmingon do
            teleportToPressPart()
            wait(1)  -- Adjust the wait time as needed for your game
        end
        autofarmThread = nil  -- Reset the thread when autofarming is turned off
    end)
end

_G.autorebirth = true
_G.rebirthCooldown = 100
_G.lastRebirthTime = 0
function teleportToPressPart()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local money = leaderstats:WaitForChild("Money")

    local powersFolder = game.Workspace.Tycoons.TycoonUlquiorra.Buttons
    
    if not powersFolder then
        warn("Powers folder not found!")
        return
    end
    local foundpresspart = false
    for _, model in ipairs(powersFolder:GetDescendants()) do
        if model:IsA("Part") and model.Name == "press" then
            if money.Value - model.Parent.price.Value > 0 then
                local newCFrame = model.CFrame * CFrame.new(5, 0, 0)
                humanoidRootPart.CFrame = newCFrame
                foundpresspart = true
                return
            else
                local newCFrame = model.Parent.Parent.Parent.Parent.Parent.CollectMoney.Collector.CFrame * CFrame.new(2, 5, 0)
                humanoidRootPart.CFrame = newCFrame
                foundpresspart = true
                return
            end
        end
    end
    -- If no press part is found, attempt to rebirth, but respect the cooldown
    if not foundpresspart and _G.autorebirth == true then
        local currentTime = tick()  -- Get current time in seconds
        
        -- Only rebirth if enough time has passed since the last rebirth
        if currentTime - _G.lastRebirthTime >= _G.rebirthCooldown then
            rebirth()  -- Trigger rebirth
            _G.lastRebirthTime = currentTime  -- Update the last rebirth time
        else
            print("Rebirth is on cooldown. Please wait a few seconds.")
        end
    end
end

-- Function to reset rebirth flag after a period of time or under certain conditions (e.g., when character is reset)
function resetRebirthFlag()
    _G.lastRebirthTime = 0  -- Reset the last rebirth time, allowing a new rebirth
end

-- Listen for the CharacterAdded event to reset the rebirth flag when the character is reset (after rebirth)
player.CharacterAdded:Connect(function()
    resetRebirthFlag()
end)


function tptoplayer()
    playertotp = _G.tptoplayer
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[playertotp].Character.HumanoidRootPart.CFrame
end

function tpbehindplayer()

	playertootp = _G.tpingbehindplayer
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[playertootp].Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 10)

end


local FirstTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})



FirstTab:AddToggle({
	Name = "Server Hop",
	Default = false,
	Callback = function(Value)
		_G.ServerHopping = Value
        ServerHop()
	end    
})

FirstTab:AddToggle({
	Name = "Ulquiorra Cifer",
	Default = false,
	Callback = function(Value)
		_G.ulquiorra = Value
        Ulqiorrainteract()
	end    
})

FirstTab:AddToggle({
	Name = "money test",
	Default = false,
	Callback = function(Value)
		_G.infmoneytest = Value
        moneytest()
	end    
})

FirstTab:AddTextbox({
    Name = "Tp to all Box Drops (speed): ",
    Default = "100",
    TextDisappear = false,
    Callback = function(Value)
        local speed = tonumber(Value)
        if speed then
            _G.balloonspeed = speed
            tpballoons(speed)
        else
            warn("Invalid speed value entered.")
        end
    end    
})

FirstTab:AddTextbox({
    Name = "Tp to nearest Box Drop (speed): ",
    Default = "100",
    TextDisappear = false,
    Callback = function(Value)
        local speed = tonumber(Value)
        if speed then
            _G.balloonspeed = speed
            tptooneballoon(speed)
        else
            warn("Invalid speed value entered.")
        end
    end    
})

local SecondTab = Window:MakeTab({
	Name = "LocalPlayer",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

SecondTab:AddTextbox({
    Name = "WalkSpeed: ",
    Default = "16",
    TextDisappear = false,
    Callback = function(Value)
        local speed = tonumber(Value)
        wlkspeed(speed)
    end    
})

local ThirdTab = Window:MakeTab({
	Name = "AutoFarm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

ThirdTab:AddToggle({
    Name = "AutoFarm",
    Default = false,
    Callback = function(Value)
        _G.Autofarmingon = Value  -- Set autofarm flag based on the toggle value
        if _G.Autofarmingon then
            Startautofarm()  -- Start the autofarming loop
        elseif autofarmThread then
            task.cancel(autofarmThread)  -- Stop the autofarm loop if it's running
            autofarmThread = nil
        end
    end    
})


ThirdTab:AddToggle({
	Name = "Autorebirth (Defaulted to true)",
	Default = true,
	Callback = function(Value)
        _G.autorebirth = true
	end    
})

ThirdTab:AddToggle({
	Name = "Dont AutoRebirth (Defaulted to false)",
	Default = false,
	Callback = function(Value)
        _G.autorebirth = false
	end    
})

local FourthTab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

FourthTab:AddTextbox({
	Name = "Tp to player",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		_G.tptoplayer = Value
        tptoplayer()
	end	  
})


FourthTab:AddTextbox({
	Name = "Tp Behind Player",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		_G.tpingbehindplayer = Value
        tpbehindplayer()
	end	  
})



OrionLib:Init()