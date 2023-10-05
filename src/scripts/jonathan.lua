local fallout = require("fallout")

local start
local spar
local weapon_check

local initialized = 0
local armed = 0
local round = 0
local v = 0

function start()
    if not(initialized) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 44)
        fallout.critter_add_trait(fallout.self_obj(), 1, 5, 64)
        initialized = 1
    end
    if (fallout.script_action() == 22) and (round < 7) then
        spar()
    else
        if fallout.script_action() == 18 then
            if fallout.source_obj() == fallout.dude_obj() then
                if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                    fallout.set_global_var(156, 1)
                    fallout.set_global_var(157, 0)
                end
                if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                    fallout.set_global_var(157, 1)
                    fallout.set_global_var(156, 0)
                end
                fallout.set_global_var(159, fallout.global_var(159) + 1)
                if (fallout.global_var(159) % 2) == 0 then
                    fallout.set_global_var(155, fallout.global_var(155) - 1)
                end
            end
        else
            if fallout.script_action() == 12 then
                if round < 1 then
                    round = round + 1
                    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(5), 0)
                end
            end
        end
    end
end

function spar()
    if round == 1 then
        fallout.anim(fallout.external_var("Student_ptr"), 16, 0)
        fallout.anim(fallout.self_obj(), 13, 0)
        v = 2
    else
        if round == 2 then
            fallout.anim(fallout.self_obj(), 16, 0)
            fallout.anim(fallout.external_var("Student_ptr"), 14, 0)
            v = 2
        else
            if round == 3 then
                fallout.anim(fallout.self_obj(), 16, 0)
                fallout.anim(fallout.external_var("Student_ptr"), 13, 0)
                v = 2
            else
                if round == 4 then
                    fallout.anim(fallout.self_obj(), 17, 0)
                    v = 1
                else
                    if round == 5 then
                        fallout.anim(fallout.external_var("Student_ptr"), 20, 0)
                        v = 2
                    else
                        if round == 6 then
                            fallout.anim(fallout.self_obj(), 0, 0)
                            fallout.anim(fallout.external_var("Student_ptr"), 37, 0)
                            v = 2
                        end
                    end
                end
            end
        end
    end
    round = round + 1
    fallout.add_timer_event(fallout.self_obj(), fallout.game_ticks(v), 0)
end

function weapon_check()
    if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.external_var("Student_ptr"), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.external_var("Student_ptr"), 2)) == 3) then
        armed = 1
    else
        armed = 0
    end
end

local exports = {}
exports.start = start
return exports
