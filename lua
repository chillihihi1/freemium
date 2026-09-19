-- [[ RONNEI HUB - FAST LAUNCH & GRAPHICS ENHANCER ]] --

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- 1. TẢI SCRIPT CHÍNH SONG SONG (CHỐNG DỰT LAG / ĐỨNG MÀN HÌNH)
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/robvxs24/freemium/refs/heads/main/chillviethoa.lua"))()
    end)
end)

-- 2. TỐI ƯU MÀU SẮC ĐỒ HỌA TƯƠI SÁNG & SẮC NÉT (SHADERS MOD)
task.spawn(function()
    pcall(function()
        -- Tinh chỉnh ánh sáng rực rỡ trong trẻo
        Lighting.GlobalShadows = true
        Lighting.ClockTime = 14
        Lighting.Brightness = 2
        Lighting.OutdoorAmbient = Color3.fromRGB(130, 150, 180)
        Lighting.Ambient = Color3.fromRGB(100, 100, 110)

        -- Dọn dẹp Effect cũ
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Atmosphere") then
                v:Destroy()
            end
        end

        -- Tăng độ tươi, rực rỡ màu sắc (Color Correction)
        local CC = Instance.new("ColorCorrectionEffect")
        CC.Name = "RonneiColorBoost"
        CC.Brightness = 0.04
        CC.Contrast = 0.12
        CC.Saturation = 0.35
        CC.Parent = Lighting

        -- Hiệu ứng phát sáng mượt (Bloom)
        local Bloom = Instance.new("BloomEffect")
        Bloom.Name = "RonneiBloom"
        Bloom.Intensity = 0.35
        Bloom.Size = 22
        Bloom.Threshold = 0.8
        Bloom.Parent = Lighting

        -- Tia sáng mặt trời dịu nhẹ (Sun Rays)
        local SunRays = Instance.new("SunRaysEffect")
        SunRays.Name = "RonneiSunRays"
        SunRays.Intensity = 0.12
        SunRays.Spread = 0.8
        SunRays.Parent = Lighting

        -- Dọn dẹp hạt hiệu ứng thừa làm nặng máy
        local function CleanParticles(v)
            if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end

        for _, v in ipairs(workspace:GetDescendants()) do CleanParticles(v) end
        workspace.DescendantAdded:Connect(CleanParticles)
    end)
end)

-- 3. WATERMARK CỐ ĐỊNH SÁT MÉP TRÊN (BACKGROUND MỜ MỜ)
local sg = Instance.new("ScreenGui")
sg.Name = "RonneiBypassWatermark"
sg.ResetOnSpawn = false

pcall(function() sg.Parent = CoreGui end)
if not sg.Parent then sg.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") end

local Card = Instance.new("Frame")
Card.Size = UDim2.new(0, 360, 0, 52)
Card.Position = UDim2.new(0.5, -180, 0, 2)
Card.BackgroundColor3 = Color3.fromRGB(15, 18, 25)
Card.BackgroundTransparency = 0.35
Card.BorderSizePixel = 0
Card.ClipsDescendants = true
Card.Parent = sg

local CardCorner = Instance.new("UICorner")
CardCorner.CornerRadius = UDim.new(0, 10)
CardCorner.Parent = Card

local CardStroke = Instance.new("UIStroke")
CardStroke.Thickness = 1.2
CardStroke.Transparency = 0.25
CardStroke.Color = Color3.fromRGB(255, 255, 255)
CardStroke.Parent = Card

local StrokeGradient = Instance.new("UIGradient")
StrokeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 210, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(170, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 210, 255))
})
StrokeGradient.Parent = CardStroke

local Badge = Instance.new("Frame")
Badge.Size = UDim2.new(0, 30, 0, 30)
Badge.Position = UDim2.new(0, 10, 0.5, -15)
Badge.BackgroundColor3 = Color3.fromRGB(28, 33, 46)
Badge.BackgroundTransparency = 0.4
Badge.BorderSizePixel = 0
Badge.Parent = Card

local BadgeCorner = Instance.new("UICorner")
BadgeCorner.CornerRadius = UDim.new(0, 6)
BadgeCorner.Parent = Badge

local BadgeText = Instance.new("TextLabel")
BadgeText.Size = UDim2.new(1, 0, 1, 0)
BadgeText.BackgroundTransparency = 1
BadgeText.Text = "🔓"
BadgeText.TextSize = 14
BadgeText.Parent = Badge

local TextVI = Instance.new("TextLabel")
TextVI.Size = UDim2.new(1, -50, 0, 18)
TextVI.Position = UDim2.new(0, 48, 0, 9)
TextVI.BackgroundTransparency = 1
TextVI.Text = "Script được bypass nokey bởi @ronnei7.htk"
TextVI.TextColor3 = Color3.fromRGB(245, 248, 255)
TextVI.Font = Enum.Font.GothamBold
TextVI.TextSize = 11
TextVI.TextXAlignment = Enum.TextXAlignment.Left
TextVI.Parent = Card

local TextEN = Instance.new("TextLabel")
TextEN.Size = UDim2.new(1, -50, 0, 14)
TextEN.Position = UDim2.new(0, 48, 0, 27)
TextEN.BackgroundTransparency = 1
TextEN.Text = "Script bypassed (no key required) by @ronnei7.htk"
TextEN.TextColor3 = Color3.fromRGB(170, 190, 220)
TextEN.Font = Enum.Font.GothamMedium
TextEN.TextSize = 9.5
TextEN.TextXAlignment = Enum.TextXAlignment.Left
TextEN.Parent = Card

task.spawn(function()
    while Card and Card.Parent do
        StrokeGradient.Rotation = (StrokeGradient.Rotation + 2) % 360
        task.wait(0.03)
    end
end)
