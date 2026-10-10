-- =======================================================
-- DRONE WAR | ULTIMATE MORPH-STYLE GUI v4.2 (Extreme Range & Wallbang)
-- =======================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

if CoreGui:FindFirstChild("DroneWarMorphGUI") then
    CoreGui:FindFirstChild("DroneWarMorphGUI"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DroneWarMorphGUI"
ScreenGui.ResetOnSpawn = false

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local Config = {
    ESP_Players = false,
    ESP_Names = false,
    ESP_Drones = false,
    
    Aim_Enabled = false,
    Aim_Wallhack = false,
    SilentAim_Enabled = false,
    FOV_Enabled = false,
    FOV_Radius = 150,
    Hitbox_Enabled = false,
    
    Fly_Enabled = false,
    Fly_Speed = 50,
    Speed_Enabled = false,
    Normal_Speed = 16,
    Sprint_Speed = 35,
    Noclip_Enabled = false,
    InfJump_Enabled = false,
    
    Binds = {
        ESP = Enum.KeyCode.E,
        Aim = Enum.KeyCode.Q,
        SilentAim = Enum.KeyCode.R,
        Fly = Enum.KeyCode.X,
        Speed = Enum.KeyCode.C,
        Noclip = Enum.KeyCode.V,
        Menu = Enum.KeyCode.F6
    }
}

local Themes = {
    ["Тёмно-синий"] = {
        Background = Color3.fromRGB(15, 20, 30),
        Sidebar = Color3.fromRGB(22, 28, 42),
        Accent = Color3.fromRGB(88, 166, 255),
        Secondary = Color3.fromRGB(30, 38, 56),
        Text = Color3.fromRGB(240, 246, 252)
    },
    ["Тёмно-красный"] = {
        Background = Color3.fromRGB(22, 14, 14),
        Sidebar = Color3.fromRGB(32, 20, 20),
        Accent = Color3.fromRGB(255, 75, 75),
        Secondary = Color3.fromRGB(48, 28, 28),
        Text = Color3.fromRGB(255, 240, 240)
    },
    ["Фиолетовый"] = {
        Background = Color3.fromRGB(20, 14, 28),
        Sidebar = Color3.fromRGB(28, 20, 40),
        Accent = Color3.fromRGB(170, 90, 255),
        Secondary = Color3.fromRGB(42, 30, 60),
        Text = Color3.fromRGB(245, 240, 255)
    },
    ["Чёрный"] = {
        Background = Color3.fromRGB(12, 12, 12),
        Sidebar = Color3.fromRGB(18, 18, 18),
        Accent = Color3.fromRGB(255, 120, 50),
        Secondary = Color3.fromRGB(28, 28, 28),
        Text = Color3.fromRGB(255, 255, 255)
    }
}
local currentTheme = Themes["Тёмно-синий"]

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 620, 0, 400)
MainFrame.Position = UDim2.new(0.5, -310, 0.5, -200)
MainFrame.BackgroundColor3 = currentTheme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = currentTheme.Accent
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.5

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 0, 45)
TitleLabel.Position = UDim2.new(0, 20, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.Text = "💎 DRONE WAR <font color='#58A6FF'>SUPREME</font>"
TitleLabel.RichText = true
TitleLabel.TextColor3 = currentTheme.Text
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 175, 1, -50)
Sidebar.Position = UDim2.new(0, 0, 0, 50)
Sidebar.BackgroundColor3 = currentTheme.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

local ProfileBox = Instance.new("Frame")
ProfileBox.Size = UDim2.new(1, -16, 0, 48)
ProfileBox.Position = UDim2.new(0, 8, 0, 10)
ProfileBox.BackgroundColor3 = currentTheme.Secondary
ProfileBox.BorderSizePixel = 0
ProfileBox.Parent = Sidebar
Instance.new("UICorner", ProfileBox).CornerRadius = UDim.new(0, 8)

local UserIcon = Instance.new("TextLabel")
UserIcon.Size = UDim2.new(0, 32, 0, 32)
UserIcon.Position = UDim2.new(0, 8, 0.5, -16)
UserIcon.BackgroundColor3 = currentTheme.Accent
UserIcon.Text = string.sub(LocalPlayer.Name, 1, 1):upper()
UserIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
UserIcon.Font = Enum.Font.GothamBold
UserIcon.TextSize = 15
UserIcon.Parent = ProfileBox
Instance.new("UICorner", UserIcon).CornerRadius = UDim.new(1, 0)

local UserNameLabel = Instance.new("TextLabel")
UserNameLabel.Size = UDim2.new(1, -48, 0, 18)
UserNameLabel.Position = UDim2.new(0, 46, 0, 7)
UserNameLabel.BackgroundTransparency = 1
UserNameLabel.Font = Enum.Font.GothamBold
UserNameLabel.Text = LocalPlayer.Name
UserNameLabel.TextColor3 = currentTheme.Text
UserNameLabel.TextSize = 12
UserNameLabel.TextXAlignment = Enum.TextXAlignment.Left
UserNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
UserNameLabel.Parent = ProfileBox

local UserSubLabel = Instance.new("TextLabel")
UserSubLabel.Size = UDim2.new(1, -48, 0, 14)
UserSubLabel.Position = UDim2.new(0, 46, 0, 25)
UserSubLabel.BackgroundTransparency = 1
UserSubLabel.Font = Enum.Font.Gotham
UserSubLabel.Text = "★ VIP Player"
UserSubLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
UserSubLabel.TextSize = 10
UserSubLabel.TextXAlignment = Enum.TextXAlignment.Left
UserSubLabel.Parent = ProfileBox

local TabsContainer = Instance.new("Frame")
TabsContainer.Size = UDim2.new(1, 0, 1, -70)
TabsContainer.Position = UDim2.new(0, 0, 0, 68)
TabsContainer.BackgroundTransparency = 1
TabsContainer.Parent = Sidebar

local PagesContainer = Instance.new("Frame")
PagesContainer.Size = UDim2.new(1, -190, 1, -55)
PagesContainer.Position = UDim2.new(0, 182, 0, 48)
PagesContainer.BackgroundTransparency = 1
PagesContainer.Parent = MainFrame

local pages = {}
local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ScrollBarThickness = 3
    page.Visible = false
    page.Parent = PagesContainer
    
    local layout = Instance.new("UIListLayout", page)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    
    pages[name] = page
    return page
end

local espPage = createPage("ESP")
local aimPage = createPage("AimBot")
local movePage = createPage("Движение")
local miscPage = createPage("Мир_ТП")
local bindsPage = createPage("Бинды")
local settingsPage = createPage("Настройки")

espPage.Visible = true

local tabButtons = {}
local activeTabName = "ESP"

local function createTabButton(name, text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 34)
    btn.Position = UDim2.new(0, 8, 0, (#tabButtons * 38))
    btn.BackgroundColor3 = (name == activeTabName) and currentTheme.Accent or currentTheme.Secondary
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = "   " .. text
    btn.TextColor3 = currentTheme.Text
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = TabsContainer

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        for _, b in pairs(tabButtons) do b.BackgroundColor3 = currentTheme.Secondary end
        pages[name].Visible = true
        btn.BackgroundColor3 = currentTheme.Accent
        activeTabName = name
    end)

    table.insert(tabButtons, btn)
    return btn
end

createTabButton("ESP", "👁️ ESP & Игроки")
createTabButton("AimBot", "🎯 Aim Bot")
createTabButton("Движение", "⚡ Движение")
createTabButton("Мир_ТП", "🌍 Мир & Телепорт")
createTabButton("Бинды", "⌨️ Клавиши")
createTabButton("Настройки", "⚙️ Настройки")

local toggleUpdaters = {}

local function createToggle(parent, title, defaultState, callback, bindKeyName)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 42)
    frame.BackgroundColor3 = currentTheme.Secondary
    frame.BorderSizePixel = 0
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamMedium
    label.Text = title
    label.TextColor3 = currentTheme.Text
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 44, 0, 24)
    toggleBtn.Position = UDim2.new(1, -54, 0.5, -12)
    toggleBtn.BackgroundColor3 = defaultState and currentTheme.Accent or Color3.fromRGB(50, 55, 65)
    toggleBtn.Text = ""
    toggleBtn.Parent = frame
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 20, 0, 20)
    circle.Position = defaultState and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Parent = toggleBtn
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

    local enabled = defaultState
    local function update(state)
        enabled = state
        if enabled then
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = currentTheme.Accent}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -22, 0.5, -10)}):Play()
        else
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 55, 65)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10)}):Play()
        end
        callback(enabled)
    end

    toggleBtn.MouseButton1Click:Connect(function()
        update(not enabled)
    end)

    if bindKeyName then
        toggleUpdaters[bindKeyName] = {
            getState = function() return enabled end,
            setState = function(state) update(state) end
        }
    end

    return update
end

local function createSlider(parent, title, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 50)
    frame.BackgroundColor3 = currentTheme.Secondary
    frame.BorderSizePixel = 0
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -90, 0, 24)
    label.Position = UDim2.new(0, 14, 0, 4)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamMedium
    label.Text = title .. ": " .. tostring(default)
    label.TextColor3 = currentTheme.Text
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local currentValue = default
    local function updateValue(newValue)
        currentValue = math.clamp(newValue, min, max)
        label.Text = title .. ": " .. tostring(currentValue)
        callback(currentValue)
    end

    local minusBtn = Instance.new("TextButton")
    minusBtn.Size = UDim2.new(0, 24, 0, 24)
    minusBtn.Position = UDim2.new(1, -60, 0, 4)
    minusBtn.BackgroundColor3 = Color3.fromRGB(50, 55, 65)
    minusBtn.Font = Enum.Font.GothamBold
    minusBtn.Text = "-"
    minusBtn.TextColor3 = currentTheme.Text
    minusBtn.TextSize = 14
    minusBtn.Parent = frame
    Instance.new("UICorner", minusBtn).CornerRadius = UDim.new(0, 6)
    minusBtn.MouseButton1Click:Connect(function() updateValue(currentValue - 10) end)

    local plusBtn = Instance.new("TextButton")
    plusBtn.Size = UDim2.new(0, 24, 0, 24)
    plusBtn.Position = UDim2.new(1, -30, 0, 4)
    plusBtn.BackgroundColor3 = Color3.fromRGB(50, 55, 65)
    plusBtn.Font = Enum.Font.GothamBold
    plusBtn.Text = "+"
    plusBtn.TextColor3 = currentTheme.Text
    plusBtn.TextSize = 14
    plusBtn.Parent = frame
    Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0, 6)
    plusBtn.MouseButton1Click:Connect(function() updateValue(currentValue + 10) end)

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -28, 0, 8)
    sliderBg.Position = UDim2.new(0, 14, 0, 34)
    sliderBg.BackgroundColor3 = Color3.fromRGB(40, 45, 55)
    sliderBg.Parent = frame
    Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = currentTheme.Accent
    sliderFill.Parent = sliderBg
    Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local function updateVal(input)
        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max - min) * pos)
        currentValue = val
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        label.Text = title .. ": " .. tostring(val)
        callback(val)
    end

    sliderBg.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateVal(inp)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            updateVal(inp)
        end
    end)
end

local function createButton(parent, title, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 38)
    btn.BackgroundColor3 = currentTheme.Secondary
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamMedium
    btn.Text = "   " .. title
    btn.TextColor3 = currentTheme.Text
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function createKeybindBtn(parent, title, keyData, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 42)
    frame.BackgroundColor3 = currentTheme.Secondary
    frame.BorderSizePixel = 0
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -110, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamMedium
    label.Text = title
    label.TextColor3 = currentTheme.Text
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 0, 26)
    btn.Position = UDim2.new(1, -100, 0.5, -13)
    btn.BackgroundColor3 = currentTheme.Accent
    btn.Font = Enum.Font.GothamBold
    btn.Text = keyData.Name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local listening = false
    btn.MouseButton1Click:Connect(function()
        listening = true
        btn.Text = "Нажмите..."
    end)

    UserInputService.InputBegan:Connect(function(inp)
        if listening and inp.UserInputType == Enum.UserInputType.Keyboard then
            listening = false
            btn.Text = inp.KeyCode.Name
            callback(inp.KeyCode)
        end
    end)
end

-- =======================================================
-- ЗАПОЛНЕНИЕ ВКЛАДОК
-- =======================================================

createToggle(espPage, "Подсветка игроков (Цвета команд)", Config.ESP_Players, function(s) Config.ESP_Players = s end, "ESP")
createToggle(espPage, "Имена, дистанция и HP над головой", Config.ESP_Names, function(s) Config.ESP_Names = s end, nil)
createToggle(espPage, "Подсветка дронов на карте", Config.ESP_Drones, function(s) Config.ESP_Drones = s end, nil)

-- Aim Bot & Combat
createToggle(aimPage, "Включить Aim Bot", Config.Aim_Enabled, function(s) Config.Aim_Enabled = s end, "Aim")
createToggle(aimPage, "Нацеливание сквозь стены (Wallhack)", Config.Aim_Wallhack, function(s) Config.Aim_Wallhack = s end, nil)
createToggle(aimPage, "Silent Aim (Wallbang + Любое расстояние)", Config.SilentAim_Enabled, function(s) Config.SilentAim_Enabled = s end, "SilentAim")
createToggle(aimPage, "Показывать круг FOV", Config.FOV_Enabled, function(s) Config.FOV_Enabled = s end, nil)
createSlider(aimPage, "Радиус круга FOV", 50, 400, Config.FOV_Radius, function(v) Config.FOV_Radius = v end)
createToggle(aimPage, "Увеличение хитбоксов врагов", Config.Hitbox_Enabled, function(s) Config.Hitbox_Enabled = s end, nil)

-- Movement
createToggle(movePage, "Включить Полёт (Fly)", Config.Fly_Enabled, function(s) Config.Fly_Enabled = s end, "Fly")
createSlider(movePage, "Скорость Полёта", 20, 500, Config.Fly_Speed, function(v) Config.Fly_Speed = v end)
createToggle(movePage, "Включить SpeedHack", Config.Speed_Enabled, function(s) Config.Speed_Enabled = s end, "Speed")
createSlider(movePage, "Обычная скорость", 16, 200, Config.Normal_Speed, function(v) Config.Normal_Speed = v end)
createSlider(movePage, "Ускорение на Shift (Sprint)", 20, 300, Config.Sprint_Speed, function(v) Config.Sprint_Speed = v end)
createToggle(movePage, "Проход сквозь стены (Noclip)", Config.Noclip_Enabled, function(s) Config.Noclip_Enabled = s end, "Noclip")
createToggle(movePage, "Бесконечный прыжок (Inf Jump)", Config.InfJump_Enabled, function(s) Config.InfJump_Enabled = s end, nil)

-- World & Misc & Teleport
createButton(miscPage, "⚡ Телепорт к ближайшему врагу", function()
    local target = nil
    local minDist = math.huge
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myPos = LocalPlayer.Character.HumanoidRootPart.Position
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                if not p.Team or p.Team ~= LocalPlayer.Team then
                    local dist = (myPos - p.Character.HumanoidRootPart.Position).Magnitude
                    if dist < minDist then
                        minDist = dist
                        target = p.Character.HumanoidRootPart
                    end
                end
            end
        end
        if target then
            LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 3, 0)
        end
    end
end)

createButton(miscPage, "🔄 Переподключиться (Rejoin Server)", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

createButton(miscPage, "🚀 Разблокировать FPS (FPS Unlocker)", function()
    pcall(function()
        if setfpscap then setfpscap(999) end
    end)
end)

-- Binds
createKeybindBtn(bindsPage, "Бинд для ESP", Config.Binds.ESP, function(k) Config.Binds.ESP = k end)
createKeybindBtn(bindsPage, "Бинд для Aim Bot", Config.Binds.Aim, function(k) Config.Binds.Aim = k end)
createKeybindBtn(bindsPage, "Бинд для Silent Aim", Config.Binds.SilentAim, function(k) Config.Binds.SilentAim = k end)
createKeybindBtn(bindsPage, "Бинд для Полёта", Config.Binds.Fly, function(k) Config.Binds.Fly = k end)
createKeybindBtn(bindsPage, "Бинд для SpeedHack", Config.Binds.Speed, function(k) Config.Binds.Speed = k end)
createKeybindBtn(bindsPage, "Бинд для Noclip", Config.Binds.Noclip, function(k) Config.Binds.Noclip = k end)
createKeybindBtn(bindsPage, "Бинд открытия Меню", Config.Binds.Menu, function(k) Config.Binds.Menu = k end)

local themeHeader = Instance.new("TextLabel")
themeHeader.Size = UDim2.new(1, -10, 0, 26)
themeHeader.BackgroundTransparency = 1
themeHeader.Font = Enum.Font.GothamBold
themeHeader.Text = "Выбор цветовой схемы интерфейса:"
themeHeader.TextColor3 = currentTheme.Text
themeHeader.TextSize = 12
themeHeader.TextXAlignment = Enum.TextXAlignment.Left
themeHeader.Parent = settingsPage

for name, data in pairs(Themes) do
    local tBtn = Instance.new("TextButton")
    tBtn.Size = UDim2.new(1, -10, 0, 38)
    tBtn.BackgroundColor3 = currentTheme.Secondary
    tBtn.BorderSizePixel = 0
    tBtn.Font = Enum.Font.GothamMedium
    tBtn.Text = "   " .. name
    tBtn.TextColor3 = currentTheme.Text
    tBtn.TextSize = 12
    tBtn.TextXAlignment = Enum.TextXAlignment.Left
    tBtn.Parent = settingsPage
    Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 8)

    local circleColor = Instance.new("Frame")
    circleColor.Size = UDim2.new(0, 18, 0, 18)
    circleColor.Position = UDim2.new(1, -28, 0.5, -9)
    circleColor.BackgroundColor3 = data.Accent
    circleColor.Parent = tBtn
    Instance.new("UICorner", circleColor).CornerRadius = UDim.new(1, 0)

    tBtn.MouseButton1Click:Connect(function()
        currentTheme = data
        MainFrame.BackgroundColor3 = currentTheme.Background
        Sidebar.BackgroundColor3 = currentTheme.Sidebar
        TitleLabel.TextColor3 = currentTheme.Text
        ProfileBox.BackgroundColor3 = currentTheme.Secondary
        UserNameLabel.TextColor3 = currentTheme.Text
        UserIcon.BackgroundColor3 = currentTheme.Accent
        MainStroke.Color = currentTheme.Accent

        for _, b in pairs(tabButtons) do
            if b.BackgroundColor3 ~= currentTheme.Secondary then
                b.BackgroundColor3 = currentTheme.Accent
            end
        end
    end)
end

-- =======================================================
-- ЛОГИКА ФУНКЦИЙ
-- =======================================================

-- FOV Circle визуал
local FOVCircleGui = Instance.new("ScreenGui", CoreGui)
FOVCircleGui.Name = "FOVCircleGui"
FOVCircleGui.IgnoreGuiInset = true

local FOVFrame = Instance.new("Frame", FOVCircleGui)
FOVFrame.BackgroundTransparency = 1
FOVFrame.AnchorPoint = Vector2.new(0.5, 0.5)

local FOVStroke = Instance.new("UIStroke", FOVFrame)
FOVStroke.Color = Color3.fromRGB(255, 255, 255)
FOVStroke.Transparency = 0
FOVStroke.Thickness = 2

local FOVCorner = Instance.new("UICorner", FOVFrame)
FOVCorner.CornerRadius = UDim.new(1, 0)

RunService.RenderStepped:Connect(function()
    local mouseLoc = UserInputService:GetMouseLocation()
    FOVFrame.Position = UDim2.new(0, mouseLoc.X, 0, mouseLoc.Y)
    local size = Config.FOV_Radius * 2
    FOVFrame.Size = UDim2.new(0, size, 0, size)
    FOVFrame.Visible = Config.FOV_Enabled
end)

-- Fly логика
local flyBV, flyBG
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    if Config.Fly_Enabled then
        if not flyBV then
            flyBV = Instance.new("BodyVelocity")
            flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            flyBV.Parent = hrp
            
            flyBG = Instance.new("BodyGyro")
            flyBG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            flyBG.P = 15000
            flyBG.Parent = hrp
        end

        flyBG.CFrame = Camera.CFrame
        local moveDir = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0, 1, 0) end

        flyBV.Velocity = moveDir * Config.Fly_Speed
    else
        if flyBV then flyBV:Destroy() flyBV = nil end
        if flyBG then flyBG:Destroy() flyBG = nil end
    end
end)

-- SpeedHack
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if Config.Speed_Enabled then
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                hum.WalkSpeed = Config.Sprint_Speed
            else
                hum.WalkSpeed = Config.Normal_Speed
            end
        end
    end
end)

-- Noclip
RunService.Stepped:Connect(function()
    if Config.Noclip_Enabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if Config.InfJump_Enabled and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Hitbox Extender
local origSizes = {}
RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            if Config.Hitbox_Enabled then
                if not origSizes[hrp] then origSizes[hrp] = hrp.Size end
                hrp.Size = Vector3.new(6, 6, 6)
                hrp.Transparency = 0.6
                hrp.CanCollide = false
            else
                if origSizes[hrp] then
                    hrp.Size = origSizes[hrp]
                    hrp.Transparency = 1
                    hrp.CanCollide = true
                    origSizes[hrp] = nil
                end
            end
        end
    end
end)

-- ESP и Дроны
RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")

            local highlight = char:FindFirstChild("MorphESP")
            if Config.ESP_Players then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "MorphESP"
                    highlight.Parent = char
                end
                local teamCol = player.Team and player.Team.TeamColor.Color or Color3.fromRGB(255, 255, 255)
                highlight.FillColor = teamCol
                highlight.OutlineColor = teamCol
                highlight.FillTransparency = 0.5
            else
                if highlight then highlight:Destroy() end
            end

            local billboard = char:FindFirstChild("MorphNameESP")
            if Config.ESP_Names and hrp and hum and hum.Health > 0 then
                if not billboard then
                    billboard = Instance.new("BillboardGui")
                    billboard.Name = "MorphNameESP"
                    billboard.Size = UDim2.new(0, 150, 0, 45)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Parent = char

                    local txt = Instance.new("TextLabel")
                    txt.Name = "Info"
                    txt.Size = UDim2.new(1, 0, 1, 0)
                    txt.BackgroundTransparency = 1
                    txt.Font = Enum.Font.GothamBold
                    txt.TextSize = 11
                    txt.TextColor3 = Color3.fromRGB(255, 255, 255)
                    txt.TextStrokeTransparency = 0
                    txt.Parent = billboard
                end
                
                local distance = math.floor((Camera.CFrame.Position - hrp.Position).Magnitude)
                local tLabel = billboard:FindFirstChild("Info")
                if tLabel then
                    tLabel.Text = string.format("%s\n%d м | HP: %d/%d", player.Name, distance, math.floor(hum.Health), math.floor(hum.MaxHealth))
                end
            else
                if billboard then billboard:Destroy() end
            end
        end
    end

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and (string.find(string.lower(obj.Name), "drone") or string.find(string.lower(obj.Name), "дрон")) then
            local droneHL = obj:FindFirstChild("DroneESP")
            if Config.ESP_Drones then
                if not droneHL then
                    droneHL = Instance.new("Highlight")
                    droneHL.Name = "DroneESP"
                    droneHL.FillColor = Color3.fromRGB(255, 170, 0)
                    droneHL.OutlineColor = Color3.fromRGB(255, 255, 0)
                    droneHL.FillTransparency = 0.4
                    droneHL.Parent = obj
                end
            else
                if droneHL then droneHL:Destroy() end
            end
        end
    end
end)

-- Aim Bot
RunService.RenderStepped:Connect(function()
    if not Config.Aim_Enabled then return end
    local bestTarget = nil
    local minDst = math.huge
    local mouseLoc = UserInputService:GetMouseLocation()

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local hum = char:FindFirstChildOfClass("Humanoid")
            local head = char:FindFirstChild("Head")

            if hum and hum.Health > 0 and head then
                if not player.Team or player.Team ~= LocalPlayer.Team then
                    local canSee = true
                    if not Config.Aim_Wallhack then
                        local origin = Camera.CFrame.Position
                        local rp = RaycastParams.new()
                        rp.FilterType = Enum.RaycastFilterType.Blacklist
                        rp.FilterDescendantsInstances = {LocalPlayer.Character, char}
                        if workspace:Raycast(origin, head.Position - origin, rp) then
                            canSee = false
                        end
                    end

                    if canSee then
                        local screenPt, onScreen = Camera:WorldToViewportPoint(head.Position)
                        if onScreen then
                            local dst = (Vector2.new(screenPt.X, screenPt.Y) - mouseLoc).Magnitude
                            if dst < minDst then
                                minDst = dst
                                bestTarget = head
                            end
                        end
                    end
                end
            end
        end
    end

    if bestTarget then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, bestTarget.Position)
    end
end)

-- Silent Aim (Wallbang + Любое расстояние через перехват Raycast)
local oldRaycast
if pcall(function() oldRaycast = hookfunction(workspace.Raycast, function(...) return oldRaycast(...) end) end) then
    oldRaycast = hookfunction(workspace.Raycast, function(self, origin, direction, raycastParams)
        if Config.SilentAim_Enabled and self == workspace then
            local closestHead = nil
            local shortestDistance = math.huge
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                    if not player.Team or player.Team ~= LocalPlayer.Team then
                        local head = player.Character.Head
                        local hum = player.Character:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            local dist = (origin - head.Position).Magnitude
                            if dist < shortestDistance then
                                shortestDistance = dist
                                closestHead = head
                            end
                        end
                    end
                end
            end
            if closestHead then
                -- Возвращаем фейковый результат попадания прямо в голову через любые стены с любого расстояния
                return {
                    Position = closestHead.Position,
                    Instance = closestHead,
                    Normal = Vector3.new(0, 1, 0),
                    Material = Enum.Material.SmoothPlastic,
                    Distance = (closestHead.Position - origin).Magnitude
                }
            end
        end
        return oldRaycast(self, origin, direction, raycastParams)
    end)
end

-- =======================================================
-- АНИМАЦИЯ И БИНДЫ
-- =======================================================
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "OpenButton"
ToggleButton.Size = UDim2.new(0, 44, 0, 44)
ToggleButton.Position = UDim2.new(0, 15, 0.5, -22)
ToggleButton.BackgroundColor3 = currentTheme.Background
ToggleButton.Text = "DW"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 14
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ScreenGui

Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)
local tStroke = Instance.new("UIStroke", ToggleButton)
tStroke.Color = currentTheme.Accent
tStroke.Thickness = 2

local menuVisible = true
local isAnimating = false

local function toggleUI()
    if isAnimating then return end
    isAnimating = true
    
    if menuVisible then
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        tween:Play()
        tween.Completed:Wait()
        MainFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 620, 0, 400)
        MainFrame.Position = UDim2.new(0.5, -310, 0.5, -200)
        menuVisible = false
    else
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        MainFrame.Visible = true
        
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 620, 0, 400),
            Position = UDim2.new(0.5, -310, 0.5, -200)
        })
        tween:Play()
        tween.Completed:Wait()
        menuVisible = true
    end
    isAnimating = false
end

ToggleButton.MouseButton1Click:Connect(toggleUI)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Config.Binds.Menu then
            toggleUI()
        elseif input.KeyCode == Config.Binds.ESP then
            Config.ESP_Players = not Config.ESP_Players
            if toggleUpdaters["ESP"] then toggleUpdaters["ESP"].setState(Config.ESP_Players) end
        elseif input.KeyCode == Config.Binds.Aim then
            Config.Aim_Enabled = not Config.Aim_Enabled
            if toggleUpdaters["Aim"] then toggleUpdaters["Aim"].setState(Config.Aim_Enabled) end
        elseif input.KeyCode == Config.Binds.SilentAim then
            Config.SilentAim_Enabled = not Config.SilentAim_Enabled
            if toggleUpdaters["SilentAim"] then toggleUpdaters["SilentAim"].setState(Config.SilentAim_Enabled) end
        elseif input.KeyCode == Config.Binds.Fly then
            Config.Fly_Enabled = not Config.Fly_Enabled
            if toggleUpdaters["Fly"] then toggleUpdaters["Fly"].setState(Config.Fly_Enabled) end
        elseif input.KeyCode == Config.Binds.Speed then
            Config.Speed_Enabled = not Config.Speed_Enabled
            if toggleUpdaters["Speed"] then toggleUpdaters["Speed"].setState(Config.Speed_Enabled) end
        elseif input.KeyCode == Config.Binds.Noclip then
            Config.Noclip_Enabled = not Config.Noclip_Enabled
            if toggleUpdaters["Noclip"] then toggleUpdaters["Noclip"].setState(Config.Noclip_Enabled) end
        end
    end
end)
