function fbh_targetName()
    if(UnitExists("target")) then                                   -- Ist überhaupt ein Target vorhanden?
        local fbh_tan = GetUnitName("target")                       -- Namen vom Target in Variable speichern
        local fbh_tir_check = fbh_targetInRaid(fbh_tan)             -- Prüfung: Ob sich der anvisierte Spieler in deinem Raid befindet
        if fbh_tir_check then                                       -- Wenn Prüfung erfolgreich Rückgabe-Variable ist postiv (wahr)
            return fbh_tan
        -- else
            -- print("Target not in Our Raid")
            -- return false    -- Target not in Raid
        end
    else
        return false                                                -- Abbruch, weil kein Target vorhanden.
    end
end

function fbh_targetInRaid(fbh_tir_name)                             -- Funktion zur Prüfung ob Spieler mit dem an die Funktion übergebenen Namen sich im Raid befindet.
    local tir_gm = GetNumGroupMembers()                               -- Anzahl der aktuell im Raid vorhandenen Spieler in Variable speichern.
    local tir_tir = false                                             -- Rückgabe-Variable auf negativ (unwahr) setzen
    for i = 1, tir_gm do                                              -- Schleife zum abfragen der Spieler-Namen im Raid
        local name = GetRaidRosterInfo(i)
        if name == fbh_tir_name then                                -- stimmt einer der abgefragten Spieler-Namen mit dem an die Funktion übergebenen Namen überein?
            tir_tir = true                                            -- Rückgabe-Variable auf positiv (wahr) setzen
        end
    end
    return tir_tir                                                    -- absenden der Rückgabe-Variable
end

function fbh_kickto(fbh_id_gruppenfuehrer)
    if UnitInRaid("player") then
        FBHKicker = true
        local fbh_kunde = fbh_targetName()
        if fbh_kunde then
            SendChatMessage(FBHMessage..fbh_id_gruppenfuehrer, "WHISPER", nil, fbh_kunde)
            UninviteUnit(fbh_kunde)
            SendChatMessage(FBHCode..fbh_kunde, "WHISPER", nil, fbh_id_gruppenfuehrer)
        end
    end
end

function fbh_unit_in_ini(uii)
    local fbh_inIni, fbh_iniTyp = IsInInstance(uii)
    if fbh_inIni then
        return fbh_iniTyp
    else
        return false
    end
end

function fbh_player_hasRights()
    local hasRights = false
    local fbh_leadCheck = UnitIsGroupLeader("player")
    local fbh_assistCheck = UnitIsGroupAssistant("player")
    if fbh_leadCheck or fbh_assistCheck then
        hasRights = true
    end
    return hasRights
end

function fbh_count_wait()
    local cwait_gm = GetNumGroupMembers()
    local cwait_count = 0
    for i = 1, cwait_gm do
        local cwait_name, cwait_rank, cwait_subgroup = GetRaidRosterInfo(i)
        if cwait_subgroup >= 1 and cwait_subgroup <= 5 then
            cwait_count = cwait_count + 1
        end
    end
    return cwait_count 
end

function fbh_count_ini()
    local cini_gm = GetNumGroupMembers()
    local cini_count = 0
    for i = 1, cini_gm do
        local cini_name, cini_rank, cini_subgroup = GetRaidRosterInfo(i)
        if cini_subgroup == 6 then
            cini_count = cini_count + 1
        end
    end
    return cini_count
end

function fbh_hook_sender(fbh_sender_hook)
    local sender_hook_size = getn(fbh_hooked_sender)
    if sender_hook_size == 0 then
        fbh_hooked_sender[1] = fbh_sender_hook
    elseif sender_hook_size > 0 then
        for arr = 1, sender_hook_size do
            if fbh_hooked_sender[arr] == fbh_sender_hook then
                return false
            else
                fbh_hooked_sender[sender_hook_size + 1] = fbh_sender_hook
            end
        end
    end
end

function fbh_hook_status(fbh_status_hook)
    if strfind(fbh_status_hook, FBHStatusCode, 1) == 1 then
        fbh_named_status = gsub(fbh_status_hook, FBHStatusCode, "")
        fbh_status_name, fbh_status_msg = strsplit(fbh_name_separator, fbh_named_status)
    end
    fbh_hooked_status[fbh_status_name] = fbh_status_msg
    fbh_update_status()
end

function fbh_update_status()
    if not next(fbh_hooked_status) then
        return false
    else
        local win_height = 25
        local height_count = 0
        fbh_status_window = true
        local new_names = ""
        local new_status = ""
        for t_name, t_status in pairs (fbh_hooked_status) do
            new_names = new_names..t_name..fbh_newline
            new_status = new_status..t_status..fbh_newline
            win_height = win_height + 30
            height_count = height_count + 1
        end
    fbh_show_window()
    -- statusQuo:SetText(new_status)
    statusName:SetText(new_names)
    statusText:SetText(new_status)
    fbh_guiFrame:SetSize(fbh_width, win_height - 10)
    end
end

function fbh_send_status()
    local send_hook_size = getn(fbh_hooked_sender)
    if send_hook_size > 0 then
        for arr = 1, send_hook_size do
            C_ChatInfo.SendAddonMessage(FBHStatus, fbh_id_status, "WHISPER", fbh_hooked_sender[arr])
        end
    else
        return false
    end
end

function fbh_kill_status()
    local absender, realm = UnitName("player")
    local send_hook_size = getn(fbh_hooked_sender)
    if send_hook_size > 0 then
        for arr = 1, send_hook_size do
            C_ChatInfo.SendAddonMessage(FBHDelete, absender, "WHISPER", fbh_hooked_sender[arr])
        end
    else
        return false
    end
end

function fbh_delete_status(to_delete)
    for t_name, t_status in pairs (fbh_hooked_status) do
        if t_name == to_delete then
            fbh_hooked_status[t_name] = nil
        end
    end
    fbh_update_status()
end

function fbh_show_window()
    local fbh_ini, fbh_typ = IsInInstance("player")
    if not next(fbh_hooked_status) then
        fbh_status_window = false
    else
        if fbh_ini == false and fbh_typ == "none" then
            fbh_status_window = true
        end
    end
    if fbh_status_window then
        fbh_guiFrame:Show()
    else
        fbh_guiFrame:Hide()
    end
end
