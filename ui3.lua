-- Roblox Freeze Trade Visual Menu v3
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Prevent duplicate GUIs from stacking
if PlayerGui:FindFirstChild("TradePrankScreen") then
    PlayerGui.TradePrankScreen:Destroy()
end

-- Create ScreenGui inside PlayerGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TradePrankScreen"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Create Main Frame (Draggable Menu)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 240)
MainFrame.Position = UDim2.new(0.5, -160, 0.4, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Sparking Background Panel
local BackgroundAnim = Instance.new("Frame")
BackgroundAnim.Name = "BackgroundAnim"
BackgroundAnim.Size = UDim2.new(1, -6, 1, -6)
BackgroundAnim.Position = UDim2.new(0, 3, 0, 3)
BackgroundAnim.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
BackgroundAnim.BorderSizePixel = 0
BackgroundAnim.ZIndex = 1
BackgroundAnim.Parent = MainFrame

local AnimCorner = Instance.new("UICorner")
AnimCorner.CornerRadius = UDim.new(0, 10)
AnimCorner.Parent = BackgroundAnim

-- Title Text (Updated to Freeze Trade v3)
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "FREEZE TRADE v3"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.ZIndex = 2
Title.Parent = MainFrame

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0, 195)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "System Status: Idle"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.Font = Enum.Font.GothamSemibold
StatusLabel.TextSize = 14
StatusLabel.ZIndex = 2
StatusLabel.Parent = MainFrame

-- Function to create buttons
local function createFakeButton(name, text, positionY)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(0, 260, 0, 45)
    Button.Position = UDim2.new(0.5, -130, 0, positionY)
    Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Button.Text = text .. ": OFF"
    Button.TextColor3 = Color3.fromRGB(255, 85, 85)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 15
    Button.ZIndex = 2
    Button.Parent = MainFrame

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button

    local state = false

    Button.MouseButton1Click:Connect(function()
        state = not state
        
        local clickSound = Instance.new("Sound")
        clickSound.SoundId = "rbxassetid://12221967"
        clickSound.Volume = 0.5
        clickSound.Parent = SoundService
        clickSound:Play()
        game:GetService("Debris"):AddItem(clickSound, 1)

        if state then
            Button.Text = text .. ": ON"
            Button.BackgroundColor3 = Color3.fromRGB(35, 55, 35)
            Button.TextColor3 = Color3.fromRGB(85, 255, 85)
            StatusLabel.Text = "Status: Successfully Activated!"
            StatusLabel.TextColor3 = Color3.fromRGB(85, 255, 85)
        else
            Button.Text = text .. ": OFF"
            Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Button.TextColor3 = Color3.fromRGB(255, 85, 85)
            StatusLabel.Text = "Status: Successfully Deactivated!"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 85, 85)
        end
        
        task.delay(2, function()
            if StatusLabel.Text ~= "System Status: Idle" then
                StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        end)
    end)
end

createFakeButton("FreezeButton", "Freeze Trade", 60)
createFakeButton("AcceptButton", "Force Accept", 120)

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(150, 150, 150)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.ZIndex = 3
CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Sparking Loop (Rapid erratic bright flashes mimicking electricity/sparks)
task.spawn(function()
    local rng = Random.new()
    while ScreenGui.Parent do
        if rng:NextNumber() > 0.4 then
            BackgroundAnim.BackgroundColor3 = Color3.fromRGB(230, 230, 255)
            task.wait(rng:NextNumber(0.02, 0.05))
            BackgroundAnim.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            task.wait(rng:NextNumber(0.03, 0.08))
            BackgroundAnim.BackgroundColor3 = Color3.fromRGB(120, 120, 150)
            task.wait(rng:NextNumber(0.01, 0.03))
        end
        BackgroundAnim.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        task.wait(rng:NextNumber(0.1, 0.4))
    end
end)
