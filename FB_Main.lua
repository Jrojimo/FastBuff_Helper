local FBHA = CreateFrame("Frame", "FBHA", UIParent)
C_ChatInfo.RegisterAddonMessagePrefix(FBHPrefix)
C_ChatInfo.RegisterAddonMessagePrefix(FBHStatus)
C_ChatInfo.RegisterAddonMessagePrefix(FBHDelete)
FBHA:RegisterEvent("ADDON_LOADED")
FBHA:RegisterEvent("CHAT_MSG_ADDON")
FBHA:RegisterEvent("CHAT_MSG_WHISPER")
FBHA:RegisterEvent("GROUP_ROSTER_UPDATE")
FBHA:RegisterEvent("RAID_ROSTER_UPDATE")
FBHA:RegisterEvent("PARTY_LEADER_CHANGED")
-- FBHA:RegisterEvent("PLAYER_LOGIN")
-- FBHA:RegisterEvent("UI_ERROR_MESSAGE")
-- FBHA:RegisterEvent("UI_INFO_MESSAGE")

function FBHA_OnEvent(self, event, ...)
    if event == "ADDON_LOADED" then
        fbh_loaded = true
    end                                             -- end if ADDON_LOADED
    if fbh_loaded then
        if event == "CHAT_MSG_WHISPER" then
            local fbh_f_msg, fbh_f_sender = select('1', ...), gsub(select('2', ...), FBHREALM, "")
            if strfind(fbh_f_msg, FBHCode, 1) == 1 then
                fbh_hook_sender(fbh_f_sender)
                local kunde = gsub(fbh_f_msg, FBHCode, "")
                InviteUnit(kunde)
            end
        end                                         -- end if CHAT_MSG_WHISPER
        if event == "CHAT_MSG_ADDON" then
            local cma_pre, cma_msg, cma_typ, cma_from = select('1', ...), select('2', ...), select('3', ...), select('4', ...)
            if cma_pre == FBHStatus then
                fbh_hook_status(cma_msg)
            elseif cma_pre == FBHDelete then
                fbh_delete_status(cma_msg)
            end                                     -- end if cma_pre
        end

        if event == "GROUP_ROSTER_UPDATE" then
                local gru_inIni, gru_iniTyp = IsInInstance("player")
                if gru_inIni == false and getn(fbh_hooked_sender) > 0 then
                -- message("party left")
                    fbh_kill_status()
                elseif gru_inIni == true and gru_iniTyp == "party" then
                    local gru_hasRights = fbh_player_hasRights()
                    if gru_hasRights then
                        local gru_ini = fbh_count_ini()
                        local gru_wait = fbh_count_wait()
                        fbh_id_status = "Status#"..FBHPLAYER..":"..gru_ini.." drin "..gru_wait.." in Warteposition"
                        fbh_send_status()
                    end
                end
        end
    end                                             -- end if fbh_loaded


end                                                 -- end function

FBHA:SetScript("OnEvent", FBHA_OnEvent);









-- local function addonHandler(self, event, a_prefix, a_message, a_disttype, a_sender)
    -- if event == "CHAT_MSG_ADDON" then
        -- local fbh_f_msg = msg
        -- if strfind(fbh_f_msg, FBHCode, 1) == 1 then
            -- local kunde = gsub(fbh_f_msg, FBHCode, "")
            -- InviteUnit(kunde)
        -- end
        -- if a_sender == "Gönndïr-Heartstriker" and a_prefix = "FBHADDON" then
            -- print("prefix: "..a_prefix)
            -- print("message: "..a_message)
            -- print("distribution type: "..a_disttype)
            -- print("sender: "..a_sender)
        -- end
    -- end
-- end


-- local frame = CreateFrame("Frame");
-- frame:RegisterEvent("CHAT_MSG_WHISPER");

-- local function eventHandler(self, event, msg, ...)
    -- if event == "CHAT_MSG_WHISPER" then
        -- local fbh_f_msg = msg
        -- if strfind(fbh_f_msg, FBHCode, 1) == 1 then
            -- local kunde = gsub(fbh_f_msg, FBHCode, "")
            -- InviteUnit(kunde)
        -- end
    -- end
-- end

-- frame:SetScript("OnEvent", eventHandler);

-- function fbh_inviteTarget(fbh_an_wen)
    -- if(UnitExists("target")) then
        -- local fbh_tin = GetUnitName("target")
        -- SendChatMessage(FBHCode..fbh_tin, "WHISPER", nil, fbh_an_wen)
    -- end
-- end

-- message("Addon loaded!")
