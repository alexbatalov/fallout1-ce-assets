local fallout = require("fallout")

local start
local do_dialogue
local supercbt
local superx
local super00

local Hostile = 0
local init_teams = 0

function start()
    if not(init_teams) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 34)
        init_teams = 1
    end
    if fallout.script_action() == 11 then
        do_dialogue()
    else
        if fallout.script_action() == 4 then
            Hostile = 1
        else
            if fallout.script_action() == 12 then
                if Hostile then
                    Hostile = 0
                    fallout.attack_complex(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                else
                    if fallout.global_var(13) == 0 then
                        fallout.set_obj_visibility(fallout.self_obj(), 1)
                    else
                        if (fallout.game_time_hour() >= 1900) or (fallout.game_time_hour() < 600) and (fallout.tile_num(fallout.self_obj()) ~= 24929) then
                            fallout.animate_move_obj_to_tile(fallout.self_obj(), 24929, 0)
                        end
                        if (fallout.game_time_hour() >= 700) and (fallout.game_time_hour() < 1800) and (fallout.tile_num(fallout.self_obj()) ~= 25915) then
                            fallout.animate_move_obj_to_tile(fallout.self_obj(), 25915, 0)
                        end
                    end
                end
            else
                if fallout.script_action() == 18 then
                    fallout.set_global_var(35, fallout.global_var(35) + 1)
                    if fallout.source_obj() == fallout.dude_obj() then
                        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                            fallout.set_global_var(156, 1)
                            fallout.set_global_var(157, 0)
                        end
                        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                            fallout.set_global_var(157, 1)
                            fallout.set_global_var(156, 0)
                        end
                        fallout.set_global_var(160, fallout.global_var(160) + 1)
                        if (fallout.global_var(160) % 6) == 0 then
                            fallout.set_global_var(155, fallout.global_var(155) + 1)
                        end
                    end
                else
                    if fallout.script_action() == 21 then
                        fallout.display_msg(fallout.message_str(100, 100))
                    end
                end
            end
        end
    end
end

function do_dialogue()
    fallout.start_gdialog(100, fallout.self_obj(), 4, -1, -1)
    fallout.gsay_start()
    if fallout.local_var(0) then
        super00()
    else
        fallout.set_local_var(0, 1)
        super00()
    end
    fallout.gsay_end()
    fallout.end_dialogue()
end

function supercbt()
    Hostile = 1
end

function superx()
    supercbt()
end

function super00()
    fallout.gsay_reply(100, 101)
    fallout.giq_option(3, 100, 102, superx, 50)
    fallout.giq_option(3, 100, 103, supercbt, 50)
    fallout.giq_option(-3, 100, 104, supercbt, 50)
end

local exports = {}
exports.start = start
return exports
