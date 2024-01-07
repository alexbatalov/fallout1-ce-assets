local fallout = require("fallout")

local start
local pickup_p_proc
local use_skill_on_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc
local go_inside
local Lenore00
local Lenore01
local Lenore02
local Lenore03
local Lenore04

local initialized = false
local home_tile = 29081

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 5)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 11 then
        talk_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    end
end

function pickup_p_proc()
    fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
end

function use_skill_on_p_proc()
    if fallout.action_being_used() == 14 then
        fallout.dialogue_system_enter()
    end
end

function talk_p_proc()
    if fallout.global_var(5) ~= 0 then
        Lenore02()
    elseif fallout.external_var("dog_is_angry") == 0 then
        Lenore04()
    elseif (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
        Lenore01()
    else
        Lenore03()
    end
end

function critter_p_proc()
    if fallout.external_var("smartass2") ~= 0 then
        Lenore00()
    end
    if fallout.external_var("dog_is_angry") == 0 then
        go_inside()
    end
end

function destroy_p_proc()
    if fallout.source_obj() == fallout.dude_obj() then
        fallout.set_global_var(159, fallout.global_var(159) + 1)
        if fallout.global_var(159) % 7 == 0 then
            fallout.set_global_var(155, fallout.global_var(155) - 1)
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(375, 100))
end

function go_inside()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), home_tile, 0)
end

function Lenore00()
    local msg
    local rnd = fallout.random(1, 3)
    if rnd == 1 then
        msg = fallout.message_str(375, 101)
    elseif rnd == 2 then
        msg = fallout.message_str(375, 102)
    else
        fallout.set_global_var(187, 1)
        msg = fallout.message_str(375, 103)
    end
    if fallout.external_var("dog_is_angry") ~= 0 then
        fallout.float_msg(fallout.self_obj(), msg, 0)
    end
    fallout.set_external_var("smartass2", 0)
end

function Lenore01()
    if fallout.external_var("dog_is_angry") ~= 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(375, 104), 0)
    end
end

function Lenore02()
    if fallout.external_var("dog_is_angry") ~= 0 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(375, 105), 0)
    end
end

function Lenore03()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(375, 106), 0)
    fallout.set_external_var("smartass", 1)
end

function Lenore04()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(375, 107), 0)
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
