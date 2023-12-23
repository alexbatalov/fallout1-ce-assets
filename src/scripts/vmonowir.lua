local fallout = require("fallout")

local start
local spatial_p_proc
local use_skill_on_p_proc

local triggered = false
local test = 0

function start()
    local script_action = fallout.script_action()
    if script_action == 2 then
        spatial_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function spatial_p_proc()
    local dude_obj = fallout.dude_obj()
    if fallout.source_obj() == dude_obj then
        if fallout.tile_num(dude_obj) ~= fallout.tile_num(fallout.self_obj()) then
            triggered = false
        else
            if not triggered then
                triggered = true
                if fallout.art_anim(fallout.obj_art_fid(dude_obj)) == 1
                    and fallout.is_success(fallout.do_check(dude_obj, 1, 0))
                    and fallout.is_success(fallout.do_check(dude_obj, 5, 0)) then
                    fallout.display_msg(fallout.message_str(615, 100))
                    fallout.set_map_var(13, 1)
                else
                    fallout.display_msg(fallout.message_str(615, 101))
                    if fallout.art_anim(fallout.obj_art_fid(dude_obj)) == 1 then
                        fallout.critter_dmg(dude_obj, fallout.random(10, 20), 1)
                    else
                        fallout.critter_dmg(dude_obj, fallout.random(15, 30), 1)
                    end
                    if not fallout.is_success(fallout.do_check(dude_obj, 6, 0)) then
                        if fallout.random(0, 1) then
                            fallout.display_msg(fallout.message_str(615, 102))
                            fallout.critter_injure(dude_obj, 8)
                        else
                            fallout.display_msg(fallout.message_str(615, 103))
                            fallout.critter_injure(dude_obj, 4)
                        end
                    end
                end
            end
        end
    end
end

function use_skill_on_p_proc()
    if fallout.map_var(7) == 1 and fallout.map_var(13) == 0 then
        fallout.script_overrides()
        if fallout.is_success(fallout.roll_vs_skill(fallout.dude_obj(), 11, -20)) then
            fallout.display_msg(fallout.message_str(615, 104))
            fallout.set_map_var(13, 1)
            fallout.move_to(fallout.self_obj(), 7000, 0)
            fallout.set_external_var("removal_ptr", fallout.self_obj())
        else
            if fallout.is_critical(test) then
                fallout.display_msg(fallout.message_str(615, 106))
                fallout.critter_dmg(fallout.dude_obj(), 1, 1)
            else
                fallout.display_msg(fallout.message_str(615, 105))
            end
        end
    end
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
return exports
