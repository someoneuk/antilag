local run = game:GetService("RunService")
local core = game:GetService("CoreGui")

-- Create GUI
local screengui = Instance.new("ScreenGui")
screengui.Name = "FPS_Counter"
screengui.Parent = core
screengui.ResetOnSpawn = false

local label = Instance.new("TextLabel")
label.Parent = screengui
label.Size = UDim2.new(0.1, 0, 0.1, 0)
label.Position = UDim2.new(0, 10, 0, 10)
label.Font = Enum.Font.FredokaOne
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Text = "Optimizing"
label.TextScaled = true
local st = Instance.new("UIStroke", label)
st.Color = Color3.fromRGB(0,0,0)
st.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
st.Thickness = 3

for _, v in pairs(game.Workspace:GetDescendants()) do
if v:IsA("BasePart") then
v.Material = Enum.Material.SmoothPlastic
v.TopSurface = Enum.SurfaceType.Smooth
v.BottomSurface = Enum.SurfaceType.Smooth
v.RightSurface = Enum.SurfaceType.Smooth
v.LeftSurface = Enum.SurfaceType.Smooth
v.FrontSurface = Enum.SurfaceType.Smooth
v.BackSurface = Enum.SurfaceType.Smooth
end
if v:IsA("Texture") or v:IsA("Decal") then
    v:Destroy()
  end
end
-- FPS logic
local frames = 0
local lastTime = tick()


label.Text = "FPS: 0"
run.RenderStepped:Connect(function()
	frames += 1
	local now = tick()
	if now - lastTime >= 1 then
		label.Text = "FPS: " .. tostring(frames)
		frames = 0
		lastTime = now
	end
end)
