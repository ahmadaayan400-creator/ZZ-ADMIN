-- =========================================================
-- 💢 ZZ YIELD — AAYAN's own command-bar admin tool
-- Infinite-Yield style: small command bar + ;cmds list popup
-- =========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local StatsService = game:GetService("Stats")
local PathfindingService = game:GetService("PathfindingService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("ZZ_YIELD") then
    PlayerGui.ZZ_YIELD:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "ZZ_YIELD"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = PlayerGui

-- =========================================================
-- execution splash — shows for a moment when the script loads,
-- Infinite-Yield style ("Infinite Yield loaded" logo popup)
-- =========================================================

do
    local Splash = Instance.new("Frame", gui)
    Splash.AnchorPoint = Vector2.new(0.5, 0.5)
    Splash.Position = UDim2.new(0.5, 0, 0.4, 0)
    Splash.Size = UDim2.new(0, 260, 0, 150)
    Splash.BackgroundTransparency = 1
    Splash.ZIndex = 100

    -- logo badge: a circular dark badge with a merged "ZZ" monogram mark
    local Badge = Instance.new("Frame", Splash)
    Badge.AnchorPoint = Vector2.new(0.5, 0)
    Badge.Position = UDim2.new(0.5, 0, 0, 0)
    Badge.Size = UDim2.new(0, 80, 0, 80)
    Badge.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Badge.BackgroundTransparency = 1
    Badge.BorderSizePixel = 0
    Badge.ZIndex = 101
    Instance.new("UICorner", Badge).CornerRadius = UDim.new(1, 0)
    local BadgeStroke = Instance.new("UIStroke", Badge)
    BadgeStroke.Thickness = 1.6
    BadgeStroke.Color = Color3.fromRGB(235, 235, 235)
    BadgeStroke.Transparency = 1

    local Z1 = Instance.new("TextLabel", Badge)
    Z1.AnchorPoint = Vector2.new(0.5, 0.5)
    Z1.Position = UDim2.new(0.38, 0, 0.5, 0)
    Z1.Size = UDim2.new(0, 46, 0, 50)
    Z1.Rotation = -10
    Z1.BackgroundTransparency = 1
    Z1.Text = "Z"
    Z1.TextColor3 = Color3.fromRGB(255, 255, 255)
    Z1.TextTransparency = 1
    Z1.Font = Enum.Font.SourceSansBold
    Z1.TextSize = 42
    Z1.ZIndex = 102

    local Z2 = Instance.new("TextLabel", Badge)
    Z2.AnchorPoint = Vector2.new(0.5, 0.5)
    Z2.Position = UDim2.new(0.62, 0, 0.5, 0)
    Z2.Size = UDim2.new(0, 46, 0, 50)
    Z2.Rotation = 10
    Z2.BackgroundTransparency = 1
    Z2.Text = "Z"
    Z2.TextColor3 = Color3.fromRGB(180, 180, 180)
    Z2.TextTransparency = 1
    Z2.Font = Enum.Font.SourceSansBold
    Z2.TextSize = 42
    Z2.ZIndex = 103

    local SplashTitle = Instance.new("TextLabel", Splash)
    SplashTitle.AnchorPoint = Vector2.new(0.5, 0)
    SplashTitle.Position = UDim2.new(0.5, 0, 0, 92)
    SplashTitle.Size = UDim2.new(1, 0, 0, 30)
    SplashTitle.BackgroundTransparency = 1
    SplashTitle.Text = "ZZ  Y I E L D"
    SplashTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SplashTitle.TextTransparency = 1
    SplashTitle.Font = Enum.Font.SourceSansBold
    SplashTitle.TextSize = 24
    SplashTitle.ZIndex = 101

    local SplashSub = Instance.new("TextLabel", Splash)
    SplashSub.AnchorPoint = Vector2.new(0.5, 0)
    SplashSub.Position = UDim2.new(0.5, 0, 0, 122)
    SplashSub.Size = UDim2.new(1, 0, 0, 18)
    SplashSub.BackgroundTransparency = 1
    SplashSub.Text = "loaded — type ;cmds to search"
    SplashSub.TextColor3 = Color3.fromRGB(180, 180, 180)
    SplashSub.TextTransparency = 1
    SplashSub.Font = Enum.Font.SourceSans
    SplashSub.TextSize = 13
    SplashSub.ZIndex = 101

    Badge.Size = UDim2.new(0, 55, 0, 55)
    local badgeGrow = TweenService:Create(Badge, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 80, 0, 80),
        BackgroundTransparency = 0.05,
    })
    local badgeStrokeIn = TweenService:Create(BadgeStroke, TweenInfo.new(0.45), { Transparency = 0.2 })
    local z1In = TweenService:Create(Z1, TweenInfo.new(0.4), { TextTransparency = 0 })
    local z2In = TweenService:Create(Z2, TweenInfo.new(0.4), { TextTransparency = 0.15 })
    local titleIn = TweenService:Create(SplashTitle, TweenInfo.new(0.4), { TextTransparency = 0 })
    local subIn = TweenService:Create(SplashSub, TweenInfo.new(0.4), { TextTransparency = 0 })
    badgeGrow:Play()
    badgeStrokeIn:Play()
    z1In:Play()
    z2In:Play()
    titleIn:Play()
    subIn:Play()

    task.spawn(function()
        task.wait(2)
        local outs = {
            TweenService:Create(Badge, TweenInfo.new(0.4), { BackgroundTransparency = 1 }),
            TweenService:Create(BadgeStroke, TweenInfo.new(0.4), { Transparency = 1 }),
            TweenService:Create(Z1, TweenInfo.new(0.4), { TextTransparency = 1 }),
            TweenService:Create(Z2, TweenInfo.new(0.4), { TextTransparency = 1 }),
            TweenService:Create(SplashTitle, TweenInfo.new(0.4), { TextTransparency = 1 }),
            TweenService:Create(SplashSub, TweenInfo.new(0.4), { TextTransparency = 1 }),
        }
        for _, t in ipairs(outs) do t:Play() end
        outs[1].Completed:Wait()
        Splash:Destroy()
    end)
end

-- =========================================================
-- helpers
-- =========================================================

local function getChar() return player.Character or player.CharacterAdded:Wait() end
local function getRoot() local c = getChar() return c and c:FindFirstChild("HumanoidRootPart") end
local function getHum() local c = getChar() return c and c:FindFirstChildOfClass("Humanoid") end

local function makeDraggable(obj)
    local dragging, dragStart, startPos, dragInput
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- =========================================================
-- command bar (bottom-left, draggable) — type commands here,
-- NOT in real chat, so this works the same in every game
-- =========================================================

local Bar = Instance.new("Frame", gui)
Bar.Size = UDim2.new(0, 330, 0, 34)
Bar.Position = UDim2.new(0, 16, 1, -50)
Bar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Bar.BorderSizePixel = 0
Bar.ZIndex = 50
Instance.new("UICorner", Bar).CornerRadius = UDim.new(0, 4)
local BarStroke = Instance.new("UIStroke", Bar)
BarStroke.Thickness = 1
BarStroke.Color = Color3.fromRGB(60, 60, 60)
makeDraggable(Bar)

local prefix = ";"

local Input = Instance.new("TextBox", Bar)
Input.Size = UDim2.new(1, -112, 1, -8)
Input.Position = UDim2.new(0, 8, 0, 4)
Input.BackgroundTransparency = 1
Input.PlaceholderText = "Type " .. prefix .. "cmds for list..."
Input.Text = ""
Input.TextColor3 = Color3.fromRGB(235, 235, 235)
Input.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
Input.Font = Enum.Font.SourceSans
Input.TextSize = 14
Input.TextXAlignment = Enum.TextXAlignment.Left
Input.ClearTextOnFocus = false
Input.ZIndex = 51

local CmdsBtn = Instance.new("TextButton", Bar)
CmdsBtn.Size = UDim2.new(0, 48, 0, 24)
CmdsBtn.Position = UDim2.new(1, -104, 0.5, -12)
CmdsBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
CmdsBtn.BorderSizePixel = 0
CmdsBtn.Text = "CMDS"
CmdsBtn.TextColor3 = Color3.fromRGB(235, 235, 235)
CmdsBtn.Font = Enum.Font.SourceSansBold
CmdsBtn.TextSize = 12
CmdsBtn.ZIndex = 51
Instance.new("UICorner", CmdsBtn).CornerRadius = UDim.new(0, 4)

local GearBtn = Instance.new("TextButton", Bar)
GearBtn.Size = UDim2.new(0, 24, 0, 24)
GearBtn.Position = UDim2.new(1, -52, 0.5, -12)
GearBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
GearBtn.BorderSizePixel = 0
GearBtn.Text = "⚙"
GearBtn.TextColor3 = Color3.fromRGB(235, 235, 235)
GearBtn.Font = Enum.Font.SourceSansBold
GearBtn.TextSize = 14
GearBtn.ZIndex = 51
Instance.new("UICorner", GearBtn).CornerRadius = UDim.new(0, 4)

local CustomizeBtn = Instance.new("TextButton", Bar)
CustomizeBtn.Size = UDim2.new(0, 24, 0, 24)
CustomizeBtn.Position = UDim2.new(1, -24, 0.5, -12)
CustomizeBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
CustomizeBtn.BorderSizePixel = 0
CustomizeBtn.Text = "⌘"
CustomizeBtn.TextColor3 = Color3.fromRGB(235, 235, 235)
CustomizeBtn.Font = Enum.Font.SourceSansBold
CustomizeBtn.TextSize = 13
CustomizeBtn.ZIndex = 51
Instance.new("UICorner", CustomizeBtn).CornerRadius = UDim.new(0, 4)

-- status/feedback line, shows last ran command or error
local Status = Instance.new("TextLabel", gui)
Status.Size = UDim2.new(0, 330, 0, 18)
Status.Position = UDim2.new(0, 16, 1, -70)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.Font = Enum.Font.SourceSans
Status.TextSize = 13
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.ZIndex = 50

local function setStatus(msg, bad)
    Status.Text = msg
    Status.TextColor3 = bad and Color3.fromRGB(255, 90, 90) or Color3.fromRGB(200, 200, 200)
end

-- =========================================================
-- cmds list popup
-- =========================================================

local ListPopup = Instance.new("Frame", gui)
ListPopup.Size = UDim2.new(0, 240, 0, 290)
ListPopup.Position = UDim2.new(0, 8, 1, -360)
ListPopup.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ListPopup.BorderSizePixel = 0
ListPopup.Visible = false
ListPopup.ZIndex = 50
Instance.new("UICorner", ListPopup).CornerRadius = UDim.new(0, 5)
local ListStroke = Instance.new("UIStroke", ListPopup)
ListStroke.Thickness = 1
ListStroke.Color = Color3.fromRGB(65, 65, 65)
makeDraggable(ListPopup)

local ListTitle = Instance.new("TextLabel", ListPopup)
ListTitle.Size = UDim2.new(1, -16, 0, 22)
ListTitle.Position = UDim2.new(0, 8, 0, 4)
ListTitle.BackgroundTransparency = 1
ListTitle.Text = "ZZ YIELD — COMMANDS"
ListTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
ListTitle.Font = Enum.Font.SourceSansBold
ListTitle.TextSize = 14
ListTitle.TextXAlignment = Enum.TextXAlignment.Left
ListTitle.ZIndex = 51

local ListCount = Instance.new("TextLabel", ListPopup)
ListCount.Size = UDim2.new(0, 60, 0, 22)
ListCount.Position = UDim2.new(1, -68, 0, 4)
ListCount.BackgroundTransparency = 1
ListCount.Text = ""
ListCount.TextColor3 = Color3.fromRGB(140, 140, 140)
ListCount.Font = Enum.Font.SourceSans
ListCount.TextSize = 11
ListCount.TextXAlignment = Enum.TextXAlignment.Right
ListCount.ZIndex = 51

-- search bar, same idea as Infinite Yield's command search
local SearchBox = Instance.new("TextBox", ListPopup)
SearchBox.Size = UDim2.new(1, -16, 0, 24)
SearchBox.Position = UDim2.new(0, 8, 0, 28)
SearchBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
SearchBox.BorderSizePixel = 0
SearchBox.PlaceholderText = "Search commands..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(230, 230, 230)
SearchBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 130)
SearchBox.Font = Enum.Font.SourceSans
SearchBox.TextSize = 13
SearchBox.ClearTextOnFocus = false
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.ZIndex = 51
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 4)
local SearchPad = Instance.new("UIPadding", SearchBox)
SearchPad.PaddingLeft = UDim.new(0, 8)
local SearchStroke = Instance.new("UIStroke", SearchBox)
SearchStroke.Thickness = 1
SearchStroke.Color = Color3.fromRGB(70, 70, 70)

local ListScroll = Instance.new("ScrollingFrame", ListPopup)
ListScroll.Size = UDim2.new(1, -16, 1, -68)
ListScroll.Position = UDim2.new(0, 8, 0, 60)
ListScroll.BackgroundTransparency = 1
ListScroll.BorderSizePixel = 0
ListScroll.ScrollBarThickness = 3
ListScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ListScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ListScroll.ZIndex = 51

local ListLayout = Instance.new("UIListLayout", ListScroll)
ListLayout.Padding = UDim.new(0, 2)

-- every line gets tracked here so the search box can filter them;
-- headers remember their group's lines so they can hide/show together
local AllLines = {}
local CurrentHeaderGroup = nil

local function addListLine(text, isHeader, key)
    local l = Instance.new("TextLabel", ListScroll)
    l.Size = UDim2.new(1, 0, 0, isHeader and 20 or 16)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = isHeader and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(205, 205, 205)
    l.Font = isHeader and Enum.Font.SourceSansBold or Enum.Font.SourceSans
    l.TextSize = isHeader and 13 or 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 51

    if isHeader then
        CurrentHeaderGroup = { header = l, items = {} }
        table.insert(AllLines, CurrentHeaderGroup)
    elseif CurrentHeaderGroup then
        table.insert(CurrentHeaderGroup.items, { label = l, key = (key or text or ""):lower() })
    end
    return l
end

local function applySearch()
    local query = SearchBox.Text:lower()
    local shownCount = 0
    for _, group in ipairs(AllLines) do
        local anyVisible = false
        for _, item in ipairs(group.items) do
            local match = query == "" or item.key:find(query, 1, true) ~= nil
            item.label.Visible = match
            if match then
                anyVisible = true
                shownCount = shownCount + 1
            end
        end
        group.header.Visible = anyVisible or query == ""
    end
    ListCount.Text = shownCount .. " cmds"
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(applySearch)

CmdsBtn.MouseButton1Click:Connect(function()
    ListPopup.Visible = not ListPopup.Visible
end)

-- =========================================================
-- SETTINGS panel (gear icon) — prefix, shields, keybinds
-- =========================================================

local SettingsPopup = Instance.new("Frame", gui)
SettingsPopup.Size = UDim2.new(0, 230, 0, 310)
SettingsPopup.Position = UDim2.new(0, 260, 1, -360)
SettingsPopup.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SettingsPopup.BorderSizePixel = 0
SettingsPopup.Visible = false
SettingsPopup.ZIndex = 50
Instance.new("UICorner", SettingsPopup).CornerRadius = UDim.new(0, 5)
local SettingsStroke = Instance.new("UIStroke", SettingsPopup)
SettingsStroke.Thickness = 1
SettingsStroke.Color = Color3.fromRGB(65, 65, 65)
makeDraggable(SettingsPopup)

local SettingsTitle = Instance.new("TextLabel", SettingsPopup)
SettingsTitle.Size = UDim2.new(1, -16, 0, 22)
SettingsTitle.Position = UDim2.new(0, 8, 0, 4)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Text = "⚙ SETTINGS"
SettingsTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
SettingsTitle.Font = Enum.Font.SourceSansBold
SettingsTitle.TextSize = 14
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
SettingsTitle.ZIndex = 51

local SettingsScroll = Instance.new("ScrollingFrame", SettingsPopup)
SettingsScroll.Size = UDim2.new(1, -16, 1, -36)
SettingsScroll.Position = UDim2.new(0, 8, 0, 30)
SettingsScroll.BackgroundTransparency = 1
SettingsScroll.BorderSizePixel = 0
SettingsScroll.ScrollBarThickness = 3
SettingsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SettingsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SettingsScroll.ZIndex = 51
local SettingsLayout = Instance.new("UIListLayout", SettingsScroll)
SettingsLayout.Padding = UDim.new(0, 5)

local function settingsHeader(text)
    local l = Instance.new("TextLabel", SettingsScroll)
    l.Size = UDim2.new(1, 0, 0, 18)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(255, 255, 255)
    l.Font = Enum.Font.SourceSansBold
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 51
    return l
end

settingsHeader("PREFIX")
local PrefixRow = Instance.new("Frame", SettingsScroll)
PrefixRow.Size = UDim2.new(1, 0, 0, 22)
PrefixRow.BackgroundTransparency = 1
PrefixRow.ZIndex = 51
local PrefixBox = Instance.new("TextBox", PrefixRow)
PrefixBox.Size = UDim2.new(0, 60, 0, 20)
PrefixBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
PrefixBox.BorderSizePixel = 0
PrefixBox.Text = prefix
PrefixBox.TextColor3 = Color3.fromRGB(230, 230, 230)
PrefixBox.Font = Enum.Font.SourceSans
PrefixBox.TextSize = 13
PrefixBox.ClearTextOnFocus = false
PrefixBox.ZIndex = 52
Instance.new("UICorner", PrefixBox).CornerRadius = UDim.new(0, 3)
local PrefixApply = Instance.new("TextButton", PrefixRow)
PrefixApply.Size = UDim2.new(0, 56, 0, 20)
PrefixApply.Position = UDim2.new(0, 66, 0, 0)
PrefixApply.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
PrefixApply.BorderSizePixel = 0
PrefixApply.Text = "Apply"
PrefixApply.TextColor3 = Color3.fromRGB(230, 230, 230)
PrefixApply.Font = Enum.Font.SourceSansBold
PrefixApply.TextSize = 12
PrefixApply.ZIndex = 52
Instance.new("UICorner", PrefixApply).CornerRadius = UDim.new(0, 3)

settingsHeader("SHIELDS")
local ShieldGrid = Instance.new("Frame", SettingsScroll)
ShieldGrid.Size = UDim2.new(1, 0, 0, 170)
ShieldGrid.BackgroundTransparency = 1
ShieldGrid.ZIndex = 51
local ShieldGridLayout = Instance.new("UIGridLayout", ShieldGrid)
ShieldGridLayout.CellSize = UDim2.new(0, 100, 0, 22)
ShieldGridLayout.CellPadding = UDim2.new(0, 4, 0, 4)

settingsHeader("KEYBINDS (PC key or hotbar slot 1-5)")
local BindRow = Instance.new("Frame", SettingsScroll)
BindRow.Size = UDim2.new(1, 0, 0, 22)
BindRow.BackgroundTransparency = 1
BindRow.ZIndex = 51
local BindKeyBox = Instance.new("TextBox", BindRow)
BindKeyBox.Size = UDim2.new(0, 36, 0, 20)
BindKeyBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
BindKeyBox.BorderSizePixel = 0
BindKeyBox.PlaceholderText = "key"
BindKeyBox.Text = ""
BindKeyBox.TextColor3 = Color3.fromRGB(230, 230, 230)
BindKeyBox.Font = Enum.Font.SourceSans
BindKeyBox.TextSize = 12
BindKeyBox.ClearTextOnFocus = false
BindKeyBox.ZIndex = 52
Instance.new("UICorner", BindKeyBox).CornerRadius = UDim.new(0, 3)
local BindCmdBox = Instance.new("TextBox", BindRow)
BindCmdBox.Size = UDim2.new(0, 94, 0, 20)
BindCmdBox.Position = UDim2.new(0, 40, 0, 0)
BindCmdBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
BindCmdBox.BorderSizePixel = 0
BindCmdBox.PlaceholderText = "command"
BindCmdBox.Text = ""
BindCmdBox.TextColor3 = Color3.fromRGB(230, 230, 230)
BindCmdBox.Font = Enum.Font.SourceSans
BindCmdBox.TextSize = 12
BindCmdBox.ClearTextOnFocus = false
BindCmdBox.ZIndex = 52
Instance.new("UICorner", BindCmdBox).CornerRadius = UDim.new(0, 3)
local BindSetBtn = Instance.new("TextButton", BindRow)
BindSetBtn.Size = UDim2.new(0, 52, 0, 20)
BindSetBtn.Position = UDim2.new(0, 138, 0, 0)
BindSetBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
BindSetBtn.BorderSizePixel = 0
BindSetBtn.Text = "Bind"
BindSetBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
BindSetBtn.Font = Enum.Font.SourceSansBold
BindSetBtn.TextSize = 12
BindSetBtn.ZIndex = 52
Instance.new("UICorner", BindSetBtn).CornerRadius = UDim.new(0, 3)

local BindsList = Instance.new("TextLabel", SettingsScroll)
BindsList.Size = UDim2.new(1, 0, 0, 50)
BindsList.BackgroundTransparency = 1
BindsList.Text = "No binds yet"
BindsList.TextColor3 = Color3.fromRGB(160, 160, 160)
BindsList.Font = Enum.Font.SourceSans
BindsList.TextSize = 11
BindsList.TextWrapped = true
BindsList.TextXAlignment = Enum.TextXAlignment.Left
BindsList.TextYAlignment = Enum.TextYAlignment.Top
BindsList.ZIndex = 51

GearBtn.MouseButton1Click:Connect(function()
    SettingsPopup.Visible = not SettingsPopup.Visible
end)

-- =========================================================
-- CUSTOMIZE panel — pick a command, give it your own shortcut
-- =========================================================

local CustomizePopup = Instance.new("Frame", gui)
CustomizePopup.Size = UDim2.new(0, 240, 0, 310)
CustomizePopup.Position = UDim2.new(0, 500, 1, -360)
CustomizePopup.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CustomizePopup.BorderSizePixel = 0
CustomizePopup.Visible = false
CustomizePopup.ZIndex = 50
Instance.new("UICorner", CustomizePopup).CornerRadius = UDim.new(0, 5)
local CustomizeStroke = Instance.new("UIStroke", CustomizePopup)
CustomizeStroke.Thickness = 1
CustomizeStroke.Color = Color3.fromRGB(65, 65, 65)
makeDraggable(CustomizePopup)

local CustomizeTitle = Instance.new("TextLabel", CustomizePopup)
CustomizeTitle.Size = UDim2.new(1, -16, 0, 20)
CustomizeTitle.Position = UDim2.new(0, 8, 0, 4)
CustomizeTitle.BackgroundTransparency = 1
CustomizeTitle.Text = "⌘ CUSTOMIZE SHORTCUTS"
CustomizeTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
CustomizeTitle.Font = Enum.Font.SourceSansBold
CustomizeTitle.TextSize = 13
CustomizeTitle.TextXAlignment = Enum.TextXAlignment.Left
CustomizeTitle.ZIndex = 51

local CustomizeSearch = Instance.new("TextBox", CustomizePopup)
CustomizeSearch.Size = UDim2.new(1, -16, 0, 22)
CustomizeSearch.Position = UDim2.new(0, 8, 0, 26)
CustomizeSearch.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
CustomizeSearch.BorderSizePixel = 0
CustomizeSearch.PlaceholderText = "Search command to shortcut..."
CustomizeSearch.Text = ""
CustomizeSearch.TextColor3 = Color3.fromRGB(230, 230, 230)
CustomizeSearch.Font = Enum.Font.SourceSans
CustomizeSearch.TextSize = 12
CustomizeSearch.ClearTextOnFocus = false
CustomizeSearch.ZIndex = 51
Instance.new("UICorner", CustomizeSearch).CornerRadius = UDim.new(0, 4)

local CustomizeList = Instance.new("ScrollingFrame", CustomizePopup)
CustomizeList.Size = UDim2.new(1, -16, 1, -150)
CustomizeList.Position = UDim2.new(0, 8, 0, 52)
CustomizeList.BackgroundTransparency = 1
CustomizeList.BorderSizePixel = 0
CustomizeList.ScrollBarThickness = 3
CustomizeList.CanvasSize = UDim2.new(0, 0, 0, 0)
CustomizeList.AutomaticCanvasSize = Enum.AutomaticSize.Y
CustomizeList.ZIndex = 51
local CustomizeListLayout = Instance.new("UIListLayout", CustomizeList)
CustomizeListLayout.Padding = UDim.new(0, 2)

local SelectedLabel = Instance.new("TextLabel", CustomizePopup)
SelectedLabel.Size = UDim2.new(1, -16, 0, 18)
SelectedLabel.Position = UDim2.new(0, 8, 1, -90)
SelectedLabel.BackgroundTransparency = 1
SelectedLabel.Text = "Selected: none"
SelectedLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
SelectedLabel.Font = Enum.Font.SourceSans
SelectedLabel.TextSize = 12
SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
SelectedLabel.ZIndex = 51

local ShortcutBox = Instance.new("TextBox", CustomizePopup)
ShortcutBox.Size = UDim2.new(1, -90, 0, 22)
ShortcutBox.Position = UDim2.new(0, 8, 1, -64)
ShortcutBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
ShortcutBox.BorderSizePixel = 0
ShortcutBox.PlaceholderText = "your shortcut e.g. bng"
ShortcutBox.Text = ""
ShortcutBox.TextColor3 = Color3.fromRGB(230, 230, 230)
ShortcutBox.Font = Enum.Font.SourceSans
ShortcutBox.TextSize = 12
ShortcutBox.ClearTextOnFocus = false
ShortcutBox.ZIndex = 51
Instance.new("UICorner", ShortcutBox).CornerRadius = UDim.new(0, 4)

local SaveShortcutBtn = Instance.new("TextButton", CustomizePopup)
SaveShortcutBtn.Size = UDim2.new(0, 74, 0, 22)
SaveShortcutBtn.Position = UDim2.new(1, -82, 1, -64)
SaveShortcutBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
SaveShortcutBtn.BorderSizePixel = 0
SaveShortcutBtn.Text = "Save"
SaveShortcutBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
SaveShortcutBtn.Font = Enum.Font.SourceSansBold
SaveShortcutBtn.TextSize = 12
SaveShortcutBtn.ZIndex = 51
Instance.new("UICorner", SaveShortcutBtn).CornerRadius = UDim.new(0, 4)

local SavedShortcutsLabel = Instance.new("TextLabel", CustomizePopup)
SavedShortcutsLabel.Size = UDim2.new(1, -16, 0, 34)
SavedShortcutsLabel.Position = UDim2.new(0, 8, 1, -36)
SavedShortcutsLabel.BackgroundTransparency = 1
SavedShortcutsLabel.Text = ""
SavedShortcutsLabel.TextColor3 = Color3.fromRGB(150, 220, 150)
SavedShortcutsLabel.Font = Enum.Font.SourceSans
SavedShortcutsLabel.TextSize = 11
SavedShortcutsLabel.TextWrapped = true
SavedShortcutsLabel.TextXAlignment = Enum.TextXAlignment.Left
SavedShortcutsLabel.ZIndex = 51

CustomizeBtn.MouseButton1Click:Connect(function()
    CustomizePopup.Visible = not CustomizePopup.Visible
end)

-- =========================================================
-- mobile/PC hotbar — 5 slots, bind a command to each with
-- ;bind 1..5 <command>, tap (or its key) to run it instantly
-- =========================================================

local Hotbar = Instance.new("Frame", gui)
Hotbar.Size = UDim2.new(0, 220, 0, 36)
Hotbar.Position = UDim2.new(1, -236, 1, -50)
Hotbar.BackgroundTransparency = 1
Hotbar.ZIndex = 50
local HotbarLayout = Instance.new("UIListLayout", Hotbar)
HotbarLayout.FillDirection = Enum.FillDirection.Horizontal
HotbarLayout.Padding = UDim.new(0, 6)
HotbarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right

local HotbarSlots = {}
for i = 1, 5 do
    local slot = Instance.new("TextButton", Hotbar)
    slot.Size = UDim2.new(0, 36, 0, 36)
    slot.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    slot.BorderSizePixel = 0
    slot.Text = tostring(i)
    slot.TextColor3 = Color3.fromRGB(200, 200, 200)
    slot.Font = Enum.Font.SourceSansBold
    slot.TextSize = 14
    slot.ZIndex = 50
    Instance.new("UICorner", slot).CornerRadius = UDim.new(1, 0)
    local sstroke = Instance.new("UIStroke", slot)
    sstroke.Thickness = 1
    sstroke.Color = Color3.fromRGB(60, 60, 60)
    HotbarSlots[tostring(i)] = slot
end

-- =========================================================
-- state + command registry
-- =========================================================

local State = {
    Flying = false, FlySpeed = 60,
    Noclip = false,
    Spinning = false, SpinSpeed = 2,
    Following = nil,
    Viewing = nil,
    CurrentTroll = nil, TrollTarget = nil,
    AntiFling = false, AntiVoid = false,
    Esp = false, EspBoxes = {},
    God = false,
    FreeCam = false,
    -- +10 more shields
    AntiFire = false, AntiRagdoll = false, AntiDamage = false, AntiSlow = false, DefaultSpeed = 16,
    AntiJumpNerf = false, DefaultJump = 50, AntiStun = false, AntiSeat = false,
    AntiInvis = false, AntiFreeze = false, AntiKill = false, AntiKillHealth = nil,
    SpeedLock = false, LockedSpeed = 16, HealthLock = false, LockedHealth = 100, JumpLock = false, LockedJump = 50,
    TrollDelay = 0.2, -- delay between bang/troll ticks — settable from the Delay box above TROLL in ;cmds
    BangAnimTrack = nil,
}

local commands = {} -- name -> {desc, run}

local function register(name, desc, run)
    commands[name] = { desc = desc, run = run }
end

-- keybinds — PC physical keys AND the on-screen hotbar slots (1-5) share
-- this table, so ";bind 1 shakethat" or ";bind f shakethat" both work
local KeyBinds = {}

local function refreshBindsList()
    local lines = {}
    for k, v in pairs(KeyBinds) do
        table.insert(lines, k .. " -> " .. prefix .. v)
    end
    table.sort(lines)
    BindsList.Text = (#lines > 0) and table.concat(lines, "\n") or "No binds yet"
end

local function doBind(key, cmdText)
    if not key or key == "" or not cmdText or cmdText == "" then return false end
    KeyBinds[key:lower()] = cmdText
    refreshBindsList()
    return true
end

register("bind", "bind [key/slot 1-5] [command...] — binds a PC key or hotbar slot", function(args)
    local key = table.remove(args, 1)
    local cmdText = table.concat(args, " ")
    if doBind(key, cmdText) then
        setStatus("Bound " .. key .. " -> " .. prefix .. cmdText)
    else
        setStatus("Usage: bind [key] [command]", true)
    end
end)

register("unbind", "unbind [key/slot] — removes a keybind", function(args)
    local key = args[1]
    if key then
        KeyBinds[key:lower()] = nil
        refreshBindsList()
        setStatus("Unbound " .. key)
    end
end)

local function findPlayer(partial)
    partial = (partial or ""):lower()
    if partial == "" then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower() == partial or p.Name:lower():find(partial, 1, true) or p.DisplayName:lower():find(partial, 1, true) then
            return p
        end
    end
    return nil
end

-- ---- self: movement ----
register("fly", "fly [speed] — toggle flight", function(args)
    State.Flying = not State.Flying
    if args[1] then State.FlySpeed = tonumber(args[1]) or State.FlySpeed end
    setStatus(State.Flying and ("Flying ON (speed " .. State.FlySpeed .. ")") or "Flying OFF")
end)

register("unfly", "unfly — turn flight off", function()
    State.Flying = false
    setStatus("Flying OFF")
end)

register("speed", "speed [number] — walkspeed", function(args)
    local hum = getHum()
    if not hum then return end
    hum.WalkSpeed = tonumber(args[1]) or 16
    setStatus("WalkSpeed set to " .. hum.WalkSpeed)
end)

register("resetspeed", "resetspeed — back to default walkspeed", function()
    local hum = getHum()
    if hum then hum.WalkSpeed = 16 end
    setStatus("WalkSpeed reset")
end)

register("jumppower", "jumppower [number] — jump height", function(args)
    local hum = getHum()
    if not hum then return end
    hum.UseJumpPower = true
    hum.JumpPower = tonumber(args[1]) or 50
    setStatus("JumpPower set to " .. hum.JumpPower)
end)

register("noclip", "noclip — toggle walking through walls", function()
    State.Noclip = not State.Noclip
    setStatus(State.Noclip and "Noclip ON" or "Noclip OFF")
end)

register("spin", "spin [speed] — spin your character", function(args)
    State.Spinning = true
    State.SpinSpeed = tonumber(args[1]) or 2
    setStatus("Spinning ON")
end)

register("unspin", "unspin — stop spinning", function()
    State.Spinning = false
    setStatus("Spinning OFF")
end)

register("trip", "trip — fall over once", function()
    local hum = getHum()
    if hum then hum:ChangeState(Enum.HumanoidStateType.Ragdoll) end
    setStatus("Tripped")
end)

register("sit", "sit — force sit", function()
    local hum = getHum()
    if hum then hum.Sit = true end
    setStatus("Sitting")
end)

register("unsit", "unsit — stand back up", function()
    local hum = getHum()
    if hum then hum.Sit = false end
    setStatus("Standing")
end)

register("respawn", "respawn — reset your character", function()
    local hum = getHum()
    if hum then hum.Health = 0 end
    setStatus("Respawning...")
end)

register("invisible", "invisible — hide your character locally", function()
    local char = getChar()
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            part.LocalTransparencyModifier = 1
        end
    end
    setStatus("Invisible ON")
end)

register("visible", "visible — undo invisible", function()
    local char = getChar()
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            part.LocalTransparencyModifier = 0
        end
    end
    setStatus("Invisible OFF")
end)

-- ---- camera ----
register("fov", "fov [number] — camera field of view", function(args)
    workspace.CurrentCamera.FieldOfView = tonumber(args[1]) or 70
    setStatus("FOV set to " .. workspace.CurrentCamera.FieldOfView)
end)

register("resetfov", "resetfov — back to default FOV", function()
    workspace.CurrentCamera.FieldOfView = 70
    setStatus("FOV reset")
end)

-- ---- other players (local view/troll only, same as your ALPHA EMPIRE troll tab) ----
register("view", "view [player] — spectate a player's camera", function(args)
    local t = findPlayer(args[1])
    if t and t.Character and t.Character:FindFirstChildOfClass("Humanoid") then
        State.Viewing = t
        workspace.CurrentCamera.CameraSubject = t.Character:FindFirstChildOfClass("Humanoid")
        setStatus("Viewing " .. t.Name)
    else
        setStatus("Player not found", true)
    end
end)

register("unview", "unview — go back to your own camera", function()
    State.Viewing = nil
    local hum = getHum()
    if hum then workspace.CurrentCamera.CameraSubject = hum end
    setStatus("View reset")
end)

register("goto", "goto [player] — teleport to a player", function(args)
    local t = findPlayer(args[1])
    local root = getRoot()
    if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") and root then
        root.CFrame = t.Character.HumanoidRootPart.CFrame
        setStatus("Teleported to " .. t.Name)
    else
        setStatus("Player not found", true)
    end
end)

register("follow", "follow [player] — keep following a player", function(args)
    local t = findPlayer(args[1])
    if t then
        State.Following = t
        setStatus("Following " .. t.Name)
    else
        setStatus("Player not found", true)
    end
end)

register("unfollow", "unfollow — stop following", function()
    State.Following = nil
    setStatus("Follow OFF")
end)

-- ---- troll (local-only, same idea as your ALPHA EMPIRE troll tab) ----
-- exact same animation Infinite Yield itself plays for ;bang, picked by rig
local function playBangAnim()
    local hum = getHum()
    if not hum then return end
    if State.BangAnimTrack then
        State.BangAnimTrack:Stop()
        State.BangAnimTrack = nil
    end
    local ok, track = pcall(function()
        local anim = Instance.new("Animation")
        local isR15 = hum.RigType == Enum.HumanoidRigType.R15
        anim.AnimationId = isR15 and "rbxassetid://5918726674" or "rbxassetid://148840371"
        local tr = hum:LoadAnimation(anim)
        tr:Play(0.1, 1, 1)
        tr:AdjustSpeed(3)
        return tr
    end)
    if ok then State.BangAnimTrack = track end
end

local function startTroll(mode, args)
    local t = findPlayer(args[1])
    if not t then setStatus("Player not found", true) return end
    State.CurrentTroll = mode
    State.TrollTarget = t
    if mode == "bang" then
        playBangAnim()
    end
    task.spawn(function()
        while State.CurrentTroll == mode and State.TrollTarget == t do
            local root = getRoot()
            local tChar = t.Character
            if root and tChar then
                local tRoot = tChar:FindFirstChild("HumanoidRootPart")
                local tHead = tChar:FindFirstChild("Head")
                if mode == "bang" and tRoot then
                    -- kept at a safe stand-off distance so your body doesn't
                    -- clip/merge into theirs — still feels stuck right on them
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 1.8 + math.sin(tick() * 20) * 0.3)
                elseif mode == "facebang" and tHead then
                    root.CFrame = tHead.CFrame * CFrame.new(0, 0, -0.8) * CFrame.Angles(0, math.pi, 0)
                elseif mode == "headsit" and tHead then
                    local hum = getHum()
                    if hum then hum.Sit = true end
                    root.CFrame = tHead.CFrame * CFrame.new(0, 1, 0)
                elseif mode == "orbit" and tRoot then
                    local angle = tick() * 5
                    root.CFrame = tRoot.CFrame * CFrame.new(math.cos(angle) * 4, 2, math.sin(angle) * 4)
                elseif mode == "annoy" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(math.random(-4, 4), math.random(-2, 4), math.random(-4, 4))

                -- 10 bang variants, each a different motion pattern — all tuned snappier/faster
                elseif mode == "backbang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 0, -(1.8 + math.sin(tick() * 20) * 0.3))
                elseif mode == "sidebang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(math.sin(tick() * 28) * 2.2, 0, 0)
                elseif mode == "topbang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 2 + math.sin(tick() * 22) * 0.7, 0)
                elseif mode == "spinbang" and tRoot then
                    local angle = tick() * 12
                    root.CFrame = tRoot.CFrame * CFrame.new(math.cos(angle) * 1.6, 0, math.sin(angle) * 1.6)
                elseif mode == "shakebang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(math.random(-20, 20) / 100, math.random(-20, 20) / 100, 1.8 + math.random(-20, 20) / 100)
                elseif mode == "floatbang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 1 + math.sin(tick() * 5.5) * 1.6, 0)
                elseif mode == "zigzagbang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(math.sin(tick() * 14) * 1.7, 0, 1.6 + math.cos(tick() * 9) * 0.5)
                elseif mode == "crazybang" and tRoot then
                    local cx, cz = math.random(-4, 4), math.random(-4, 4)
                    if math.abs(cx) < 1.6 then cx = cx >= 0 and 1.6 or -1.6 end
                    if math.abs(cz) < 1.6 then cz = cz >= 0 and 1.6 or -1.6 end
                    root.CFrame = tRoot.CFrame * CFrame.new(cx, math.random(-1, 4), cz)
                elseif mode == "slowbang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 1.8 + math.sin(tick() * 3) * 0.3)

                -- +5 more bang variants
                elseif mode == "dizzybang" and tRoot then
                    local angle = tick() * 22
                    root.CFrame = tRoot.CFrame * CFrame.new(math.cos(angle) * 1.3, math.sin(angle * 2) * 1.6, math.sin(angle) * 1.3)
                elseif mode == "yeetbang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 1.8) * CFrame.new(0, (tick() * 55) % 20, 0)
                elseif mode == "ghostbang" and tRoot then
                    -- deliberately flickers close/through — that's the "ghost" of ghostbang
                    root.CFrame = tRoot.CFrame * CFrame.new(math.random(-18, 18) / 10, math.random(-6, 18) / 10, math.random(-18, 18) / 10)
                elseif mode == "magnetbang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 1.6 + math.abs(math.sin(tick() * 9)) * 1.4)
                elseif mode == "rocketbang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(0, (tick() * 16) % 15, 1.6)
                end
            end
            if State.TrollDelay and State.TrollDelay > 0 then
                task.wait(State.TrollDelay)
            else
                RunService.RenderStepped:Wait()
            end
        end
        if State.BangAnimTrack then
            State.BangAnimTrack:Stop()
            State.BangAnimTrack = nil
        end
    end)
    setStatus("Trolling " .. t.Name .. " (" .. mode .. ")")
end

register("bang", "bang [player] — bump into them, front", function(args) startTroll("bang", args) end)
register("backbang", "backbang [player] — bump from behind", function(args) startTroll("backbang", args) end)
register("sidebang", "sidebang [player] — oscillate left-right", function(args) startTroll("sidebang", args) end)
register("topbang", "topbang [player] — bump from above", function(args) startTroll("topbang", args) end)
register("spinbang", "spinbang [player] — spin tightly around them", function(args) startTroll("spinbang", args) end)
register("shakebang", "shakebang [player] — fast jitter right on them", function(args) startTroll("shakebang", args) end)
register("floatbang", "floatbang [player] — slow vertical bob above", function(args) startTroll("floatbang", args) end)
register("zigzagbang", "zigzagbang [player] — zigzag around them", function(args) startTroll("zigzagbang", args) end)
register("crazybang", "crazybang [player] — fast random teleport nearby", function(args) startTroll("crazybang", args) end)
register("slowbang", "slowbang [player] — slow gentle bump", function(args) startTroll("slowbang", args) end)
register("dizzybang", "dizzybang [player] — fast corkscrew spin on them", function(args) startTroll("dizzybang", args) end)
register("yeetbang", "yeetbang [player] — launches up and down on them", function(args) startTroll("yeetbang", args) end)
register("ghostbang", "ghostbang [player] — random flicker teleports through them", function(args) startTroll("ghostbang", args) end)
register("magnetbang", "magnetbang [player] — pulls in and out like a magnet", function(args) startTroll("magnetbang", args) end)
register("rocketbang", "rocketbang [player] — rockets up repeatedly on them", function(args) startTroll("rocketbang", args) end)

register("facebang", "facebang [player] — troll face-bang", function(args) startTroll("facebang", args) end)
register("headsit", "headsit [player] — sit on a player's head", function(args) startTroll("headsit", args) end)
register("orbit", "orbit [player] — orbit around a player", function(args) startTroll("orbit", args) end)
register("annoy", "annoy [player] — teleport-spam near a player", function(args) startTroll("annoy", args) end)

register("stoptroll", "stoptroll — stop all troll modes", function()
    State.CurrentTroll = nil
    State.TrollTarget = nil
    local hum = getHum()
    if hum then hum.Sit = false end
    if State.BangAnimTrack then
        State.BangAnimTrack:Stop()
        State.BangAnimTrack = nil
    end
    setStatus("Troll stopped")
end)

register("stop", "stop — PANIC BUTTON: instantly stops every bang/effect/toggle running", function()
    State.CurrentTroll = nil
    State.TrollTarget = nil
    State.Flying = false
    State.Noclip = false
    State.Spinning = false
    State.Following = nil
    State.Viewing = nil
    State.AntiFling = false
    State.AntiVoid = false
    State.Esp = false
    State.God = false
    State.FreeCam = false
    State.AntiFire = false
    State.AntiRagdoll = false
    State.AntiDamage = false
    State.AntiSlow = false
    State.AntiJumpNerf = false
    State.AntiStun = false
    State.AntiSeat = false
    State.AntiInvis = false
    State.AntiFreeze = false
    State.AntiKill = false
    State.SpeedLock = false
    State.HealthLock = false
    State.JumpLock = false
    State.Rainbow = false
    State.NoAnim = false
    State.AntiAfk = false

    local hum = getHum()
    if hum then
        hum.Sit = false
        hum.PlatformStand = false
        for _, track in ipairs(hum:GetPlayingAnimationTracks()) do track:Stop() end
    end
    local root = getRoot()
    if root then
        root.Anchored = false
        root.CustomPhysicalProperties = nil
    end
    local char = getChar()
    if char then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.LocalTransparencyModifier = 0 end
            if p.Name == "ZZFire" or p.Name == "ZZSmoke" or p.Name == "ZZSparkle" or p.Name == "ZZGlow" then
                p:Destroy()
            end
        end
    end
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    setStatus("Everything stopped")
end)

-- ---- sound / misc ----
register("music", "music [id] — play a sound by asset id", function(args)
    if not args[1] then return end
    for _, v in ipairs(workspace:GetChildren()) do
        if v:IsA("Sound") and v.Name == "ZZAdminMusic" then v:Destroy() end
    end
    local s = Instance.new("Sound", workspace)
    s.Name = "ZZAdminMusic"
    s.SoundId = "rbxassetid://" .. args[1]
    s.Volume = 4
    s:Play()
    setStatus("Playing music: " .. args[1])
end)

register("stopmusic", "stopmusic — stop the playing sound", function()
    for _, v in ipairs(workspace:GetChildren()) do
        if v:IsA("Sound") and v.Name == "ZZAdminMusic" then v:Destroy() end
    end
    setStatus("Music stopped")
end)

register("rejoin", "rejoin — rejoin the current server", function()
    TeleportService:Teleport(game.PlaceId, player)
end)

register("prefix", "prefix [char] — change the command prefix", function(args)
    if args[1] and #args[1] == 1 then
        prefix = args[1]
        Input.PlaceholderText = "Type " .. prefix .. "cmds for list..."
        setStatus("Prefix changed to " .. prefix)
    else
        setStatus("Give a single character, e.g. prefix !", true)
    end
end)

register("cmds", "cmds — show this list", function()
    ListPopup.Visible = true
end)

-- =========================================================
-- BULK GENERATED COMMANDS — colorN / speedpresetN / fovpresetN
-- Not hand-written one by one (that would be thousands of lines
-- of near-identical junk for no real benefit) — a loop registers
-- them the same way register() does for every other command, so
-- they work exactly the same when typed. They're left OUT of the
-- ;cmds popup below on purpose so that list stays readable; type
-- them directly, e.g. ;color250, ;speedpreset80, ;fovpreset10.
-- =========================================================

for i = 1, 1000 do
    register("color" .. i, nil, function()
        local char = getChar()
        local col = Color3.fromHSV((i % 1000) / 1000, 1, 1)
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.Color = col end
        end
        setStatus("color" .. i .. " applied")
    end)
end

for i = 1, 500 do
    register("speedpreset" .. i, nil, function()
        local hum = getHum()
        if hum then hum.WalkSpeed = i end
        setStatus("speedpreset" .. i .. " (walkspeed " .. i .. ")")
    end)
end

for i = 1, 500 do
    register("fovpreset" .. i, nil, function()
        local fovVal = 10 + (i / 500) * 100
        workspace.CurrentCamera.FieldOfView = fovVal
        setStatus("fovpreset" .. i .. " (fov " .. math.floor(fovVal) .. ")")
    end)
end

-- =========================================================
-- build the cmds popup text from the registry (grouped) —
-- only the real, hand-written commands show up here
-- =========================================================

-- ---- shields (actually working protections) ----
register("antifling", "antifling — stops bang/fling pushes (clamps velocity)", function()
    State.AntiFling = not State.AntiFling
    setStatus(State.AntiFling and "AntiFling ON (also blocks bang pushes)" or "AntiFling OFF")
end)

register("antivoid", "antivoid — teleports you back up if you fall into the void", function()
    State.AntiVoid = not State.AntiVoid
    setStatus(State.AntiVoid and "AntiVoid ON" or "AntiVoid OFF")
end)

register("antifire", "antifire — removes Fire/Sparkles others put on you", function()
    State.AntiFire = not State.AntiFire
    setStatus(State.AntiFire and "AntiFire ON" or "AntiFire OFF")
end)

register("antiragdoll", "antiragdoll — stops forced ragdoll states", function()
    State.AntiRagdoll = not State.AntiRagdoll
    setStatus(State.AntiRagdoll and "AntiRagdoll ON" or "AntiRagdoll OFF")
end)

register("antidamage", "antidamage — keeps your health pinned near full", function()
    State.AntiDamage = not State.AntiDamage
    setStatus(State.AntiDamage and "AntiDamage ON" or "AntiDamage OFF")
end)

register("antislow", "antislow — resets WalkSpeed if something slows you", function()
    State.AntiSlow = not State.AntiSlow
    local hum = getHum()
    if hum then State.DefaultSpeed = hum.WalkSpeed end
    setStatus(State.AntiSlow and "AntiSlow ON" or "AntiSlow OFF")
end)

register("antijumpnerf", "antijumpnerf — resets JumpPower if it's nerfed", function()
    State.AntiJumpNerf = not State.AntiJumpNerf
    local hum = getHum()
    if hum then State.DefaultJump = hum.JumpPower end
    setStatus(State.AntiJumpNerf and "AntiJumpNerf ON" or "AntiJumpNerf OFF")
end)

register("antistun", "antistun — clears forced PlatformStand/Seated stun states", function()
    State.AntiStun = not State.AntiStun
    setStatus(State.AntiStun and "AntiStun ON" or "AntiStun OFF")
end)

register("antiseat", "antiseat — stops being force-seated", function()
    State.AntiSeat = not State.AntiSeat
    setStatus(State.AntiSeat and "AntiSeat ON" or "AntiSeat OFF")
end)

register("antiinvis", "antiinvis — resets transparency if others hide you", function()
    State.AntiInvis = not State.AntiInvis
    setStatus(State.AntiInvis and "AntiInvis ON" or "AntiInvis OFF")
end)

register("antifreeze", "antifreeze — unanchors you if something freezes you", function()
    State.AntiFreeze = not State.AntiFreeze
    setStatus(State.AntiFreeze and "AntiFreeze ON" or "AntiFreeze OFF")
end)

register("antikill", "antikill — heals you back if health suddenly drops hard", function()
    State.AntiKill = not State.AntiKill
    local hum = getHum()
    State.AntiKillHealth = hum and hum.Health or 100
    setStatus(State.AntiKill and "AntiKill ON" or "AntiKill OFF")
end)

-- ---- extra (Infinite-Yield-style real commands) ----
register("esp", "esp — see every player through walls (box outline)", function()
    State.Esp = true
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local hl = Instance.new("Highlight")
            hl.Name = "ZZEsp"
            hl.FillTransparency = 1
            hl.OutlineColor = Color3.fromRGB(150, 70, 255)
            hl.Parent = p.Character
            State.EspBoxes[p] = hl
        end
    end
    setStatus("ESP ON")
end)

register("unesp", "unesp — turn esp off", function()
    State.Esp = false
    for _, hl in pairs(State.EspBoxes) do
        if hl then hl:Destroy() end
    end
    State.EspBoxes = {}
    setStatus("ESP OFF")
end)

register("trail", "trail — attach a trail effect to your character", function()
    local char = getChar()
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local old = root:FindFirstChild("ZZTrail")
    if old then old:Destroy() end
    local a0 = Instance.new("Attachment", root)
    a0.Position = Vector3.new(0, 1, 0)
    local a1 = Instance.new("Attachment", root)
    a1.Position = Vector3.new(0, -1, 0)
    local trail = Instance.new("Trail")
    trail.Name = "ZZTrail"
    trail.Attachment0 = a0
    trail.Attachment1 = a1
    trail.Color = ColorSequence.new(Color3.fromRGB(150, 70, 255))
    trail.Lifetime = 1
    trail.Parent = root
    setStatus("Trail ON")
end)

register("untrail", "untrail — remove the trail", function()
    local root = getRoot()
    local t = root and root:FindFirstChild("ZZTrail")
    if t then t:Destroy() end
    setStatus("Trail OFF")
end)

register("size", "size [number] — scale your character", function(args)
    local char = getChar()
    local n = tonumber(args[1]) or 1
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then part.Size = part.Size * n end
    end
    setStatus("Size scaled by " .. n)
end)

register("resetsize", "resetsize — respawn to undo scaling", function()
    local hum = getHum()
    if hum then hum.Health = 0 end
    setStatus("Respawning to reset size...")
end)

register("freecam", "freecam — detach camera to fly around freely", function()
    State.FreeCam = true
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    setStatus("FreeCam ON (WASD + Space/Ctrl)")
end)

register("unfreecam", "unfreecam — back to normal camera", function()
    State.FreeCam = false
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    local hum = getHum()
    if hum then workspace.CurrentCamera.CameraSubject = hum end
    setStatus("FreeCam OFF")
end)

register("kill", "kill — kill yourself", function()
    local hum = getHum()
    if hum then hum.Health = 0 end
    setStatus("Killed")
end)

register("god", "god — very fast health regen", function()
    State.God = true
    setStatus("God mode ON")
end)

register("ungod", "ungod — normal regen", function()
    State.God = false
    setStatus("God mode OFF")
end)

register("health", "health [number] — set your max health", function(args)
    local hum = getHum()
    local n = tonumber(args[1])
    if hum and n then
        hum.MaxHealth = n
        hum.Health = n
    end
    setStatus("Health set to " .. tostring(n))
end)

register("gravity", "gravity [number] — change workspace gravity", function(args)
    workspace.Gravity = tonumber(args[1]) or 196.2
    setStatus("Gravity set to " .. workspace.Gravity)
end)

register("resetgravity", "resetgravity — back to default gravity", function()
    workspace.Gravity = 196.2
    setStatus("Gravity reset")
end)

-- =========================================================
-- +100 USEFUL COMMANDS — lighting, camera, cosmetics, utility,
-- social and locks. Everything here is a real, working effect,
-- not filler.
-- =========================================================

local OrigLighting = {
    Brightness = Lighting.Brightness,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    FogEnd = Lighting.FogEnd,
    FogStart = Lighting.FogStart,
    FogColor = Lighting.FogColor,
    ClockTime = Lighting.ClockTime,
    GlobalShadows = Lighting.GlobalShadows,
}

local function getEffect(className, name)
    local e = Lighting:FindFirstChild(name)
    if not e then
        e = Instance.new(className, Lighting)
        e.Name = name
    end
    return e
end

-- ---- lighting ----
register("brightness", "brightness [number] — set Lighting brightness", function(args)
    Lighting.Brightness = tonumber(args[1]) or 2
    setStatus("Brightness set")
end)
register("resetbrightness", "resetbrightness — restore default brightness", function()
    Lighting.Brightness = OrigLighting.Brightness
    setStatus("Brightness reset")
end)
register("fog", "fog [1-10] — thicker fog at higher numbers", function(args)
    local n = tonumber(args[1]) or 5
    Lighting.FogEnd = math.max(20, 400 - n * 35)
    Lighting.FogStart = 0
    setStatus("Fog set")
end)
register("resetfog", "resetfog — restore default fog", function()
    Lighting.FogEnd = OrigLighting.FogEnd
    Lighting.FogStart = OrigLighting.FogStart
    Lighting.FogColor = OrigLighting.FogColor
    setStatus("Fog reset")
end)
register("ambient", "ambient [dark/normal/bright] — ambient lighting preset", function(args)
    local p = (args[1] or "normal"):lower()
    if p == "dark" then
        Lighting.Ambient = Color3.fromRGB(10, 10, 10)
        Lighting.OutdoorAmbient = Color3.fromRGB(20, 20, 20)
    elseif p == "bright" then
        Lighting.Ambient = Color3.fromRGB(150, 150, 150)
        Lighting.OutdoorAmbient = Color3.fromRGB(150, 150, 150)
    else
        Lighting.Ambient = Color3.fromRGB(80, 80, 80)
        Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
    end
    setStatus("Ambient set to " .. p)
end)
register("resetambient", "resetambient — restore default ambient", function()
    Lighting.Ambient = OrigLighting.Ambient
    Lighting.OutdoorAmbient = OrigLighting.OutdoorAmbient
    setStatus("Ambient reset")
end)
register("time", "time [0-24] — set the time of day", function(args)
    Lighting.ClockTime = tonumber(args[1]) or 14
    setStatus("Time set")
end)
register("daytime", "daytime — set to midday", function()
    Lighting.ClockTime = 14
    setStatus("Daytime")
end)
register("nighttime", "nighttime — set to midnight", function()
    Lighting.ClockTime = 0
    setStatus("Nighttime")
end)
register("sunsettime", "sunsettime — set to sunset", function()
    Lighting.ClockTime = 18
    setStatus("Sunset")
end)
register("blur", "blur [size] — blurs the screen", function(args)
    local e = getEffect("BlurEffect", "ZZBlur")
    e.Size = tonumber(args[1]) or 12
    setStatus("Blur on")
end)
register("unblur", "unblur — removes blur", function()
    local e = Lighting:FindFirstChild("ZZBlur")
    if e then e:Destroy() end
    setStatus("Blur off")
end)
register("bloom", "bloom — adds a glowing bloom effect", function()
    local e = getEffect("BloomEffect", "ZZBloom")
    e.Intensity = 1.5
    setStatus("Bloom on")
end)
register("unbloom", "unbloom — removes bloom", function()
    local e = Lighting:FindFirstChild("ZZBloom")
    if e then e:Destroy() end
    setStatus("Bloom off")
end)
register("sunrays", "sunrays — adds a sun rays effect", function()
    local e = getEffect("SunRaysEffect", "ZZSunRays")
    e.Intensity = 0.25
    setStatus("Sun rays on")
end)
register("unsunrays", "unsunrays — removes sun rays", function()
    local e = Lighting:FindFirstChild("ZZSunRays")
    if e then e:Destroy() end
    setStatus("Sun rays off")
end)
register("colorcorrect", "colorcorrect [warm/cold/normal] — color grading preset", function(args)
    local e = getEffect("ColorCorrectionEffect", "ZZColorCorrect")
    local p = (args[1] or "normal"):lower()
    if p == "warm" then
        e.TintColor = Color3.fromRGB(255, 220, 180)
    elseif p == "cold" then
        e.TintColor = Color3.fromRGB(180, 210, 255)
    else
        e.TintColor = Color3.new(1, 1, 1)
    end
    setStatus("Color correction set")
end)
register("uncolorcorrect", "uncolorcorrect — removes color correction", function()
    local e = Lighting:FindFirstChild("ZZColorCorrect")
    if e then e:Destroy() end
    setStatus("Color correction off")
end)
register("dof", "dof — adds depth of field blur", function()
    local e = getEffect("DepthOfFieldEffect", "ZZDof")
    e.FarIntensity = 0.3
    setStatus("Depth of field on")
end)
register("undof", "undof — removes depth of field", function()
    local e = Lighting:FindFirstChild("ZZDof")
    if e then e:Destroy() end
    setStatus("Depth of field off")
end)
register("shadows", "shadows — enables global shadows", function()
    Lighting.GlobalShadows = true
    setStatus("Shadows on")
end)
register("unshadows", "unshadows — disables global shadows", function()
    Lighting.GlobalShadows = false
    setStatus("Shadows off")
end)
register("resetlighting", "resetlighting — restores lighting to how it was on load", function()
    Lighting.Brightness = OrigLighting.Brightness
    Lighting.Ambient = OrigLighting.Ambient
    Lighting.OutdoorAmbient = OrigLighting.OutdoorAmbient
    Lighting.FogEnd = OrigLighting.FogEnd
    Lighting.FogStart = OrigLighting.FogStart
    Lighting.FogColor = OrigLighting.FogColor
    Lighting.ClockTime = OrigLighting.ClockTime
    Lighting.GlobalShadows = OrigLighting.GlobalShadows
    for _, n in ipairs({ "ZZBlur", "ZZBloom", "ZZSunRays", "ZZColorCorrect", "ZZDof" }) do
        local e = Lighting:FindFirstChild(n)
        if e then e:Destroy() end
    end
    setStatus("Lighting fully reset")
end)

-- ---- visual presets ----
local function tintPreset(color, sat)
    local e = getEffect("ColorCorrectionEffect", "ZZColorCorrect")
    e.TintColor = color
    e.Saturation = sat or 0
end
register("matrix", "matrix — green tinted color grading", function()
    tintPreset(Color3.fromRGB(120, 255, 120), -0.3)
    setStatus("Matrix mode")
end)
register("sepia", "sepia — old photo color grading", function()
    tintPreset(Color3.fromRGB(230, 190, 130), -0.4)
    setStatus("Sepia mode")
end)
register("grayscale", "grayscale — black and white color grading", function()
    tintPreset(Color3.new(1, 1, 1), -1)
    setStatus("Grayscale mode")
end)
register("nightvision", "nightvision — green night-vision color grading", function()
    tintPreset(Color3.fromRGB(100, 255, 120), 0.1)
    Lighting.Brightness = 3
    setStatus("Night vision mode")
end)
register("thermal", "thermal — orange heat-vision color grading", function()
    tintPreset(Color3.fromRGB(255, 140, 60), 0.2)
    setStatus("Thermal mode")
end)
register("quake", "quake — a sudden screen earthquake shake", function()
    task.spawn(function()
        local cam = workspace.CurrentCamera
        local t0 = tick()
        while tick() - t0 < 2 do
            cam.CFrame = cam.CFrame * CFrame.new(math.random(-15, 15) / 10, math.random(-15, 15) / 10, 0)
            RunService.RenderStepped:Wait()
        end
    end)
    setStatus("Earthquake!")
end)
register("rain", "rain — adds a falling rain particle effect", function()
    local root = getRoot()
    if not root then return end
    local att = root:FindFirstChild("ZZRainAtt") or Instance.new("Attachment", root)
    att.Name = "ZZRainAtt"
    att.Position = Vector3.new(0, 15, 0)
    local p = Instance.new("ParticleEmitter", att)
    p.Name = "ZZRain"
    p.Color = ColorSequence.new(Color3.fromRGB(150, 180, 255))
    p.Size = NumberSequence.new(0.15)
    p.Lifetime = NumberRange.new(1.5)
    p.Rate = 200
    p.Speed = NumberRange.new(20)
    p.SpreadAngle = Vector2.new(60, 60)
    p.Acceleration = Vector3.new(0, -40, 0)
    setStatus("Rain on")
end)
register("unrain", "unrain — removes rain effect", function()
    local root = getRoot()
    local att = root and root:FindFirstChild("ZZRainAtt")
    if att then att:Destroy() end
    setStatus("Rain off")
end)
register("snow", "snow — adds a falling snow particle effect", function()
    local root = getRoot()
    if not root then return end
    local att = root:FindFirstChild("ZZSnowAtt") or Instance.new("Attachment", root)
    att.Name = "ZZSnowAtt"
    att.Position = Vector3.new(0, 15, 0)
    local p = Instance.new("ParticleEmitter", att)
    p.Name = "ZZSnow"
    p.Color = ColorSequence.new(Color3.new(1, 1, 1))
    p.Size = NumberSequence.new(0.25)
    p.Lifetime = NumberRange.new(3)
    p.Rate = 80
    p.Speed = NumberRange.new(4)
    p.SpreadAngle = Vector2.new(80, 80)
    p.Acceleration = Vector3.new(0, -8, 0)
    setStatus("Snow on")
end)
register("unsnow", "unsnow — removes snow effect", function()
    local root = getRoot()
    local att = root and root:FindFirstChild("ZZSnowAtt")
    if att then att:Destroy() end
    setStatus("Snow off")
end)

-- ---- camera ----
register("camshake", "camshake [intensity] [seconds] — shakes your camera", function(args)
    local intensity = tonumber(args[1]) or 2
    local duration = tonumber(args[2]) or 1.5
    task.spawn(function()
        local cam = workspace.CurrentCamera
        local t0 = tick()
        while tick() - t0 < duration do
            cam.CFrame = cam.CFrame * CFrame.new(math.random(-100, 100) / 100 * intensity * 0.05, math.random(-100, 100) / 100 * intensity * 0.05, 0)
            RunService.RenderStepped:Wait()
        end
    end)
    setStatus("Camera shake")
end)
register("firstperson", "firstperson — locks camera to first person", function()
    player.CameraMode = Enum.CameraMode.LockFirstPerson
    setStatus("First person locked")
end)
register("thirdperson", "thirdperson — back to normal third person camera", function()
    player.CameraMode = Enum.CameraMode.Classic
    setStatus("Third person")
end)
register("zoomlock", "zoomlock [distance] — locks camera zoom distance", function(args)
    local d = tonumber(args[1]) or 10
    player.CameraMinZoomDistance = d
    player.CameraMaxZoomDistance = d
    setStatus("Zoom locked to " .. d)
end)
register("unzoomlock", "unzoomlock — restores normal zoom range", function()
    player.CameraMinZoomDistance = 0.5
    player.CameraMaxZoomDistance = 400
    setStatus("Zoom unlocked")
end)
register("cammin", "cammin [number] — minimum camera zoom", function(args)
    player.CameraMinZoomDistance = tonumber(args[1]) or 0.5
    setStatus("CameraMinZoomDistance set")
end)
register("cammax", "cammax [number] — maximum camera zoom", function(args)
    player.CameraMaxZoomDistance = tonumber(args[1]) or 400
    setStatus("CameraMaxZoomDistance set")
end)
register("tilt", "tilt [degrees] — rolls your camera sideways", function(args)
    local deg = tonumber(args[1]) or 20
    local cam = workspace.CurrentCamera
    cam.CFrame = cam.CFrame * CFrame.Angles(0, 0, math.rad(deg))
    setStatus("Camera tilted")
end)
register("untilt", "untilt — resets camera roll", function()
    local cam = workspace.CurrentCamera
    local x, y, _ = cam.CFrame:ToOrientation()
    cam.CFrame = CFrame.new(cam.CFrame.Position) * CFrame.Angles(x, y, 0)
    setStatus("Camera roll reset")
end)

-- ---- self-cosmetic ----
register("sparkle", "sparkle — sparkle particles on your character", function()
    local root = getRoot()
    if root and not root:FindFirstChild("ZZSparkle") then
        Instance.new("Sparkles", root).Name = "ZZSparkle"
    end
    setStatus("Sparkle on")
end)
register("unsparkle", "unsparkle — removes sparkles", function()
    local root = getRoot()
    local s = root and root:FindFirstChild("ZZSparkle")
    if s then s:Destroy() end
    setStatus("Sparkle off")
end)
register("smoke", "smoke — smoke trail on your character", function()
    local root = getRoot()
    if root and not root:FindFirstChild("ZZSmoke") then
        Instance.new("Smoke", root).Name = "ZZSmoke"
    end
    setStatus("Smoke on")
end)
register("unsmoke", "unsmoke — removes smoke", function()
    local root = getRoot()
    local s = root and root:FindFirstChild("ZZSmoke")
    if s then s:Destroy() end
    setStatus("Smoke off")
end)
register("selffire", "selffire — fire effect on your character", function()
    local root = getRoot()
    if root and not root:FindFirstChild("ZZFire") then
        Instance.new("Fire", root).Name = "ZZFire"
    end
    setStatus("Fire on")
end)
register("unselffire", "unselffire — removes fire effect", function()
    local root = getRoot()
    local f = root and root:FindFirstChild("ZZFire")
    if f then f:Destroy() end
    setStatus("Fire off")
end)
register("glow", "glow — a soft light glow around you", function()
    local root = getRoot()
    if root and not root:FindFirstChild("ZZGlow") then
        local l = Instance.new("PointLight", root)
        l.Name = "ZZGlow"
        l.Range = 12
        l.Brightness = 3
    end
    setStatus("Glow on")
end)
register("unglow", "unglow — removes glow", function()
    local root = getRoot()
    local l = root and root:FindFirstChild("ZZGlow")
    if l then l:Destroy() end
    setStatus("Glow off")
end)
register("rainbow", "rainbow — cycles your character's color like a rainbow", function()
    State.Rainbow = true
    task.spawn(function()
        while State.Rainbow do
            local char = getChar()
            if char then
                local hue = (tick() * 0.2) % 1
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Color = Color3.fromHSV(hue, 1, 1)
                    end
                end
            end
            task.wait(0.1)
        end
    end)
    setStatus("Rainbow on")
end)
register("unrainbow", "unrainbow — stops the rainbow color cycle", function()
    State.Rainbow = false
    setStatus("Rainbow off")
end)

register("shakethat", "shakethat — plays the shake-that-thang hip dance emote", function()
    local hum = getHum()
    if not hum then return end
    if State.DanceTrack then
        State.DanceTrack:Stop()
        State.DanceTrack = nil
    end
    local ok, result = pcall(function()
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://507776043" -- official Roblox default "Dance2" emote (hip-shake)
        local track = hum:LoadAnimation(anim)
        track.Priority = Enum.AnimationPriority.Action
        track.Looped = true
        track:Play()
        return track
    end)
    if ok then
        State.DanceTrack = result
        setStatus("Shake that thang! 🕺")
    else
        setStatus("Couldn't load the dance emote here", true)
    end
end)

register("unshakethat", "unshakethat — stops the shake-that-thang emote", function()
    if State.DanceTrack then
        State.DanceTrack:Stop()
        State.DanceTrack = nil
    end
    setStatus("Dance stopped")
end)

register("bigself", "bigself [scale] — scales you up", function(args)
    local char = getChar()
    local n = tonumber(args[1]) or 2
    if char then
        for _, v in ipairs({ "HeadScale", "BodyDepthScale", "BodyHeightScale", "BodyWidthScale" }) do
            local sc = char:FindFirstChild(v)
            if sc then sc.Value = sc.Value * n end
        end
    end
    setStatus("Scaled up")
end)
register("smallself", "smallself [scale] — scales you down", function(args)
    local char = getChar()
    local n = tonumber(args[1]) or 0.5
    if char then
        for _, v in ipairs({ "HeadScale", "BodyDepthScale", "BodyHeightScale", "BodyWidthScale" }) do
            local sc = char:FindFirstChild(v)
            if sc then sc.Value = sc.Value * n end
        end
    end
    setStatus("Scaled down")
end)
register("resetmyself", "resetmyself — respawns to undo scaling/effects", function()
    player:LoadCharacter()
    setStatus("Respawned")
end)
register("ghost", "ghost — half-transparent + noclip combo", function()
    State.Noclip = true
    local char = getChar()
    if char then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.LocalTransparencyModifier = 0.6 end
        end
    end
    setStatus("Ghost mode on")
end)
register("unghost", "unghost — turns ghost mode off", function()
    State.Noclip = false
    local char = getChar()
    if char then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.LocalTransparencyModifier = 0 end
        end
    end
    setStatus("Ghost mode off")
end)

-- ---- utility ----
local SavedPos = {}
register("savepos", "savepos — saves your current position (slot 1)", function()
    local root = getRoot()
    if root then SavedPos[1] = root.CFrame end
    setStatus("Position saved (1)")
end)
register("savepos2", "savepos2 — saves your current position (slot 2)", function()
    local root = getRoot()
    if root then SavedPos[2] = root.CFrame end
    setStatus("Position saved (2)")
end)
register("savepos3", "savepos3 — saves your current position (slot 3)", function()
    local root = getRoot()
    if root then SavedPos[3] = root.CFrame end
    setStatus("Position saved (3)")
end)
register("loadpos", "loadpos — teleports to saved position (slot 1)", function()
    local root = getRoot()
    if root and SavedPos[1] then root.CFrame = SavedPos[1] end
    setStatus("Loaded position (1)")
end)
register("loadpos2", "loadpos2 — teleports to saved position (slot 2)", function()
    local root = getRoot()
    if root and SavedPos[2] then root.CFrame = SavedPos[2] end
    setStatus("Loaded position (2)")
end)
register("loadpos3", "loadpos3 — teleports to saved position (slot 3)", function()
    local root = getRoot()
    if root and SavedPos[3] then root.CFrame = SavedPos[3] end
    setStatus("Loaded position (3)")
end)
register("bring", "bring [player] — teleports a player to you", function(args)
    local t = findPlayer(args[1])
    local root = getRoot()
    if t and root and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
        t.Character.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(2, 0, 0)
        setStatus("Brought " .. t.Name)
    end
end)
register("bringall", "bringall — teleports every player to you", function()
    local root = getRoot()
    if not root then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            p.Character.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(math.random(-6, 6), 0, math.random(-6, 6))
        end
    end
    setStatus("Brought everyone")
end)
register("serverinfo", "serverinfo — shows place/job id in the status line", function()
    setStatus("Place " .. tostring(game.PlaceId) .. " | Job " .. tostring(game.JobId):sub(1, 8))
end)
register("fps", "fps — shows an on-screen FPS counter", function()
    if gui:FindFirstChild("ZZFpsLabel") then return end
    local l = Instance.new("TextLabel", gui)
    l.Name = "ZZFpsLabel"
    l.Size = UDim2.new(0, 90, 0, 20)
    l.Position = UDim2.new(0, 16, 0, 16)
    l.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    l.TextColor3 = Color3.fromRGB(235, 235, 235)
    l.Font = Enum.Font.SourceSansBold
    l.TextSize = 13
    l.Text = "FPS: --"
    Instance.new("UICorner", l).CornerRadius = UDim.new(0, 4)
    task.spawn(function()
        local frames, t0 = 0, tick()
        while l.Parent do
            frames = frames + 1
            if tick() - t0 >= 1 then
                l.Text = "FPS: " .. frames
                frames = 0
                t0 = tick()
            end
            RunService.RenderStepped:Wait()
        end
    end)
    setStatus("FPS counter on")
end)
register("unfps", "unfps — removes the FPS counter", function()
    local l = gui:FindFirstChild("ZZFpsLabel")
    if l then l:Destroy() end
    setStatus("FPS counter off")
end)
register("ping", "ping — shows your network ping", function()
    if gui:FindFirstChild("ZZPingLabel") then return end
    local l = Instance.new("TextLabel", gui)
    l.Name = "ZZPingLabel"
    l.Size = UDim2.new(0, 90, 0, 20)
    l.Position = UDim2.new(0, 16, 0, 40)
    l.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    l.TextColor3 = Color3.fromRGB(235, 235, 235)
    l.Font = Enum.Font.SourceSansBold
    l.TextSize = 13
    l.Text = "Ping: --"
    Instance.new("UICorner", l).CornerRadius = UDim.new(0, 4)
    task.spawn(function()
        while l.Parent do
            local ok, item = pcall(function() return StatsService.Network.ServerStatsItem["Data Ping"] end)
            if ok and item then l.Text = "Ping: " .. math.floor(item:GetValue()) .. "ms" end
            task.wait(1)
        end
    end)
    setStatus("Ping display on")
end)
register("unping", "unping — removes the ping display", function()
    local l = gui:FindFirstChild("ZZPingLabel")
    if l then l:Destroy() end
    setStatus("Ping display off")
end)
register("coords", "coords — shows your live XYZ position", function()
    if gui:FindFirstChild("ZZCoordsLabel") then return end
    local l = Instance.new("TextLabel", gui)
    l.Name = "ZZCoordsLabel"
    l.Size = UDim2.new(0, 220, 0, 20)
    l.Position = UDim2.new(0, 16, 0, 64)
    l.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    l.TextColor3 = Color3.fromRGB(235, 235, 235)
    l.Font = Enum.Font.SourceSansBold
    l.TextSize = 13
    l.Text = "XYZ: --"
    Instance.new("UICorner", l).CornerRadius = UDim.new(0, 4)
    task.spawn(function()
        while l.Parent do
            local root = getRoot()
            if root then
                l.Text = string.format("XYZ: %.0f, %.0f, %.0f", root.Position.X, root.Position.Y, root.Position.Z)
            end
            task.wait(0.2)
        end
    end)
    setStatus("Coordinates display on")
end)
register("uncoords", "uncoords — removes the coordinates display", function()
    local l = gui:FindFirstChild("ZZCoordsLabel")
    if l then l:Destroy() end
    setStatus("Coordinates display off")
end)
register("clock", "clock — shows the real-world time", function()
    if gui:FindFirstChild("ZZClockLabel") then return end
    local l = Instance.new("TextLabel", gui)
    l.Name = "ZZClockLabel"
    l.Size = UDim2.new(0, 90, 0, 20)
    l.Position = UDim2.new(0, 16, 0, 88)
    l.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    l.TextColor3 = Color3.fromRGB(235, 235, 235)
    l.Font = Enum.Font.SourceSansBold
    l.TextSize = 13
    l.Text = os.date("%H:%M:%S")
    Instance.new("UICorner", l).CornerRadius = UDim.new(0, 4)
    task.spawn(function()
        while l.Parent do
            l.Text = os.date("%H:%M:%S")
            task.wait(1)
        end
    end)
    setStatus("Clock on")
end)
register("unclock", "unclock — removes the clock", function()
    local l = gui:FindFirstChild("ZZClockLabel")
    if l then l:Destroy() end
    setStatus("Clock off")
end)
register("plrlist", "plrlist — shows a live list of players in the server", function()
    if gui:FindFirstChild("ZZPlrList") then return end
    local l = Instance.new("TextLabel", gui)
    l.Name = "ZZPlrList"
    l.Size = UDim2.new(0, 160, 0, 120)
    l.Position = UDim2.new(1, -176, 0, 16)
    l.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    l.TextColor3 = Color3.fromRGB(235, 235, 235)
    l.Font = Enum.Font.SourceSans
    l.TextSize = 12
    l.TextYAlignment = Enum.TextYAlignment.Top
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextWrapped = true
    Instance.new("UICorner", l).CornerRadius = UDim.new(0, 4)
    task.spawn(function()
        while l.Parent do
            local names = {}
            for _, p in ipairs(Players:GetPlayers()) do table.insert(names, p.Name) end
            l.Text = "Players (" .. #names .. ")\n" .. table.concat(names, "\n")
            task.wait(1)
        end
    end)
    setStatus("Player list on")
end)
register("unplrlist", "unplrlist — removes the player list", function()
    local l = gui:FindFirstChild("ZZPlrList")
    if l then l:Destroy() end
    setStatus("Player list off")
end)
register("antiafk", "antiafk — stops Roblox's idle/AFK kick", function()
    State.AntiAfk = true
    task.spawn(function()
        while State.AntiAfk do
            task.wait(60)
            if State.AntiAfk then
                pcall(function()
                    local vim = game:GetService("VirtualInputManager")
                    vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                    vim:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                end)
            end
        end
    end)
    setStatus("AntiAFK on")
end)
register("unantiafk", "unantiafk — turns antiafk off", function()
    State.AntiAfk = false
    setStatus("AntiAFK off")
end)
register("savecam", "savecam — saves your current camera CFrame", function()
    State.SavedCam = workspace.CurrentCamera.CFrame
    setStatus("Camera saved")
end)
register("loadcam", "loadcam — restores your saved camera CFrame (use with freecam)", function()
    if State.SavedCam then workspace.CurrentCamera.CFrame = State.SavedCam end
    setStatus("Camera loaded")
end)
register("walkto", "walkto [player] — pathfinds and walks to them", function(args)
    local t = findPlayer(args[1])
    local hum = getHum()
    local root = getRoot()
    if not (t and hum and root and t.Character and t.Character:FindFirstChild("HumanoidRootPart")) then
        setStatus("Player not found", true)
        return
    end
    local ok, path = pcall(function()
        local p = PathfindingService:CreatePath()
        p:ComputeAsync(root.Position, t.Character.HumanoidRootPart.Position)
        return p
    end)
    if ok and path and path.Status == Enum.PathStatus.Success then
        task.spawn(function()
            for _, wp in ipairs(path:GetWaypoints()) do
                hum:MoveTo(wp.Position)
                hum.MoveToFinished:Wait(2)
            end
        end)
        setStatus("Walking to " .. t.Name)
    else
        setStatus("No path found", true)
    end
end)

-- ---- social ----
local IgnoreList = {}
register("ignore", "ignore [player] — excludes them from ESP/troll targeting", function(args)
    local t = findPlayer(args[1])
    if t then
        IgnoreList[t.UserId] = true
        setStatus("Ignoring " .. t.Name)
    end
end)
register("unignore", "unignore [player] — removes them from the ignore list", function(args)
    local t = findPlayer(args[1])
    if t then
        IgnoreList[t.UserId] = nil
        setStatus("Unignored " .. t.Name)
    end
end)
register("announce", "announce [text] — big system message only you can see", function(args)
    local msg = table.concat(args, " ")
    pcall(function()
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = msg,
            Color = Color3.fromRGB(255, 200, 80),
            Font = Enum.Font.SourceSansBold,
            TextSize = 20,
        })
    end)
    setStatus("Announced locally")
end)
register("bubbleon", "bubbleon — enables chat bubbles above heads", function()
    pcall(function() game:GetService("Chat").BubbleChatEnabled = true end)
    setStatus("Bubble chat on")
end)
register("bubbleoff", "bubbleoff — disables chat bubbles above heads", function()
    pcall(function() game:GetService("Chat").BubbleChatEnabled = false end)
    setStatus("Bubble chat off")
end)
register("motd", "motd [text] — pins a message-of-the-day banner on screen", function(args)
    local msg = table.concat(args, " ")
    local l = gui:FindFirstChild("ZZMotd")
    if not l then
        l = Instance.new("TextLabel", gui)
        l.Name = "ZZMotd"
        l.Size = UDim2.new(0, 400, 0, 30)
        l.Position = UDim2.new(0.5, -200, 0, 10)
        l.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        l.TextColor3 = Color3.fromRGB(240, 240, 240)
        l.Font = Enum.Font.SourceSansBold
        l.TextSize = 14
        Instance.new("UICorner", l).CornerRadius = UDim.new(0, 4)
    end
    l.Text = msg
    setStatus("MOTD set")
end)
register("unmotd", "unmotd — removes the message-of-the-day banner", function()
    local l = gui:FindFirstChild("ZZMotd")
    if l then l:Destroy() end
    setStatus("MOTD removed")
end)

-- ---- player-extra ----
register("spectatenext", "spectatenext — switches your view to the next player", function()
    local list = Players:GetPlayers()
    if #list == 0 then return end
    local idx = 1
    for i, p in ipairs(list) do
        if p == State.Viewing then idx = i break end
    end
    local nextP = list[(idx % #list) + 1]
    if nextP then
        State.Viewing = nextP
        setStatus("Viewing " .. nextP.Name)
    end
end)
register("spectateprev", "spectateprev — switches your view to the previous player", function()
    local list = Players:GetPlayers()
    if #list == 0 then return end
    local idx = 1
    for i, p in ipairs(list) do
        if p == State.Viewing then idx = i break end
    end
    local prevIdx = idx - 1
    if prevIdx < 1 then prevIdx = #list end
    local prevP = list[prevIdx]
    if prevP then
        State.Viewing = prevP
        setStatus("Viewing " .. prevP.Name)
    end
end)
register("resetcam", "resetcam — resets your camera back to normal follow mode", function()
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    local hum = getHum()
    if hum then workspace.CurrentCamera.CameraSubject = hum end
    State.FreeCam = false
    setStatus("Camera reset")
end)
register("freezeself", "freezeself — anchors you in place", function()
    local root = getRoot()
    if root then root.Anchored = true end
    setStatus("Frozen")
end)
register("unfreezeself", "unfreezeself — unanchors you", function()
    local root = getRoot()
    if root then root.Anchored = false end
    setStatus("Unfrozen")
end)
register("noanim", "noanim — stops all your character's animations", function()
    local hum = getHum()
    if hum then
        for _, track in ipairs(hum:GetPlayingAnimationTracks()) do track:Stop() end
    end
    State.NoAnim = true
    setStatus("Animations stopped")
end)
register("resetanim", "resetanim — allows animations to play again", function()
    State.NoAnim = false
    setStatus("Animations resumed")
end)
register("slide", "slide — removes friction so you slide around", function()
    local root = getRoot()
    if root then
        root.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.01, 0.5, 1, 1)
    end
    setStatus("Slide on")
end)
register("unslide", "unslide — restores normal friction", function()
    local root = getRoot()
    if root then root.CustomPhysicalProperties = nil end
    setStatus("Slide off")
end)

-- ---- locks ----
register("speedlock", "speedlock [number] — keeps your WalkSpeed pinned", function(args)
    State.SpeedLock = true
    State.LockedSpeed = tonumber(args[1]) or 16
    setStatus("WalkSpeed locked to " .. State.LockedSpeed)
end)
register("unspeedlock", "unspeedlock — turns speed lock off", function()
    State.SpeedLock = false
    setStatus("Speed lock off")
end)
register("healthlock", "healthlock [number] — keeps your health pinned at a value", function(args)
    State.HealthLock = true
    State.LockedHealth = tonumber(args[1]) or 100
    setStatus("Health locked to " .. State.LockedHealth)
end)
register("unhealthlock", "unhealthlock — turns health lock off", function()
    State.HealthLock = false
    setStatus("Health lock off")
end)
register("jumplock", "jumplock [number] — keeps your JumpPower pinned", function(args)
    State.JumpLock = true
    State.LockedJump = tonumber(args[1]) or 50
    setStatus("JumpPower locked to " .. State.LockedJump)
end)
register("unjumplock", "unjumplock — turns jump lock off", function()
    State.JumpLock = false
    setStatus("Jump lock off")
end)

-- =========================================================
-- ALIASES — Infinite Yield itself is mostly the same features
-- under many names; this does the same thing honestly: every
-- alias below runs the exact same code as its real command,
-- it's just another name for it. Hidden from ;cmds (desc=nil)
-- so the real list above stays clean — type the name directly.
-- =========================================================

local function alias(newName, targetName)
    local c = commands[targetName]
    if c then
        commands[newName] = { desc = nil, run = c.run }
    end
end

alias("setambient", "ambient")
alias("broadcast", "announce")
alias("pester", "annoy")
alias("noafk", "antiafk")
alias("afkbypass", "antiafk")
alias("shielddamage", "antidamage")
alias("shieldfire", "antifire")
alias("shieldfling", "antifling")
alias("shieldfreeze", "antifreeze")
alias("shieldinvis", "antiinvis")
alias("shieldjumpnerf", "antijumpnerf")
alias("shieldkill", "antikill")
alias("shieldragdoll", "antiragdoll")
alias("shieldseat", "antiseat")
alias("shieldslow", "antislow")
alias("shieldstun", "antistun")
alias("shieldvoid", "antivoid")
alias("rearbang", "backbang")
alias("punch", "bang")
alias("slam", "bang")
alias("scaleup", "bigself")
alias("grow", "bigself")
alias("keybind", "bind")
alias("setbloom", "bloom")
alias("setblur", "blur")
alias("bright", "brightness")
alias("tphere", "bring")
alias("summon", "bring")
alias("summonall", "bringall")
alias("tpallhere", "bringall")
alias("bubblesoff", "bubbleoff")
alias("bubbleson", "bubbleon")
alias("shakecam", "camshake")
alias("realtime", "clock")
alias("commands", "cmds")
alias("help", "cmds")
alias("grading", "colorcorrect")
alias("xyz", "coords")
alias("position", "coords")
alias("chaosbang", "crazybang")
alias("depthoffield", "dof")
alias("chams", "esp")
alias("wallhacks", "esp")
alias("mugbang", "facebang")
alias("fpv", "firstperson")
alias("fp", "firstperson")
alias("hoverbang", "floatbang")
alias("flying", "fly")
alias("flye", "fly")
alias("setfog", "fog")
alias("stalk", "follow")
alias("zoom", "fov")
alias("fpscounter", "fps")
alias("spectatecam", "freecam")
alias("flycam", "freecam")
alias("anchor", "freezeself")
alias("ghostmode", "ghost")
alias("light", "glow")
alias("godmode", "god")
alias("invincible", "god")
alias("tp", "goto")
alias("teleportto", "goto")
alias("grav", "gravity")
alias("headperch", "headsit")
alias("hp", "health")
alias("sethealth", "health")
alias("lockhealth", "healthlock")
alias("mute", "ignore")
alias("invis", "invisible")
alias("hide", "invisible")
alias("lockjump", "jumplock")
alias("jp", "jumppower")
alias("jumpheight", "jumppower")
alias("die", "kill")
alias("suicide", "kill")
alias("loadpos1", "loadpos")
alias("poload", "loadpos")
alias("banner", "motd")
alias("playmusic", "music")
alias("playsound", "music")
alias("animoff", "noanim")
alias("stopanims", "noanim")
alias("clip", "noclip")
alias("wallhack", "noclip")
alias("circle", "orbit")
alias("pingdisplay", "ping")
alias("playerlist", "plrlist")
alias("setprefix", "prefix")
alias("setrain", "rain")
alias("colorcycle", "rainbow")
alias("rgbmode", "rainbow")
alias("rejoinserver", "rejoin")
alias("unambient", "resetambient")
alias("animon", "resetanim")
alias("unbright", "resetbrightness")
alias("camreset", "resetcam")
alias("unfog", "resetfog")
alias("unzoom", "resetfov")
alias("ungrav", "resetgravity")
alias("unscale", "resetsize")
alias("unspeed", "resetspeed")
alias("wsreset", "resetspeed")
alias("reset", "respawn")
alias("resetchar", "respawn")
alias("savepos1", "savepos")
alias("posave", "savepos")
alias("firefx", "selffire")
alias("flame", "selffire")
alias("srvinfo", "serverinfo")
alias("setshadows", "shadows")
alias("jitterbang", "shakebang")
alias("dance", "shakethat")
alias("tangshake", "shakethat")
alias("lateralbang", "sidebang")
alias("seat", "sit")
alias("scale", "size")
alias("frictionoff", "slide")
alias("gentlebang", "slowbang")
alias("scaledown", "smallself")
alias("shrink", "smallself")
alias("smokefx", "smoke")
alias("setsnow", "snow")
alias("sparkles", "sparkle")
alias("nextview", "spectatenext")
alias("prevview", "spectateprev")
alias("ws", "speed")
alias("walkspeed", "speed")
alias("lockspeed", "speedlock")
alias("twirl", "spin")
alias("twistbang", "spinbang")
alias("panic", "stop")
alias("resetall", "stop")
alias("musicstop", "stopmusic")
alias("stopsound", "stopmusic")
alias("endtroll", "stoptroll")
alias("trolloff", "stoptroll")
alias("setsunrays", "sunrays")
alias("tpv", "thirdperson")
alias("tp3", "thirdperson")
alias("settime", "time")
alias("clocktime", "time")
alias("overheadbang", "topbang")
alias("traileffect", "trail")
alias("fall", "trip")
alias("stumble", "trip")
alias("unnoafk", "unantiafk")
alias("keyunbind", "unbind")
alias("nobloom", "unbloom")
alias("noblur", "unblur")
alias("norealtime", "unclock")
alias("nograding", "uncolorcorrect")
alias("noxyz", "uncoords")
alias("nodof", "undof")
alias("unchams", "unesp")
alias("nowallhacks", "unesp")
alias("nofly", "unfly")
alias("flyoff", "unfly")
alias("unstalk", "unfollow")
alias("nofpscounter", "unfps")
alias("unspectatecam", "unfreecam")
alias("unflycam", "unfreecam")
alias("unanchor", "unfreezeself")
alias("unghostmode", "unghost")
alias("unlight", "unglow")
alias("unglodmode", "ungod")
alias("mortal", "ungod")
alias("unlockhealth", "unhealthlock")
alias("unmute", "unignore")
alias("unlockjump", "unjumplock")
alias("nobanner", "unmotd")
alias("nopingdisplay", "unping")
alias("noplayerlist", "unplrlist")
alias("norain", "unrain")
alias("uncolorcycle", "unrainbow")
alias("unrgbmode", "unrainbow")
alias("unfirefx", "unselffire")
alias("unflame", "unselffire")
alias("noshadows", "unshadows")
alias("dancestop", "unshakethat")
alias("stopdance", "unshakethat")
alias("unseat", "unsit")
alias("stand", "unsit")
alias("frictionon", "unslide")
alias("unsmokefx", "unsmoke")
alias("nosnow", "unsnow")
alias("unsparkles", "unsparkle")
alias("unlockspeed", "unspeedlock")
alias("untwirl", "unspin")
alias("nosunrays", "unsunrays")
alias("notilt", "untilt")
alias("notrail", "untrail")
alias("unspectate", "unview")
alias("nozoomlock", "unzoomlock")
alias("spectate", "view")
alias("vis", "visible")
alias("unhide", "visible")
alias("pathto", "walkto")
alias("autowalk", "walkto")
alias("wigglebang", "zigzagbang")

local groups = {
    { "MOVEMENT", { "fly", "unfly", "speed", "resetspeed", "jumppower", "noclip", "spin", "unspin", "trip", "sit", "unsit", "respawn", "invisible", "visible" } },
    { "CAMERA", { "fov", "resetfov", "freecam", "unfreecam" } },
    { "PLAYERS", { "view", "unview", "goto", "follow", "unfollow" } },
    { "TROLL", { "bang", "backbang", "sidebang", "topbang", "spinbang", "shakebang", "floatbang", "zigzagbang", "crazybang", "slowbang", "facebang", "headsit", "orbit", "annoy", "stoptroll" } },
    { "SHIELD", { "antifling", "antivoid" } },
    { "EXTRA", { "esp", "unesp", "trail", "untrail", "size", "resetsize", "kill", "god", "ungod", "health", "gravity", "resetgravity" } },
    { "MISC", { "music", "stopmusic", "rejoin", "prefix", "cmds", "stop" } },
}

local shown = {}
for _, group in ipairs(groups) do
    addListLine(group[1], true)

    if group[1] == "TROLL" then
        -- delay box — whatever number you set here controls the speed of
        -- every bang (front AND back), live, no command needed
        local delayRow = Instance.new("Frame", ListScroll)
        delayRow.Size = UDim2.new(1, 0, 0, 22)
        delayRow.BackgroundTransparency = 1
        delayRow.ZIndex = 51

        local delayLabel = Instance.new("TextLabel", delayRow)
        delayLabel.Size = UDim2.new(0, 64, 1, 0)
        delayLabel.BackgroundTransparency = 1
        delayLabel.Text = "Delay(s):"
        delayLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
        delayLabel.Font = Enum.Font.SourceSans
        delayLabel.TextSize = 12
        delayLabel.TextXAlignment = Enum.TextXAlignment.Left
        delayLabel.ZIndex = 52

        local delayBox = Instance.new("TextBox", delayRow)
        delayBox.Size = UDim2.new(0, 56, 0, 18)
        delayBox.Position = UDim2.new(0, 66, 0, 2)
        delayBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        delayBox.BorderSizePixel = 0
        delayBox.Text = tostring(State.TrollDelay)
        delayBox.TextColor3 = Color3.fromRGB(230, 230, 230)
        delayBox.Font = Enum.Font.SourceSans
        delayBox.TextSize = 12
        delayBox.ClearTextOnFocus = false
        delayBox.ZIndex = 52
        Instance.new("UICorner", delayBox).CornerRadius = UDim.new(0, 3)
        local delayStroke = Instance.new("UIStroke", delayBox)
        delayStroke.Thickness = 1
        delayStroke.Color = Color3.fromRGB(70, 70, 70)

        delayBox.FocusLost:Connect(function()
            local n = tonumber(delayBox.Text)
            if n and n >= 0 then
                State.TrollDelay = n
                setStatus("Bang delay set to " .. n .. "s")
            else
                delayBox.Text = tostring(State.TrollDelay)
            end
        end)

        if CurrentHeaderGroup then
            table.insert(CurrentHeaderGroup.items, { label = delayRow, key = "delay bang troll speed" })
        end
    end

    for _, name in ipairs(group[2]) do
        local c = commands[name]
        if c then
            addListLine(prefix .. c.desc, false, name)
            shown[name] = true
        end
    end
end

-- SAFETY NET: any real command that was registered but forgotten above
-- still shows up here automatically — nothing real stays hidden
local leftovers = {}
for name, c in pairs(commands) do
    if c.desc and not shown[name] then table.insert(leftovers, name) end
end
if #leftovers > 0 then
    table.sort(leftovers)
    addListLine("OTHER", true)
    for _, name in ipairs(leftovers) do
        addListLine(prefix .. commands[name].desc, false, name)
    end
end

addListLine("INFO", true)
addListLine("+2000 more: colorN, speedpresetN, fovpresetN", false, "more presets bulk")
applySearch()

-- =========================================================
-- parsing + running typed commands
-- =========================================================

local function runCommand(text)
    if text:sub(1, #prefix) ~= prefix then
        setStatus("Commands must start with " .. prefix, true)
        return
    end

    local body = text:sub(#prefix + 1)
    local parts = {}
    for word in body:gmatch("%S+") do table.insert(parts, word) end
    local name = table.remove(parts, 1)
    if not name then return end
    name = name:lower()

    local cmd = commands[name]
    if cmd then
        local ok, err = pcall(cmd.run, parts)
        if not ok then setStatus("Error: " .. tostring(err), true) end
    else
        setStatus("Unknown command: " .. name, true)
    end
end

Input.FocusLost:Connect(function(enteredPressed)
    if not enteredPressed then return end
    local text = Input.Text
    Input.Text = ""
    if text == "" then return end
    runCommand(text)
end)

-- =========================================================
-- wiring for SETTINGS / CUSTOMIZE / HOTBAR / KEYBINDS
-- (lives down here because it needs `commands` + `runCommand`,
-- which only exist once every command above has registered)
-- =========================================================

-- prefix apply button
PrefixApply.MouseButton1Click:Connect(function()
    local ch = PrefixBox.Text
    if ch and #ch == 1 then
        prefix = ch
        Input.PlaceholderText = "Type " .. prefix .. "cmds for list..."
        setStatus("Prefix changed to " .. prefix)
    else
        setStatus("Give a single character", true)
        PrefixBox.Text = prefix
    end
end)

-- shield quick-toggle buttons — every shield command becomes a clickable button
local ShieldNames = {
    "antifling", "antivoid", "antifire", "antiragdoll", "antidamage", "antislow",
    "antijumpnerf", "antistun", "antiseat", "antiinvis", "antifreeze", "antikill",
    "speedlock", "healthlock", "jumplock", "antiafk",
}
for _, name in ipairs(ShieldNames) do
    local cmd = commands[name]
    if cmd then
        local btn = Instance.new("TextButton", ShieldGrid)
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btn.BorderSizePixel = 0
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        btn.Font = Enum.Font.SourceSans
        btn.TextSize = 11
        btn.ZIndex = 52
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        btn.MouseButton1Click:Connect(function()
            local ok, err = pcall(cmd.run, {})
            if not ok then setStatus("Error: " .. tostring(err), true) end
        end)
    end
end

BindSetBtn.MouseButton1Click:Connect(function()
    if doBind(BindKeyBox.Text, BindCmdBox.Text) then
        setStatus("Bound " .. BindKeyBox.Text .. " -> " .. prefix .. BindCmdBox.Text)
        BindKeyBox.Text = ""
        BindCmdBox.Text = ""
    end
end)

-- PC keyboard listener — ignores keystrokes while any textbox is focused
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if UserInputService:GetFocusedTextBox() then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    local keyName = input.KeyCode.Name:lower()
    local bound = KeyBinds[keyName]
    if bound then
        runCommand(prefix .. bound)
    end
end)

-- hotbar slot taps (works with touch on mobile AND mouse click on PC)
for slotNum, slotBtn in pairs(HotbarSlots) do
    slotBtn.MouseButton1Click:Connect(function()
        local bound = KeyBinds[slotNum]
        if bound then
            runCommand(prefix .. bound)
        else
            setStatus("Slot " .. slotNum .. " not bound — try " .. prefix .. "bind " .. slotNum .. " [command]", true)
        end
    end)
end

-- =========================================================
-- CUSTOMIZE panel logic — pick any real command, give it a
-- shortcut name, and the shortcut runs the exact same thing
-- =========================================================

local SelectedCommand = nil
local CustomizeRows = {}

local function populateCustomizeList(query)
    for _, row in ipairs(CustomizeRows) do row:Destroy() end
    CustomizeRows = {}
    local names = {}
    for name, c in pairs(commands) do
        if c.desc and (query == "" or name:find(query, 1, true)) then
            table.insert(names, name)
        end
    end
    table.sort(names)
    for _, name in ipairs(names) do
        local row = Instance.new("TextButton", CustomizeList)
        row.Size = UDim2.new(1, 0, 0, 18)
        row.BackgroundTransparency = 1
        row.Text = prefix .. name
        row.TextColor3 = Color3.fromRGB(210, 210, 210)
        row.Font = Enum.Font.SourceSans
        row.TextSize = 12
        row.TextXAlignment = Enum.TextXAlignment.Left
        row.ZIndex = 51
        row.MouseButton1Click:Connect(function()
            SelectedCommand = name
            SelectedLabel.Text = "Selected: " .. prefix .. name
        end)
        table.insert(CustomizeRows, row)
    end
end

CustomizeSearch:GetPropertyChangedSignal("Text"):Connect(function()
    populateCustomizeList(CustomizeSearch.Text:lower())
end)
populateCustomizeList("")

SaveShortcutBtn.MouseButton1Click:Connect(function()
    local shortcut = ShortcutBox.Text:lower():gsub(prefix, "")
    if not SelectedCommand then
        SelectedLabel.Text = "Pick a command first"
        return
    end
    if not shortcut or shortcut == "" then
        SelectedLabel.Text = "Type a shortcut name"
        return
    end
    commands[shortcut] = commands[SelectedCommand]
    SavedShortcutsLabel.Text = prefix .. shortcut .. " now runs " .. prefix .. SelectedCommand .. " ✓"
    setStatus(prefix .. shortcut .. " -> " .. prefix .. SelectedCommand)
    ShortcutBox.Text = ""
end)

-- =========================================================
-- REAL CHAT HIJACK — type ";cmds" (or whatever the prefix is)
-- directly in the ACTUAL Roblox chat box. The message is caught
-- and blocked before it ever reaches the server, so nobody else
-- sees it, and it runs as a ZZ YIELD command instead.
-- Needs an executor that exposes hookmetamethod/getnamecallmethod
-- (Synapse, Script-Ware, Krnl, etc.) — if yours doesn't, the
-- command bar above still works exactly the same either way.
-- =========================================================

local function wrapHook(fn)
    -- some executors need the replacement to be a C closure or the
    -- hook gets rejected/flagged — use newcclosure when it exists
    if typeof(newcclosure) == "function" then
        local ok, wrapped = pcall(newcclosure, fn)
        if ok and wrapped then return wrapped end
    end
    return fn
end

local hijackOk = false
if typeof(hookmetamethod) == "function" and typeof(getnamecallmethod) == "function" then
    local setupOk, err = pcall(function()
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", wrapHook(function(self, ...)
            local args = { ... }
            local methodOk, method = pcall(getnamecallmethod)

            if methodOk then
                -- new chat (TextChatService) — TextChannel:SendAsync(text)
                if method == "SendAsync" then
                    local isChannelOk, isChannel = pcall(function() return self:IsA("TextChannel") end)
                    if isChannelOk and isChannel then
                        local text = args[1]
                        if type(text) == "string" and text:sub(1, #prefix) == prefix then
                            task.spawn(runCommand, text)
                            return
                        end
                    end
                end

                -- legacy chat — DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, channel)
                if method == "FireServer" then
                    local isInstOk, isInst = pcall(function() return typeof(self) == "Instance" and self.Name == "SayMessageRequest" end)
                    if isInstOk and isInst then
                        local text = args[1]
                        if type(text) == "string" and text:sub(1, #prefix) == prefix then
                            task.spawn(runCommand, text)
                            return
                        end
                    end
                end
            end

            return oldNamecall(self, ...)
        end))
    end)
    hijackOk = setupOk
    if not setupOk then
        warn("[ZZ YIELD] chat hijack setup failed: " .. tostring(err))
    end
end

if hijackOk then
    setStatus("Chat hijack active — " .. prefix .. "cmds works in real chat too")
else
    setStatus("Chat hijack not supported here — use the command bar below", true)
    print("[ZZ YIELD] Your executor doesn't support hookmetamethod/getnamecallmethod (or the hook failed). The command bar still works 100% the same, every command runs from there too.")
end

-- =========================================================
-- engine loops for toggled states
-- =========================================================

local bodyVelocity

local function ensureFlyParts(root)
    if not bodyVelocity or bodyVelocity.Parent ~= root then
        if bodyVelocity then bodyVelocity:Destroy() end
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = root
    end
end

RunService.RenderStepped:Connect(function()
    local root = getRoot()
    if not root then return end

    if State.Flying then
        ensureFlyParts(root)
        local cam = workspace.CurrentCamera
        local move = Vector3.new(0, 0, 0)
        local dir = cam.CFrame.LookVector
        local right = cam.CFrame.RightVector
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += dir end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= dir end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= right end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += right end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0, 1, 0) end
        if move.Magnitude > 0 then move = move.Unit end
        bodyVelocity.Velocity = move * State.FlySpeed
    elseif bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end

    if State.Spinning then
        root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(State.SpinSpeed * 10), 0)
    end

    if State.Following and State.Following.Character and State.Following.Character:FindFirstChild("HumanoidRootPart") then
        root.CFrame = State.Following.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
    end

    -- SHIELD: antifling — also stops bang-style collision pushes, since
    -- both show up as a sudden abnormal velocity spike on your root part
    if State.AntiFling then
        local vel = root.AssemblyLinearVelocity
        if vel.Magnitude > 90 then
            root.AssemblyLinearVelocity = Vector3.new(0, math.min(vel.Y, 20), 0)
        end
    end

    -- SHIELD: antivoid — rescue from falling out of the map
    if State.AntiVoid and root.Position.Y < -75 then
        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        root.CFrame = CFrame.new(root.Position.X, 50, root.Position.Z)
    end

    if State.God then
        local hum = getHum()
        if hum and hum.Health < hum.MaxHealth then
            hum.Health = math.min(hum.MaxHealth, hum.Health + hum.MaxHealth * 0.1)
        end
    end

    if State.FreeCam then
        local cam = workspace.CurrentCamera
        local move = Vector3.new(0, 0, 0)
        local dir = cam.CFrame.LookVector
        local right = cam.CFrame.RightVector
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += dir end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= dir end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= right end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += right end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0, 1, 0) end
        if move.Magnitude > 0 then
            cam.CFrame = cam.CFrame + move.Unit * 1.2
        end
    end

    local hum2 = getHum()
    local char2 = getChar()

    -- +10 shields
    if State.AntiFire and char2 then
        for _, p in ipairs(char2:GetChildren()) do
            if p:IsA("Fire") or p:IsA("Sparkles") then p:Destroy() end
        end
    end
    if State.AntiRagdoll and hum2 then
        if hum2.PlatformStand then hum2.PlatformStand = false end
    end
    if State.AntiDamage and hum2 and hum2.Health < hum2.MaxHealth * 0.9 then
        hum2.Health = hum2.MaxHealth
    end
    if State.AntiSlow and hum2 and not State.Flying and math.abs(hum2.WalkSpeed - State.DefaultSpeed) > 0.5 then
        hum2.WalkSpeed = State.DefaultSpeed
    end
    if State.AntiJumpNerf and hum2 and math.abs(hum2.JumpPower - State.DefaultJump) > 0.5 then
        hum2.JumpPower = State.DefaultJump
    end
    if State.AntiStun and hum2 and hum2.PlatformStand then
        hum2.PlatformStand = false
    end
    if State.AntiSeat and hum2 and hum2.Sit and not State.CurrentTroll then
        hum2.Sit = false
    end
    if State.AntiInvis and char2 then
        for _, p in ipairs(char2:GetDescendants()) do
            if p:IsA("BasePart") and p.Transparency > 0.05 and not p.Name:match("^ZZ") then
                p.Transparency = 0
            end
        end
    end
    if State.AntiFreeze and root.Anchored then
        root.Anchored = false
    end
    if State.AntiKill and hum2 then
        if State.AntiKillHealth and hum2.Health < State.AntiKillHealth - hum2.MaxHealth * 0.4 then
            hum2.Health = math.min(hum2.MaxHealth, State.AntiKillHealth)
        end
        State.AntiKillHealth = hum2.Health
    end

    -- locks
    if State.SpeedLock and hum2 and math.abs(hum2.WalkSpeed - State.LockedSpeed) > 0.5 then
        hum2.WalkSpeed = State.LockedSpeed
    end
    if State.HealthLock and hum2 and math.abs(hum2.Health - State.LockedHealth) > 0.5 then
        hum2.Health = State.LockedHealth
    end
    if State.JumpLock and hum2 and math.abs(hum2.JumpPower - State.LockedJump) > 0.5 then
        hum2.UseJumpPower = true
        hum2.JumpPower = State.LockedJump
    end

    if State.NoAnim and hum2 then
        for _, track in ipairs(hum2:GetPlayingAnimationTracks()) do track:Stop() end
    end
end)

-- clean up ESP highlights for players who leave, and re-apply for new characters
Players.PlayerRemoving:Connect(function(p)
    if State.EspBoxes[p] then
        State.EspBoxes[p]:Destroy()
        State.EspBoxes[p] = nil
    end
end)

print("💢 ZZ YIELD loaded! Type " .. prefix .. "cmds in the command bar.")
