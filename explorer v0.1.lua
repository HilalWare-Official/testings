-- // ROBLOX STUDIO STYLE EXPLORER (LIGHT THEME) // --

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- // GUI SETUP // --
local TargetParent
if RunService:IsStudio() then
    TargetParent = LocalPlayer:WaitForChild("PlayerGui")
else
    local CoreGui = game:GetService("CoreGui")
    TargetParent = CoreGui or LocalPlayer:WaitForChild("PlayerGui")
end

if TargetParent:FindFirstChild("StudioExplorer") then
    TargetParent.StudioExplorer:Destroy()
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "StudioExplorer"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = TargetParent

-- Ana Pencere
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Window"
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(180, 180, 180)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.Size = UDim2.new(0, 300, 0, 500)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = Gui

-- Başlık Çubuğu
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 25)
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 8, 0, 0)
TitleText.Size = UDim2.new(1, -8, 1, 0)
TitleText.Font = Enum.Font.SourceSans
TitleText.Text = "Explorer - ID: 5570419907"
TitleText.TextColor3 = Color3.fromRGB(50, 50, 50)
TitleText.TextSize = 14
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Kapatma Butonu
local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(100, 100, 100)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -25, 0, 0)
CloseBtn.Font = Enum.Font.SourceSans
CloseBtn.TextSize = 18
CloseBtn.Parent = TitleBar
CloseBtn.MouseButton1Click:Connect(function() Gui:Destroy() end)

-- Arama Çubuğu
local SearchBar = Instance.new("Frame")
SearchBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SearchBar.BorderColor3 = Color3.fromRGB(200, 200, 200)
SearchBar.Position = UDim2.new(0, 4, 0, 28)
SearchBar.Size = UDim2.new(1, -8, 0, 20)
SearchBar.Parent = MainFrame

local SearchText = Instance.new("TextLabel")
SearchText.BackgroundTransparency = 1
SearchText.Size = UDim2.new(1, -4, 1, 0)
SearchText.Position = UDim2.new(0, 4, 0, 0)
SearchText.Text = "Filter workspace (Ctrl+Shift+X)"
SearchText.TextColor3 = Color3.fromRGB(150, 150, 150)
SearchText.TextXAlignment = Enum.TextXAlignment.Left
SearchText.Font = Enum.Font.SourceSans
SearchText.TextSize = 14
SearchText.Parent = SearchBar

-- Liste Alanı
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.Position = UDim2.new(0, 0, 0, 52)
ScrollFrame.Size = UDim2.new(1, 0, 1, -52)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ScrollBarThickness = 8
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)
ScrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
ScrollFrame.Parent = MainFrame

local MainListLayout = Instance.new("UIListLayout")
MainListLayout.SortOrder = Enum.SortOrder.LayoutOrder
MainListLayout.Padding = UDim.new(0, 2)
MainListLayout.Parent = ScrollFrame

local MainPadding = Instance.new("UIPadding")
MainPadding.PaddingLeft = UDim.new(0, 4)
MainPadding.PaddingTop = UDim.new(0, 4)
MainPadding.Parent = ScrollFrame

-- CanvasSize'ı otomatik güncelle
MainListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, MainListLayout.AbsoluteContentSize.Y)
end)

-- // DOĞRU İKON HARİTASI - ASSET ID: 5570419907 // --
local ICON_ID = "rbxassetid://5570419907"

-- Bulduğun doğru koordinatlarla güncellenmiş ikon haritası
local IconMap = {
    -- Servisler ve Temel Objeler
    ["Workspace"] = Vector2.new(128, 16),
    ["Players"] = Vector2.new(16, 16),
    ["Lighting"] = Vector2.new(32, 16),
    ["ReplicatedStorage"] = Vector2.new(48, 0),
    ["ServerScriptService"] = Vector2.new(64, 0),
    ["ServerStorage"] = Vector2.new(80, 0),
    ["StarterPlayer"] = Vector2.new(96, 0),
    ["StarterGui"] = Vector2.new(112, 0),
    ["StarterPack"] = Vector2.new(144, 16),
    ["SoundService"] = Vector2.new(144, 32),
    ["Chat"] = Vector2.new(0, 48),
    
    -- Temel Objeler
    ["Folder"] = Vector2.new(0, 0),
    ["Part"] = Vector2.new(16, 0),
    ["Model"] = Vector2.new(32, 0),
    ["Script"] = Vector2.new(64, 0),
    ["LocalScript"] = Vector2.new(112, 16),
    ["ModuleScript"] = Vector2.new(96, 0),
    
    -- GUI Objeleri
    ["ScreenGui"] = Vector2.new(0, 0),
    ["Frame"] = Vector2.new(0, 0),
    ["TextLabel"] = Vector2.new(0, 0),
    ["TextButton"] = Vector2.new(64, 0),
    ["ImageButton"] = Vector2.new(112, 0),
    
    -- 3D Objeler
    ["MeshPart"] = Vector2.new(16, 0),
    ["UnionOperation"] = Vector2.new(32, 0),
    ["WedgePart"] = Vector2.new(16, 0),
    ["CornerWedgePart"] = Vector2.new(16, 0),
    ["TrussPart"] = Vector2.new(16, 0),
    ["VehicleSeat"] = Vector2.new(16, 0),
    ["Seat"] = Vector2.new(16, 0),
    ["Camera"] = Vector2.new(80, 0),
    ["Terrain"] = Vector2.new(32, 0),
    
    -- Işıklandırma
    ["PointLight"] = Vector2.new(32, 16),
    ["SpotLight"] = Vector2.new(32, 16),
    ["SurfaceLight"] = Vector2.new(32, 16),
    
    -- Ses
    ["Sound"] = Vector2.new(0, 16),
    ["AudioEmitter"] = Vector2.new(0, 16),
    
    -- Data Objeleri
    ["IntValue"] = Vector2.new(64, 0),
    ["StringValue"] = Vector2.new(64, 0),
    ["BoolValue"] = Vector2.new(64, 0),
    ["NumberValue"] = Vector2.new(64, 0),
    ["ObjectValue"] = Vector2.new(64, 0),
    ["CFrameValue"] = Vector2.new(64, 0),
    ["Color3Value"] = Vector2.new(64, 0),
    ["Vector3Value"] = Vector2.new(64, 0),
    ["BrickColorValue"] = Vector2.new(64, 0),
    
    -- Remote Objeler
    ["RemoteEvent"] = Vector2.new(64, 0),
    ["RemoteFunction"] = Vector2.new(64, 0),
    ["BindableEvent"] = Vector2.new(64, 0),
    ["BindableFunction"] = Vector2.new(64, 0),
    
    -- UI Layout
    ["UIListLayout"] = Vector2.new(64, 32),
    ["UIGridLayout"] = Vector2.new(64, 32),
    ["UIPadding"] = Vector2.new(64, 32),
    ["UIAspectRatioConstraint"] = Vector2.new(64, 32),
    ["UISizeConstraint"] = Vector2.new(64, 32),
    ["UITextSizeConstraint"] = Vector2.new(64, 32),
    ["UICorner"] = Vector2.new(64, 32),
    ["UIStroke"] = Vector2.new(64, 32),
    
    -- Mesh'ler
    ["SpecialMesh"] = Vector2.new(128, 0),
    ["BlockMesh"] = Vector2.new(128, 0),
    ["CylinderMesh"] = Vector2.new(128, 0),
    
    -- Fizik
    ["BodyForce"] = Vector2.new(48, 16),
    ["BodyVelocity"] = Vector2.new(48, 16),
    ["BodyAngularVelocity"] = Vector2.new(48, 16),
    ["BodyThrust"] = Vector2.new(48, 16),
    ["RocketPropulsion"] = Vector2.new(48, 16),
    ["BodyGyro"] = Vector2.new(48, 16),
    ["BodyPosition"] = Vector2.new(48, 16),
    
    -- Constraint'ler
    ["Weld"] = Vector2.new(16, 48),
    ["Motor"] = Vector2.new(16, 48),
    ["Motor6D"] = Vector2.new(16, 48),
    ["HingeConstraint"] = Vector2.new(16, 48),
    ["PrismaticConstraint"] = Vector2.new(16, 48),
    
    -- Diğer
    ["ClickDetector"] = Vector2.new(64, 0),
    ["ProximityPrompt"] = Vector2.new(64, 0),
    ["Humanoid"] = Vector2.new(144, 0),
    ["Animation"] = Vector2.new(64, 0),
    ["Tool"] = Vector2.new(96, 16),
    ["Fire"] = Vector2.new(32, 16),
    ["Smoke"] = Vector2.new(32, 16),
    ["Sparkles"] = Vector2.new(32, 16),
    ["Decal"] = Vector2.new(128, 0),
    ["Texture"] = Vector2.new(128, 0),
    
    -- Sky ve Atmosfer
    ["Sky"] = Vector2.new(96, 32),
    ["Atmosphere"] = Vector2.new(96, 32),
    ["Clouds"] = Vector2.new(96, 32),
    
    -- Network
    ["NetworkClient"] = Vector2.new(64, 16),
    ["ClientReplicator"] = Vector2.new(80, 16),
}

local function GetIconOffset(className)
    -- Önce tam eşleşmeyi dene
    if IconMap[className] then
        return IconMap[className]
    end
    
    -- Pattern eşleştirmeleri
    if className:find("Script") then 
        return IconMap["Script"] or Vector2.new(64, 0)
    end
    if className:find("Part") then 
        return IconMap["Part"] or Vector2.new(16, 0)
    end
    if className:find("Gui") then 
        return IconMap["ScreenGui"] or Vector2.new(0, 0)
    end
    if className:find("Value") then 
        return IconMap["StringValue"] or Vector2.new(64, 0)
    end
    if className:find("Constraint") then 
        return IconMap["UIAspectRatioConstraint"] or Vector2.new(64, 32)
    end
    if className:find("Mesh") then 
        return IconMap["SpecialMesh"] or Vector2.new(128, 0)
    end
    if className:find("Light") then 
        return IconMap["PointLight"] or Vector2.new(32, 16)
    end
    if className:find("Force") or className:find("Velocity") or className:find("Gyro") or className:find("Position") then 
        return IconMap["BodyForce"] or Vector2.new(48, 16)
    end
    if className:find("Weld") or className:find("Motor") or className:find("Constraint") then 
        return IconMap["Weld"] or Vector2.new(16, 48)
    end
    if className:find("Audio") then 
        return IconMap["Sound"] or Vector2.new(0, 16)
    end
    
    -- Varsayılan ikon (Folder)
    return IconMap["Folder"] or Vector2.new(0, 0)
end

-- // NODE OLUŞTURMA FONKSİYONU // --
local function CreateNode(obj, parentContainer, indent)
    indent = indent or 0
    
    -- Ana container
    local NodeFrame = Instance.new("Frame")
    NodeFrame.Name = obj.Name
    NodeFrame.BackgroundTransparency = 1
    NodeFrame.Size = UDim2.new(1, 0, 0, 20)
    NodeFrame.AutomaticSize = Enum.AutomaticSize.Y
    NodeFrame.Parent = parentContainer

    local NodeListLayout = Instance.new("UIListLayout")
    NodeListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    NodeListLayout.Parent = NodeFrame

    -- Üst satır (görünür kısım)
    local TopRow = Instance.new("Frame")
    TopRow.Name = "TopRow"
    TopRow.BackgroundTransparency = 1
    TopRow.Size = UDim2.new(1, 0, 0, 20)
    TopRow.Parent = NodeFrame

    -- Expand butonu
    local ExpandArrow = Instance.new("TextLabel")
    ExpandArrow.Name = "ExpandArrow"
    ExpandArrow.Size = UDim2.new(0, 16, 0, 16)
    ExpandArrow.Position = UDim2.new(0, indent, 0, 2)
    ExpandArrow.BackgroundTransparency = 1
    ExpandArrow.Text = "▶"
    ExpandArrow.TextColor3 = Color3.fromRGB(100, 100, 100)
    ExpandArrow.TextSize = 10
    ExpandArrow.TextXAlignment = Enum.TextXAlignment.Center
    ExpandArrow.TextYAlignment = Enum.TextYAlignment.Center
    ExpandArrow.Parent = TopRow

    -- İKON
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Size = UDim2.new(0, 16, 0, 16)
    Icon.Position = UDim2.new(0, indent + 18, 0, 2)
    Icon.BackgroundTransparency = 1
    Icon.Image = ICON_ID
    Icon.ImageRectSize = Vector2.new(16, 16)
    Icon.ImageRectOffset = GetIconOffset(obj.ClassName)
    Icon.Parent = TopRow

    -- İsim
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -(indent + 38), 1, 0)
    NameLabel.Position = UDim2.new(0, indent + 38, 0, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = obj.Name
    NameLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    NameLabel.Font = Enum.Font.SourceSans
    NameLabel.TextSize = 14
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    NameLabel.Parent = TopRow

    -- Tıklama butonu
    local ClickButton = Instance.new("TextButton")
    ClickButton.Size = UDim2.new(1, 0, 1, 0)
    ClickButton.BackgroundTransparency = 1
    ClickButton.Text = ""
    ClickButton.ZIndex = 5
    ClickButton.Parent = TopRow

    -- Çocuklar container'ı
    local ChildrenContainer = Instance.new("Frame")
    ChildrenContainer.Name = "ChildrenContainer"
    ChildrenContainer.BackgroundTransparency = 1
    ChildrenContainer.Size = UDim2.new(1, 0, 0, 0)
    ChildrenContainer.AutomaticSize = Enum.AutomaticSize.Y
    ChildrenContainer.Visible = false
    ChildrenContainer.Parent = NodeFrame

    local ChildrenLayout = Instance.new("UIListLayout")
    ChildrenLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ChildrenLayout.Parent = ChildrenContainer

    -- Çocuk kontrolü
    local hasChildren = false
    local childrenLoaded = false
    
    local function CheckChildren()
        local success, children = pcall(function()
            return obj:GetChildren()
        end)
        hasChildren = success and #children > 0
        return hasChildren
    end
    
    hasChildren = CheckChildren()
    
    -- Çocuk yoksa ok'u gizle
    if not hasChildren then
        ExpandArrow.Text = ""
    end

    -- Tıklama olayı
    ClickButton.MouseButton1Click:Connect(function()
        if hasChildren then
            -- EXPAND/COLLAPSE işlemi
            if ChildrenContainer.Visible then
                -- KAPAT
                ChildrenContainer.Visible = false
                ExpandArrow.Text = "▶"
                ExpandArrow.TextColor3 = Color3.fromRGB(100, 100, 100)
            else
                -- AÇ
                ChildrenContainer.Visible = true
                ExpandArrow.Text = "▼"
                ExpandArrow.TextColor3 = Color3.fromRGB(0, 0, 0)
                
                -- İlk kez açılıyorsa çocukları yükle
                if not childrenLoaded then
                    local success, children = pcall(function()
                        return obj:GetChildren()
                    end)
                    
                    if success then
                        table.sort(children, function(a, b)
                            return a.Name:lower() < b.Name:lower()
                        end)
                        
                        for _, child in ipairs(children) do
                            CreateNode(child, ChildrenContainer, indent + 20)
                        end
                        childrenLoaded = true
                    end
                end
            end
        else
            -- Sadece seçim işlemi
            -- Tüm seçimleri temizle
            for _, descendant in ipairs(ScrollFrame:GetDescendants()) do
                if descendant:IsA("Frame") and descendant.Name == "TopRow" then
                    descendant.BackgroundTransparency = 1
                end
            end
            
            -- Bu öğeyi seç
            TopRow.BackgroundTransparency = 0
            TopRow.BackgroundColor3 = Color3.fromRGB(204, 232, 255)
        end
    end)
end

-- // SERVİSLERİ YÜKLE - DÜZELTİLDİ // --
local function LoadServices()
    local servicesToLoad = {
        "Workspace",
        "Players", 
        "Lighting",
        "ReplicatedStorage",
        "ServerScriptService",
        "ServerStorage",
        "StarterPlayer",
        "StarterGui",
        "StarterPack",
        "SoundService",
        "Chat",
        "Teams"
    }
    
    local loadedCount = 0
    
    for _, serviceName in ipairs(servicesToLoad) do
        local success, service = pcall(function()
            return game:GetService(serviceName)
        end)
        
        if success and service then
            CreateNode(service, ScrollFrame, 0)
            loadedCount = loadedCount + 1
            print("✓ " .. serviceName .. " yüklendi")
        else
            print("✗ " .. serviceName .. " yüklenemedi")
        end
    end
    
    print("Toplam " .. loadedCount .. " servis yüklendi")
    
    -- Workspace'i otomatik aç
    task.wait(0.5)
    local workspaceNode = ScrollFrame:FindFirstChild("Workspace")
    if workspaceNode then
        local topRow = workspaceNode:FindFirstChild("TopRow")
        if topRow then
            local clickButton = topRow:FindFirstChildOfClass("TextButton")
            if clickButton then
                clickButton:Fire("MouseButton1Click")
                print("Workspace otomatik olarak açıldı")
            end
        end
    end
end

-- Script başladığında servisleri yükle
LoadServices()

print("=== EXPLORER YÜKLENDİ ===")
print("Asset ID: 5570419907")
print("Doğru ikon koordinatları ile çalışıyor!")
