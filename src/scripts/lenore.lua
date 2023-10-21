local fallout = require("fallout")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0
local g1 = 0
local g2 = 0
local g3 = 29081

local start
local do_dialogue
local go_inside
local Lenore00
local Lenore01
local Lenore02
local Lenore03
local Lenore04

-- ?import? variable hostile
-- ?import? variable armed
-- ?import? variable initialized
-- ?import? variable home_tile
-- ?import? variable growling

function start()
    if not(g2) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 5)
        g2 = 1
    else
        if fallout.script_action() == 11 then
            do_dialogue()
        else
            if fallout.script_action() == 18 then
                if fallout.source_obj() == fallout.dude_obj() then
                    fallout.set_global_var(159, fallout.global_var(159) + 1)
                    if (fallout.global_var(159) % 7) == 0 then
                        fallout.set_global_var(155, fallout.global_var(155) - 1)
                    end
                end
            else
                if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
                    fallout.script_overrides()
                    fallout.display_msg(fallout.message_str(375, 100))
                else
                    if fallout.script_action() == 4 then
                        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
                    else
                        if fallout.script_action() == 12 then
                            if fallout.external_var("smartass2") then
                                Lenore00()
                            end
                            if not(fallout.external_var("dog_is_angry")) then
                                go_inside()
                            end
                        else
                            if fallout.script_action() == 8 then
                                if fallout.action_being_used() == 14 then
                                    fallout.dialogue_system_enter()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function do_dialogue()
    if fallout.global_var(5) ~= 0 then
        Lenore02()
    else
        if not(fallout.external_var("dog_is_angry")) then
            Lenore04()
        else
            if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                Lenore01()
            else
                Lenore03()
            end
        end
    end
end

function go_inside()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), g3, 0)
end

function Lenore00()
    local v0 = 0
    local v1 = 0
    v0 = fallout.random(1, 3)
    if v0 == 1 then
        v1 = fallout.message_str(375, 101)
    else
        if v0 == 2 then
            v1 = fallout.message_str(375, 102)
        else
            fallout.set_global_var(187, 1)
            v1 = fallout.message_str(375, 103)
        end
    end
    if fallout.external_var("dog_is_angry") then
        fallout.float_msg(fallout.self_obj(), v1, 0)
    end
    fallout.set_external_var("smartass2", 0)
end

function Lenore01()
    if fallout.external_var("dog_is_angry") then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(375, 104), 0)
    end
end

function Lenore02()
    if fallout.external_var("dog_is_angry") then
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
return exports
