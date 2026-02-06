-- [[ PREMIUM SIMPLE GUI ]] --
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PremiumLogicGUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Variabel Kontrol
_G.FastFarm = false

-- Frame Utama
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 160)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Top Bar (Minimize Area)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "PREMIUM V2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -32, 0, 2)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.BackgroundTransparency = 1
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.Parent = TopBar

-- Tombol Auto Summit
local AutoBtn = Instance.new("TextButton")
AutoBtn.Size = UDim2.new(0, 190, 0, 45)
AutoBtn.Position = UDim2.new(0.5, -95, 0, 50)
AutoBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
AutoBtn.Text = "AUTO SUMMIT: OFF"
AutoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoBtn.Font = Enum.Font.GothamBold
AutoBtn.Parent = MainFrame

local Corner1 = Instance.new("UICorner")
Corner1.Parent = AutoBtn

-- Tombol Copy Link
local CopyBtn = Instance.new("TextButton")
CopyBtn.Size = UDim2.new(0, 190, 0, 45)
CopyBtn.Position = UDim2.new(0.5, -95, 0, 105)
CopyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CopyBtn.Text = "COPY GROUP LINK"
CopyBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.Parent = MainFrame

local Corner2 = Instance.new("UICorner")
Corner2.Parent = CopyBtn

-- [[ DRAG & MINIMIZE ]] --
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    local targetSize = minimized and UDim2.new(0, 220, 0, 35) or UDim2.new(0, 220, 0, 160)
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = targetSize}):Play()
    MinBtn.Text = minimized and "+" or "-"
end)

CopyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://chat.whatsapp.com/I8hG44FLgrRAwQcS3lvEft")
    CopyBtn.Text = "LINK COPIED!"
    task.wait(1)
    CopyBtn.Text = "COPY GROUP LINK"
end)

-- [[ LOGIC MENTAH KAMU (TIDAK DIUBAH) ]] --
AutoBtn.MouseButton1Click:Connect(function()
    _G.FastFarm = not _G.FastFarm
    if _G.FastFarm then
        AutoBtn.Text = "AUTO SUMMIT: ON"
        AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 100)
        
        -- EKSEKUSI LOGIC MENTAH KAMU DISINI
        print("Instant Summit Mounth Setapak")

        local workspace = game:GetService("Workspace")
        local Player = game.Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local root = Character:WaitForChild("HumanoidRootPart")

        -- 1. PANCINGAN AWAL KE IVY_A (Sekali Saja)
        local function pancingIvy()
            local static = workspace:WaitForChild("Static")
            local ivy = static:FindFirstChild("Ivy_A", true)
            if ivy then
                local targetCF = (ivy:IsA("Model") and ivy:GetModelCFrame()) or ivy.CFrame
                root.CFrame = targetCF
                print("succes")
                task.wait(2) -- Jeda biar folder Checkpoints ke-load sempurna
            end
        end

        -- 2. FUNGSI TELEPORT INSTANT
        local function instantTP(name)
            local checkpoints = workspace:FindFirstChild("Checkpoints")
            if checkpoints then
                local target = checkpoints:FindFirstChild(name, true)
                if target then
                    local targetCF = (target:IsA("Model") and target:GetModelCFrame()) or target.CFrame
                    root.CFrame = targetCF
                    return true
                end
            end
            return false
        end

        -- EKSEKUSI
        pcall(pancingIvy)

        print("start instant summit")
        
        task.spawn(function()
            while _G.FastFarm do
                -- Teleport ke SUMMIT
                if instantTP("SUMMIT") then
                    task.wait(0.2) 
                end
                
                -- Teleport ke C1
                if instantTP("C1") then
                    task.wait(0.2)
                end
                
                task.wait() 
            end
        end)
    else
        AutoBtn.Text = "AUTO SUMMIT: OFF"
        AutoBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    end
end)
