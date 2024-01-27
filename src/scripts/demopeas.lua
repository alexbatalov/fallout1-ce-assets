local fallout = require("fallout")
local misc = require("lib.misc")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0
local g1 = 0
local g2 = 0

local start
local talk_p_proc
local go_inside
local PeasantD00
local PeasantD01
local PeasantD02
local PeasantD03
local PeasantD04

-- ?import? variable hostile
-- ?import? variable armed
-- ?import? variable initialized
-- ?import? variable growling

function start()
    if not(g2) then
        fallout.critter_add_trait(fallout.self_obj(), 1, 6, 5)
        g2 = 1
    else
        if fallout.script_action() == 11 then
            talk_p_proc()
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
                            PeasantD00()
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

function talk_p_proc()
    if fallout.global_var(5) ~= 0 then
        PeasantD02()
    else
        if not(fallout.external_var("dog_is_angry")) then
            PeasantD04()
        else
            if misc.is_armed(fallout.dude_obj()) then
                PeasantD01()
            else
                PeasantD03()
            end
        end
    end
end

function go_inside()
    fallout.animate_move_obj_to_tile(fallout.self_obj(), 15283, 0)
end

function PeasantD00()
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
        fallout.float_msg(fallout.self_obj(), v1, 3)
    end
    fallout.set_external_var("smartass2", 0)
end

function PeasantD01()
    if fallout.external_var("dog_is_angry") then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(375, 104), 3)
    end
end

function PeasantD02()
    if fallout.external_var("dog_is_angry") then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(375, 105), 3)
    end
end

function PeasantD03()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(375, 106), 3)
    fallout.set_external_var("smartass", 1)
end

function PeasantD04()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(375, 107), 3)
end

local exports = {}
exports.start = start
exports.talk_p_proc = talk_p_proc
return exports
