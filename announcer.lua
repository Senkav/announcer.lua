local announcer = {}

local ui = {}

local main_section = NEW_UI_LIB.create_tab(false, Menu.Find("Miscellaneous"), "In Game", "Announcer")
main_section.ref:Icon("\u{f590}")
main_section = main_section:create("Main")

local global_settings = main_section:create("Announcer")

ui.global_switch = global_settings:switch("Enable", false, "\u{f00c}")
ui.voicer_type = global_settings:combo("Voice Type", {"PickMe Girl"}, 1, "\u{e548}"):link_to_ui_disable_condition(ui.global_switch)
ui.volume = global_settings:slider("Volume", 1, 200, 100, "%d%%", "\u{f6a8}"):link_to_ui_disable_condition(ui.global_switch)

ui.debug = global_settings:button("Test Sound", function ()

    Engine.PlayVol("sounds/pick_me_announcer/fort_rad.vsnd_c", ui.volume() / 100)
end):link_to_ui_disable_condition(ui.global_switch)

local sound_map = {

    ["announcer_announcer_battle_prepare_01"] = {sounds = {"announce_01"}, {"announce_02"}, {"announce_03"}, {"announce_04"}, {"announce_05"}},
    ["fort_rad"] = {sounds = {"glif_01"}, {"glif_02"}},
    ["fort_dire"] = {sounds = {"glif_01"}, {"glif_02"}},

    ["twr_attack_yr_top"] = {radiant = {"top_twr_rad", "top_twr_rad_2", "nash tower v tope atakuyut_01", "nash tower v tope atakuyut_02", "nash tower v tope atakuyut_03", "nash tower v tope atakuyut_04", "nash tower v tope atakuyut_05"}, dire = {"nash tower v tope atakuyut_01", "nash tower v tope atakuyut_02", "nash tower v tope atakuyut_03", "nash tower v tope atakuyut_04", "nash tower v tope atakuyut_05"}},
    ["twr_fall_yr_top"] = {radiant = {"top_twr_fall", "top_twr_fall_rad", "nash tower top upal_01", "nash tower top upal_02", "nash tower top upal_03"}, dire = {"top_twr_fall", "top_twr_fall_dire", "nash tower top upal_01", "nash tower top upal_02", "nash tower top upal_03"}},

    ["twr_attack_yr_bot"] = {radiant = {"bot_twr_rad", "bot_twr_rad_2", "nash tower v bote atakuyut_01", "nash tower v bote atakuyut_02", "nash tower v bote atakuyut_03", "nash tower v bote atakuyut_04", "nash tower v bote atakuyut_05"}, dire = {"bot_twr_dire", "nash tower v bote atakuyut_01", "nash tower v bote atakuyut_02", "nash tower v bote atakuyut_03", "nash tower v bote atakuyut_04", "nash tower v bote atakuyut_05"}},
    ["twr_fall_yr_bot"] = {radiant = {"bot_twr_fall_rad", "nash tower bot upal_01", "nash tower bot upal_02", "nash tower bot upal_03"}, dire = {"nash tower bot upal_01", "nash tower bot upal_02", "nash tower bot upal_03"}},

    ["twr_attack_yr_mid"] = {radiant = {"mid_twr", "mid_twr_rad", "nash tower v midu atakuyut_01", "nash tower v midu atakuyut_02", "nash tower v midu atakuyut_03", "nash tower v midu atakuyut_04"}, dire = {"mid_twr", "mid_twr_dire", "nash tower v midu atakuyut_01", "nash tower v midu atakuyut_02", "nash tower v midu atakuyut_03", "nash tower v midu atakuyut_04"}},
    ["twr_fall_yr_mid"] = {radiant = {"mid_twr_fall", "nash tower mid upal_01", "nash tower mid upal_02", "nash tower mid upal_03"}, dire = {"mid_twr_fall", "mid_twr_fall_dire", "nash tower mid upal_01", "nash tower mid upal_02", "nash tower mid upal_03"}},

    ["rax_attack_yr_mid"] = {radiant = {"nashi kazarmy v mide atakuyut_01", "nashi kazarmy v mide atakuyut_02"}, dire = {"nashi kazarmy v mide atakuyut_01", "nashi kazarmy v mide atakuyut_02"}},
    ["rax_fall_yr_mid"] = {radiant = {"mid_rax_fall_rad", "nashi bot kazarmy_01", "nashi bot kazarmy_02"}, dire = {"nashi bot kazarmy_01", "nashi bot kazarmy_02"}},

    ["rax_attack_yr_top"] = {radiant = {"top_rax_rad", "nashi kazarmy v tope atakuyut_01", "nashi kazarmy v tope atakuyut_02"}, dire = {"top_rax_dire", "nashi kazarmy v tope atakuyut_01", "nashi kazarmy v tope atakuyut_02"}},
    ["rax_fall_yr_top"] = {radiant = {"nashi top kazarmy_01", "nashi top kazarmy_02", "nashi top kazarmy_03"}, dire = {"nashi top kazarmy_01", "nashi top kazarmy_02", "nashi top kazarmy_03"}},

    ["rax_attack_yr_bot"] = {radiant = {"nashi kazarmy v bote atakuyut_01", "nashi kazarmy v bote atakuyut_02"}, dire = {"nashi kazarmy v bote atakuyut_01", "nashi kazarmy v bote atakuyut_02"}},
    ["rax_fall_yr_bot"] = {radiant = {"nashi bot kazarmy_01", "nashi bot kazarmy_02"}, dire = {"nashi bot kazarmy_01", "nashi bot kazarmy_02"}},

    ["anc_attack_yr"] = {sounds = {"anc_attack_yr"}},

    ["twr_fall_enm_top"] = {radiant = {"top vraga_01", "top vraga_02", "bot vraga_03"}, dire = {"top vraga_01", "top vraga_02", "top vraga_03"}},
    ["twr_fall_enm_mid"] = {radiant = {"mid vraga_01", "mid vraga_02", "bot vraga_03"}, dire = {"mid vraga_01", "mid vraga_02", "mid vraga_03"}},
    ["twr_fall_enm_bot"] = {radiant = {"bot vraga_01", "bot vraga_02", "bot vraga_03"}, dire = {"bot vraga_01", "bot vraga_02", "bot vraga_03"}},

    ["rax_fall_enm_top"] = {radiant = {"kazarmy vraga v tope_01", "kazarmy vraga v tope_01"}, dire = {"kazarmy vraga v tope_01", "kazarmy vraga v tope_02"}},
    ["rax_fall_enm_mid"] = {radiant = {"kazarmy vraga v mide_01", "kazarmy vraga v mide_02"}, dire = {"kazarmy vraga v mide_01", "kazarmy vraga v mide_02"}},
    ["rax_fall_enm_bot"] = {radiant = {"kazarmy vraga v bote_01", "kazarmy vraga v bote_02"}, dire = {"kazarmy vraga v bote_01", "kazarmy vraga v bote_02"}},

    ["mega_now_you"] = {radiant = {"mega_now_you", "mega_now_you_rad", "nashi megakripi_01", "nashi megakripi_02"}, dire = {"mega_now_you", "mega_now_you_dire", "nashi megakripi_01", "nashi megakripi_02"}},
    ["mega_now_enm"] = {radiant = {"mega_now_enm", "megakripi vraga_01", "megakripi vraga_02", "megakripi vraga_03"}, dire = {"mega_now_enm", "megakripi vraga_01", "megakripi vraga_02", "megakripi vraga_03"}},

    ["roshan_fallen_rad"] = {sounds = {"roshan_fallen_rad"}},
    ["roshan_fallen_dire"] = {sounds = {"roshan_fallen_dire"}},

    ["twr_deny_yr_mid"] = {},
    ["twr_deny_yr_top"] = {},
    ["twr_deny_yr_bot"] = {},

    ["twr_deny_enm_mid"] = {},
    ["twr_deny_enm_top"] = {},
    ["twr_deny_enm_bot"] = {},

    -- ["cour_kill_rad"] = {sounds = {"cour_kill_rad"}},
    --["cour_kill_dire"] = {sounds = {"cour_kill_dire"}},

    ["victory_rad"] = {sounds = {"victory_rad"}},
    ["victory_dire"] = {sounds = {"victory_dire"}},
}

local hero = nil

announcer.OnSpeak = function (data)
    
    log("OnSpeak", data)

    if not ui.global_switch() then return end

    if not data.name then return end

    for i, j in pairs(sound_map) do
        
        if data.name:find(i) then

            if j.radiant then

                if not hero then hero = Heroes.GetLocal() end
                
                if Entity.GetTeamNum(hero) == 2 then

                    if #j.radiant == 0 then return end
                    
                    local sound = j.radiant[math.random(1, #j.radiant)]
                    Engine.PlayVol("sounds/pick_me_announcer/"..sound..".vsnd_c", ui.volume() / 100)
                else

                    if #j.dire == 0 then return end

                    local sound = j.dire[math.random(1, #j.dire)]
                    Engine.PlayVol("sounds/pick_me_announcer/"..sound..".vsnd_c", ui.volume() / 100)
                end
            else

                if not j.sounds or #j.sounds == 0 then return end

                local sound = j.sounds[math.random(1, #j.sounds)]
                Engine.PlayVol("sounds/pick_me_announcer/"..sound..".vsnd_c", ui.volume() / 100)
            end
            
            return false
        end
    end
end

return announcer