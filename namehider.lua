RunService.RenderStepped:Connect(function()
    if not config.enabled then return end

    for _, player in ipairs(Players:GetPlayers()) do
        local char = player.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                -- Handle enemies
                local nametag = root:FindFirstChild("NametagGui")
                if nametag then
                    for _, label in ipairs(nametag:GetDescendants()) do
                        if label:IsA("TextLabel") then
                            if label.Name == "DisplayName" then
                                if player == LocalPlayer then
                                    label.Text = config.myName
                                else
                                    label.Text = config.enemyName
                                end
                            end
                            if label.Name == "Username" then
                                if player == LocalPlayer then
                                    label.Text = "@" .. config.myName
                                else
                                    label.Text = "@" .. config.enemyName
                                end
                            end
                        end
                    end
                end

                -- Handle teammates
                local teamtag = root:FindFirstChild("TeammateLabel")
                if teamtag then
                    for _, label in ipairs(teamtag:GetDescendants()) do
                        if label:IsA("TextLabel") then
                            if label.Name == "DisplayName" then
                                label.Text = config.enemyName
                            end
                            if label.Name == "Username" then
                                label.Text = "@" .. config.enemyName
                            end
                        end
                    end
                end
            end
        end
    end

    -- DuelInterface scoreboard
    local mainGui = PlayerGui:FindFirstChild("MainGui")
    if not mainGui then return end
    local mainFrame = mainGui:FindFirstChild("MainFrame")
    if not mainFrame then return end
    local duelInterfaces = mainFrame:FindFirstChild("DuelInterfaces")
    if not duelInterfaces then return end
    local duelInterface = duelInterfaces:FindFirstChild("DuelInterface")
    if not duelInterface then return end

    for _, v in ipairs(duelInterface:GetDescendants()) do
        if v:IsA("TextLabel") and v.Name == "Username" then
            if string.find(v.Text, "@" .. LocalPlayer.Name) then
                v.Text = "@" .. config.myName
            else
                v.Text = "@" .. config.enemyName
            end
        end
    end
end)
