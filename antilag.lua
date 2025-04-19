task.wait(5)
--[[ Ultimate Anti‑Lag LocalScript ]]--
local RunService    = game:GetService("RunService")
local Players       = game:GetService("Players")
local Lighting      = game:GetService("Lighting")
local CoreGui       = game:GetService("CoreGui")
local ContentP      = game:GetService("ContentProvider")

local player = Players.LocalPlayer
local SHOW_FPS       = true              -- show FPS counter?
local QUALITY_LEVEL  = 1                 -- 1=lowest, 10=highest

-- ========== SETTINGS ========== --
-- sharpen up any textures (forces lower mip levels)
pcall(function()
	ContentP:SetBaseMipLevel(4)
end)
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
	local gui = Instance.new("ScreenGui", CoreGui)
	gui.Name = tostring(math.random(0,9999)..math.random(0,9999))
	gui.ResetOnSpawn = false

	fpsLabel = Instance.new("TextLabel", gui)
	fpsLabel.Size            = UDim2.new(0.1,0,0.1,0)
	fpsLabel.Position        = UDim2.new(0,0,0,0)
	fpsLabel.BackgroundTransparency = 1
	fpsLabel.TextScaled      = true
	fpsLabel.Font            = Enum.Font.FredokaOne
	fpsLabel.TextColor3      = Color3.new(1,1,1)
	fpsLabel.Text            = "fps booster!!"
for i = 1, 5 do
	fpsLabel.TextTransparency = 1
	task.wait(0.1)
	fpsLabel.TextTransparency = 0
end

fpsLabel.Text = "by someoneus"
task.wait(0.1)

local frameCount, lastTime = 0, tick()
RunService.RenderStepped:Connect(function()
	if show and fpsLabel then
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
			settings().Rendering.QualityLevel = show and QUALITY_LEVEL or 10
		end

