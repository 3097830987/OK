if _G.PH then return end _G.PH = true
if not game:IsLoaded() then game.Loaded:Wait() end

local P, UIS = game:GetService("Players"), game:GetService("UserInputService")
local me = P.LocalPlayer
local remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Misc"):WaitForChild("RequestProfile")
local hidden = { [me.Name] = true } -- add names: hidden["Name"] = true

local colors = {
	Unranked = "#ffffff", Bronze = "#CD7F32", Silver = "#C0C0C0", Gold = "#FFD700",
	Platinum = "#00fbff", Diamond = "#3573e6", Onyx = "#41315e",
	Nemesis = "#b700ff", Archnemesis = "#1900ff",
}

-- Bronze 1 ... Onyx 3 (18 tiers, 200 ELO each)
local tiers = {}
for _, r in ipairs({ "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Onyx" }) do
	for i = 1, 3 do tiers[#tiers + 1] = r .. " " .. i end
end

local function rank(e)
	if e < 1 then return "Unranked", "Unranked" end
	local n = e >= 12500 and "Archnemesis" or e >= 3600 and "Nemesis" or tiers[math.floor(e / 200) + 1]
	return n, n:match("%a+")
end

local function pct(n) return type(n) == "number" and n >= 0 and ("%.1f%%"):format(n * 100) or "N/A" end

-- UI
local gui = Instance.new("ScreenGui")
gui.Name, gui.ResetOnSpawn, gui.DisplayOrder = "ProfilesHUD", false, 999999
gui.Parent = me:WaitForChild("PlayerGui")

local list = Instance.new("ScrollingFrame")
list.Size, list.Position = UDim2.new(0, 280, 0, 400), UDim2.new(1, -295, 0, 200)
list.BackgroundColor3, list.BackgroundTransparency, list.BorderSizePixel = Color3.fromRGB(15, 15, 15), 0.1, 0
list.ScrollBarThickness, list.AutomaticCanvasSize, list.CanvasSize = 3, Enum.AutomaticSize.Y, UDim2.new()
list.Parent = gui
Instance.new("UICorner", list).CornerRadius = UDim.new(0, 12)
local layout = Instance.new("UIListLayout", list)
layout.Padding, layout.SortOrder = UDim.new(0, 4), Enum.SortOrder.LayoutOrder

UIS.InputBegan:Connect(function(i, gp)
	if not gp and i.KeyCode == Enum.KeyCode.F3 then gui.Enabled = not gui.Enabled end
end)

-- Cards
local cards, n = {}, 0

local function addPlayer(p)
	if hidden[p.Name] then return end
	local c = Instance.new("TextLabel")
	c.Size, c.BackgroundColor3, c.BorderSizePixel = UDim2.new(1, -8, 0, 62), Color3.fromRGB(25, 25, 25), 0
	c.Font, c.TextSize, c.RichText, c.TextWrapped = Enum.Font.GothamMedium, 12, true, true
	c.TextXAlignment, c.TextYAlignment, c.TextColor3 = Enum.TextXAlignment.Left, Enum.TextYAlignment.Top, Color3.fromRGB(200, 200, 200)
	c.Text, c.LayoutOrder, c.Parent = "<b>" .. p.Name .. "</b>\nLoading...", 9999, list
	Instance.new("UICorner", c).CornerRadius = UDim.new(0, 8)
	cards[p] = c

	n += 1
	task.spawn(function()
		task.wait(n * 0.1) -- stagger requests
		for _ = 1, 20 do
			if not p.Parent then return end
			local ok, d = pcall(remote.InvokeServer, remote, p)
			if ok and type(d) == "table" and d.Level then
				local elo = d.RankedCurrentELO or 0
				local name, base = rank(elo)
				local w = {}
				for i = 1, 4 do w[i] = d.FavoriteWeapons and d.FavoriteWeapons[i] and d.FavoriteWeapons[i].Name or "N/A" end
				c.Text = ("<b>%s</b>  <font color='%s'>%s</font>\nLvl %s | ELO %s\nCasual %s • Ranked %s\n%s"):format(
					p.Name, colors[base], name, d.Level, elo, pct(d.CasualWinPercent), pct(d.RankedWinPercent), table.concat(w, " • "))
				c.Size = UDim2.new(1, -8, 0, 78)
				c.LayoutOrder = -elo -- highest ELO on top
				return
			end
			task.wait(8)
		end
		c.Text = p.Name .. "\nN/A"
	end)
end

for _, p in ipairs(P:GetPlayers()) do addPlayer(p) end
P.PlayerAdded:Connect(addPlayer)
P.PlayerRemoving:Connect(function(p)
	if cards[p] then cards[p]:Destroy() cards[p] = nil end
end)
