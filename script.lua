-- EasyTP V1
-- Simple Teleport with Player Selection UI
-- PGDN = TELEPORT | RIGHT SHIFT = SHOW/HIDE UI
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local selectedPlayer = nil
local guiVisible = true
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EasyTPUI"
ScreenGui.Parent = game.CoreGui
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0, 10, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
MainFrame.Parent = ScreenGui
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0.7, 0, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "EasyTP V1"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 14
TitleText.Parent = TitleBar
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -30, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 16
MinimizeButton.Parent = TitleBar
local PlayersFrame = Instance.new("ScrollingFrame")
PlayersFrame.Size = UDim2.new(1, -10, 1, -100)
PlayersFrame.Position = UDim2.new(0, 5, 0, 35)
PlayersFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
PlayersFrame.BorderSizePixel = 1
PlayersFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
PlayersFrame.ScrollBarThickness = 6
PlayersFrame.Parent = MainFrame
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = PlayersFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 2)
local SelectedFrame = Instance.new("Frame")
SelectedFrame.Size = UDim2.new(1, -10, 0, 30)
SelectedFrame.Position = UDim2.new(0, 5, 1, -60)
SelectedFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SelectedFrame.BorderSizePixel = 1
SelectedFrame.BorderColor3 = Color3.fromRGB(70, 70, 70)
SelectedFrame.Parent = MainFrame
local SelectedText = Instance.new("TextLabel")
SelectedText.Size = UDim2.new(1, 0, 1, 0)
SelectedText.BackgroundTransparency = 1
SelectedText.Text = "No player selected"
SelectedText.TextColor3 = Color3.fromRGB(150, 150, 150)
SelectedText.Font = Enum.Font.Gotham
SelectedText.TextSize = 12
SelectedText.Parent = SelectedFrame
local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -10, 0, 20)
StatusText.Position = UDim2.new(0, 5, 1, -25)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Ready - PGDN for Teleport"
StatusText.TextColor3 = Color3.fromRGB(0, 200, 0)
StatusText.Font = Enum.Font.Gotham
StatusText.TextSize = 11
StatusText.Parent = MainFrame
local function updatePlayerList()
    for _, child in pairs(PlayersFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local PlayerButton = Instance.new("TextButton")
            PlayerButton.Size = UDim2.new(1, -10, 0, 30)
            PlayerButton.Position = UDim2.new(0, 5, 0, 0)
            PlayerButton.Text = player.Name
            PlayerButton.TextColor3 = Color3.fromRGB(200, 200, 200)
            PlayerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            PlayerButton.BorderSizePixel = 1
            PlayerButton.BorderColor3 = Color3.fromRGB(70, 70, 70)
            PlayerButton.Font = Enum.Font.Gotham
            PlayerButton.TextSize = 12
            PlayerButton.Parent = PlayersFrame
            
            PlayerButton.MouseButton1Click:Connect(function()
                selectedPlayer = player
                SelectedText.Text = "Selected: " .. player.Name
                SelectedText.TextColor3 = Color3.fromRGB(0, 200, 0)
                
                -- Highlight selected button
                for _, btn in pairs(PlayersFrame:GetChildren()) do
                    if btn:IsA("TextButton") then
                        if btn.Text == player.Name then
                            btn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
                            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                        else
                            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
                        end
                    end
                end
                
                StatusText.Text = "Player selected - PGDN for Teleport"
                StatusText.TextColor3 = Color3.fromRGB(0, 200, 0)
            end)
        end
    end
    PlayersFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
end

local function toggleGUI()
    guiVisible = not guiVisible
    if guiVisible then
        MainFrame.Visible = true
        local tween = TweenService:Create(
            MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 300, 0, 400)}
        )
        tween:Play()
    else
        local tween = TweenService:Create(
            MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 400)}
        )
        tween:Play()
        tween.Completed:Connect(function()
            MainFrame.Visible = false
        end)
    end
end
local function executeTeleport()
    if not selectedPlayer then
        StatusText.Text = "ERROR: No player selected!"
        StatusText.TextColor3 = Color3.fromRGB(255, 50, 50)
        return
    end
    if not selectedPlayer.Character or not LocalPlayer.Character then
        StatusText.Text = "Waiting for character loading..."
        StatusText.TextColor3 = Color3.fromRGB(255, 165, 0)
        local maxWait = 50
        local waited = 0
        
        while (not selectedPlayer.Character or not LocalPlayer.Character) and waited < maxWait do
            wait(0.1)
            waited = waited + 1
        end
    end
    if selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") and
       LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        
        LocalPlayer.Character.HumanoidRootPart.CFrame = 
            selectedPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        StatusText.Text = "Successfully teleported to " .. selectedPlayer.Name .. "!"
        StatusText.TextColor3 = Color3.fromRGB(0, 200, 0)
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "EasyTP V1",
            Text = "Teleported to " .. selectedPlayer.Name .. "!",
            Duration = 3
        })
        
    else
        StatusText.Text = "ERROR: Character not available!"
        StatusText.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end
MinimizeButton.MouseButton1Click:Connect(toggleGUI)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.PageDown then
        executeTeleport()
    end
    if input.KeyCode == Enum.KeyCode.RightShift then
        toggleGUI()
    end
end)
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()
local dragging = false
local dragStart = nil
local startPos = nil
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragStart = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
task.wait(2)
StatusText.Text = "READY - PGDN: Teleport | R-SHIFT: UI"
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "EasyTP V1",
    Text = "Right Shift for UI Toggle",
    Duration = 5
})
print("[[ EasyTP V1 - ACTIVATED ]]")
print(":: FEATURES: Player selection UI + Toggle + Drag")
print(":: KEYS: PGDN = Teleport | Right Shift = UI Toggle")
print(":: STATUS: SYSTEM READY")
