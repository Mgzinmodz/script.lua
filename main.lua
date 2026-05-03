-- MGZMODZ | UI PROFISSIONAL AVANÇADO

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MGZMODZ_PRO"
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 460, 0, 350)
main.Position = UDim2.new(0.5, -230, 0.5, -175)
main.BackgroundColor3 = Color3.fromRGB(18,18,28)
main.Active = true
main.Draggable = true
main.Parent = gui

Instance.new("UICorner", main)

-- TOP BAR
local top = Instance.new("Frame")
top.Size = UDim2.new(1,0,0,35)
top.BackgroundColor3 = Color3.fromRGB(12,12,20)
top.Parent = main

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "MGZMODZ HUB"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = top

-- BOTÕES TOP
local function createTopBtn(txt, pos)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,30,1,0)
	b.Position = pos
	b.Text = txt
	b.BackgroundTransparency = 1
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	b.Parent = top
	return b
end

local close = createTopBtn("X", UDim2.new(1,-30,0,0))
local mini = createTopBtn("-", UDim2.new(1,-60,0,0))

-- CONTENT
local content = Instance.new("Frame")
content.Size = UDim2.new(1,0,1,-70)
content.Position = UDim2.new(0,0,0,70)
content.BackgroundTransparency = 1
content.Parent = main

-- CLEAR
local function clear()
	for _,v in pairs(content:GetChildren()) do
		v:Destroy()
	end
end

-- TOGGLE
local function createToggle(text, y)
	local state = false
	
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.9,0,0,30)
	btn.Position = UDim2.new(0.05,0,0,y)
	btn.BackgroundColor3 = Color3.fromRGB(35,35,50)
	btn.Text = text.." : OFF"
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Parent = content
	
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = text.." : "..(state and "ON" or "OFF")
		btn.BackgroundColor3 = state and Color3.fromRGB(0,170,255) or Color3.fromRGB(35,35,50)
	end)
end

-- TABS
local function createTab(name, posX, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.25,0,0,35)
	btn.Position = UDim2.new(posX,0,0,35)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(25,25,35)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Parent = main
	
	btn.MouseButton1Click:Connect(callback)
end

-- AIMBOT
local function showAimbot()
	clear()
	local y=5
	for _,txt in ipairs({
		"Ativar Aimbot","Mostrar FOV","Linha de Mira",
		"Silent Aim","Team Check","No Recoil"
	}) do
		createToggle(txt,y)
		y+=35
	end
end

-- VISUAL
local function showVisual()
	clear()
	local y=5
	for _,txt in ipairs({
		"ESP Ativar","ESP Nome","ESP Box",
		"ESP Linha","ESP Vida","ESP Esqueleto"
	}) do
		createToggle(txt,y)
		y+=35
	end
end

-- MISC
local function showMisc()
	clear()
	local y=5
	for _,txt in ipairs({
		"Speed","Fly","Spin",
		"Teleport","Auto Farm","Anti AFK"
	}) do
		createToggle(txt,y)
		y+=35
	end
end

-- MAIN
local function showMain()
	clear()
	local y=5
	for _,txt in ipairs({
		"Invisível","X-Ray","Full Bright",
		"Remove Fog","FPS Boost","Reset GUI"
	}) do
		createToggle(txt,y)
		y+=35
	end
end

-- TABS
createTab("Aimbot",0,showAimbot)
createTab("Visual",0.25,showVisual)
createTab("Misc",0.5,showMisc)
createTab("Main",0.75,showMain)

showAimbot()

-- MINIMIZAR
local minimized = false
mini.MouseButton1Click:Connect(function()
	minimized = not minimized
	TweenService:Create(main,TweenInfo.new(0.3),{
		Size = minimized and UDim2.new(0,460,0,35) or UDim2.new(0,460,0,350)
	}):Play()
end)

-- FECHAR
close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- MUDAR COR (clicando no título)
local themes = {
	Color3.fromRGB(0,170,255),
	Color3.fromRGB(255,85,127),
	Color3.fromRGB(0,255,170),
	Color3.fromRGB(255,170,0)
}

local index = 1
title.MouseButton1Click:Connect(function()
	index = index % #themes + 1
	top.BackgroundColor3 = themes[index]
end)
