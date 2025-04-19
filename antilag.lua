
local RunService    = game:GetService("RunService")
local Players       = game:GetService("Players")
local Lighting      = game:GetService("Lighting")
local CoreGui       = game:GetService("CoreGui")
local ContentP      = game:GetService("ContentProvider")

local player = Players.LocalPlayer
local SHOW_FPS       = true              -- show FPS counter?
local QUALITY_LEVEL  = 1                 -- 1=lowest, 10=highest


local lastgui = CoreGui:FindFirstChild("de_fpsboosterlolz")
if lastgui then
    lastgui:Destroy()
end
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "de_fpsboosterlolz"
gui.ResetOnSpawn = false


local label = Instance.new("TextLabel", gui)
label.Size = UDim2.new(1,0,1,0)
label.BackgroundTransparency = 1
label.Font = Enum.Font.FredokaOne
label.TextColor3 = Color3.new(1,1,1)
label.TextScaled = true
label.Text = [[Disclaimer
this script will completely change the following properties / instances
Material, Surfaces, RenderFidelity, CastShadow, GlobalShadow, Enabled
ParticleEmitter, Beam, Trail, Decal, Texture
and this will force your client (if supported) to lower rendering quality]]
local stroke = Instance.new("UIStroke", label)
stroke.Color = Color3.new(0,0,0)
stroke.Thickness = 3
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
task.wait(5)
label:Destroy()
-- harsh lighting settings
Lighting.GlobalShadows = false

-- force low render quality (may error on some clients)
pcall(function()
	if settings().Rendering then
		settings().Rendering.QualityLevel = QUALITY_LEVEL
	end
end)

-- ========== OPTIMIZER FUNCTION ========== --
local function optimize(desc)
	if not desc or not desc.Parent then return end

	-- Remove super‑heavy objects
	if desc:IsA("ParticleEmitter")
		or desc:IsA("Trail")
		or desc:IsA("Beam")
		or desc:IsA("Fire")
		or desc:IsA("Smoke")
	then
		desc.Enabled = false
		return
	end

	-- Kill bulky decals/textures
	if desc:IsA("Texture")
		or desc:IsA("Decal")
	then
		desc:Destroy()
		return
	end
	
	if desc:IsA("MeshPart") then
		desc.RenderFidelity = Enum.RenderFidelity.Performance
	end
	-- Simplify all BaseParts
	if desc:IsA("BasePart") then
		desc.Material     = Enum.Material.SmoothPlastic
		desc.CastShadow   = false
		desc.TopSurface   = Enum.SurfaceType.Smooth
		desc.BottomSurface= Enum.SurfaceType.Smooth
		desc.FrontSurface = Enum.SurfaceType.Smooth
		desc.BackSurface  = Enum.SurfaceType.Smooth
		desc.LeftSurface  = Enum.SurfaceType.Smooth
		desc.RightSurface = Enum.SurfaceType.Smooth
	end
end

-- ========== INITIAL SWEEP ========== --
for _, obj in ipairs(workspace:GetDescendants()) do
	optimize(obj)
end

-- ========== DYNAMIC LISTENERS ========== --
workspace.DescendantAdded:Connect(optimize)
Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(chr)
		-- optimize existing and future character parts
		for _, d in ipairs(chr:GetDescendants()) do optimize(d) end
		chr.DescendantAdded:Connect(optimize)
	end)
end)

-- ========== FPS COUNTER ========== --

	fpsLabel = Instance.new("TextLabel", gui)
	fpsLabel.Size            = UDim2.new(0.05,0,0.05,0)
	fpsLabel.Position        = UDim2.new(0,0,0,0)
	fpsLabel.BackgroundTransparency = 1
	fpsLabel.TextScaled      = true
	fpsLabel.Font            = Enum.Font.FredokaOne
	fpsLabel.TextColor3      = Color3.new(1,1,1)
	fpsLabel.Text            = "fps booster!!"

local stroke = Instance.new("UIStroke", fpsLabel)
stroke.Color = Color3.new(0,0,0)
stroke.Thickness = 3
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual

local frameCount, lastTime = 0, tick()
RunService.RenderStepped:Connect(function()
	if fpsLabel then
		frameCount += 1
		local now = tick()
		if now - lastTime >= 1 then
			fpsLabel.Text = "["..frameCount.."]"
			frameCount, lastTime = 0, now
		end
	end
end)


		Lighting.GlobalShadows = false
		if settings().Rendering then
			settings().Rendering.QualityLevel = true and QUALITY_LEVEL or 10
		end
