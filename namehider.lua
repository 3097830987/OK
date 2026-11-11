if _G.PH then return end _G.PH = true
if not game:IsLoaded() then game.Loaded:Wait() end

local P, RS = game:GetService("Players"), game:GetService("ReplicatedStorage")
local me = P.LocalPlayer
local hidden = { [me.Name] = true } -- hidden["Name"] = true

local colors = {
	Unranked = "#ffffff", Bronze = "#CD7F32", Silver = "#C0C0C0", Gold = "#FFD700",
	Platinum = "#00fbff", Diamond = "#3573e6", Onyx = "#8a6fd1",
	Nemesis = "#b700ff", Archnemesis = "#4d4dff",
}

local tiers = {}
for _, r in ipairs({ "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Onyx" }) do
	for i = 1, 3 do tiers[#tiers + 1] = r .. " " .. i end
end

local function rank(e)
	if e < 1 then return "Unranked", "Unranked" end
	local n = e >= 12500 and "Archnemesis" or e >= 3600 and "Nemesis" or tiers[math.floor(e / 200) + 1]
	return n, n:match("%a+")
end

-- find the profile remote
local remote
for _ = 1, 30 do
	for _, v in ipairs(RS:GetDescendants()) do
		if v:IsA("RemoteFunction") and v.Name:find("RequestProfile", 1, true) then
			remote = v
			break
		end
	end
	if remote then break end
	task.wait(0.5)
end
if not remote then
	warn("[HUD] RequestProfile RemoteFunction not found. Anything profile-like:")
	for _, v in ipairs(RS:GetDescendants()) do
		if v.Name:lower():find("profile", 1, true) then print(v.ClassName, v:GetFullName()) end
	end
	_G.PH = nil
	return
end
print("[HUD] using remote:", remote.ClassName, remote:GetFullName())

-- UI
local gui = Instance.new("ScreenGui")
gui.Name, gui.ResetOnSpawn, gui.DisplayOrder = "RankHUD", false, 999999
gui.Parent = me:WaitForChild("PlayerGui")

local list = Instance.new("Frame")
list.Size, list.Position = UDim2.new(0, 200, 0, 0), UDim2.new(1, -215, 0, 200)
list.AutomaticSize, list.BackgroundColor3, list.BackgroundTransparency = Enum.AutomaticSize.Y, Color3.fromRGB(15, 15, 15), 0.15
list.BorderSizePixel, list.Parent = 0, gui
Instance.new("UICorner", list).CornerRadius = UDim.new(0, 8)
local layout = Instance.new("UIListLayout", list)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local rows = {}

local function add(p)
	if hidden[p.Name] then return end
	local l = Instance.new("TextLabel")
	l.Size, l.BackgroundTransparency, l.RichText = UDim2.new(1, 0, 0, 20), 1, true
	l.Font, l.TextSize, l.TextColor3 = Enum.Font.GothamBold, 12, Color3.new(1, 1, 1)
	l.TextXAlignment, l.LayoutOrder = Enum.TextXAlignment.Left, 9999
	l.Text, l.Parent = " " .. p.Name .. "  ...", list
	rows[p] = l

	task.spawn(function()
		for i = 1, 10 do
			if not p.Parent then return end
			local ok, d = pcall(remote.InvokeServer, remote, p)
			if ok and type(d) == "table" then
				local elo = d.RankedCurrentELO or 0
				local name, base = rank(elo)
				l.Text = (" %s  <font color='%s'>%s</font>"):format(p.Name, colors[base], name)
				l.LayoutOrder = -elo
				return
			end
			if i == 1 then warn("[HUD] fetch failed for " .. p.Name .. ":", ok and type(d) or d) end
			task.wait(5)
		end
		l.Text = " " .. p.Name .. "  N/A"
	end)
end

for _, p in ipairs(P:GetPlayers()) do task.spawn(add, p) task.wait(0.15) end
P.PlayerAdded:Connect(add)
P.PlayerRemoving:Connect(function(p)
	if rows[p] then rows[p]:Destroy() rows[p] = nil end
end)
