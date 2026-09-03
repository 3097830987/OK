-- Open Source :P
-- Last updated: 02/09/2026 6:48 PM (GMT+2)
-- @cpplibrary was here

local httpService = game:GetService("HttpService")
local starterGui = game:GetService("StarterGui")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")
_G.HiddenUsers = { "FriendsUsernameHere" }

local f1, f2, f3, f4, f5, f6, f7, rivalsInfoHUD, uiListLayout, textLabel, playerGui,
  requestProfile, v1, v2, v3, v4, rivalsHUD, v5, scrollingFrame, waitForChild, text, v6, v7, f8,
  f9, v8, v9, v10, f10, f11

if _G.ProfilesHUDLoaded then
  return
else
  _G.ProfilesHUDLoaded = true

  if not game:IsLoaded() then
    game.Loaded:Wait()
  end

  local v11 = syn and syn.request

  local v12 = v11
  v12 = v11 or http and http.request or request

  -- Discord invite removed

  RankColors = {
    Unranked = "#ffffff",
    Bronze = "#CD7F32",
    Silver = "#C0C0C0",
    Gold = "#FFD700",
    Platinum = "#00fbff",
    Diamond = "#3573e6",
    Onyx = "#41315e",
    Nemesis = "#b700ff",
    Archnemesis = "#1900ff",
  }

  local localPlayer = players.LocalPlayer
  playerGui = localPlayer:WaitForChild("PlayerGui")
  requestProfile = replicatedStorage:WaitForChild("Remotes"):WaitForChild("Misc"):WaitForChild("RequestProfile")
  v1 = {}

  pcall(function()
    for key, value in pairs(require(replicatedStorage.Modules.SeasonLibrary).CurrentSeason.RankProfile.Ranks) do
      if value.Image then
        v1[key] = type(value.Image) == "string" and value.Image
          or "rbxassetid://" .. tostring(value.Image)
      end
    end
  end)

  v2 = tick()

  local function f12(p1)
    local gsub = p1:gsub("#", "")
    local v13 = tonumber(gsub:sub(1, 2), 16)
    local v14 = tonumber(gsub:sub(3, 4), 16)
    local v15 = tonumber(gsub:sub(5, 6), 16)
    return Color3.fromRGB(v13, v14, v15)
  end

  local v16 = {}

  if _G.HiddenUsers then
    for index, value2 in ipairs(_G.HiddenUsers) do
      v16[value2] = true
    end
  end

  v16[localPlayer.Name] = true
  local v17 = {}

  for key2, value3 in pairs(RankColors) do
    v17[key2] = f12(value3)
  end

  v3 = {
    HiddenUsers = v16,
    RankColors = v17,
    RequestGap = 0.1,
    RetryDelay = 8,
    MaxRetries = 999,
  }

  v4 = {
    BgDark = Color3.fromRGB(10, 10, 10),
    BgCard = Color3.fromRGB(20, 20, 20),
    AccentBlue = Color3.fromRGB(74, 124, 155),
    AccentLight = Color3.fromRGB(93, 154, 196),
    AccentDark = Color3.fromRGB(58, 98, 120),
    TextWhite = Color3.fromRGB(255, 255, 255),
    TextGray = Color3.fromRGB(160, 160, 160),
    TextDim = Color3.fromRGB(102, 102, 102),
    StatusGreen = Color3.fromRGB(76, 175, 80),
  }

  function f1(p2)
    if type(p2) ~= "number" or p2 < 0 then
      return "N/A"
    end

    return string.format("%.2f%%", p2 * 100)
  end

  function f2(p3)
    local customLeaderstats = p3:FindFirstChild("CustomLeaderstats")

    if customLeaderstats then
      local winStreak = customLeaderstats:FindFirstChild("Win Streak")

      if winStreak then
        return winStreak.Value
      end

      return 0
    end

    return 0
  end

  function f3(p4)
    if type(p4) ~= "number" or p4 < 1 then
      return "Unranked", "Unranked", v1.Unranked
    end

    local v18, v19

    if p4 >= 12500 then
      v18 = "Archnemesis"
      v19 = "Archnemesis"
    elseif p4 >= 3600 then
      v18 = "Nemesis"
      v19 = "Nemesis"
    elseif p4 >= 3400 then
      v18 = "Onyx 3"
      v19 = "Onyx"
    elseif p4 >= 3200 then
      v18 = "Onyx 2"
      v19 = "Onyx"
    elseif p4 >= 3000 then
      v18 = "Onyx 1"
      v19 = "Onyx"
    elseif p4 >= 2800 then
      v18 = "Diamond 3"
      v19 = "Diamond"
    elseif p4 >= 2600 then
      v18 = "Diamond 2"
      v19 = "Diamond"
    elseif p4 >= 2400 then
      v18 = "Diamond 1"
      v19 = "Diamond"
    elseif p4 >= 2200 then
      v18 = "Platinum 3"
      v19 = "Platinum"
    elseif p4 >= 2000 then
      v18 = "Platinum 2"
      v19 = "Platinum"
    elseif p4 >= 1800 then
      v18 = "Platinum 1"
      v19 = "Platinum"
    elseif p4 >= 1600 then
      v18 = "Gold 3"
      v19 = "Gold"
    elseif p4 >= 1400 then
      v18 = "Gold 2"
      v19 = "Gold"
    elseif p4 >= 1200 then
      v18 = "Gold 1"
      v19 = "Gold"
    elseif p4 >= 1000 then
      v18 = "Silver 3"
      v19 = "Silver"
    elseif p4 >= 800 then
      v18 = "Silver 2"
      v19 = "Silver"
    elseif p4 >= 600 then
      v18 = "Silver 1"
      v19 = "Silver"
    elseif p4 >= 400 then
      v18 = "Bronze 3"
      v19 = "Bronze"
    elseif p4 >= 200 then
      v18 = "Bronze 2"
      v19 = "Bronze"
    else
      v18 = "Bronze 1"
      v19 = "Bronze"
    end

    return v18, v19, v1[v18]
  end

  function f4(p5)
    return v3.RankColors[p5] or v4.TextGray
  end

  function f5(p6)
    local v20 = math.floor(p6 / 3600)
    return string.format("%02d:%02d:%02d", v20, math.floor(p6 % 3600 / 60), math.floor(p6 % 60))
  end

  function f6(p7)
    return type(p7) == "table"
      and (p7.Level ~= nil or p7.RankedCurrentELO ~= nil or p7.CasualWinPercent ~= nil)
  end

  rivalsHUD = Instance.new("ScreenGui")
  rivalsHUD.Name = "RivalsHUD"
  rivalsHUD.ResetOnSpawn = false
  rivalsHUD.DisplayOrder = 999999
  rivalsHUD.Parent = playerGui

  rivalsInfoHUD = Instance.new("ScreenGui")
  rivalsInfoHUD.Name = "RivalsInfoHUD"
  rivalsInfoHUD.ResetOnSpawn = false
  rivalsInfoHUD.DisplayOrder = 999998
  rivalsInfoHUD.Parent = playerGui

  v5 = true

  userInputService.InputBegan:Connect(function(input, p8)
    if not p8 and input.KeyCode == Enum.KeyCode.F3 then
      v5 = not v5
      rivalsHUD.Enabled = v5
      rivalsInfoHUD.Enabled = v5
    end
  end)

  local frame = Instance.new("Frame")
  frame.Size = UDim2.new(0, 300, 0, 400)
  frame.Position = UDim2.new(1, -315, 0, 420)
  frame.BackgroundColor3 = v4.BgCard
  frame.BackgroundTransparency = 0.05
  frame.BorderSizePixel = 0
  frame.Parent = rivalsHUD

  local instance = Instance.new("UICorner", frame)
  instance.CornerRadius = UDim.new(0, 16)

  local frame2 = Instance.new("Frame")
  frame2.Size = UDim2.new(1, -40, 0, 1)
  frame2.Position = UDim2.new(0, 20, 0, 0)
  frame2.BackgroundColor3 = v4.AccentBlue
  frame2.BackgroundTransparency = 0.3
  frame2.BorderSizePixel = 0
  frame2.Parent = frame

  local uiStroke = Instance.new("UIStroke")
  uiStroke.Color = v4.AccentBlue
  uiStroke.Transparency = 0.8
  uiStroke.Thickness = 1
  uiStroke.Parent = frame

  local frame3 = Instance.new("Frame")
  frame3.Size = UDim2.new(1, -12, 0, 32)
  frame3.Position = UDim2.new(0, 6, 0, 6)
  frame3.BackgroundColor3 = v4.BgDark
  frame3.BackgroundTransparency = 0.1
  frame3.BorderSizePixel = 0
  frame3.Parent = frame

  local instance2 = Instance.new("UICorner", frame3)
  instance2.CornerRadius = UDim.new(0, 12)

  local textLabel2 = Instance.new("TextLabel")
  textLabel2.Size = UDim2.new(0, 60, 1, 0)
  textLabel2.Position = UDim2.new(0, 12, 0, 0)
  textLabel2.BackgroundTransparency = 1
  textLabel2.Font = Enum.Font.GothamBold
  textLabel2.TextSize = 12
  textLabel2.TextColor3 = v4.AccentBlue
  textLabel2.Text = "RIVALS"
  textLabel2.TextXAlignment = Enum.TextXAlignment.Left
  textLabel2.Parent = frame3

  local textLabel3 = Instance.new("TextLabel")
  textLabel3.Size = UDim2.new(1, -80, 1, 0)
  textLabel3.Position = UDim2.new(0, 75, 0, 0)
  textLabel3.BackgroundTransparency = 1
  textLabel3.Font = Enum.Font.Gotham
  textLabel3.TextSize = 11
  textLabel3.TextColor3 = v4.TextGray
  textLabel3.Text = "Player Profiles"
  textLabel3.TextXAlignment = Enum.TextXAlignment.Left
  textLabel3.Parent = frame3

  scrollingFrame = Instance.new("ScrollingFrame")
  scrollingFrame.Size = UDim2.new(1, -12, 1, -46)
  scrollingFrame.Position = UDim2.new(0, 6, 0, 42)
  scrollingFrame.BackgroundTransparency = 1
  scrollingFrame.ScrollBarThickness = 3
  scrollingFrame.ScrollBarImageColor3 = v4.AccentBlue
  scrollingFrame.BorderSizePixel = 0
  scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
  scrollingFrame.Parent = frame

  uiListLayout = Instance.new("UIListLayout")
  uiListLayout.Padding = UDim.new(0, 6)
  uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout.Parent = scrollingFrame

  local frame4 = Instance.new("Frame")
  frame4.Size = UDim2.new(0, 300, 0, 90)
  frame4.Position = UDim2.new(1, -315, 0, 830)
  frame4.BackgroundColor3 = v4.BgCard
  frame4.BackgroundTransparency = 0.05
  frame4.BorderSizePixel = 0
  frame4.Parent = rivalsInfoHUD

  local instance3 = Instance.new("UICorner", frame4)
  instance3.CornerRadius = UDim.new(0, 16)

  local frame5 = Instance.new("Frame")
  frame5.Size = UDim2.new(1, -40, 0, 1)
  frame5.Position = UDim2.new(0, 20, 0, 0)
  frame5.BackgroundColor3 = v4.AccentBlue
  frame5.BackgroundTransparency = 0.3
  frame5.BorderSizePixel = 0
  frame5.Parent = frame4

  local uiStroke2 = Instance.new("UIStroke")
  uiStroke2.Color = v4.AccentBlue
  uiStroke2.Transparency = 0.8
  uiStroke2.Thickness = 1
  uiStroke2.Parent = frame4

  local frame6 = Instance.new("Frame")
  frame6.Size = UDim2.new(1, -12, 0, 26)
  frame6.Position = UDim2.new(0, 6, 0, 6)
  frame6.BackgroundColor3 = v4.BgDark
  frame6.BackgroundTransparency = 0.1
  frame6.BorderSizePixel = 0
  frame6.Parent = frame4

  local instance4 = Instance.new("UICorner", frame6)
  instance4.CornerRadius = UDim.new(0, 10)

  local textLabel4 = Instance.new("TextLabel")
  textLabel4.Size = UDim2.new(0, 60, 1, 0)
  textLabel4.Position = UDim2.new(0, 10, 0, 0)
  textLabel4.BackgroundTransparency = 1
  textLabel4.Font = Enum.Font.GothamBold
  textLabel4.TextSize = 10
  textLabel4.TextColor3 = v4.AccentBlue
  textLabel4.Text = "RIVALS"
  textLabel4.TextXAlignment = Enum.TextXAlignment.Left
  textLabel4.Parent = frame6

  local textLabel5 = Instance.new("TextLabel")
  textLabel5.Size = UDim2.new(1, -80, 1, 0)
  textLabel5.Position = UDim2.new(0, 70, 0, 0)
  textLabel5.BackgroundTransparency = 1
  textLabel5.Font = Enum.Font.Gotham
  textLabel5.TextSize = 10
  textLabel5.TextColor3 = v4.TextGray
  textLabel5.Text = "Info"
  textLabel5.TextXAlignment = Enum.TextXAlignment.Left
  textLabel5.Parent = frame6

  local frame7 = Instance.new("Frame")
  frame7.Size = UDim2.new(0, 6, 0, 6)
  frame7.Position = UDim2.new(1, -16, 0.5, -3)
  frame7.BackgroundColor3 = v4.StatusGreen
  frame7.BorderSizePixel = 0
  frame7.Parent = frame6

  Instance.new("UICorner", frame7).CornerRadius = UDim.new(0, 3)

  textLabel = Instance.new("TextLabel")
  textLabel.Size = UDim2.new(1, -16, 1, -38)
  textLabel.Position = UDim2.new(0, 10, 0, 34)
  textLabel.BackgroundTransparency = 1
  textLabel.TextColor3 = v4.TextGray
  textLabel.Font = Enum.Font.Gotham
  textLabel.TextSize = 11
  textLabel.TextXAlignment = Enum.TextXAlignment.Left
  textLabel.TextYAlignment = Enum.TextYAlignment.Top
  textLabel.TextWrapped = true
  textLabel.Text = "Loading..."
  textLabel.Parent = frame4

  waitForChild = nil
  text = "N/A"

  task.spawn(function()
    local waitForChild2 = playerGui:WaitForChild("MainGui", 30)

    if waitForChild2 then
      local waitForChild3 = waitForChild2:WaitForChild("MainFrame", 10)

      if waitForChild3 then
        local waitForChild4 = waitForChild3:WaitForChild("Lobby", 10)

        if waitForChild4 then
          local waitForChild5 = waitForChild4:WaitForChild("Currency", 10)

          if waitForChild5 then
            waitForChild = waitForChild5:WaitForChild("Container", 10)
          end
        end
      end
    end

    while rivalsInfoHUD.Parent and waitForChild do
      for key3, value4 in pairs(waitForChild:GetChildren()) do
        if value4.Name == "CurrencySlot" and value4.Visible then
          local title = value4:FindFirstChild("Title")

          if title and title:IsA("TextLabel") then
            text = title.Text
            break
          end
        end
      end

      task.wait(3)
    end
  end)

  task.spawn(function()
    while rivalsInfoHUD.Parent do
      local v21 = f5(tick() - v2)

      textLabel.Text = string.format(
        "Runtime: %s\nKeys: %s\n\nF3 Toggle  ·  @cpplibrary", v21, text
      )

      task.wait(1)
    end
  end)

  v6 = {}
  v7 = false

  function f8()
    if v7 then
      return
    end

    v7 = true

    task.spawn(function()
      while #v6 > 0 do
        v13662 = table.remove(v6, 1)
        v13662()
        task.wait(v3.RequestGap)
      end

      v7 = false
    end)
  end

  function f9(p9, p10)
    table.insert(v6, p10 and 1 or #v6 + 1, p9)
    f8()
  end

  function f7()
    local v22 = {}

    for key4, value5 in pairs(v8) do
      v22[#v22 + 1] = { userId = key4, card = value5, elo = v9[key4] or 0 }
    end

    table.sort(v22, function(p11, p12) return p11.elo > p12.elo end)

    for index2, value6 in ipairs(v22) do
      value6.card.LayoutOrder = index2
    end
  end

  v8 = {}
  v9 = {}
  v10 = {}

  function f10(p13, p14, p15, p16, p17, p18, p19, p20, p21)
    if not p13.Parent then
      return
    end

    if p20 > v3.MaxRetries then
      p15.Text = "Lvl N/A · ELO N/A\nCasual: N/A  Ranked: N/A\nN/A · N/A · N/A · N/A"
      p15.TextColor3 = v4.TextDim
      return
    end

    f9(function()
      if not p13.Parent or not rivalsHUD.Parent then
        return
      else
        local v23, v24 = pcall(requestProfile.InvokeServer, requestProfile, p13)

        if v23 and f6(v24) then
          local favoriteWeapons = v24.FavoriteWeapons or {}
          local rankedCurrentELO = v24.RankedCurrentELO or 0
          v9[p13.UserId] = rankedCurrentELO
          f7()
          local format = string.format

          p15.Text = format(
            "Lvl %s  |  ELO %s\nCasual %s  •  Ranked %s\n%s • %s • %s • %s",
            tostring(v24.Level or "N/A"), tostring(rankedCurrentELO), f1(v24.CasualWinPercent),
            f1(v24.RankedWinPercent), favoriteWeapons[1] and favoriteWeapons[1].Name or "N/A",
            favoriteWeapons[2] and favoriteWeapons[2].Name or "N/A",
            favoriteWeapons[3] and favoriteWeapons[3].Name or "N/A",
            favoriteWeapons[4] and favoriteWeapons[4].Name or "N/A"
          )

          p15.TextColor3 = v4.TextGray

          if rankedCurrentELO then
            local text2, v25, v26 = f3(rankedCurrentELO)

            p17.Text = text2
            p17.TextColor3 = f4(v25)
            p17.Visible = true

            if v26 and v26 ~= "" then
              p16.Image = v26
              p16.Visible = true
            else
              p16.Visible = false
            end
          else
            p16.Visible = false
            p17.Visible = false
          end

          p19.Text = tostring((f2(p13)))
          p19.Visible = true

          p18.Visible = true
          v10[p13.UserId] = { label = p19, icon = p18, player = p13 }
        else
          task.delay(v3.RetryDelay, function()
            f10(p13, p14, p15, p16, p17, p18, p19, p20 + 1, false)
          end)
        end

        return
      end
    end, p21)
  end

  task.spawn(function()
    while rivalsHUD.Parent do
      task.wait(5)

      for key5, value7 in pairs(v10) do
        if value7.player and value7.player.Parent then
          value7.label.Text = tostring(f2(value7.player))
        end
      end
    end
  end)

  function f11(p22, p23)
    if v3.HiddenUsers[p22.Name] then
      return
    else
      local frame8 = Instance.new("Frame")
      frame8.Name = "PlayerCard_" .. p22.UserId
      frame8.Size = UDim2.new(1, -6, 0, 94)
      frame8.BackgroundColor3 = v4.BgDark
      frame8.BorderSizePixel = 0
      frame8.LayoutOrder = 9999
      frame8.Parent = scrollingFrame

      local instance5 = Instance.new("UICorner", frame8)
      instance5.CornerRadius = UDim.new(0, 10)

      local uiStroke3 = Instance.new("UIStroke")
      uiStroke3.Color = v4.AccentBlue
      uiStroke3.Transparency = 0.88
      uiStroke3.Thickness = 1
      uiStroke3.Parent = frame8

      local frame9 = Instance.new("Frame")
      frame9.Size = UDim2.new(0, 3, 1, -12)
      frame9.Position = UDim2.new(0, 0, 0, 6)
      frame9.BackgroundColor3 = v4.AccentBlue
      frame9.BackgroundTransparency = 0.4
      frame9.BorderSizePixel = 0
      frame9.Parent = frame8

      local instance6 = Instance.new("UICorner", frame9)
      instance6.CornerRadius = UDim.new(0, 2)

      local frame10 = Instance.new("Frame")
      frame10.Size = UDim2.new(0, 40, 0, 40)
      frame10.Position = UDim2.new(0, 10, 0, 6)
      frame10.BackgroundColor3 = v4.AccentDark
      frame10.BorderSizePixel = 0
      frame10.Parent = frame8

      local instance7 = Instance.new("UICorner", frame10)
      instance7.CornerRadius = UDim.new(0, 20)

      local imageLabel = Instance.new("ImageLabel")
      imageLabel.Size = UDim2.new(1, 0, 1, 0)
      imageLabel.BackgroundTransparency = 1
      imageLabel.Image = "rbxthumb://type=AvatarHeadShot&id=" .. p22.UserId .. "&w=150&h=150"
      imageLabel.Parent = frame10

      local instance8 = Instance.new("UICorner", imageLabel)
      instance8.CornerRadius = UDim.new(0, 20)

      local frame11 = Instance.new("Frame")
      frame11.Size = UDim2.new(1, -60, 0, 18)
      frame11.Position = UDim2.new(0, 56, 0, 6)
      frame11.BackgroundTransparency = 1
      frame11.Parent = frame8

      local textLabel6 = Instance.new("TextLabel")
      textLabel6.Size = UDim2.new(1, -50, 1, 0)
      textLabel6.BackgroundTransparency = 1
      textLabel6.TextColor3 = v4.TextWhite
      textLabel6.Font = Enum.Font.GothamBold
      textLabel6.TextSize = 12
      textLabel6.TextXAlignment = Enum.TextXAlignment.Left
      textLabel6.TextTruncate = Enum.TextTruncate.AtEnd
      textLabel6.Text = p22.Name
      textLabel6.Parent = frame11

      local imageLabel2 = Instance.new("ImageLabel")
      imageLabel2.Size = UDim2.new(0, 14, 0, 14)
      imageLabel2.Position = UDim2.new(1, -32, 0, 2)
      imageLabel2.BackgroundTransparency = 1
      imageLabel2.Image = "rbxassetid://17094014569"
      imageLabel2.Visible = false
      imageLabel2.Parent = frame11

      local textLabel7 = Instance.new("TextLabel")
      textLabel7.Size = UDim2.new(0, 20, 1, 0)
      textLabel7.Position = UDim2.new(1, -18, 0, 0)
      textLabel7.BackgroundTransparency = 1
      textLabel7.TextColor3 = v4.TextWhite
      textLabel7.Font = Enum.Font.GothamBold
      textLabel7.TextSize = 11
      textLabel7.TextXAlignment = Enum.TextXAlignment.Left
      textLabel7.Text = "0"
      textLabel7.Visible = false
      textLabel7.Parent = frame11

      local frame12 = Instance.new("Frame")
      frame12.Size = UDim2.new(1, -60, 0, 16)
      frame12.Position = UDim2.new(0, 56, 0, 28)
      frame12.BackgroundTransparency = 1
      frame12.Parent = frame8

      local imageLabel3 = Instance.new("ImageLabel")
      imageLabel3.Size = UDim2.new(0, 28, 0, 28)
      imageLabel3.Position = UDim2.new(0, 0, 0.5, -14)
      imageLabel3.BackgroundTransparency = 1
      imageLabel3.Visible = false
      imageLabel3.Parent = frame12

      local textLabel8 = Instance.new("TextLabel")
      textLabel8.Size = UDim2.new(1, -22, 1, 0)
      textLabel8.Position = UDim2.new(0, 32, 0.5, -8)
      textLabel8.BackgroundTransparency = 1
      textLabel8.Font = Enum.Font.GothamBold
      textLabel8.TextSize = 10
      textLabel8.TextXAlignment = Enum.TextXAlignment.Left
      textLabel8.TextYAlignment = Enum.TextYAlignment.Center
      textLabel8.Visible = false
      textLabel8.Parent = frame12

      local textLabel9 = Instance.new("TextLabel")
      textLabel9.Size = UDim2.new(1, -14, 0, 44)
      textLabel9.Position = UDim2.new(0, 10, 0, 54)
      textLabel9.BackgroundTransparency = 1
      textLabel9.TextColor3 = Color3.fromRGB(220, 220, 220)
      textLabel9.Font = Enum.Font.GothamMedium
      textLabel9.TextSize = 11
      textLabel9.TextWrapped = true
      textLabel9.TextXAlignment = Enum.TextXAlignment.Left
      textLabel9.TextYAlignment = Enum.TextYAlignment.Top
      textLabel9.Text = "Loading..."
      textLabel9.Parent = frame8

      v8[p22.UserId] = frame8
      v9[p22.UserId] = 0

      f10(
        p22, textLabel6, textLabel9, imageLabel3, textLabel8, imageLabel2, textLabel7, 1,
        p23 == true
      )

      return
    end
  end

  uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y + 10)
  end)

  for index3, value8 in ipairs(players:GetPlayers()) do
    task.spawn(f11, value8, false)
  end

  players.PlayerAdded:Connect(function(player) f11(player, true) end)

  players.PlayerRemoving:Connect(function(player2)
    local v27 = v8[player2.UserId]

    if v27 then
      v27:Destroy()
      v8[player2.UserId] = nil
      v9[player2.UserId] = nil
      v10[player2.UserId] = nil
    end
  end)

  print("@cpplibrary - Profiles HUD loaded successfully.")

 queue_on_teleport([[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/3097830987/OK/refs/heads/main/namehider.lua"))() -- Auto Execute
]])
  return
end

-- @cpplibrary was here
