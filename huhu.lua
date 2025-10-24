local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

gui = Instance.new("ScreenGui")
gui.Name = "BrainrotESP"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 250)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
mainFrame.Parent = gui

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "Steal a Brainrot ESP"
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0.5, -15)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeButton.BorderSizePixel = 0
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 14
closeButton.Parent = topBar

local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0, 10, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 4
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
contentFrame.Parent = mainFrame

local espButton = Instance.new("TextButton")
espButton.Name = "ESPButton"
espButton.Size = UDim2.new(1, 0, 0, 40)
espButton.Position = UDim2.new(0, 0, 0, 10)
espButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
espButton.BorderSizePixel = 0
espButton.Font = Enum.Font.GothamBold
espButton.Text = "TOGGLE ESP (N)"
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.TextSize = 14
espButton.Parent = contentFrame

local espStatus = Instance.new("TextLabel")
espStatus.Name = "ESPStatus"
espStatus.Size = UDim2.new(1, 0, 0, 20)
espStatus.Position = UDim2.new(0, 0, 0, 60)
espStatus.BackgroundTransparency = 1
espStatus.Font = Enum.Font.Gotham
espStatus.Text = "Player ESP: Disabled"
espStatus.TextColor3 = Color3.fromRGB(255, 80, 80)
espStatus.TextSize = 12
espStatus.TextXAlignment = Enum.TextXAlignment.Left
espStatus.Parent = contentFrame

local baseEspButton = Instance.new("TextButton")
baseEspButton.Name = "BaseESPButton"
baseEspButton.Size = UDim2.new(1, 0, 0, 40)
baseEspButton.Position = UDim2.new(0, 0, 0, 90)
baseEspButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
baseEspButton.BorderSizePixel = 0
baseEspButton.Font = Enum.Font.GothamBold
baseEspButton.Text = "TOGGLE BASE ESP (B)"
baseEspButton.TextColor3 = Color3.fromRGB(255, 255, 255)
baseEspButton.TextSize = 14
baseEspButton.Parent = contentFrame

local baseEspStatus = Instance.new("TextLabel")
baseEspStatus.Name = "BaseESPStatus"
baseEspStatus.Size = UDim2.new(1, 0, 0, 20)
baseEspStatus.Position = UDim2.new(0, 0, 0, 140)
baseEspStatus.BackgroundTransparency = 1
baseEspStatus.Font = Enum.Font.Gotham
baseEspStatus.Text = "Base ESP: Disabled"
baseEspStatus.TextColor3 = Color3.fromRGB(255, 80, 80)
baseEspStatus.TextSize = 12
baseEspStatus.TextXAlignment = Enum.TextXAlignment.Left
baseEspStatus.Parent = contentFrame

local espEnabled = false
local espObjects = {}
local baseEspEnabled = false
local baseEspObjects = {}

local function createESP(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local character = player.Character
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local head = character:FindFirstChild("Head")
    
    if not rootPart or not head then return end
    
    -- Create billboard GUI for name
    local billboardGui = Instance.new("BillboardGui")
    local nameLabel = Instance.new("TextLabel")
    
    billboardGui.Name = "ESP_" .. player.Name
    billboardGui.Adornee = head
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
    billboardGui.AlwaysOnTop = true
    
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.TextSize = 18
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextYAlignment = Enum.TextYAlignment.Bottom
    nameLabel.Parent = billboardGui
    
    billboardGui.Parent = head
    
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESP_Box_" .. player.Name
    box.Adornee = character:FindFirstChild("HumanoidRootPart")
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Size = character:GetExtentsSize() * 1.2
    box.Color3 = Color3.fromRGB(0, 200, 255)
    box.Transparency = 0.7
    box.Parent = character:FindFirstChild("HumanoidRootPart")
    
    espObjects[player] = {
        billboard = billboardGui,
        box = box
    }
    
end

local function removeESP(player)
    if espObjects[player] then
        if espObjects[player].billboard then
            espObjects[player].billboard:Destroy()
        end
        if espObjects[player].box then
            espObjects[player].box:Destroy()
        end
        espObjects[player] = nil
    end
    
end

local function createBaseESP()
    local localPlayer = Players.LocalPlayer
    local character = localPlayer.Character
    if not character then 
        warn("No character found")
        return 
    end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then 
        warn("No HumanoidRootPart found")
        return 
    end
    
    local workspace = game:GetService("Workspace")
    local plotsFolder = workspace:FindFirstChild("Plots")
    
    if not plotsFolder then
        warn("Plots folder not found in workspace")
        print("Workspace children:")
        for _, child in ipairs(workspace:GetChildren()) do
            print("  - " .. child.Name .. " (" .. child.ClassName .. ")")
        end
        return
    end
    
    print("Found Plots folder, searching for base...")
    print("Player position: " .. tostring(hrp.Position))
    
    local playerBase = nil
    local closestPlot = nil
    local closestDistance = math.huge
    
    for _, plot in ipairs(plotsFolder:GetChildren()) do
        print("Checking plot: " .. plot.Name)
        if plot:IsA("Model") or plot:IsA("Folder") then
            for _, child in ipairs(plot:GetChildren()) do
                print("  Child: " .. child.Name .. " (" .. child.ClassName .. ")")
                if child:IsA("Model") and (string.find(child.Name, "Base") or string.find(child.Name, localPlayer.Name)) then
                    print("  Found base: " .. child.Name)
                    playerBase = child
                    break
                end
            end
            if playerBase then break end
        end
    end
    
    if not playerBase then
        warn("Could not find player base. Trying alternative method...")
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and string.find(obj.Name:lower(), localPlayer.Name:lower()) and string.find(obj.Name:lower(), "base") then
                print("Found base via alternative method: " .. obj.Name)
                playerBase = obj
                break
            end
        end
    end
    
    if not playerBase then
        warn("Could not find player base at all")
        return
    end
    
    print("Highlighting base: " .. playerBase.Name)
    
    local function highlightPart(part)
        if part:IsA("BasePart") then
            local highlight = Instance.new("Highlight")
            highlight.Name = "BaseESP_Highlight"
            highlight.Adornee = part
            highlight.FillColor = Color3.fromRGB(150, 150, 150)
            highlight.OutlineColor = Color3.fromRGB(200, 200, 200)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0.3
            highlight.Parent = part
            
            table.insert(baseEspObjects, highlight)
        end
    end
    
    local partCount = 0
    for _, child in ipairs(playerBase:GetDescendants()) do
        highlightPart(child)
        partCount = partCount + 1
    end
    
    print("Highlighted " .. partCount .. " parts")
end

local function removeBaseESP()
    for _, highlight in ipairs(baseEspObjects) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    baseEspObjects = {}
end

local function toggleBaseESP()
    baseEspEnabled = not baseEspEnabled
    
    if baseEspEnabled then
        baseEspStatus.Text = "Base ESP: Enabled"
        baseEspStatus.TextColor3 = Color3.fromRGB(0, 255, 150)
        baseEspButton.BackgroundColor3 = Color3.fromRGB(0, 200, 150)
        createBaseESP()
    else
        baseEspStatus.Text = "Base ESP: Disabled"
        baseEspStatus.TextColor3 = Color3.fromRGB(255, 80, 80)
        baseEspButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        removeBaseESP()
    end
end

local function toggleESP()
    espEnabled = not espEnabled
    
    if espEnabled then
        espStatus.Text = "Player ESP: Enabled"
        espStatus.TextColor3 = Color3.fromRGB(0, 255, 150)
        espButton.BackgroundColor3 = Color3.fromRGB(0, 200, 150)
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                createESP(player)
            end
        end
    else
        espStatus.Text = "Player ESP: Disabled"
        espStatus.TextColor3 = Color3.fromRGB(255, 80, 80)
        espButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        
        for player in pairs(espObjects) do
            removeESP(player)
        end
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function()
        if espEnabled then
            wait(1)
            createESP(player)
        end
    end)
end

local function onPlayerRemoving(player)
    removeESP(player)
end

local function init()
    Players.PlayerAdded:Connect(onPlayerAdded)
    Players.PlayerRemoving:Connect(onPlayerRemoving)
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            onPlayerAdded(player)
        end
    end
    
    espButton.MouseButton1Click:Connect(toggleESP)
    baseEspButton.MouseButton1Click:Connect(toggleBaseESP)
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.N then
            toggleESP()
        elseif not gameProcessed and input.KeyCode == Enum.KeyCode.B then
            toggleBaseESP()
        end
    end)
    
    local dragging = false
    local dragInput, mousePos, framePos
    
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            mainFrame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)
    
    gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end

init()

local function addRoundedCorners()
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame
    
    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 8)
    topCorner.Parent = topBar
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = espButton
    
    local baseButtonCorner = Instance.new("UICorner")
    baseButtonCorner.CornerRadius = UDim.new(0, 6)
    baseButtonCorner.Parent = baseEspButton
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 15)
    closeCorner.Parent = closeButton
end

addRoundedCorners()

local function addShadow(frame)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.ZIndex = -1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = frame
end

addShadow(mainFrame)

local function addTooltip(button, text)
    local tooltip = Instance.new("TextLabel")
    tooltip.Name = "Tooltip"
    tooltip.Size = UDim2.new(0, 200, 0, 40)
    tooltip.Position = UDim2.new(0, 0, -1, -10)
    tooltip.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    tooltip.BorderSizePixel = 0
    tooltip.Font = Enum.Font.Gotham
    tooltip.Text = text
    tooltip.TextColor3 = Color3.fromRGB(240, 240, 250)
    tooltip.TextSize = 12
    tooltip.TextWrapped = true
    tooltip.Visible = false
    tooltip.ZIndex = 100
    tooltip.Parent = button
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = tooltip
    
    button.MouseEnter:Connect(function()
        tooltip.Visible = true
    end)
    
    button.MouseLeave:Connect(function()
        tooltip.Visible = false
    end)
end

addTooltip(espButton, "Toggle ESP for all players. Shows player names and hitboxes.")
addTooltip(baseEspButton, "Toggle ESP for your base. Highlights your base in gray.")
addTooltip(closeButton, "Close the ESP interface")

local versionLabel = Instance.new("TextLabel")
versionLabel.Name = "Version"
versionLabel.Size = UDim2.new(1, -10, 0, 20)
versionLabel.Position = UDim2.new(0, 10, 1, -25)
versionLabel.BackgroundTransparency = 1
versionLabel.Font = Enum.Font.Gotham
versionLabel.Text = "Steal a Brainrot ESP v1.2"
versionLabel.TextColor3 = Color3.fromRGB(120, 130, 150)
versionLabel.TextSize = 10
versionLabel.TextXAlignment = Enum.TextXAlignment.Right
versionLabel.Parent = mainFrame

local creditsLabel = Instance.new("TextLabel")
creditsLabel.Name = "Credits"
creditsLabel.Size = UDim2.new(1, -10, 0, 20)
creditsLabel.Position = UDim2.new(0, 10, 1, -10)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Font = Enum.Font.Gotham
creditsLabel.Text = "Made for AnonHub"
creditsLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
creditsLabel.TextSize = 10
creditsLabel.TextXAlignment = Enum.TextXAlignment.Right
creditsLabel.Parent = mainFrame

local keybindInfo = Instance.new("TextLabel")
keybindInfo.Name = "KeybindInfo"
keybindInfo.Size = UDim2.new(1, -10, 0, 15)
keybindInfo.Position = UDim2.new(0, 10, 0, 25)
keybindInfo.BackgroundTransparency = 1
keybindInfo.Font = Enum.Font.Gotham
keybindInfo.Text = "N: Player ESP | B: Base ESP"
keybindInfo.TextColor3 = Color3.fromRGB(0, 200, 255)
keybindInfo.TextSize = 10
keybindInfo.TextXAlignment = Enum.TextXAlignment.Left
keybindInfo.Parent = topBar

local function addButtonHoverEffect(button)
    local originalSize = button.Size
    local hoverSize = UDim2.new(originalSize.X.Scale * 1.02, 0, originalSize.Y.Scale * 1.1, 0)
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {Size = hoverSize}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {Size = originalSize}):Play()
    end)
end

addButtonHoverEffect(espButton)
addButtonHoverEffect(baseEspButton)

local function addClickEffect(button)
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = button.Size * 0.95}):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 40)}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 40)}):Play()
    end)
end

addClickEffect(espButton)
addClickEffect(baseEspButton)

mainFrame.BackgroundTransparency = 1
TweenService:Create(mainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()

game:BindToClose(function()
    gui:Destroy()
end)
