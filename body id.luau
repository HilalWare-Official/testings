-- LocalScript (StarterPlayerScripts içine koy)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI oluştur
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BodyIDsGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 260)
frame.Position = UDim2.new(0.5, -210, 0.2, 0)
frame.AnchorPoint = Vector2.new(0.5, 0)
frame.BackgroundTransparency = 0.15
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -12, 0, 28)
title.Position = UDim2.new(0, 6, 0, 6)
title.BackgroundTransparency = 1
title.Text = "Avatar Asset ID'leri"
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansSemibold
title.TextSize = 18
title.Parent = frame

local textbox = Instance.new("TextBox")
textbox.Size = UDim2.new(1, -12, 1, -86)
textbox.Position = UDim2.new(0, 6, 0, 40)
textbox.ClearTextOnFocus = false
textbox.MultiLine = true
textbox.TextWrapped = true
textbox.Font = Enum.Font.Code
textbox.TextSize = 14
textbox.TextXAlignment = Enum.TextXAlignment.Left
textbox.TextYAlignment = Enum.TextYAlignment.Top
textbox.TextColor3 = Color3.new(1,1,1)
textbox.BackgroundTransparency = 0.2
textbox.BackgroundColor3 = Color3.fromRGB(20,20,20)
textbox.Parent = frame

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0, 100, 0, 28)
copyBtn.Position = UDim2.new(1, -106, 1, -34)
copyBtn.AnchorPoint = Vector2.new(0,0)
copyBtn.Text = "Kopyala"
copyBtn.Font = Enum.Font.SourceSans
copyBtn.TextSize = 14
copyBtn.Parent = frame

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0, 100, 0, 28)
refreshBtn.Position = UDim2.new(1, -216, 1, -34)
refreshBtn.Text = "Yenile"
refreshBtn.Font = Enum.Font.SourceSans
refreshBtn.TextSize = 14
refreshBtn.Parent = frame

-- HumanoidDescription alıp ID'leri string haline çevir
local function gatherIDs()
    local success, desc = pcall(function()
        return Players:GetHumanoidDescriptionFromUserId(player.UserId)
    end)
    if not success or not desc then
        return nil, "HumanoidDescription alınamadı."
    end

    local t = {}
    -- Temel properties (var olanlar)
    local keys = {
        "Head", "Face", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg",
        "Shirt", "Pants", "ShirtGraphic",
        "BackAccessory", "WaistAccessory",
        "AccessoryBlob", -- accessoriestopla ciğerinden veri alır (bazen uzun string)
        "BodyTypeScale", "DepthScale", "HeightScale", "ProportionScale", "HeadScale"
    }

    for _, k in ipairs(keys) do
        local ok, val = pcall(function() return desc[k] end)
        if ok and val ~= nil and tostring(val) ~= "" then
            t[#t+1] = string.format("%s = %s", k, tostring(val))
        end
    end

    -- Eğer WaistAccessory veya BackAccessory gibi virgülle ayrılmış listeler varsa onları göster
    if desc.WaistAccessory and desc.WaistAccessory ~= "" then
        t[#t+1] = "WaistAccessory (list) = " .. tostring(desc.WaistAccessory)
    end
    if desc.BackAccessory and desc.BackAccessory ~= "" then
        t[#t+1] = "BackAccessory (list) = " .. tostring(desc.BackAccessory)
    end

    -- AccessoryBlob uzun olabilir; kullanıcıya özet göster
    if desc.AccessoryBlob and desc.AccessoryBlob ~= "" then
        t[#t+1] = "AccessoryBlob (büyük string; katmanlı giyim/aksesuar verisi)"
    end

    return table.concat(t, "\n"), nil
end

local function refresh()
    local text, err = gatherIDs()
    if not text then
        textbox.Text = "Hata: " .. tostring(err)
    else
        textbox.Text = text
    end
end

-- Kopyala butonu: önce setclipboard varsa dener; yoksa TextBox'ı seçip manuel kopyalama için hazır eder
copyBtn.MouseButton1Click:Connect(function()
    local toCopy = textbox.Text
    if not toCopy or toCopy == "" then return end

    -- setclipboard varsa güvenli şekilde kullan (pcall)
    local ok, setcb = pcall(function() return setclipboard end)
    if ok and type(setcb) == "function" then
        local sOk, sErr = pcall(function() setclipboard(toCopy) end)
        if sOk then
            copyBtn.Text = "Kopyalandı!"
            wait(1.2)
            copyBtn.Text = "Kopyala"
            return
        end
    end

    -- setclipboard yoksa TextBox'ta seçili bırak ve kullanıcıya kopyalama talimatı ver
    textbox:CaptureFocus()
    copyBtn.Text = "Ctrl+C ile kopyala"
    wait(1.6)
    copyBtn.Text = "Kopyala"
end)

refreshBtn.MouseButton1Click:Connect(refresh)

-- otomatik ilk doldurma
refresh()
