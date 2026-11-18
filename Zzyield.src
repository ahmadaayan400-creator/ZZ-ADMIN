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

-- forward declarations: these get their real value further down the file,
-- but setStatus (defined early) needs to see them as upvalues, not globals
local State
local zzTickSound
local ListPopup, SettingsPopup, CustomizePopup
local prefix = ";"

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
    Splash.Position = UDim2.new(0.5, 0, 0.38, 0)
    Splash.Size = UDim2.new(0, 340, 0, 220)
    Splash.BackgroundTransparency = 1
    Splash.ZIndex = 100

    -- gold ring behind the badge, premium metallic feel
    local Ring = Instance.new("Frame", Splash)
    Ring.AnchorPoint = Vector2.new(0.5, 0)
    Ring.Position = UDim2.new(0.5, 0, 0, 0)
    Ring.Size = UDim2.new(0, 150, 0, 150)
    Ring.BackgroundColor3 = Color3.fromRGB(207, 165, 68)
    Ring.BackgroundTransparency = 1
    Ring.BorderSizePixel = 0
    Ring.ZIndex = 100
    Instance.new("UICorner", Ring).CornerRadius = UDim.new(1, 0)
    local RingGrad = Instance.new("UIGradient", Ring)
    RingGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(207, 165, 68)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 246, 216)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 106, 31)),
    })
    RingGrad.Rotation = 90

    -- logo badge: a circular dark badge with a merged "ZZ" monogram mark
    local Badge = Instance.new("Frame", Ring)
    Badge.AnchorPoint = Vector2.new(0.5, 0.5)
    Badge.Position = UDim2.new(0.5, 0, 0.5, 0)
    Badge.Size = UDim2.new(1, -10, 1, -10)
    Badge.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    Badge.BackgroundTransparency = 1
    Badge.BorderSizePixel = 0
    Badge.ZIndex = 101
    Instance.new("UICorner", Badge).CornerRadius = UDim.new(1, 0)

    local Z1 = Instance.new("TextLabel", Badge)
    Z1.AnchorPoint = Vector2.new(0.5, 0.5)
    Z1.Position = UDim2.new(0.37, 0, 0.5, 0)
    Z1.Size = UDim2.new(0, 80, 0, 88)
    Z1.Rotation = -9
    Z1.BackgroundTransparency = 1
    Z1.Text = "Z"
    Z1.TextColor3 = Color3.fromRGB(255, 255, 255)
    Z1.TextTransparency = 1
    Z1.Font = Enum.Font.SourceSansBold
    Z1.TextSize = 74
    Z1.ZIndex = 102

    local Z2 = Instance.new("TextLabel", Badge)
    Z2.AnchorPoint = Vector2.new(0.5, 0.5)
    Z2.Position = UDim2.new(0.63, 0, 0.5, 0)
    Z2.Size = UDim2.new(0, 80, 0, 88)
    Z2.Rotation = 9
    Z2.BackgroundTransparency = 1
    Z2.Text = "Z"
    Z2.TextColor3 = Color3.fromRGB(232, 196, 102)
    Z2.TextTransparency = 1
    Z2.Font = Enum.Font.SourceSansBold
    Z2.TextSize = 74
    Z2.ZIndex = 103

    local SplashTitle = Instance.new("TextLabel", Splash)
    SplashTitle.AnchorPoint = Vector2.new(0.5, 0)
    SplashTitle.Position = UDim2.new(0.5, 0, 0, 162)
    SplashTitle.Size = UDim2.new(1, 0, 0, 36)
    SplashTitle.BackgroundTransparency = 1
    SplashTitle.Text = "ZZ  Y I E L D"
    SplashTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SplashTitle.TextTransparency = 1
    SplashTitle.Font = Enum.Font.SourceSansBold
    SplashTitle.TextSize = 32
    SplashTitle.ZIndex = 101
    SplashTitle.TextStrokeColor3 = Color3.fromRGB(232, 196, 102)
    SplashTitle.TextStrokeTransparency = 1 -- faded in below, gives it a soft gold glow

    local SplashLine = Instance.new("Frame", Splash)
    SplashLine.AnchorPoint = Vector2.new(0.5, 0)
    SplashLine.Position = UDim2.new(0.5, 0, 0, 196)
    SplashLine.Size = UDim2.new(0, 110, 0, 1)
    SplashLine.BackgroundColor3 = Color3.fromRGB(207, 165, 68)
    SplashLine.BackgroundTransparency = 1
    SplashLine.BorderSizePixel = 0
    SplashLine.ZIndex = 101
    local SplashLineGrad = Instance.new("UIGradient", SplashLine)
    SplashLineGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0.2),
        NumberSequenceKeypoint.new(1, 1),
    })

    local SplashSub = Instance.new("TextLabel", Splash)
    SplashSub.AnchorPoint = Vector2.new(0.5, 0)
    SplashSub.Position = UDim2.new(0.5, 0, 0, 202)
    SplashSub.Size = UDim2.new(1, 0, 0, 18)
    SplashSub.BackgroundTransparency = 1
    SplashSub.Text = "loaded — type ;cmds to search"
    SplashSub.TextColor3 = Color3.fromRGB(180, 180, 180)
    SplashSub.TextTransparency = 1
    SplashSub.Font = Enum.Font.SourceSans
    SplashSub.TextSize = 13
    SplashSub.ZIndex = 101

    Ring.Size = UDim2.new(0, 100, 0, 100)
    local ringGrow = TweenService:Create(Ring, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 150, 0, 150),
        BackgroundTransparency = 0,
    })
    local badgeIn = TweenService:Create(Badge, TweenInfo.new(0.4), { BackgroundTransparency = 0.05 })
    local z1In = TweenService:Create(Z1, TweenInfo.new(0.45), { TextTransparency = 0 })
    local z2In = TweenService:Create(Z2, TweenInfo.new(0.45), { TextTransparency = 0.1 })
    local titleIn = TweenService:Create(SplashTitle, TweenInfo.new(0.4), { TextTransparency = 0, TextStrokeTransparency = 0.55 })
    local lineIn = TweenService:Create(SplashLine, TweenInfo.new(0.4), { BackgroundTransparency = 0 })
    local subIn = TweenService:Create(SplashSub, TweenInfo.new(0.4), { TextTransparency = 0 })
    ringGrow:Play()
    badgeIn:Play()
    z1In:Play()
    z2In:Play()
    titleIn:Play()
    lineIn:Play()
    subIn:Play()

    task.spawn(function()
        task.wait(2.2)
        local outs = {
            TweenService:Create(Ring, TweenInfo.new(0.4), { BackgroundTransparency = 1 }),
            TweenService:Create(Badge, TweenInfo.new(0.4), { BackgroundTransparency = 1 }),
            TweenService:Create(Z1, TweenInfo.new(0.4), { TextTransparency = 1 }),
            TweenService:Create(Z2, TweenInfo.new(0.4), { TextTransparency = 1 }),
            TweenService:Create(SplashTitle, TweenInfo.new(0.4), { TextTransparency = 1, TextStrokeTransparency = 1 }),
            TweenService:Create(SplashLine, TweenInfo.new(0.4), { BackgroundTransparency = 1 }),
            TweenService:Create(SplashSub, TweenInfo.new(0.4), { TextTransparency = 1 }),
        }
        for _, t in ipairs(outs) do t:Play() end
        outs[1].Completed:Wait()
        Splash:Destroy()

        -- first-time help toast
        local toast = Instance.new("Frame", gui)
        toast.Size = UDim2.new(0, 300, 0, 60)
        toast.Position = UDim2.new(0.5, -150, 0, -70)
        toast.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        toast.BorderSizePixel = 0
        toast.ZIndex = 60
        Instance.new("UICorner", toast).CornerRadius = UDim.new(0, 10)
        local toastStroke = Instance.new("UIStroke", toast)
        toastStroke.Thickness = 1
        toastStroke.Color = Color3.fromRGB(232, 196, 102)
        toastStroke.Transparency = 0.4
        local toastText = Instance.new("TextLabel", toast)
        toastText.Size = UDim2.new(1, -20, 1, 0)
        toastText.Position = UDim2.new(0, 10, 0, 0)
        toastText.BackgroundTransparency = 1
        toastText.Text = "Welcome! Type " .. prefix .. "cmds to search every command, or tap the ⚙ gear for settings."
        toastText.TextColor3 = Color3.fromRGB(220, 220, 220)
        toastText.Font = Enum.Font.SourceSans
        toastText.TextSize = 13
        toastText.TextWrapped = true
        toastText.ZIndex = 60
        TweenService:Create(toast, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0.5, -150, 0, 20) }):Play()
        task.wait(4.5)
        local toastOut = TweenService:Create(toast, TweenInfo.new(0.35), { Position = UDim2.new(0.5, -150, 0, -70) })
        toastOut:Play()
        toastOut.Completed:Wait()
        toast:Destroy()
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

-- IY-style "slides up from the bottom" popup open/close. Every ;cmds /
-- settings / customize panel uses this instead of just flipping Visible,
-- so it animates in the same way real Infinite Yield's panel does.
local zzPopupHomePos = {} -- panel -> its real resting Position (set on first open)
local function zzOpenPopup(panel)
    if not zzPopupHomePos[panel] then zzPopupHomePos[panel] = panel.Position end
    local home = zzPopupHomePos[panel]
    panel.Position = UDim2.new(home.X.Scale, home.X.Offset, home.Y.Scale, home.Y.Offset + 60)
    panel.Visible = true
    local goalT = 1
    for _, d in ipairs(panel:GetDescendants()) do
        if d:IsA("GuiObject") then goalT = nil break end
    end
    TweenService:Create(panel, TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = home }):Play()
end
local function zzClosePopup(panel)
    local home = zzPopupHomePos[panel] or panel.Position
    local tw = TweenService:Create(panel, TweenInfo.new(0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
        { Position = UDim2.new(home.X.Scale, home.X.Offset, home.Y.Scale, home.Y.Offset + 60) })
    tw:Play()
    tw.Completed:Connect(function()
        if panel.Position == UDim2.new(home.X.Scale, home.X.Offset, home.Y.Scale, home.Y.Offset + 60) then
            panel.Visible = false
            panel.Position = home
        end
    end)
end
local function zzTogglePopup(panel)
    if panel.Visible then zzClosePopup(panel) else zzOpenPopup(panel) end
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

prefix = ";"

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

-- minimize button — tiny tab above the bar's top-right corner
local MinimizeBtn = Instance.new("TextButton", gui)
MinimizeBtn.Size = UDim2.new(0, 20, 0, 20)
MinimizeBtn.Position = UDim2.new(0, 326, 1, -72)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Text = "–"
MinimizeBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.TextSize = 16
MinimizeBtn.ZIndex = 52
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(1, 0)

local RestoreBubble = Instance.new("TextButton", gui)
RestoreBubble.Size = UDim2.new(0, 44, 0, 44)
RestoreBubble.Position = UDim2.new(0, 16, 1, -60)
RestoreBubble.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
RestoreBubble.BorderSizePixel = 0
RestoreBubble.Text = "ZZ"
RestoreBubble.TextColor3 = Color3.fromRGB(232, 196, 102)
RestoreBubble.Font = Enum.Font.SourceSansBold
RestoreBubble.TextSize = 16
RestoreBubble.ZIndex = 52
RestoreBubble.Visible = false
Instance.new("UICorner", RestoreBubble).CornerRadius = UDim.new(1, 0)
local restoreStroke = Instance.new("UIStroke", RestoreBubble)
restoreStroke.Thickness = 1
restoreStroke.Color = Color3.fromRGB(232, 196, 102)
restoreStroke.Transparency = 0.4

local zzMinimized = false
local function zzSetMinimized(on)
    zzMinimized = on
    Bar.Visible = not on
    MinimizeBtn.Visible = not on
    RestoreBubble.Visible = on
    if on then
        if ListPopup then ListPopup.Visible = false end
        if SettingsPopup then SettingsPopup.Visible = false end
        if CustomizePopup then CustomizePopup.Visible = false end
    end
end
MinimizeBtn.MouseButton1Click:Connect(function() zzSetMinimized(true) end)
RestoreBubble.MouseButton1Click:Connect(function() zzSetMinimized(false) end)

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
    if zzTickSound and State and State.SoundEnabled then
        pcall(function() zzTickSound:Play() end)
    end
end

-- =========================================================
-- cmds list popup
-- =========================================================

ListPopup = Instance.new("Frame", gui)
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

-- favorites header — stays hidden until something's pinned
local FavHeader = Instance.new("TextLabel", ListScroll)
FavHeader.Size = UDim2.new(1, 0, 0, 20)
FavHeader.BackgroundTransparency = 1
FavHeader.Text = "\226\152\133 FAVORITES"
FavHeader.TextColor3 = Color3.fromRGB(232, 196, 102)
FavHeader.Font = Enum.Font.SourceSansBold
FavHeader.TextSize = 13
FavHeader.TextXAlignment = Enum.TextXAlignment.Left
FavHeader.ZIndex = 51
FavHeader.LayoutOrder = -1000
FavHeader.Visible = false
local FavLabels = {}

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
    zzTogglePopup(ListPopup)
end)

-- =========================================================
-- SETTINGS panel (gear icon) — prefix, shields, keybinds
-- =========================================================

SettingsPopup = Instance.new("Frame", gui)
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
    zzTogglePopup(SettingsPopup)
end)

-- =========================================================
-- CUSTOMIZE panel — pick a command, give it your own shortcut
-- =========================================================

CustomizePopup = Instance.new("Frame", gui)
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
    zzTogglePopup(CustomizePopup)
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

-- fly up/down buttons — only shown while flying (mobile has no
-- Space/Ctrl keys, so this is how vertical movement works everywhere)
local FlyPad = Instance.new("Frame", gui)
FlyPad.Size = UDim2.new(0, 46, 0, 100)
FlyPad.Position = UDim2.new(1, -236, 1, -160)
FlyPad.BackgroundTransparency = 1
FlyPad.ZIndex = 50
FlyPad.Visible = false
local FlyPadLayout = Instance.new("UIListLayout", FlyPad)
FlyPadLayout.Padding = UDim.new(0, 8)
FlyPadLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right

local function makeFlyBtn(txt)
    local b = Instance.new("TextButton", FlyPad)
    b.Size = UDim2.new(0, 46, 0, 46)
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    b.BackgroundTransparency = 0.15
    b.BorderSizePixel = 0
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(232, 196, 102)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 22
    b.ZIndex = 50
    b.AutoButtonColor = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
    local bstroke = Instance.new("UIStroke", b)
    bstroke.Thickness = 1
    bstroke.Color = Color3.fromRGB(232, 196, 102)
    bstroke.Transparency = 0.5
    return b
end
local FlyUpBtn = makeFlyBtn("▲")
local FlyDownBtn = makeFlyBtn("▼")
FlyUpBtn.InputBegan:Connect(function(io)
    if io.UserInputType == Enum.UserInputType.MouseButton1 or io.UserInputType == Enum.UserInputType.Touch then
        State.FlyUp = true
    end
end)
FlyUpBtn.InputEnded:Connect(function(io)
    if io.UserInputType == Enum.UserInputType.MouseButton1 or io.UserInputType == Enum.UserInputType.Touch then
        State.FlyUp = false
    end
end)
FlyDownBtn.InputBegan:Connect(function(io)
    if io.UserInputType == Enum.UserInputType.MouseButton1 or io.UserInputType == Enum.UserInputType.Touch then
        State.FlyDown = true
    end
end)
FlyDownBtn.InputEnded:Connect(function(io)
    if io.UserInputType == Enum.UserInputType.MouseButton1 or io.UserInputType == Enum.UserInputType.Touch then
        State.FlyDown = false
    end
end)

-- =========================================================
-- state + command registry
-- =========================================================

State = {
    Flying = false, FlySpeed = 60, FlyUp = false, FlyDown = false,
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
    TrollDelay = 0, -- delay between bang/troll ticks — settable from the Delay box above TROLL in ;cmds
    TrollSpeed = 20, -- how fast bang/backbang/facebang oscillate front-back — Speed box next to Delay
    BangAnimTrack = nil,
    CurrentMove = nil, MoveTarget = nil, MoveAngle = 0,
    HiddenGui = false,
    KickedPlayers = {},
    HijackEnabled = true,
    Favorites = {},
    SoundEnabled = true,
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

-- own body gets anchored + non-collide while trolling so gravity/physics
-- can't knock you sideways or topple you over fighting the CFrame — this
-- is what was making bang/sit modes fall over instead of staying upright
local function zzSetTrollPhysics(on)
    local char = getChar()
    local root = getRoot()
    if root then root.Anchored = on end
    if char then
        for _, d in ipairs(char:GetDescendants()) do
            if d:IsA("BasePart") then d.CanCollide = not on end
        end
    end
end

local function startTroll(mode, args)
    local t = findPlayer(args[1])
    if not t then setStatus("Player not found", true) return end
    State.CurrentTroll = mode
    State.TrollTarget = t
    zzSetTrollPhysics(true)
    -- emote only plays for backbang now
    if mode == "backbang" then
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
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 1.8 + math.sin(tick() * State.TrollSpeed) * 0.3)
                elseif mode == "backbang" and tRoot then
                    -- stuck right behind them, oscillating in/out
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 0, -(1.5 + math.sin(tick() * State.TrollSpeed) * 0.3))
                elseif mode == "facebang" and tHead then
                    -- right on their mouth, oscillating in/out — at 0 delay
                    -- this stays locked on the mouth and just swings
                    -- front-back at Speed
                    root.CFrame = tHead.CFrame * CFrame.new(0, 0, -(0.6 + math.sin(tick() * State.TrollSpeed) * 0.25)) * CFrame.Angles(0, math.pi, 0)
                elseif mode == "headsit" and tHead then
                    local hum = getHum()
                    if hum then hum.Sit = true end
                    root.CFrame = tHead.CFrame * CFrame.new(0, 1, 0)
                elseif mode == "frontsit" and tHead then
                    local hum = getHum()
                    if hum then hum.Sit = true end
                    root.CFrame = tHead.CFrame * CFrame.new(0, 0.5, -1.6) * CFrame.Angles(0, math.pi, 0)
                elseif mode == "annoy" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(math.random(-4, 4), math.random(-2, 4), math.random(-4, 4))
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
        zzSetTrollPhysics(false)
    end)
    setStatus("Trolling " .. t.Name .. " (" .. mode .. ")")
end

register("bang", "bang [player] — bump into them, front", function(args) startTroll("bang", args) end)
register("backbang", "backbang [player] — bump from behind (plays the real bang emote)", function(args) startTroll("backbang", args) end)
register("facebang", "facebang [player] — right on their mouth, oscillating", function(args) startTroll("facebang", args) end)
register("headsit", "headsit [player] — sit on a player's head", function(args) startTroll("headsit", args) end)
register("frontsit", "frontsit [player] — sit facing them", function(args) startTroll("frontsit", args) end)
register("annoy", "annoy [player] — teleport-spam near a player", function(args) startTroll("annoy", args) end)

register("fling", "fling [player] — (local-only) makes it look like they got flung into the sky", function(args)
    local t = findPlayer(args[1])
    if not t then setStatus("Player not found", true) return end
    State.CurrentTroll = "fling"
    State.TrollTarget = t
    local startTime = tick()
    local basePos = nil
    task.spawn(function()
        while State.CurrentTroll == "fling" and State.TrollTarget == t do
            local tChar = t.Character
            local tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
            if tRoot then
                if not basePos then basePos = tRoot.Position end
                local elapsed = tick() - startTime
                local height = (elapsed * 30) % 160 -- loops back down for a continuous launch look
                tRoot.CFrame = CFrame.new(basePos.X, basePos.Y + height, basePos.Z)
                    * CFrame.Angles(math.rad(elapsed * 300), math.rad(elapsed * 180), math.rad(elapsed * 260))
            else
                basePos = nil
            end
            if State.TrollDelay and State.TrollDelay > 0 then
                task.wait(State.TrollDelay)
            else
                RunService.RenderStepped:Wait()
            end
        end
    end)
    setStatus("Flinging " .. t.Name .. " into the sky (local-only visual)")
end)

-- ---- movement (local-only, orbit/spiral/hover/follow-style) ----
-- 10 distinct movement patterns that circle/trail the target instead of
-- bumping into them — own body doesn't collide with theirs while active
local isMoveMode = {
    orbit = true, spiral = true, hover = true, drift = true, pendulum = true,
    wiggle = true, zigzagwalk = true, bounce = true, circlerun = true,
}

local function startMove(mode, args)
    local t = findPlayer(args[1])
    if not t then setStatus("Player not found", true) return end
    State.CurrentMove = mode
    State.MoveTarget = t
    State.MoveAngle = 0
    task.spawn(function()
        while State.CurrentMove == mode and State.MoveTarget == t do
            local root = getRoot()
            local char = Players.LocalPlayer.Character
            local tChar = t.Character
            local tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")
            if root and tRoot then
                State.MoveAngle = State.MoveAngle + 0.08
                local tpos = tRoot.Position
                local a = State.MoveAngle

                -- own body shouldn't collide with theirs while moving around them
                if char then
                    for _, d in ipairs(char:GetChildren()) do
                        if d:IsA("BasePart") then d.CanCollide = false end
                    end
                end
                -- don't fight the orbit with leftover push/fling velocity
                pcall(function()
                    root.AssemblyLinearVelocity = Vector3.zero
                    root.AssemblyAngularVelocity = Vector3.zero
                end)

                if mode == "orbit" then
                    local pos = tpos + Vector3.new(math.cos(a), 0, math.sin(a)) * 6
                    root.CFrame = CFrame.lookAt(pos, Vector3.new(tpos.X, pos.Y, tpos.Z))
                elseif mode == "spiral" then
                    local r = 2 + 4 * (0.5 + 0.5 * math.sin(a * 0.4))
                    local y = 2 + math.sin(a * 0.6) * 3
                    local pos = tpos + Vector3.new(math.cos(a), 0, math.sin(a)) * r + Vector3.new(0, y, 0)
                    root.CFrame = CFrame.lookAt(pos, tpos)
                elseif mode == "hover" then
                    local pos = tpos + Vector3.new(0, 6 + math.sin(a) * 1.5, 0)
                    root.CFrame = CFrame.new(pos) * CFrame.Angles(0, a * 1.5, 0)
                elseif mode == "drift" then
                    local pos = tpos + Vector3.new(math.cos(a * 0.3), 0, math.sin(a * 0.3)) * 10
                    root.CFrame = CFrame.lookAt(pos, tpos)
                elseif mode == "pendulum" then
                    local swing = math.sin(a * 1.5) * 4
                    local pos = tpos + Vector3.new(swing, 1.5, -3)
                    root.CFrame = CFrame.lookAt(pos, tpos)
                elseif mode == "wiggle" then
                    local pos = tpos + Vector3.new(math.sin(a * 6) * 1.2, 0, 2.2)
                    root.CFrame = CFrame.lookAt(pos, tpos)
                elseif mode == "zigzagwalk" then
                    local pos = tpos + Vector3.new(math.sin(a * 2.5) * 3, 0, math.cos(a * 1.2) * 3 + 2)
                    root.CFrame = CFrame.lookAt(pos, tpos)
                elseif mode == "bounce" then
                    local pos = tpos + Vector3.new(2.5, math.abs(math.sin(a * 2)) * 4, 0)
                    root.CFrame = CFrame.lookAt(pos, tpos)
                elseif mode == "circlerun" then
                    local pos = tpos + Vector3.new(math.cos(a * 3), 0, math.sin(a * 3)) * 3
                    root.CFrame = CFrame.lookAt(pos, Vector3.new(tpos.X, pos.Y, tpos.Z))
                end
            end
            RunService.Heartbeat:Wait()
        end
        local char = Players.LocalPlayer.Character
        if char then
            for _, d in ipairs(char:GetChildren()) do
                if d:IsA("BasePart") then d.CanCollide = true end
            end
        end
    end)
    setStatus("Moving on " .. t.Name .. " (" .. mode .. ")")
end

register("orbit", "orbit [player] — circle fully around them", function(args) startMove("orbit", args) end)
register("spiral", "spiral [player] — spiral in and out around them", function(args) startMove("spiral", args) end)
register("hover", "hover [player] — hover spinning above them", function(args) startMove("hover", args) end)
register("drift", "drift [player] — slow wide drifting circle", function(args) startMove("drift", args) end)
register("pendulum", "pendulum [player] — swing side to side in front", function(args) startMove("pendulum", args) end)
register("wiggle", "wiggle [player] — fast side-to-side wiggle near them", function(args) startMove("wiggle", args) end)
register("zigzagwalk", "zigzagwalk [player] — zigzag path around them", function(args) startMove("zigzagwalk", args) end)
register("bounce", "bounce [player] — bounce up and down beside them", function(args) startMove("bounce", args) end)
register("circlerun", "circlerun [player] — tight fast circles at their feet", function(args) startMove("circlerun", args) end)
register("follow2", "follow2 [player] — smoothly glide behind them as they move", function(args) startMove("drift", args) end)

register("stoptroll", "stoptroll — stop all troll/movement modes", function()
    State.CurrentTroll = nil
    State.TrollTarget = nil
    State.CurrentMove = nil
    State.MoveTarget = nil
    local hum = getHum()
    if hum then hum.Sit = false end
    if State.BangAnimTrack then
        State.BangAnimTrack:Stop()
        State.BangAnimTrack = nil
    end
    local root = getRoot()
    if root then root.Anchored = false end
    local char = Players.LocalPlayer.Character
    if char then
        for _, d in ipairs(char:GetDescendants()) do
            if d:IsA("BasePart") then d.CanCollide = true end
        end
    end
    setStatus("Troll stopped")
end)

-- ---- a few extra useful commands ----
register("hidegui", "hidegui — hide the Roblox CoreGui (chat/backpack/etc)", function()
    pcall(function()
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    end)
    State.HiddenGui = true
    setStatus("CoreGui hidden")
end)
register("showgui", "showgui — show the Roblox CoreGui again", function()
    pcall(function()
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
    end)
    State.HiddenGui = false
    setStatus("CoreGui shown")
end)
register("viewdistance", "viewdistance [n] — set render distance in studs", function(args)
    local n = tonumber(args[1])
    if not n then setStatus("Usage: viewdistance <studs>", true) return end
    pcall(function()
        workspace.StreamingTargetRadius = n
    end)
    setStatus("View distance set to " .. n)
end)
register("lowgraphics", "lowgraphics — turn off shadows/particles for smoother play", function()
    Lighting.GlobalShadows = false
    for _, p in ipairs(workspace:GetDescendants()) do
        if p:IsA("ParticleEmitter") or p:IsA("Smoke") or p:IsA("Fire") or p:IsA("Sparkles") then
            p.Enabled = false
        end
    end
    setStatus("Low graphics mode ON")
end)
register("highgraphics", "highgraphics — restore shadows/particles", function()
    Lighting.GlobalShadows = true
    for _, p in ipairs(workspace:GetDescendants()) do
        if p:IsA("ParticleEmitter") or p:IsA("Smoke") or p:IsA("Fire") or p:IsA("Sparkles") then
            p.Enabled = true
        end
    end
    setStatus("Low graphics mode OFF")
end)
register("copyme", "copyme [player] — copy a player's character appearance onto yourself", function(args)
    local t = findPlayer(args[1])
    if not t then setStatus("Player not found", true) return end
    local plr = Players.LocalPlayer
    pcall(function()
        plr:LoadCharacterWithHumanoidDescription(
            game:GetService("Players"):GetHumanoidDescriptionFromUserId(t.UserId)
        )
    end)
    setStatus("Copied " .. t.Name .. "'s appearance")
end)

-- ---- Infinite-Yield-style alias manager (make your OWN shortcuts at
-- runtime, on top of the 199 built-in ones) ----
State.CustomAliases = State.CustomAliases or {}
register("addalias", "addalias [cmd] [alias] — make a new shortcut for a command", function(args)
    local cmdName, aliasName = args[1], args[2]
    if not cmdName or not aliasName then setStatus("Usage: addalias <cmd> <alias>", true) return end
    local c = commands[cmdName]
    if not c then setStatus("No such command: " .. cmdName, true) return end
    commands[aliasName] = { desc = nil, run = c.run }
    State.CustomAliases[aliasName] = cmdName
    setStatus(aliasName .. " -> " .. cmdName)
end)
register("removealias", "removealias [alias] — remove a shortcut you made", function(args)
    local aliasName = args[1]
    if aliasName and State.CustomAliases[aliasName] then
        commands[aliasName] = nil
        State.CustomAliases[aliasName] = nil
        setStatus("Removed alias " .. aliasName)
    else
        setStatus("Not a custom alias", true)
    end
end)
register("clraliases", "clraliases — remove every shortcut you made", function()
    for a, _ in pairs(State.CustomAliases) do
        commands[a] = nil
    end
    State.CustomAliases = {}
    setStatus("Cleared your custom aliases")
end)

-- ---- plugin packs (local feature bundles you can switch on/off by name —
-- NOT a remote-code loader: we won't loadstring/HttpGet some random link
-- just because a button is pressed, that's how backdoors get in. these
-- are real bundled toggles, same ;plugin <name> UX as Infinite Yield) ----
State.ActivePlugins = State.ActivePlugins or {}
local Plugins = {
    espplus = {
        on = function() commands["esp"].run({}) end,
        off = function() commands["unesp"].run({}) end,
    },
    trollpack = {
        on = function() setStatus("trollpack ready — use ;bang ;backbang ;facebang etc") end,
        off = function() commands["stoptroll"].run({}) end,
    },
    campack = {
        on = function() commands["freecam"].run({}) end,
        off = function() commands["freecam"].run({}) end,
    },
    shieldpack = {
        on = function()
            for _, n in ipairs({ "antifling", "antivoid", "antifire", "antiragdoll", "antidamage" }) do
                if commands[n] then commands[n].run({}) end
            end
        end,
        off = function()
            for _, n in ipairs({ "antifling", "antivoid", "antifire", "antiragdoll", "antidamage" }) do
                if commands["un" .. n] then commands["un" .. n].run({}) end
            end
        end,
    },
}
local function runPlugin(name)
    local p = Plugins[name]
    if not p then setStatus("No plugin named " .. tostring(name) .. " (try: espplus, trollpack, campack, shieldpack)", true) return end
    p.on()
    State.ActivePlugins[name] = true
    setStatus("Plugin loaded: " .. name)
end
register("addplugin", "addplugin [name] — load a bundled plugin pack", function(args) runPlugin(args[1]) end)
register("plugin", "plugin [name] — load a bundled plugin pack", function(args) runPlugin(args[1]) end)
register("removeplugin", "removeplugin [name] — unload a plugin pack", function(args)
    local name = args[1]
    local p = Plugins[name]
    if p and State.ActivePlugins[name] then
        p.off()
        State.ActivePlugins[name] = nil
        setStatus("Plugin unloaded: " .. name)
    else
        setStatus("That plugin isn't loaded", true)
    end
end)
register("deleteplugin", "deleteplugin [name] — unload a plugin pack", function(args) commands["removeplugin"].run(args) end)
register("reloadplugin", "reloadplugin [name] — unload then reload a plugin pack", function(args)
    local name = args[1]
    if Plugins[name] then
        if State.ActivePlugins[name] then Plugins[name].off() end
        runPlugin(name)
    else
        setStatus("No such plugin", true)
    end
end)
register("addallplugins", "addallplugins — load every bundled plugin pack", function()
    for name, _ in pairs(Plugins) do runPlugin(name) end
end)
register("loadallplugins", "loadallplugins — load every bundled plugin pack", function() commands["addallplugins"].run({}) end)
register("listplugins", "listplugins — show available plugin pack names", function()
    local names = {}
    for n, _ in pairs(Plugins) do table.insert(names, n) end
    setStatus("Plugins: " .. table.concat(names, ", "))
end)

-- ---- bang/backbang/facebang oscillation speed — separate from Delay.
-- Delay = how long between position updates (0 = every frame, smoothest).
-- Speed = how fast the front-back oscillation itself swings once it's
-- updating — at Delay 0 it stays locked on the mouth/body and just swings
-- front-back at whatever Speed is set to.
register("trollspeed", "trollspeed [n] — oscillation speed for bang/backbang/facebang (default 20)", function(args)
    local n = tonumber(args[1])
    if not n then setStatus("Troll speed: " .. State.TrollSpeed, false) return end
    State.TrollSpeed = n
    setStatus("Troll speed set to " .. n)
end)

-- ---- 100 more useful commands ----
local zzLoadTime = tick()

-- info / debug (real Roblox properties, nothing faked)
register("age", "age [player] — show their Roblox account age in days", function(args)
    local t = findPlayer(args[1]) or Players.LocalPlayer
    setStatus(t.Name .. " account age: " .. t.AccountAge .. " days")
end)
register("accountage", "accountage [player] — alias of age", function(args) commands["age"].run(args) end)
register("gameid", "gameid — show this game's GameId", function() setStatus("GameId: " .. tostring(game.GameId)) end)
register("placeid", "placeid — show this place's PlaceId", function() setStatus("PlaceId: " .. tostring(game.PlaceId)) end)
register("jobid", "jobid — show this server's JobId", function() setStatus("JobId: " .. tostring(game.JobId)) end)
register("version", "version — show the script version", function() setStatus("ZZ YIELD v1.0") end)
register("credits", "credits — who made this", function() setStatus("ZZ YIELD — made for AAYAN") end)
register("myid", "myid — show your own UserId", function() setStatus("UserId: " .. tostring(Players.LocalPlayer.UserId)) end)
register("displayname", "displayname [player] — show their display name", function(args)
    local t = findPlayer(args[1]) or Players.LocalPlayer
    setStatus(t.DisplayName)
end)
register("membership", "membership [player] — show Premium/BC status", function(args)
    local t = findPlayer(args[1]) or Players.LocalPlayer
    setStatus(t.Name .. ": " .. tostring(t.MembershipType))
end)
register("playercount", "playercount — how many players are in the server", function()
    setStatus(#Players:GetPlayers() .. " players in server")
end)
register("uptime", "uptime — how long ZZ YIELD has been loaded", function()
    setStatus(math.floor(tick() - zzLoadTime) .. "s since load")
end)
register("ismobile", "ismobile — check if you're on a touch device", function()
    setStatus(UserInputService.TouchEnabled and "Touch device" or "Not a touch device")
end)

-- humanoid properties
register("hipheight", "hipheight [n] — raise/lower how high you stand", function(args)
    local hum = getHum()
    local n = tonumber(args[1])
    if hum and n then hum.HipHeight = n setStatus("HipHeight: " .. n) end
end)
register("resethipheight", "resethipheight — back to default standing height", function()
    local hum = getHum()
    if hum then hum.HipHeight = 0 setStatus("HipHeight reset") end
end)
register("autorotateoff", "autorotateoff — stop auto-facing your movement direction", function()
    local hum = getHum()
    if hum then hum.AutoRotate = false setStatus("AutoRotate OFF") end
end)
register("autorotateon", "autorotateon — resume auto-facing your movement direction", function()
    local hum = getHum()
    if hum then hum.AutoRotate = true setStatus("AutoRotate ON") end
end)
register("maxslope", "maxslope [deg] — steepest slope you can walk up", function(args)
    local hum = getHum()
    local n = tonumber(args[1])
    if hum and n then hum.MaxSlopeAngle = n setStatus("MaxSlopeAngle: " .. n) end
end)
register("resetmaxslope", "resetmaxslope — back to default slope limit", function()
    local hum = getHum()
    if hum then hum.MaxSlopeAngle = 89 setStatus("MaxSlopeAngle reset") end
end)
register("namedisplay", "namedisplay [studs] — distance your nametag is visible from", function(args)
    local hum = getHum()
    local n = tonumber(args[1])
    if hum and n then hum.NameDisplayDistance = n setStatus("NameDisplayDistance: " .. n) end
end)
register("healthdisplay", "healthdisplay [studs] — distance your healthbar is visible from", function(args)
    local hum = getHum()
    local n = tonumber(args[1])
    if hum and n then hum.HealthDisplayDistance = n setStatus("HealthDisplayDistance: " .. n) end
end)
register("hidenametag", "hidenametag — hide your own nametag from everyone", function()
    local hum = getHum()
    if hum then hum.NameDisplayDistance = 0 setStatus("Nametag hidden") end
end)
register("hidehealthbar", "hidehealthbar — hide your own healthbar from everyone", function()
    local hum = getHum()
    if hum then hum.HealthDisplayDistance = 0 setStatus("Healthbar hidden") end
end)

-- camera
register("fixcam", "fixcam — reset a broken/stuck camera", function()
    local cam = workspace.CurrentCamera
    cam.CameraType = Enum.CameraType.Custom
    local hum = getHum()
    if hum then cam.CameraSubject = hum end
    setStatus("Camera fixed")
end)
register("cmdbar", "cmdbar — show/hide the command bar", function()
    Bar.Visible = not Bar.Visible
    setStatus(Bar.Visible and "Command bar shown" or "Command bar hidden (;cmdbar to bring back)")
end)
register("maxzoom", "maxzoom [n] — furthest your camera can zoom out", function(args)
    local n = tonumber(args[1])
    if n then Players.LocalPlayer.CameraMaxZoomDistance = n setStatus("Max zoom: " .. n) end
end)
register("minzoom", "minzoom [n] — closest your camera can zoom in", function(args)
    local n = tonumber(args[1])
    if n then Players.LocalPlayer.CameraMinZoomDistance = n setStatus("Min zoom: " .. n) end
end)
register("resetzoom", "resetzoom — restore default zoom limits", function()
    Players.LocalPlayer.CameraMaxZoomDistance = 400
    Players.LocalPlayer.CameraMinZoomDistance = 0.5
    setStatus("Zoom limits reset")
end)
register("lockcam", "lockcam — freeze the camera exactly where it is", function()
    local cam = workspace.CurrentCamera
    State.CamLockCFrame = cam.CFrame
    State.CamLocked = true
    cam.CameraType = Enum.CameraType.Scriptable
    setStatus("Camera locked")
end)
register("unlockcam", "unlockcam — unfreeze the camera", function()
    State.CamLocked = false
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    setStatus("Camera unlocked")
end)
register("mouselock", "mouselock — lock your mouse to the screen center", function()
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    setStatus("Mouse locked")
end)
register("unmouselock", "unmouselock — free your mouse again", function()
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    setStatus("Mouse unlocked")
end)

-- character cosmetic (local-only visuals, same category as the rest of
-- this script — only changes what things look like on your own client)
register("drophats", "drophats — remove your own hats/accessories (local)", function()
    local char = getChar()
    if not char then return end
    for _, a in ipairs(char:GetChildren()) do
        if a:IsA("Accessory") then a:Destroy() end
    end
    setStatus("Hats dropped (local)")
end)
register("removetools", "removetools — clear every tool from your backpack", function()
    local plr = Players.LocalPlayer
    local bp = plr:FindFirstChild("Backpack")
    if bp then for _, tool in ipairs(bp:GetChildren()) do tool:Destroy() end end
    setStatus("Tools removed")
end)
register("droptool", "droptool — unequip whatever tool you're holding", function()
    local char = getChar()
    if not char then return end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") then tool.Parent = Players.LocalPlayer:FindFirstChild("Backpack") or tool.Parent end
    end
    setStatus("Tool unequipped")
end)
register("fullinvis", "fullinvis — fully invisible to yourself (local)", function()
    local char = getChar()
    if not char then return end
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") then d.LocalTransparencyModifier = 1
        elseif d:IsA("Decal") then d.LocalTransparencyModifier = 1 end
    end
    setStatus("Fully invisible (local)")
end)
register("unfullinvis", "unfullinvis — undo fullinvis", function()
    local char = getChar()
    if not char then return end
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") then d.LocalTransparencyModifier = 0
        elseif d:IsA("Decal") then d.LocalTransparencyModifier = 0 end
    end
    setStatus("Visible again")
end)
register("noshirt", "noshirt — remove your shirt (local)", function()
    local char = getChar()
    local s = char and char:FindFirstChildOfClass("Shirt")
    if s then s:Destroy() setStatus("Shirt removed") end
end)
register("nopants", "nopants — remove your pants (local)", function()
    local char = getChar()
    local p = char and char:FindFirstChildOfClass("Pants")
    if p then p:Destroy() setStatus("Pants removed") end
end)
register("randomcolors", "randomcolors — random body colors", function()
    local char = getChar()
    local bc = char and char:FindFirstChildOfClass("BodyColors")
    if bc then
        local function rc() return BrickColor.random() end
        bc.HeadColor = rc() bc.TorsoColor = rc() bc.LeftArmColor = rc()
        bc.RightArmColor = rc() bc.LeftLegColor = rc() bc.RightLegColor = rc()
        setStatus("Random body colors")
    end
end)
register("headsize", "headsize [n] — scale your head up/down", function(args)
    local char = getChar()
    local head = char and char:FindFirstChild("Head")
    local n = tonumber(args[1])
    if head and n then head.Size = Vector3.new(n, n, n) setStatus("Head size: " .. n) end
end)
register("resetheadsize", "resetheadsize — back to normal head size", function()
    local char = getChar()
    local head = char and char:FindFirstChild("Head")
    if head then head.Size = Vector3.new(2, 1, 1) setStatus("Head size reset") end
end)
register("transparencyself", "transparencyself [0-1] — fade yourself out (local)", function(args)
    local n = tonumber(args[1])
    local char = getChar()
    if char and n then
        for _, d in ipairs(char:GetDescendants()) do
            if d:IsA("BasePart") then d.LocalTransparencyModifier = n end
        end
        setStatus("Transparency: " .. n)
    end
end)

-- social / chat
register("say", "say [msg] — make a local chat bubble over your head", function(args)
    local msg = table.concat(args, " ")
    local char = getChar()
    local head = char and char:FindFirstChild("Head")
    if head and msg ~= "" then
        pcall(function() game:GetService("Chat"):Chat(head, msg, Enum.ChatColor.White) end)
        setStatus("Said: " .. msg)
    end
end)
register("whisper", "whisper [player] [msg] — say something only you'll see tagged to them (local note)", function(args)
    local t = findPlayer(args[1])
    if not t then setStatus("Player not found", true) return end
    local msg = table.concat(args, " ", 2)
    setStatus("(to " .. t.Name .. ") " .. msg)
end)
register("friendcheck", "friendcheck [player] — check if you're friends with them", function(args)
    local t = findPlayer(args[1])
    if not t then setStatus("Player not found", true) return end
    local ok, isFriend = pcall(function() return Players.LocalPlayer:IsFriendsWith(t.UserId) end)
    setStatus(ok and (isFriend and "You ARE friends with " .. t.Name or "Not friends with " .. t.Name) or "Couldn't check", not ok)
end)

-- quick presets (one-tap shortcuts for the most common settings)
register("speed16", "speed16 — default walkspeed", function() commands["speed"].run({ "16" }) end)
register("speed50", "speed50 — fast walkspeed", function() commands["speed"].run({ "50" }) end)
register("speed100", "speed100 — very fast walkspeed", function() commands["speed"].run({ "100" }) end)
register("speed200", "speed200 — extreme walkspeed", function() commands["speed"].run({ "200" }) end)
register("jump50", "jump50 — default jump power", function() commands["jumppower"].run({ "50" }) end)
register("jump100", "jump100 — high jump", function() commands["jumppower"].run({ "100" }) end)
register("jump200", "jump200 — extreme jump", function() commands["jumppower"].run({ "200" }) end)
register("resetjumppower", "resetjumppower — back to default jump power", function() commands["jumppower"].run({ "50" }) end)
register("fov30", "fov30 — narrow FOV", function() commands["fov"].run({ "30" }) end)
register("fov50", "fov50 — default-ish FOV", function() commands["fov"].run({ "50" }) end)
register("fov70", "fov70 — default FOV", function() commands["fov"].run({ "70" }) end)
register("fov90", "fov90 — wide FOV", function() commands["fov"].run({ "90" }) end)
register("fov120", "fov120 — extreme wide FOV", function() commands["fov"].run({ "120" }) end)
register("savepos2", "savepos2 — save position to slot 2", function()
    local root = getRoot()
    if root then State.SavedPos2 = root.CFrame setStatus("Saved pos slot 2") end
end)
register("loadpos2", "loadpos2 — teleport to saved slot 2", function()
    local root = getRoot()
    if root and State.SavedPos2 then root.CFrame = State.SavedPos2 setStatus("Loaded pos slot 2") end
end)
register("savepos3", "savepos3 — save position to slot 3", function()
    local root = getRoot()
    if root then State.SavedPos3 = root.CFrame setStatus("Saved pos slot 3") end
end)
register("loadpos3", "loadpos3 — teleport to saved slot 3", function()
    local root = getRoot()
    if root and State.SavedPos3 then root.CFrame = State.SavedPos3 setStatus("Loaded pos slot 3") end
end)

-- lighting mood presets (each sets several Lighting properties at once)
register("lightmode1", "lightmode1 — bright sunny preset", function()
    Lighting.Brightness = 2 Lighting.ClockTime = 14 Lighting.FogEnd = 100000
    Lighting.Ambient = Color3.fromRGB(150, 150, 150)
    setStatus("Lighting: sunny")
end)
register("lightmode2", "lightmode2 — warm sunset preset", function()
    Lighting.Brightness = 1.2 Lighting.ClockTime = 18 Lighting.FogEnd = 1500
    Lighting.Ambient = Color3.fromRGB(120, 90, 70)
    setStatus("Lighting: sunset")
end)
register("lightmode3", "lightmode3 — dark night preset", function()
    Lighting.Brightness = 0.3 Lighting.ClockTime = 0 Lighting.FogEnd = 300
    Lighting.Ambient = Color3.fromRGB(20, 20, 30)
    setStatus("Lighting: night")
end)
register("lightmode4", "lightmode4 — foggy horror preset", function()
    Lighting.Brightness = 0.5 Lighting.FogEnd = 60 Lighting.FogColor = Color3.fromRGB(40, 40, 40)
    Lighting.Ambient = Color3.fromRGB(10, 10, 10)
    setStatus("Lighting: horror fog")
end)
register("lightmode5", "lightmode5 — neon rave preset", function()
    Lighting.Brightness = 1 Lighting.ClockTime = 0 Lighting.FogEnd = 100000
    Lighting.Ambient = Color3.fromRGB(80, 0, 120)
    setStatus("Lighting: neon rave")
end)

-- movement tweaks
register("dash", "dash — quick burst of speed in the direction you're facing", function()
    local root = getRoot()
    if root then
        pcall(function() root.AssemblyLinearVelocity = root.CFrame.LookVector * 90 + Vector3.new(0, 10, 0) end)
        setStatus("Dash!")
    end
end)
register("superjump", "superjump — one really high jump", function()
    local hum = getHum()
    local root = getRoot()
    if hum and root then
        pcall(function() root.AssemblyLinearVelocity = Vector3.new(0, 120, 0) end)
        setStatus("Super jump!")
    end
end)
register("crouch", "crouch — lower your stance and slow down", function()
    local hum = getHum()
    if hum then
        State.PreCrouchSpeed = hum.WalkSpeed
        hum.HipHeight = -1
        hum.WalkSpeed = math.max(4, hum.WalkSpeed * 0.4)
        setStatus("Crouching")
    end
end)
register("uncrouch", "uncrouch — stand back up", function()
    local hum = getHum()
    if hum then
        hum.HipHeight = 0
        hum.WalkSpeed = State.PreCrouchSpeed or State.DefaultSpeed
        setStatus("Standing")
    end
end)
register("sprint", "sprint — temporary speed boost", function()
    local hum = getHum()
    if hum then
        State.PreSprintSpeed = hum.WalkSpeed
        hum.WalkSpeed = (State.PreSprintSpeed or 16) * 2
        setStatus("Sprinting")
    end
end)
register("unsprint", "unsprint — back to normal speed", function()
    local hum = getHum()
    if hum then
        hum.WalkSpeed = State.PreSprintSpeed or State.DefaultSpeed
        setStatus("Sprint off")
    end
end)

-- misc
register("topview", "topview — bird's-eye camera view", function()
    local cam = workspace.CurrentCamera
    local root = getRoot()
    if root then
        cam.CameraType = Enum.CameraType.Scriptable
        cam.CFrame = CFrame.new(root.Position + Vector3.new(0, 40, 0), root.Position)
        setStatus("Top-down view (;fixcam to undo)")
    end
end)
register("selfcheck", "selfcheck — quick status readout (health/speed/position)", function()
    local hum = getHum()
    local root = getRoot()
    if hum and root then
        local p = root.Position
        setStatus(string.format("HP %d/%d  WS %d  Pos %.0f,%.0f,%.0f", hum.Health, hum.MaxHealth, hum.WalkSpeed, p.X, p.Y, p.Z))
    end
end)
register("pos", "pos — show your current position", function()
    local root = getRoot()
    if root then
        local p = root.Position
        setStatus(string.format("%.1f, %.1f, %.1f", p.X, p.Y, p.Z))
    end
end)
register("distanceto", "distanceto [player] — how far away someone is", function(args)
    local t = findPlayer(args[1])
    local root = getRoot()
    local tRoot = t and t.Character and t.Character:FindFirstChild("HumanoidRootPart")
    if root and tRoot then
        setStatus(string.format("%.0f studs from %s", (root.Position - tRoot.Position).Magnitude, t.Name))
    else
        setStatus("Player not found", true)
    end
end)
register("lookat", "lookat [player] — point your camera at someone", function(args)
    local t = findPlayer(args[1])
    local tRoot = t and t.Character and t.Character:FindFirstChild("HumanoidRootPart")
    local cam = workspace.CurrentCamera
    if tRoot then
        cam.CameraType = Enum.CameraType.Scriptable
        cam.CFrame = CFrame.lookAt(cam.CFrame.Position, tRoot.Position)
        setStatus("Looking at " .. t.Name .. " (;fixcam to undo)")
    else
        setStatus("Player not found", true)
    end
end)
register("listplayers", "listplayers — list everyone in the server", function()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do table.insert(names, p.Name) end
    setStatus(table.concat(names, ", "))
end)
register("maxplayers", "maxplayers — this server's player cap", function()
    setStatus("Max players: " .. tostring(Players.MaxPlayers))
end)
register("serverfull", "serverfull — check if the server is at capacity", function()
    local full = #Players:GetPlayers() >= Players.MaxPlayers
    setStatus(full and "Server is FULL" or "Server has space")
end)
register("flyspeed", "flyspeed [n] — set fly speed", function(args)
    local n = tonumber(args[1])
    if n then State.FlySpeed = n setStatus("Fly speed: " .. n) end
end)
register("resetflyspeed", "resetflyspeed — back to default fly speed (60)", function()
    State.FlySpeed = 60
    setStatus("Fly speed reset")
end)
register("teamcheck", "teamcheck [player] — show their team", function(args)
    local t = findPlayer(args[1]) or Players.LocalPlayer
    setStatus(t.Name .. " team: " .. (t.Team and t.Team.Name or "none"))
end)
register("resetcamsubject", "resetcamsubject — point the camera back at yourself", function()
    local hum = getHum()
    if hum then workspace.CurrentCamera.CameraSubject = hum setStatus("Camera subject reset") end
end)
register("walkspeedof", "walkspeedof [player] — show someone's walkspeed", function(args)
    local t = findPlayer(args[1])
    local hum = t and t.Character and t.Character:FindFirstChildOfClass("Humanoid")
    if hum then setStatus(t.Name .. " WalkSpeed: " .. hum.WalkSpeed) else setStatus("Player not found", true) end
end)
register("healthof", "healthof [player] — show someone's health", function(args)
    local t = findPlayer(args[1])
    local hum = t and t.Character and t.Character:FindFirstChildOfClass("Humanoid")
    if hum then setStatus(t.Name .. " HP: " .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth)) else setStatus("Player not found", true) end
end)
register("shownametag", "shownametag — undo hidenametag", function()
    local hum = getHum()
    if hum then hum.NameDisplayDistance = 100 setStatus("Nametag shown") end
end)
register("showhealthbar", "showhealthbar — undo hidehealthbar", function()
    local hum = getHum()
    if hum then hum.HealthDisplayDistance = 100 setStatus("Healthbar shown") end
end)

-- ---- chat hijack toggle (privacy — some people don't want real Roblox
-- chat able to trigger commands, since typing it briefly shows in the box) ----
register("togglehijack", "togglehijack — turn real-chat command hijack on/off", function()
    State.HijackEnabled = not State.HijackEnabled
    setStatus("Chat hijack: " .. (State.HijackEnabled and "ON" or "OFF (command bar still works)"))
end)

-- ---- serverhop — jump to a different server of the same game ----
register("serverhop", "serverhop — teleport to a different server of this game", function()
    local ok, err = pcall(function()
        local tps = game:GetService("TeleportService")
        tps:Teleport(game.PlaceId, Players.LocalPlayer)
    end)
    if not ok then setStatus("Serverhop failed: " .. tostring(err), true) end
end)

-- ---- config save/load — persists prefix/speed/binds/troll settings
-- between sessions, using the executor's writefile/readfile if it has
-- them. Safe: local file on your own device, nothing remote. ----
local ZZ_CONFIG_FILE = "zz_yield_config.json"
local function zzHasFileIO()
    return typeof(writefile) == "function" and typeof(readfile) == "function" and typeof(isfile) == "function"
end
register("saveconfig", "saveconfig — save prefix/speed/binds to a local file", function()
    if not zzHasFileIO() then setStatus("Your executor doesn't support writefile", true) return end
    local data = {
        prefix = prefix,
        flySpeed = State.FlySpeed,
        trollDelay = State.TrollDelay,
        trollSpeed = State.TrollSpeed,
        binds = KeyBinds,
        favorites = State.Favorites,
        soundEnabled = State.SoundEnabled,
        hijackEnabled = State.HijackEnabled,
    }
    local ok, encoded = pcall(function() return game:GetService("HttpService"):JSONEncode(data) end)
    if not ok then setStatus("Couldn't encode config", true) return end
    local writeOk, writeErr = pcall(writefile, ZZ_CONFIG_FILE, encoded)
    if writeOk then setStatus("Config saved") else setStatus("Save failed: " .. tostring(writeErr), true) end
end)
register("loadconfig", "loadconfig — load prefix/speed/binds from the saved file", function()
    if not zzHasFileIO() then setStatus("Your executor doesn't support readfile", true) return end
    local existsOk, exists = pcall(isfile, ZZ_CONFIG_FILE)
    if not existsOk or not exists then setStatus("No saved config yet — use ;saveconfig first", true) return end
    local readOk, content = pcall(readfile, ZZ_CONFIG_FILE)
    if not readOk then setStatus("Couldn't read config file", true) return end
    local decodeOk, data = pcall(function() return game:GetService("HttpService"):JSONDecode(content) end)
    if not decodeOk or type(data) ~= "table" then setStatus("Config file is corrupted", true) return end
    if data.prefix then prefix = data.prefix end
    if data.flySpeed then State.FlySpeed = data.flySpeed end
    if data.trollDelay then State.TrollDelay = data.trollDelay end
    if data.trollSpeed then State.TrollSpeed = data.trollSpeed end
    if data.favorites then
        for c, on in pairs(data.favorites) do
            if on and commands[c] then commands["favorite"].run({ c }) end
        end
    end
    if data.soundEnabled ~= nil then State.SoundEnabled = data.soundEnabled end
    if data.hijackEnabled ~= nil then State.HijackEnabled = data.hijackEnabled end
    if data.binds then
        for k, v in pairs(data.binds) do KeyBinds[k] = v end
        refreshBindsList()
    end
    setStatus("Config loaded")
end)

-- ---- favorites / pinned commands ----
register("favorite", "favorite [cmd] — pin a command to the top of ;cmds", function(args)
    local c = args[1]
    if not c or not commands[c] then setStatus("No such command", true) return end
    if State.Favorites[c] then setStatus(c .. " already pinned") return end
    State.Favorites[c] = true
    local l = Instance.new("TextLabel", ListScroll)
    l.Size = UDim2.new(1, 0, 0, 16)
    l.BackgroundTransparency = 1
    l.Text = prefix .. c
    l.TextColor3 = Color3.fromRGB(232, 196, 102)
    l.Font = Enum.Font.SourceSans
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 51
    l.LayoutOrder = -999
    FavLabels[c] = l
    FavHeader.Visible = true
    setStatus(c .. " pinned to favorites")
end)
register("unfavorite", "unfavorite [cmd] — unpin a command", function(args)
    local c = args[1]
    State.Favorites[c] = nil
    if FavLabels[c] then FavLabels[c]:Destroy() FavLabels[c] = nil end
    local anyLeft = false
    for _ in pairs(State.Favorites) do anyLeft = true break end
    FavHeader.Visible = anyLeft
    setStatus(c .. " unpinned")
end)

-- ---- notification sound — a soft tick whenever the status bar updates ----
zzTickSound = Instance.new("Sound")
zzTickSound.SoundId = "rbxasset://sounds/electronicpingshort.wav"
zzTickSound.Volume = 0.35
zzTickSound.Parent = gui
register("togglesound", "togglesound — turn the status tick sound on/off", function()
    State.SoundEnabled = not State.SoundEnabled
    setStatus("Notification sound: " .. (State.SoundEnabled and "ON" or "OFF"))
end)

-- ---- changelog ----
register("changelog", "changelog — show version history", function()
    setStatus("v1.0 — launch: full command set, troll pack, shields, alias/plugin system, keybinds")
end)

-- ---- raw Lua console — runs code YOU type yourself, locally, nothing
-- fetched from anywhere. Same idea as Infinite Yield's own cmdbar. ----
register("lua", "lua [code] — run your own Lua code locally", function(args)
    local code = table.concat(args, " ")
    if code == "" then setStatus("Usage: lua <code>", true) return end
    local fn, compileErr = loadstring(code)
    if not fn then setStatus("Compile error: " .. tostring(compileErr), true) return end
    local ok, runErr = pcall(fn)
    if ok then setStatus("Lua ran OK") else setStatus("Runtime error: " .. tostring(runErr), true) end
end)

-- ---- kick (local-only — a real cross-server kick isn't possible from a
-- client script; this is the strongest honest version: wipes them
-- completely off YOUR screen — body, name, collision — and keeps them
-- hidden even if they respawn, until you unkick them) ----
State.KickedPlayers = State.KickedPlayers or {}
local function zzApplyKickVisual(char, hidden)
    if not char then return end
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") then
            d.LocalTransparencyModifier = hidden and 1 or 0
            d.CanCollide = not hidden
        elseif d:IsA("Decal") or d:IsA("Texture") then
            d.LocalTransparencyModifier = hidden and 1 or 0
        elseif d:IsA("BillboardGui") or d:IsA("SurfaceGui") then
            d.Enabled = not hidden
        end
    end
end

register("kick", "kick [player] — (local-only) totally removes them from your own screen, like they got kicked", function(args)
    local t = findPlayer(args[1])
    if not t then setStatus("Player not found", true) return end
    if State.KickedPlayers[t] then setStatus(t.Name .. " already kicked (local)", true) return end
    State.KickedPlayers[t] = true
    task.spawn(function()
        while State.KickedPlayers[t] do
            zzApplyKickVisual(t.Character, true)
            RunService.Heartbeat:Wait()
        end
    end)
    setStatus(t.Name .. " kicked from your screen (local-only)")
end)

register("unkick", "unkick [player] — bring a kicked player back on your screen", function(args)
    local t = findPlayer(args[1])
    if not t then setStatus("Player not found", true) return end
    State.KickedPlayers[t] = nil
    zzApplyKickVisual(t.Character, false)
    setStatus(t.Name .. " is visible again")
end)

register("kickall", "kickall — (local-only) kicks every other player from your screen", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer and not State.KickedPlayers[p] then
            State.KickedPlayers[p] = true
            local pp = p
            task.spawn(function()
                while State.KickedPlayers[pp] do
                    zzApplyKickVisual(pp.Character, true)
                    RunService.Heartbeat:Wait()
                end
            end)
        end
    end
    setStatus("Kicked everyone from your screen (local-only)")
end)

register("unkickall", "unkickall — bring everyone back on your screen", function()
    for p, _ in pairs(State.KickedPlayers) do
        State.KickedPlayers[p] = nil
        zzApplyKickVisual(p.Character, false)
    end
    setStatus("Everyone visible again")
end)

register("stop", "stop — PANIC BUTTON: instantly stops every bang/effect/toggle running", function()
    State.CurrentTroll = nil
    State.TrollTarget = nil
    State.CurrentMove = nil
    State.MoveTarget = nil
    for p, _ in pairs(State.KickedPlayers) do
        State.KickedPlayers[p] = nil
        zzApplyKickVisual(p.Character, false)
    end
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
    if not ListPopup.Visible then zzOpenPopup(ListPopup) end
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
alias("chaosbang", "annoy")
alias("depthoffield", "dof")
alias("chams", "esp")
alias("wallhacks", "esp")
alias("mugbang", "facebang")
alias("facesit", "frontsit")
alias("fpv", "firstperson")
alias("fp", "firstperson")
alias("hoverbang", "hover")
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
alias("jitterbang", "wiggle")
alias("dance", "shakethat")
alias("tangshake", "shakethat")
alias("lateralbang", "pendulum")
alias("seat", "sit")
alias("scale", "size")
alias("frictionoff", "slide")
alias("gentlebang", "bang")
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
alias("twistbang", "spiral")
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
alias("overheadbang", "headsit")
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
alias("remove", "kick")
alias("disconnect", "kick")
alias("unremove", "unkick")
alias("pathto", "walkto")
alias("autowalk", "walkto")
alias("wigglebang", "zigzagwalk")

local groups = {
    { "MOVEMENT", { "fly", "unfly", "speed", "resetspeed", "jumppower", "noclip", "spin", "unspin", "trip", "sit", "unsit", "respawn", "invisible", "visible" } },
    { "CAMERA", { "fov", "resetfov", "freecam", "unfreecam" } },
    { "PLAYERS", { "view", "unview", "goto", "follow", "unfollow" } },
    { "TROLL", { "bang", "backbang", "facebang", "headsit", "frontsit", "annoy", "fling", "stoptroll" } },
    { "MOVEMENT2", { "orbit", "spiral", "hover", "drift", "pendulum", "wiggle", "zigzagwalk", "bounce", "circlerun", "follow2" } },
    { "SHIELD", { "antifling", "antivoid" } },
    { "EXTRA", { "esp", "unesp", "trail", "untrail", "size", "resetsize", "kill", "god", "ungod", "health", "gravity", "resetgravity" } },
    { "MISC", { "music", "stopmusic", "rejoin", "prefix", "cmds", "stop", "hidegui", "showgui", "viewdistance", "lowgraphics", "highgraphics", "copyme", "kick", "unkick", "kickall", "unkickall", "trollspeed" } },
    { "ALIAS/PLUGIN", { "addalias", "removealias", "clraliases", "addplugin", "plugin", "removeplugin", "deleteplugin", "reloadplugin", "addallplugins", "loadallplugins", "listplugins" } },
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

        -- speed box — how fast the front-back oscillation swings once it's
        -- updating. At Delay 0 it stays locked right on them (mouth/body)
        -- and just swings front-back at this speed.
        local speedLabel = Instance.new("TextLabel", delayRow)
        speedLabel.Size = UDim2.new(0, 56, 1, 0)
        speedLabel.Position = UDim2.new(0, 128, 0, 0)
        speedLabel.BackgroundTransparency = 1
        speedLabel.Text = "Speed:"
        speedLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
        speedLabel.Font = Enum.Font.SourceSans
        speedLabel.TextSize = 12
        speedLabel.TextXAlignment = Enum.TextXAlignment.Left
        speedLabel.ZIndex = 52

        local speedBox = Instance.new("TextBox", delayRow)
        speedBox.Size = UDim2.new(0, 42, 0, 18)
        speedBox.Position = UDim2.new(0, 180, 0, 2)
        speedBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        speedBox.BorderSizePixel = 0
        speedBox.Text = tostring(State.TrollSpeed)
        speedBox.TextColor3 = Color3.fromRGB(230, 230, 230)
        speedBox.Font = Enum.Font.SourceSans
        speedBox.TextSize = 12
        speedBox.ClearTextOnFocus = false
        speedBox.ZIndex = 52
        Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 3)
        local speedStroke = Instance.new("UIStroke", speedBox)
        speedStroke.Thickness = 1
        speedStroke.Color = Color3.fromRGB(70, 70, 70)

        speedBox.FocusLost:Connect(function()
            local n = tonumber(speedBox.Text)
            if n and n > 0 then
                State.TrollSpeed = n
                setStatus("Bang speed set to " .. n)
            else
                speedBox.Text = tostring(State.TrollSpeed)
            end
        end)

        if CurrentHeaderGroup then
            table.insert(CurrentHeaderGroup.items, { label = delayRow, key = "delay speed bang troll" })
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
                if State.HijackEnabled and method == "SendAsync" then
                    local isChannelOk, isChannel = pcall(function() return self:IsA("TextChannel") end)
                    if isChannelOk and isChannel then
                        local text = args[1]
                        if type(text) == "string" then
                            local trimmed = text:match("^%s*(.-)%s*$")
                            if trimmed:sub(1, #prefix) == prefix then
                                task.spawn(runCommand, trimmed)
                                task.spawn(function() setStatus("Ran from chat: " .. trimmed) end)
                                return
                            end
                        end
                    end
                end

                -- legacy chat — DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, channel)
                if State.HijackEnabled and method == "FireServer" then
                    local isInstOk, isInst = pcall(function() return typeof(self) == "Instance" and self.Name == "SayMessageRequest" end)
                    if isInstOk and isInst then
                        local text = args[1]
                        if type(text) == "string" then
                            local trimmed = text:match("^%s*(.-)%s*$")
                            if trimmed:sub(1, #prefix) == prefix then
                                task.spawn(runCommand, trimmed)
                                task.spawn(function() setStatus("Ran from chat: " .. trimmed) end)
                                return
                            end
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

    if FlyPad.Visible ~= State.Flying then FlyPad.Visible = State.Flying end

    if State.Flying then
        ensureFlyParts(root)
        local cam = workspace.CurrentCamera
        local hum = getHum()
        -- THIS was the real "stuck in one place" bug: without PlatformStand,
        -- the Humanoid's own walk/gravity state machine keeps fighting
        -- BodyVelocity every physics step and wins, especially vertically
        -- and whenever you're not actively holding a direction.
        if hum and not hum.PlatformStand then hum.PlatformStand = true end
        local move = Vector3.new(0, 0, 0)
        local dir = cam.CFrame.LookVector
        local right = cam.CFrame.RightVector
        -- Humanoid.MoveDirection already reflects whatever input the
        -- player is using RIGHT NOW (keyboard WASD, mobile touch joystick,
        -- or a gamepad) — reading raw keyboard keys only (old code) is why
        -- fly got stuck in place on mobile, since there's no WASD there.
        if hum then
            local md = hum.MoveDirection
            if md.Magnitude > 0.05 then
                -- re-express their move intent relative to the camera so
                -- "forward" on the joystick always means camera-forward
                local fwd = (dir * Vector3.new(1, 0, 1))
                if fwd.Magnitude > 0.001 then fwd = fwd.Unit end
                local sid = (right * Vector3.new(1, 0, 1))
                if sid.Magnitude > 0.001 then sid = sid.Unit end
                local fAmt = md:Dot(fwd)
                local sAmt = md:Dot(sid)
                move = fwd * fAmt + sid * sAmt
            end
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += dir end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= dir end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= right end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += right end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) or State.FlyUp then move += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or State.FlyDown then move -= Vector3.new(0, 1, 0) end
        if move.Magnitude > 0 then move = move.Unit end
        bodyVelocity.Velocity = move * State.FlySpeed
    elseif bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
        local hum = getHum()
        if hum then hum.PlatformStand = false end
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
