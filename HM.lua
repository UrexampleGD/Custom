local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local function createButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0.4, 0, 0.1, 0)
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(255, 102, 102)
    button.Font = Enum.Font.GothamBold
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18
    button.Parent = ScreenGui
    button.MouseButton1Click:Connect(callback)
    return button
end

local HintUI = Instance.new("Frame")
HintUI.Size = UDim2.new(0, 350, 0, 220)
HintUI.Position = UDim2.new(0.5, -175, 0.5, -110)
HintUI.BackgroundColor3 = Color3.fromRGB(255, 102, 102)
HintUI.Visible = false
HintUI.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = HintUI

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Thickness = 2
UIStroke.Parent = HintUI

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Text = "Custom Hint/Message"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Parent = HintUI

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.8, 0, 0.2, 0)
TextBox.Position = UDim2.new(0.1, 0, 0.3, 0)
TextBox.PlaceholderText = "Enter your message..."
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 18
TextBox.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox.Parent = HintUI

local TextCorner = Instance.new("UICorner")
TextCorner.CornerRadius = UDim.new(0, 5)
TextCorner.Parent = TextBox

local function createStyledButton(text, position, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.4, 0, 0.2, 0)
    button.Position = position
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    button.MouseButton1Click:Connect(callback)
    button.Parent = HintUI
end

createStyledButton("Show Hint", UDim2.new(0.1, 0, 0.6, 0), function()
    local hint = Instance.new("Hint")
    hint.Parent = game.Workspace
    hint.Text = TextBox.Text
end)

createStyledButton("Show Message", UDim2.new(0.5, 0, 0.6, 0), function()
    local message = Instance.new("Message")
    message.Parent = game.Workspace
    message.Text = TextBox.Text
end)

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.8, 0, 0.2, 0)
CloseButton.Position = UDim2.new(0.1, 0, 0.8, 0)
CloseButton.Text = "Close"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

CloseButton.Parent = HintUI
CloseButton.MouseButton1Click:Connect(function()
    HintUI.Visible = false
end)

createButton("Custom Hint/Message", function()
    HintUI.Visible = true
end)

local dragToggle, dragInput, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    HintUI.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

HintUI.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true
        dragStart = input.Position
        startPos = HintUI.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragToggle = false
            end
        end)
    end
end)

HintUI.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragToggle then
        updateInput(input)
    end
end)
