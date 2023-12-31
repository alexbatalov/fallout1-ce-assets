local fallout = require("fallout")
local light = require("lib.light")
local party = require("lib.party")

fallout.create_external_var("women_killed")
fallout.create_external_var("signal_women")
fallout.create_external_var("killing_women")
fallout.create_external_var("Garls_Inven_Ptr")
fallout.create_external_var("Cell_Door_Ptr")

local rndx = 0
local Tandi_hex = 0
local temp = 0

local start

local party_elevation = 0
local dude_start_hex = 0

fallout.create_external_var("Ian_ptr")
fallout.create_external_var("Dog_ptr")
fallout.create_external_var("Tycho_ptr")
fallout.create_external_var("Katja_ptr")
fallout.create_external_var("Tandi_ptr")

function start()
    if fallout.script_action() == 15 then
        light.lighting()
        fallout.set_global_var(69, 2)
        if fallout.metarule(14, 0) then
            fallout.display_msg(fallout.message_str(194, 103))
            if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
                if (fallout.get_critter_stat(fallout.dude_obj(), 6) > 8) and fallout.random(0, 1) then
                    fallout.set_global_var(116, 1)
                end
            end
        end
        if fallout.metarule(22, 0) == 0 then
            if (fallout.global_var(114) == 1) and (fallout.global_var(115) <= 12) or (fallout.global_var(115) <= 6) then
                fallout.kill_critter_type(16777254, 0)
                fallout.kill_critter_type(16777235, 0)
                fallout.kill_critter_type(16777233, 0)
                fallout.kill_critter_type(16777248, 0)
                fallout.kill_critter_type(16777249, 0)
                fallout.kill_critter_type(16777243, 0)
                fallout.kill_critter_type(16777236, 0)
                fallout.kill_critter_type(16777247, 0)
                fallout.kill_critter_type(16777238, 0)
                fallout.kill_critter_type(16777253, 0)
                fallout.kill_critter_type(16777218, 0)
                fallout.kill_critter_type(16777248, 0)
            end
        end
        if fallout.global_var(32) == 1 then
            fallout.override_map_start(96, 133, 0, 5)
        else
            fallout.override_map_start(96, 133, 0, 5)
        end
        party_elevation = party.add_party()
    else
        if fallout.script_action() == 23 then
            light.lighting()
        else
            if fallout.script_action() == 16 then
                if (fallout.global_var(26) == 5) and (fallout.map_var(1) ~= 1) then
                    fallout.set_map_var(1, 1)
                    fallout.set_global_var(26, 5)
                    fallout.set_global_var(103, 2)
                    temp = (16 - fallout.global_var(115)) * 50
                    if temp < 500 then
                        temp = 500 - temp
                        fallout.display_msg(fallout.message_str(238, 100) .. temp .. fallout.message_str(238, 101))
                        fallout.set_global_var(155, fallout.global_var(155) + 1)
                        fallout.give_exp_points(temp)
                    else
                        temp = 0
                        fallout.set_global_var(155, fallout.global_var(155) + 1)
                        fallout.display_msg(fallout.message_str(238, 100) .. temp .. fallout.message_str(238, 101))
                    end
                end
                if (fallout.global_var(114) == 1) and (fallout.global_var(115) <= 8) or (fallout.global_var(115) <= 4) then
                    fallout.kill_critter_type(16777254, 0)
                    fallout.kill_critter_type(16777235, 0)
                    fallout.kill_critter_type(16777233, 0)
                    fallout.kill_critter_type(16777248, 0)
                    fallout.kill_critter_type(16777249, 0)
                    fallout.kill_critter_type(16777243, 0)
                    fallout.kill_critter_type(16777236, 0)
                    fallout.kill_critter_type(16777247, 0)
                    fallout.kill_critter_type(16777238, 0)
                    fallout.kill_critter_type(16777253, 0)
                    fallout.kill_critter_type(16777218, 0)
                end
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
