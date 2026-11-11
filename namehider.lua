-- Rank HUD for Matcha (Drawing library, no Instance.new)
print("[HUD] v2 matcha script running")
print("[HUD] globals  Drawing:", Drawing ~= nil, " Vector2:", Vector2 ~= nil, " Color3:", Color3 ~= nil, " Instance:", Instance ~= nil)
local P = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local me = P.LocalPlayer
local hidden = { [me.Name] = true } -- hidden["Name"] = true

local colors = {
	Unranked = Color3.fromRGB(255,255,255), Bronze = Color3.fromRGB(205,127,50),
	Silver = Color3.fromRGB(192,192,192), Gold = Color3.fromRGB(255,215,0),
	Platinum = Color3.fromRGB(0,251,255), Diamond = Color3.fromRGB(53,115,230),
	Onyx = Color3.fromRGB(138,111,209), Nemesis = Color3.fromRGB(183,0,255),
	Archnemesis = Color3.fromRGB(77,77,255),
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

-- find remote
local remote
for _, v in ipairs(RS:GetDescendants()) do
	if v.ClassName == "RemoteFunction" and v.Name:find("RequestProfile", 1, true) then remote = v break end
end
print("[HUD] remote:", remote and remote:GetFullName() or "NOT FOUND")

-- PROBE: print any replicated values on players so we can see where rank might live
for _, p in ipairs(P:GetPlayers()) do
	pcall(function()
		print("== " .. p.Name)
		for _, d in ipairs(p:GetDescendants()) do
			if d.ClassName:find("Value") then print("  ", d:GetFullName(), d.Value) end
		end
	end)
end

local data, texts = {}, {}   -- data[p] = {name=, base=, elo=}

local function fetch(p)
	if not remote or data[p] then return end
	data[p] = { name = "...", base = "Unranked", elo = -1 }
	local ok, d = pcall(function() return remote:InvokeServer(p) end)
	if ok and type(d) == "table" then
		local elo = d.RankedCurrentELO or 0
		local n, b = rank(elo)
		data[p] = { name = n, base = b, elo = elo }
	else
		print("[HUD] fetch failed for " .. p.Name .. ":", ok and type(d) or d)
		data[p] = { name = "N/A", base = "Unranked", elo = -1 }
	end
end

while true do
	local list = {}
	for _, p in ipairs(P:GetPlayers()) do
		if not hidden[p.Name] then
			pcall(fetch, p)
			list[#list + 1] = p
		end
	end
	table.sort(list, function(a, b) return (data[a] and data[a].elo or -1) > (data[b] and data[b].elo or -1) end)

	for p, t in pairs(texts) do
		if not p.Parent then t:Remove() texts[p] = nil end
	end
	for i, p in ipairs(list) do
		local t = texts[p]
		if not t then
			print("[HUD] step: Drawing.new")
			t = Drawing.new("Text")
			t.Size, t.Outline, t.Visible = 16, true, true
			texts[p] = t
		end
		local d = data[p] or { name = "...", base = "Unranked" }
		t.Text = p.Name .. "  " .. d.name
		t.Color = colors[d.base]
		print("[HUD] step: Vector2.new")
		t.Position = Vector2.new(20, 200 + (i - 1) * 18)
	end
	wait(1)
end
