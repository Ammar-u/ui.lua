-- Roblox Freeze Trade Prank GUI (Purely Visual)
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

-- Prevent duplicate GUIs
if CoreGui:FindFirstChild("TradePrankScreen") then
    CoreGui.TradePrankScreen:Destroy()
end

-- Create ScreenGui
local ScreenGui = Instance.New("ScreenGui")
ScreenGui.Name = "FreezeTradePanel"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Create Main Frame (Draggable Menu)
local MainFrame = Instance.New("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 240)
MainFrame.Position = UDim2.new(0.5, -160, 0.4, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Allows you to move the menu around
MainFrame.Parent = ScreenGui

-- Corner styling for Main Frame
local MainCorner = Instance.New("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Animated Flashing Background (White/Black Sparkle Effect)
local BackgroundAnim = Instance.New("Frame")
BackgroundAnim.Name = "BackgroundAnim"
BackgroundAnim.Size = UDim2.new(1, -6, 1, -6)
BackgroundAnim.Position = UDim2.new(0, 3, 0, 3)
BackgroundAnim.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BackgroundAnim.BorderSizePixel = 0
BackgroundAnim.ZIndex = 1
BackgroundAnim.Parent = MainFrame

local AnimCorner = Instance.New("UICorner")
AnimCorner.CornerRadius = UDim.new(0, 10)
AnimCorner.Parent = BackgroundAnim

-- Title Text
local Title = Instance.New("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "FREEZE TRADE PRANK v1.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.ZIndex = 2
Title.Parent = MainFrame

-- Status Label (Shows "Successfully" text)
local StatusLabel = Instance.New("TextLabel")
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

-- Function to create fake toggle buttons
local function createFakeButton(name, text, positionY)
    local Button = Instance.New("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(0, 260, 0, 45)
    Button.Position = UDim2.new(0.5, -130, 0, positionY)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.Text = text .. ": OFF"
    Button.TextColor3 = Color3.fromRGB(255, 85, 85)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 15
    Button.ZIndex = 2
    Button.Parent = MainFrame

    local ButtonCorner = Instance.New("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button

    local state = false

    Button.MouseButton1Click:Connect(function()
        state = not state
        
        -- Play generic click sound locally
        local clickSound = Instance.New("Sound")
        clickSound.SoundId = "rbxassetid://12221967"
        clickSound.Volume = 0.5
        clickSound.Parent = SoundService
        clickSound:Play()
        game:GetService("Debris"):AddItem(clickSound, 1)

        if state then
            Button.Text = text .. ": ON"
            Button.BackgroundColor3 = Color3.fromRGB(40, 60, 40)
            Button.TextColor3 = Color3.fromRGB(85, 255, 85)
            StatusLabel.Text = "Status: Successfully Activated!"
            StatusLabel.TextColor3 = Color3.fromRGB(85, 255, 85)
        else
            Button.Text = text .. ": OFF"
            Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Button.TextColor3 = Color3.fromRGB(255, 85, 85)
            StatusLabel.Text = "Status: Successfully Deactivated!"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 85, 85)
        end
        
        -- Reset status color back to neutral after 2 seconds
        task.delay(2, function()
            if StatusLabel.Text ~= "System Status: Idle" then
                StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        end)
    end)
end

-- Create the two requested option buttons
createFakeButton("FreezeButton", "Freeze Trade", 60)
createFakeButton("AcceptButton", "Force Accept", 120)

-- Close Button (To remove the prank GUI safely)
local CloseButton = Instance.New("TextButton")
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

-- Sparking Background Loop (Rapid White & Black Shift)
task.spawn(function()
    while ScreenGui.Parent do
        -- Alternate background rapidly to create a visual "sparkle/glitch" mode
        BackgroundAnim.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        task.wait(0.08)
        BackgroundAnim.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        task.wait(0.12)
        BackgroundAnim.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        task.wait(0.05)
        BackgroundAnim.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        task.wait(0.15)
    end
end)
