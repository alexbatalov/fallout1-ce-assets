local fallout = require("fallout")
local reputation = require("lib.reputation")

--
-- Some unreferenced imported varables found.
-- Because of it it is impossible to specify
-- the real names of global variables.
--

local g0 = 0
local g1 = 0
local g2 = 0
local g3 = 0
local g4 = 0
local g5 = 1

-- ?import? variable test
-- ?import? variable temp
-- ?import? variable ego_blast
-- ?import? variable per
-- ?import? variable PICK
-- ?import? variable mult
-- ?import? variable Tycho_Ptr
-- ?import? variable Katja_Ptr
-- ?import? variable Tandi_Ptr

local start
local blast_party

function start()
    if fallout.script_action() == 2 then
        if fallout.source_obj() == fallout.dude_obj() then
            g3 = fallout.get_critter_stat(fallout.dude_obj(), 1)
            if fallout.local_var(0) <= fallout.map_var(2) then
                fallout.set_local_var(0, fallout.map_var(2) + 1)
                g0 = g3 + fallout.map_var(0)
                if fallout.random(1, 10) < g0 then
                    g4 = fallout.map_var(0)
                    if fallout.obj_carrying_pid_obj(fallout.dude_obj(), 123) then
                        if fallout.map_var(1) ~= 0 then
                            fallout.set_map_var(1, 0)
                            fallout.display_msg(fallout.message_str(740, 107))
                        end
                    else
                        if g4 == 0 then
                            fallout.display_msg(fallout.message_str(740, 100))
                            fallout.set_map_var(1, 1)
                            fallout.set_map_var(0, fallout.map_var(0) + 1)
                        else
                            if g4 == 1 then
                                if fallout.has_trait(0, fallout.dude_obj(), 27) then
                                    g2 = 0
                                else
                                    fallout.display_msg(fallout.message_str(740, 101))
                                    g2 = fallout.random(1, g3)
                                    fallout.critter_dmg(fallout.dude_obj(), g2, 0 | 256)
                                end
                                fallout.set_map_var(0, fallout.map_var(0) + 1)
                                g5 = 1
                                blast_party()
                            else
                                if g4 == 2 then
                                    if fallout.has_trait(0, fallout.dude_obj(), 27) then
                                        g2 = 0
                                    else
                                        fallout.display_msg(fallout.message_str(740, 102))
                                        g2 = fallout.random(1, g3) + fallout.random(1, g3)
                                        fallout.critter_dmg(fallout.dude_obj(), g2, 0 | 256)
                                    end
                                    fallout.set_map_var(0, fallout.map_var(0) + 1)
                                    g5 = 2
                                    blast_party()
                                else
                                    if g4 == 3 then
                                        if fallout.has_trait(0, fallout.dude_obj(), 27) then
                                            g2 = 0
                                        else
                                            fallout.display_msg(fallout.message_str(740, 103))
                                            g2 = fallout.random(1, g3) + fallout.random(1, g3) + fallout.random(1, g3)
                                            fallout.critter_dmg(fallout.dude_obj(), g2, 0 | 256)
                                        end
                                        fallout.set_map_var(0, fallout.map_var(0) + 1)
                                        g5 = 3
                                        blast_party()
                                    else
                                        if g4 == 4 then
                                            if fallout.has_trait(0, fallout.dude_obj(), 27) then
                                                g2 = 0
                                            else
                                                fallout.display_msg(fallout.message_str(740, 104))
                                                g2 = fallout.random(1, g3) + fallout.random(1, g3) + fallout.random(1, g3)
                                                fallout.critter_dmg(fallout.dude_obj(), g2, 0 | 256)
                                                fallout.critter_injure(fallout.dude_obj(), 64)
                                                g1 = fallout.get_critter_stat(fallout.dude_obj(), 1)
                                                fallout.set_critter_stat(fallout.dude_obj(), 1, -1)
                                            end
                                            fallout.set_map_var(0, fallout.map_var(0) + 1)
                                            g5 = 3
                                            blast_party()
                                        else
                                            if g4 == 5 then
                                                if fallout.has_trait(0, fallout.dude_obj(), 27) then
                                                    g2 = 0
                                                else
                                                    fallout.display_msg(fallout.message_str(740, 105))
                                                    g2 = 1
                                                    if reputation.has_rep_berserker() then
                                                        g2 = g2 + 15
                                                    end
                                                    if fallout.global_var(158) > 2 then
                                                        g2 = g2 + 20
                                                    end
                                                    fallout.critter_dmg(fallout.dude_obj(), g2, 0 | 256)
                                                    g1 = fallout.get_critter_stat(fallout.dude_obj(), 4)
                                                    fallout.set_critter_stat(fallout.dude_obj(), 4, -1)
                                                end
                                                fallout.set_map_var(0, fallout.map_var(0) + 1)
                                                g5 = 4
                                                blast_party()
                                            else
                                                if g4 == 6 then
                                                    if fallout.has_trait(0, fallout.dude_obj(), 27) then
                                                        g2 = 0
                                                    else
                                                        fallout.display_msg(fallout.message_str(740, 106))
                                                        g1 = fallout.get_critter_stat(fallout.dude_obj(), 1)
                                                        fallout.set_critter_stat(fallout.dude_obj(), 1, -1)
                                                        g1 = fallout.get_critter_stat(fallout.dude_obj(), 4)
                                                        fallout.set_critter_stat(fallout.dude_obj(), 4, -1)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function blast_party()
    g2 = 1
    if reputation.has_rep_berserker() then
        g2 = g2 + 7
    end
    if fallout.global_var(158) > 2 then
        g2 = g2 + 10
    end
    if fallout.global_var(118) == 2 then
        if g5 < 4 then
            g3 = fallout.get_critter_stat(fallout.party_member_obj(16777292), 1)
            g2 = fallout.random(1, g3)
            if g5 > 1 then
                g2 = g2 + fallout.random(1, g3)
            end
            if g5 > 2 then
                g2 = g2 + fallout.random(1, g3)
            end
        end
        fallout.critter_dmg(fallout.party_member_obj(16777292), g2, 0 | 256)
    end
    if fallout.global_var(121) == 2 then
        if g5 < 4 then
            g3 = fallout.get_critter_stat(fallout.party_member_obj(16777426), 1)
            g2 = fallout.random(1, g3)
            if g5 > 1 then
                g2 = g2 + fallout.random(1, g3)
            end
            if g5 > 2 then
                g2 = g2 + fallout.random(1, g3)
            end
        end
        fallout.critter_dmg(fallout.party_member_obj(16777426), g2, 0 | 256)
    end
    if fallout.global_var(244) == 2 then
        if g5 < 4 then
            g3 = fallout.get_critter_stat(fallout.party_member_obj(16777518), 1)
            g2 = fallout.random(1, g3)
            if g5 > 1 then
                g2 = g2 + fallout.random(1, g3)
            end
            if g5 > 2 then
                g2 = g2 + fallout.random(1, g3)
            end
        end
        fallout.critter_dmg(fallout.party_member_obj(16777518), g2, 0 | 256)
    end
    if fallout.global_var(26) == 5 then
        if g5 < 4 then
            g3 = fallout.get_critter_stat(fallout.party_member_obj(16777279), 1)
            g2 = fallout.random(1, g3)
            if g5 > 1 then
                g2 = g2 + fallout.random(1, g3)
            end
            if g5 > 2 then
                g2 = g2 + fallout.random(1, g3)
            end
        end
        fallout.critter_dmg(fallout.party_member_obj(16777279), g2, 0 | 256)
    end
end

local exports = {}
exports.start = start
return exports
