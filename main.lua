-- MGZMODZ | ULTRA UI

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- SAVE CONFIG
local config = {}
local function save()
	if writefile then
		writefile("mgzmodz.json", game:GetService("HttpService"):JSONEncode(config))
	end
end

local function load()
	if readfile and isfile and isfile("mgzmodz.json") then
		config = game:GetService("HttpService"):JSONDecode(readfile("mgzmodz.json"))
	end
end
load()

-- GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

-- OPEN BUTTON
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0,120,0,35)
openBtn.Position = UDim2.new(0,20,0.5,0)
openBtn.Text = "MGZMODZ"
openBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,480,0,360)
main.Position = UDim2.new(0.5,-240,0.5,-180)
main.BackgroundColor3 = Color3.fromRGB(18,18,28)
main.Visible = false

-- DRAG
local dragging, dragInput, startPos, startFrame
main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		startPos = input.Position
		startFrame = main.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - startPos
		main.Position = UDim2.new(
			startFrame.X.Scale,
			startFrame.X.Offset + delta.X,
			startFrame.Y.Scale,
			startFrame.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- TOP BAR
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,35)
top.BackgroundColor3 = Color3.fromRGB(12,12,20)

local title = Instance.new("TextButton", top)
title.Size = UDim2.new(1,-90,1,0)
title.Text = "MGZMODZ HUB"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)

local close = Instance.new("TextButton", top)
close.Size = UDim2.new(0,30,1,0)
close.Position = UDim2.new(1,-30,0,0)
close.Text = "X"

local mini = Instance.new("TextButton", top)
mini.Size = UDim2.new(0,30,1,0)
mini.Position = UDim2.new(1,-60,0,0)
mini.Text = "-"

local themeBtn = Instance.new("TextButton", top)
themeBtn.Size = UDim2.new(0,30,1,0)
themeBtn.Position = UDim2.new(1,-90,0,0)
themeBtn.Text = "🎨"

-- CONTENT
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1,0,1,-70)
content.Position = UDim2.new(0,0,0,70)
content.BackgroundTransparency = 1

local function clear()
	for _,v in pairs(content:GetChildren()) do
		v:Destroy()
	end
end

-- TOGGLE
local function createToggle(name,y)
	local state = config[name] or false
	
	local btn = Instance.new("TextButton", content)
	btn.Size = UDim2.new(0.9,0,0,30)
	btn.Position = UDim2.new(0.05,0,0,y)
	
	local function update()
		btn.Text = name.." : "..(state and "ON" or "OFF")
		btn.BackgroundColor3 = state and Color3.fromRGB(0,170,255) or Color3.fromRGB(35,35,50)
	end
	
	update()
	
	btn.MouseButton1Click:Connect(function()
		state = not state
		config[name] = state
		update()
		save()
	end)
end

-- SLIDER
local function createSlider(name,min,max,y)
	local value = config[name] or min
	
	local box = Instance.new("TextBox", content)
	box.Size = UDim2.new(0.9,0,0,30)
	box.Position = UDim2.new(0.05,0,0,y)
	box.Text = name..": "..value
	
	box.FocusLost:Connect(function()
		local num = tonumber(box.Text:match("%d+"))
		if num then
			value = math.clamp(num,min,max)
			config[name] = value
			box.Text = name..": "..value
			save()
		end
	end)
end

-- TABS
local function tab(name,x,func)
	local b = Instance.new("TextButton", main)
	b.Size = UDim2.new(0.25,0,0,35)
	b.Position = UDim2.new(x,0,0,35)
	b.Text = name
	b.BackgroundColor3 = Color3.fromRGB(25,25,35)
	b.TextColor3 = Color3.new(1,1,1)
	
	b.MouseButton1Click:Connect(func)
end

-- PAGES
local function aimbot()
	clear()
	local y=5
	createToggle("Aimbot",y); y+=35
	createToggle("FOV",y); y+=35
	createSlider("FOV Size",50,300,y); y+=35
	createToggle("Silent Aim",y); y+=35
	createToggle("Team Check",y); y+=35
	createToggle("No Recoil",y)
end

local function visual()
	clear()
	local y=5
	createToggle("ESP",y); y+=35
	createToggle("Name",y); y+=35
	createToggle("Box",y); y+=35
	createToggle("Line",y); y+=35
	createToggle("Health",y); y+=35
	createToggle("Skeleton",y)
end

local function misc()
	clear()
	local y=5
	createToggle("Speed",y); y+=35
	createSlider("Speed Value",16,200,y); y+=35
	createToggle("Fly",y); y+=35
	createToggle("Spin",y); y+=35
	createToggle("Teleport",y); y+=35
	createToggle("Auto Farm",y)
end

local function mainTab()
	clear()
	local y=5
	createToggle("Invisible",y); y+=35
	createToggle("Xray",y); y+=35
	createToggle("Full Bright",y); y+=35
	createToggle("No Fog",y); y+=35
	createToggle("FPS Boost",y); y+=35
	createToggle("Reset UI",y)
end

tab("Aimbot",0,aimbot)
tab("Visual",0.25,visual)
tab("Misc",0.5,misc)
tab("Main",0.75,mainTab)

aimbot()

-- OPEN / CLOSE
openBtn.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-- MINIMIZE
local minimized = false
mini.MouseButton1Click:Connect(function()
	minimized = not minimized
	TweenService:Create(main,TweenInfo.new(0.25),{
		Size = minimized and UDim2.new(0,480,0,35) or UDim2.new(0,480,0,360)
	}):Play()
end)

-- CLOSE
close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- THEMES
local themes = {
	Color3.fromRGB(0,170,255),
	Color3.fromRGB(255,85,127),
	Color3.fromRGB(0,255,170),
	Color3.fromRGB(255,170,0)
}

local t=1
themeBtn.MouseButton1Click:Connect(function()
	t = t % #themes + 1
	top.BackgroundColor3 = themes[t]
end)
