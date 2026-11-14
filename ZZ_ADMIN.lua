-- =========================================================
-- 💢 ZZ ADMIN — AAYAN's own command-bar admin tool
-- Infinite-Yield style: small command bar + ;cmds list popup
-- =========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("ZZ_ADMIN") then
    PlayerGui.ZZ_ADMIN:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "ZZ_ADMIN"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = PlayerGui

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
Bar.Size = UDim2.new(0, 280, 0, 34)
Bar.Position = UDim2.new(0, 16, 1, -50)
Bar.BackgroundColor3 = Color3.fromRGB(12, 9, 22)
Bar.BackgroundTransparency = 0.1
Bar.BorderSizePixel = 0
Bar.ZIndex = 50
Instance.new("UICorner", Bar).CornerRadius = UDim.new(0, 8)
local BarStroke = Instance.new("UIStroke", Bar)
BarStroke.Thickness = 1.2
BarStroke.Color = Color3.fromRGB(150, 70, 255)
makeDraggable(Bar)

local prefix = ";"

local Input = Instance.new("TextBox", Bar)
Input.Size = UDim2.new(1, -62, 1, -8)
Input.Position = UDim2.new(0, 8, 0, 4)
Input.BackgroundTransparency = 1
Input.PlaceholderText = "Type " .. prefix .. "cmds for list..."
Input.Text = ""
Input.TextColor3 = Color3.fromRGB(230, 220, 255)
Input.PlaceholderColor3 = Color3.fromRGB(130, 115, 160)
Input.Font = Enum.Font.GothamMedium
Input.TextSize = 12
Input.TextXAlignment = Enum.TextXAlignment.Left
Input.ClearTextOnFocus = false
Input.ZIndex = 51

local CmdsBtn = Instance.new("TextButton", Bar)
CmdsBtn.Size = UDim2.new(0, 48, 0, 24)
CmdsBtn.Position = UDim2.new(1, -54, 0.5, -12)
CmdsBtn.BackgroundColor3 = Color3.fromRGB(150, 70, 255)
CmdsBtn.BorderSizePixel = 0
CmdsBtn.Text = "CMDS"
CmdsBtn.TextColor3 = Color3.new(1, 1, 1)
CmdsBtn.Font = Enum.Font.GothamBlack
CmdsBtn.TextSize = 10
CmdsBtn.ZIndex = 51
Instance.new("UICorner", CmdsBtn).CornerRadius = UDim.new(0, 6)

-- status/feedback line, shows last ran command or error
local Status = Instance.new("TextLabel", gui)
Status.Size = UDim2.new(0, 280, 0, 18)
Status.Position = UDim2.new(0, 16, 1, -70)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.TextColor3 = Color3.fromRGB(190, 170, 255)
Status.Font = Enum.Font.GothamMedium
Status.TextSize = 11
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.ZIndex = 50

local function setStatus(msg, bad)
    Status.Text = msg
    Status.TextColor3 = bad and Color3.fromRGB(255, 120, 120) or Color3.fromRGB(190, 170, 255)
end

-- =========================================================
-- cmds list popup
-- =========================================================

local ListPopup = Instance.new("Frame", gui)
ListPopup.Size = UDim2.new(0, 260, 0, 320)
ListPopup.Position = UDim2.new(0, 16, 1, -390)
ListPopup.BackgroundColor3 = Color3.fromRGB(14, 10, 26)
ListPopup.BorderSizePixel = 0
ListPopup.Visible = false
ListPopup.ZIndex = 50
Instance.new("UICorner", ListPopup).CornerRadius = UDim.new(0, 10)
local ListStroke = Instance.new("UIStroke", ListPopup)
ListStroke.Thickness = 1.2
ListStroke.Color = Color3.fromRGB(150, 70, 255)
makeDraggable(ListPopup)

local ListTitle = Instance.new("TextLabel", ListPopup)
ListTitle.Size = UDim2.new(1, -16, 0, 26)
ListTitle.Position = UDim2.new(0, 8, 0, 4)
ListTitle.BackgroundTransparency = 1
ListTitle.Text = "💢 ZZ ADMIN — COMMANDS"
ListTitle.TextColor3 = Color3.new(1, 1, 1)
ListTitle.Font = Enum.Font.GothamBlack
ListTitle.TextSize = 12
ListTitle.ZIndex = 51

local ListScroll = Instance.new("ScrollingFrame", ListPopup)
ListScroll.Size = UDim2.new(1, -16, 1, -40)
ListScroll.Position = UDim2.new(0, 8, 0, 32)
ListScroll.BackgroundTransparency = 1
ListScroll.BorderSizePixel = 0
ListScroll.ScrollBarThickness = 3
ListScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ListScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ListScroll.ZIndex = 51

local ListLayout = Instance.new("UIListLayout", ListScroll)
ListLayout.Padding = UDim.new(0, 2)

local function addListLine(text, isHeader)
    local l = Instance.new("TextLabel", ListScroll)
    l.Size = UDim2.new(1, 0, 0, isHeader and 20 or 16)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = isHeader and Color3.fromRGB(200, 130, 255) or Color3.fromRGB(200, 195, 220)
    l.Font = isHeader and Enum.Font.GothamBlack or Enum.Font.Gotham
    l.TextSize = isHeader and 12 or 10.5
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 51
end

CmdsBtn.MouseButton1Click:Connect(function()
    ListPopup.Visible = not ListPopup.Visible
end)

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
}

local commands = {} -- name -> {desc, run}

local function register(name, desc, run)
    commands[name] = { desc = desc, run = run }
end

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
local function startTroll(mode, args)
    local t = findPlayer(args[1])
    if not t then setStatus("Player not found", true) return end
    State.CurrentTroll = mode
    State.TrollTarget = t
    task.spawn(function()
        while State.CurrentTroll == mode and State.TrollTarget == t do
            local root = getRoot()
            local tChar = t.Character
            if root and tChar then
                local tRoot = tChar:FindFirstChild("HumanoidRootPart")
                local tHead = tChar:FindFirstChild("Head")
                if mode == "bang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 1.2 + math.sin(tick() * 25) * 0.8)
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

                -- 10 bang variants, each a different motion pattern
                elseif mode == "backbang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 0, -1.2 - math.sin(tick() * 25) * 0.8)
                elseif mode == "sidebang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(math.sin(tick() * 20) * 2, 0, 0)
                elseif mode == "topbang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 2 + math.sin(tick() * 15) * 0.6, 0)
                elseif mode == "spinbang" and tRoot then
                    local angle = tick() * 8
                    root.CFrame = tRoot.CFrame * CFrame.new(math.cos(angle) * 1.5, 0, math.sin(angle) * 1.5)
                elseif mode == "shakebang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(math.random(-50, 50) / 100, math.random(-50, 50) / 100, math.random(-50, 50) / 100)
                elseif mode == "floatbang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 1 + math.sin(tick() * 4) * 1.5, 0)
                elseif mode == "zigzagbang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(math.sin(tick() * 10) * 1.5, 0, math.cos(tick() * 6) * 1.5)
                elseif mode == "crazybang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(math.random(-3, 3), math.random(-1, 3), math.random(-3, 3))
                elseif mode == "slowbang" and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 1.2 + math.sin(tick() * 3) * 0.8)
                end
            end
            RunService.Heartbeat:Wait()
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

register("facebang", "facebang [player] — troll face-bang", function(args) startTroll("facebang", args) end)
register("headsit", "headsit [player] — sit on a player's head", function(args) startTroll("headsit", args) end)
register("orbit", "orbit [player] — orbit around a player", function(args) startTroll("orbit", args) end)
register("annoy", "annoy [player] — teleport-spam near a player", function(args) startTroll("annoy", args) end)

register("stoptroll", "stoptroll — stop all troll modes", function()
    State.CurrentTroll = nil
    State.TrollTarget = nil
    local hum = getHum()
    if hum then hum.Sit = false end
    setStatus("Troll stopped")
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

local groups = {
    { "MOVEMENT", { "fly", "unfly", "speed", "resetspeed", "jumppower", "noclip", "spin", "unspin", "trip", "sit", "unsit", "respawn", "invisible", "visible" } },
    { "CAMERA", { "fov", "resetfov" } },
    { "PLAYERS", { "view", "unview", "goto", "follow", "unfollow" } },
    { "TROLL", { "bang", "facebang", "headsit", "orbit", "annoy", "stoptroll" } },
    { "MISC", { "music", "stopmusic", "rejoin", "prefix", "cmds" } },
}

for _, group in ipairs(groups) do
    addListLine(group[1], true)
    for _, name in ipairs(group[2]) do
        local c = commands[name]
        if c then addListLine(prefix .. c.desc) end
    end
end
addListLine("", false)
addListLine("+2000 more: colorN, speedpresetN, fovpresetN", false)

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
-- REAL CHAT HIJACK — type ";cmds" (or whatever the prefix is)
-- directly in the ACTUAL Roblox chat box. The message is caught
-- and blocked before it ever reaches the server, so nobody else
-- sees it, and it runs as a ZZ ADMIN command instead.
-- Needs an executor that exposes hookmetamethod/getnamecallmethod
-- (Synapse, Script-Ware, Krnl, etc.) — if yours doesn't, the
-- command bar above still works exactly the same either way.
-- =========================================================

if typeof(hookmetamethod) == "function" and typeof(getnamecallmethod) == "function" then
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local args = { ... }
        local ok, method = pcall(getnamecallmethod)

        if ok then
            -- new chat (TextChatService) — TextChannel:SendAsync(text)
            if method == "SendAsync" then
                local isChannel = pcall(function() return self:IsA("TextChannel") end)
                if isChannel then
                    local text = args[1]
                    if type(text) == "string" and text:sub(1, #prefix) == prefix then
                        task.spawn(runCommand, text)
                        return
                    end
                end
            end

            -- legacy chat — DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, channel)
            if method == "FireServer" and typeof(self) == "Instance" and self.Name == "SayMessageRequest" then
                local text = args[1]
                if type(text) == "string" and text:sub(1, #prefix) == prefix then
                    task.spawn(runCommand, text)
                    return
                end
            end
        end

        return oldNamecall(self, ...)
    end)
    setStatus("Chat hijack active — " .. prefix .. "cmds works in real chat too")
else
    setStatus("Executor has no hookmetamethod — use the command bar instead", true)
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
end)

print("💢 ZZ ADMIN loaded! Type " .. prefix .. "cmds in the command bar.")
