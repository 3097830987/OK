-- Name Hider Script
-- UI built with nexlib (Kiciahook style)
-- Keybind: P to open/close

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- SETTINGS
local config = {
    myName = "YourName",
    enemyName = "rivalsisthebest",
    enabled = false
}

-- =====================
-- NEXLIB UI
-- =====================
local t = {accentclr = Color3.fromRGB(128, 213, 247), dropdownframes = {}, colorpickerframes = {}}

local D = Instance.new("ScreenGui")
D.Name = "NameHider"
D.ResetOnSpawn = false
D.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() D.Parent = game:GetService("CoreGui") end)
if not D.Parent then D.Parent = PlayerGui end

local function makeDraggable(dragPart, frame)
    local dragging, dragInput, dragStart, startPos
    dragPart.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    dragPart.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = D
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 220)
MainFrame.Visible = false

local MainOutline = Instance.new("ImageLabel")
MainOutline.Parent = MainFrame
MainOutline.BackgroundTransparency = 1
MainOutline.Position = UDim2.new(0, 1, 0, 1)
MainOutline.Size = UDim2.new(1, -2, 1, -2)
MainOutline.Image = "rbxassetid://2592362371"
MainOutline.ImageColor3 = Color3.fromRGB(60, 60, 60)
MainOutline.ScaleType = Enum.ScaleType.Slice
MainOutline.SliceCenter = Rect.new(2, 2, 62, 62)

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.AnchorPoint = Vector2.new(0.5, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
TopBar.BorderSizePixel = 0
TopBar.Position = UDim2.new(0.5, 0, 0, 2)
TopBar.Size = UDim2.new(1, -5, 0, 28)

local TopBarTitle = Instance.new("TextLabel")
TopBarTitle.Parent = TopBar
TopBarTitle.BackgroundTransparency = 1
TopBarTitle.Position = UDim2.new(0, 7, 0, 5)
TopBarTitle.Size = UDim2.new(1, 0, 0, 16)
TopBarTitle.Font = Enum.Font.Code
TopBarTitle.Text = "Name Hider"
TopBarTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
TopBarTitle.TextSize = 16
TopBarTitle.TextXAlignment = Enum.TextXAlignment.Left

local TopBarLine = Instance.new("Frame")
TopBarLine.Parent = TopBar
TopBarLine.BackgroundColor3 = t.accentclr
TopBarLine.BorderSizePixel = 0
TopBarLine.Position = UDim2.new(0, 0, 0, 27)
TopBarLine.Size = UDim2.new(1, 0, 0, 1)

coroutine.wrap(function()
    while true do
        TopBarLine.BackgroundColor3 = t.accentclr
        task.wait()
    end
end)()

makeDraggable(TopBar, MainFrame)

-- Section Frame
local SectionFrame = Instance.new("Frame")
SectionFrame.Parent = MainFrame
SectionFrame.AnchorPoint = Vector2.new(0.5, 0)
SectionFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SectionFrame.BorderSizePixel = 0
SectionFrame.Position = UDim2.new(0.5, 0, 0, 38)
SectionFrame.Size = UDim2.new(1, -18, 0, 170)

local SectionOutline = Instance.new("ImageLabel")
SectionOutline.Parent = SectionFrame
SectionOutline.BackgroundTransparency = 1
SectionOutline.Position = UDim2.new(0, 1, 0, 1)
SectionOutline.Size = UDim2.new(1, -2, 1, -2)
SectionOutline.Image = "rbxassetid://2592362371"
SectionOutline.ImageColor3 = Color3.fromRGB(60, 60, 60)
SectionOutline.ScaleType = Enum.ScaleType.Slice
SectionOutline.SliceCenter = Rect.new(2, 2, 62, 62)

local SectionTitleFrame = Instance.new("Frame")
SectionTitleFrame.Parent = SectionFrame
SectionTitleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SectionTitleFrame.BorderSizePixel = 0
SectionTitleFrame.Position = UDim2.new(0, 10, 0, 0)
SectionTitleFrame.Size = UDim2.new(0, 90, 0, 7)

local SectionTitle = Instance.new("TextLabel")
SectionTitle.Parent = SectionTitleFrame
SectionTitle.BackgroundTransparency = 1
SectionTitle.Position = UDim2.new(0, 0, 0, -3)
SectionTitle.Size = UDim2.new(1, 0, 0, 7)
SectionTitle.Font = Enum.Font.Code
SectionTitle.Text = "Name Spoofer"
SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SectionTitle.TextSize = 14

local ItemHolder = Instance.new("Frame")
ItemHolder.Parent = SectionFrame
ItemHolder.AnchorPoint = Vector2.new(0.5, 0)
ItemHolder.BackgroundTransparency = 1
ItemHolder.Position = UDim2.new(0.5, 0, 0, 15)
ItemHolder.Size = UDim2.new(1, -16, 1, -20)

local ItemLayout = Instance.new("UIListLayout")
ItemLayout.Parent = ItemHolder
ItemLayout.SortOrder = Enum.SortOrder.LayoutOrder
ItemLayout.Padding = UDim.new(0, 8)

-- Toggle
local function makeToggle(parent, labelText, default, callback)
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = parent
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Size = UDim2.new(1, 0, 0, 22)
    toggleBtn.Font = Enum.Font.Code
    toggleBtn.Text = ""
    toggleBtn.TextSize = 14

    local toggleFrame = Instance.new("Frame")
    toggleFrame.Parent = toggleBtn
    toggleFrame.AnchorPoint = Vector2.new(0, 0.5)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    toggleFrame.BorderColor3 = t.accentclr
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Position = UDim2.new(0, 0, 0.5, 0)
    toggleFrame.Size = UDim2.new(0, 14, 0, 14)

    local toggleOutline = Instance.new("ImageLabel")
    toggleOutline.Parent = toggleFrame
    toggleOutline.BackgroundTransparency = 1
    toggleOutline.Size = UDim2.new(1, 0, 1, 0)
    toggleOutline.Image = "rbxassetid://2592362371"
    toggleOutline.ImageColor3 = Color3.fromRGB(60, 60, 60)
    toggleOutline.ScaleType = Enum.ScaleType.Slice
    toggleOutline.SliceCenter = Rect.new(2, 2, 62, 62)

    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Parent = toggleBtn
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Position = UDim2.new(0, 19, 0, 0)
    toggleLabel.Size = UDim2.new(1, -19, 1, 0)
    toggleLabel.Font = Enum.Font.Code
    toggleLabel.Text = labelText
    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleLabel.TextSize = 14
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.TextTransparency = default and 0 or 0.4

    local state = default or false

    local function updateVisual()
        if state then
            toggleFrame.BackgroundColor3 = t.accentclr
            TweenService:Create(toggleLabel, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
        else
            toggleFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            TweenService:Create(toggleLabel, TweenInfo.new(0.2), {TextTransparency = 0.4}):Play()
        end
    end

    updateVisual()

    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        updateVisual()
        callback(state)
    end)

    coroutine.wrap(function()
        while true do
            toggleFrame.BorderColor3 = t.accentclr
            task.wait()
        end
    end)()
end

-- Textbox
local function makeTextbox(parent, labelText, placeholder, callback)
    local container = Instance.new("Frame")
    container.Parent = parent
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, 0, 0, 37)

    local label = Instance.new("TextLabel")
    label.Parent = container
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, 13)
    label.Font = Enum.Font.Code
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    local boxFrame = Instance.new("Frame")
    boxFrame.Parent = container
    boxFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    boxFrame.BorderSizePixel = 0
    boxFrame.Position = UDim2.new(0, 0, 1, -20)
    boxFrame.Size = UDim2.new(1, 0, 0, 20)

    local boxOutline = Instance.new("ImageLabel")
    boxOutline.Parent = boxFrame
    boxOutline.BackgroundTransparency = 1
    boxOutline.Size = UDim2.new(1, 0, 1, 0)
    boxOutline.Image = "rbxassetid://2592362371"
    boxOutline.ImageColor3 = Color3.fromRGB(60, 60, 60)
    boxOutline.ScaleType = Enum.ScaleType.Slice
    boxOutline.SliceCenter = Rect.new(2, 2, 62, 62)

    local textbox = Instance.new("TextBox")
    textbox.Parent = boxFrame
    textbox.BackgroundTransparency = 1
    textbox.Position = UDim2.new(0, 5, 0, 0)
    textbox.Size = UDim2.new(1, -5, 1, 0)
    textbox.Font = Enum.Font.Code
    textbox.PlaceholderText = placeholder
    textbox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    textbox.Text = ""
    textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textbox.TextSize = 14
    textbox.TextXAlignment = Enum.TextXAlignment.Left
    textbox.ClearTextOnFocus = false

    textbox.FocusLost:Connect(function()
        if #textbox.Text > 0 then
            callback(textbox.Text)
        end
    end)
end

-- Build UI elements
makeToggle(ItemHolder, "Enable Name Hider", false, function(state)
    config.enabled = state
end)

makeTextbox(ItemHolder, "Your Name:", "Enter your fake name", function(text)
    config.myName = text
end)

makeTextbox(ItemHolder, "Enemy Name:", "Enter enemy fake name", function(text)
    config.enemyName = text
end)

-- Keybind P to toggle
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.P then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- =====================
-- NAME CHANGING LOGIC
-- =====================
RunService.RenderStepped:Connect(function()
    if not config.enabled then return end

    for _, player in ipairs(Players:GetPlayers()) do
        local char = player.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                local nametag = root:FindFirstChild("NametagGui")
                if nametag then
                    for _, label in ipairs(nametag:GetDescendants()) do
                        if label:IsA("TextLabel") then
                            if label.Name == "DisplayName" then
                                if player == LocalPlayer then
                                    label.Text = config.myName
                                else
                                    label.Text = config.enemyName
                                end
                            end
                            if label.Name == "Username" then
                                if player == LocalPlayer then
                                    label.Text = "@" .. config.myName
                                else
                                    label.Text = "@" .. config.enemyName
                                end
                            end
                        end
                    end
                end

                local teamtag = root:FindFirstChild("TeammateLabel")
                if teamtag then
                    for _, label in ipairs(teamtag:GetDescendants()) do
                        if label:IsA("TextLabel") then
                            if label.Name == "DisplayName" then
                                label.Text = config.enemyName
                            end
                            if label.Name == "Username" then
                                label.Text = "@" .. config.enemyName
                            end
                        end
                    end
                end
            end
        end
    end

    local mainGui = PlayerGui:FindFirstChild("MainGui")
    if not mainGui then return end
    local mainFrame = mainGui:FindFirstChild("MainFrame")
    if not mainFrame then return end
    local duelInterfaces = mainFrame:FindFirstChild("DuelInterfaces")
    if not duelInterfaces then return end
    local duelInterface = duelInterfaces:FindFirstChild("DuelInterface")
    if not duelInterface then return end

    for _, v in ipairs(duelInterface:GetDescendants()) do
        if v:IsA("TextLabel") and v.Name == "Username" then
            if string.find(v.Text, "@" .. LocalPlayer.Name) then
                v.Text = "@" .. config.myName
            else
                v.Text = "@" .. config.enemyName
            end
        end
    end
end)

print("Name Hider loaded! Press P to open/close.")
