local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local spatial_p_proc
local blast_party

local ego_blast = 0
local per = 0
local mult = 1

function start()
    local script_action = fallout.script_action()
    if script_action == 2 then
        spatial_p_proc()
    end
end

function spatial_p_proc()
    local dude_obj = fallout.dude_obj()
    if fallout.source_obj() == dude_obj then
        per = fallout.get_critter_stat(dude_obj, 1)
        if fallout.local_var(0) <= fallout.map_var(2) then
            fallout.set_local_var(0, fallout.map_var(2) + 1)
            if fallout.random(1, 10) < per + fallout.map_var(0) then
                local pick = fallout.map_var(0)
                if fallout.obj_carrying_pid_obj(dude_obj, 123) then
                    if fallout.map_var(1) ~= 0 then
                        fallout.set_map_var(1, 0)
                        fallout.display_msg(fallout.message_str(740, 107))
                    end
                else
                    if pick == 0 then
                        fallout.display_msg(fallout.message_str(740, 100))
                        fallout.set_map_var(1, 1)
                        fallout.set_map_var(0, fallout.map_var(0) + 1)
                    elseif pick == 1 then
                        if fallout.has_trait(0, dude_obj, 27) then
                            ego_blast = 0
                        else
                            fallout.display_msg(fallout.message_str(740, 101))
                            ego_blast = fallout.random(1, per)
                            fallout.critter_dmg(dude_obj, ego_blast, 0 | 256)
                        end
                        fallout.set_map_var(0, fallout.map_var(0) + 1)
                        mult = 1
                        blast_party()
                    elseif pick == 2 then
                        if fallout.has_trait(0, dude_obj, 27) then
                            ego_blast = 0
                        else
                            fallout.display_msg(fallout.message_str(740, 102))
                            ego_blast = fallout.random(1, per) + fallout.random(1, per)
                            fallout.critter_dmg(dude_obj, ego_blast, 0 | 256)
                        end
                        fallout.set_map_var(0, fallout.map_var(0) + 1)
                        mult = 2
                        blast_party()
                    elseif pick == 3 then
                        if fallout.has_trait(0, dude_obj, 27) then
                            ego_blast = 0
                        else
                            fallout.display_msg(fallout.message_str(740, 103))
                            ego_blast = fallout.random(1, per) + fallout.random(1, per) + fallout.random(1, per)
                            fallout.critter_dmg(dude_obj, ego_blast, 0 | 256)
                        end
                        fallout.set_map_var(0, fallout.map_var(0) + 1)
                        mult = 3
                        blast_party()
                    elseif pick == 4 then
                        if fallout.has_trait(0, dude_obj, 27) then
                            ego_blast = 0
                        else
                            fallout.display_msg(fallout.message_str(740, 104))
                            ego_blast = fallout.random(1, per) + fallout.random(1, per) + fallout.random(1, per)
                            fallout.critter_dmg(dude_obj, ego_blast, 0 | 256)
                            fallout.critter_injure(dude_obj, 64)
                            fallout.set_critter_stat(dude_obj, 1, -1)
                        end
                        fallout.set_map_var(0, fallout.map_var(0) + 1)
                        mult = 3
                        blast_party()
                    elseif pick == 5 then
                        if fallout.has_trait(0, dude_obj, 27) then
                            ego_blast = 0
                        else
                            fallout.display_msg(fallout.message_str(740, 105))
                            ego_blast = 1
                            if reputation.has_rep_berserker() then
                                ego_blast = ego_blast + 15
                            end
                            if fallout.global_var(158) > 2 then
                                ego_blast = ego_blast + 20
                            end
                            fallout.critter_dmg(dude_obj, ego_blast, 0 | 256)
                            fallout.set_critter_stat(dude_obj, 4, -1)
                        end
                        fallout.set_map_var(0, fallout.map_var(0) + 1)
                        mult = 4
                        blast_party()
                    elseif pick == 6 then
                        if fallout.has_trait(0, dude_obj, 27) then
                            ego_blast = 0
                        else
                            fallout.display_msg(fallout.message_str(740, 106))
                            fallout.set_critter_stat(dude_obj, 1, -1)
                            fallout.set_critter_stat(dude_obj, 4, -1)
                        end
                    end
                end
            end
        end
    end
end

function blast_party()
    ego_blast = 1
    if reputation.has_rep_berserker() then
        ego_blast = ego_blast + 7
    end
    if fallout.global_var(158) > 2 then
        ego_blast = ego_blast + 10
    end
    if fallout.global_var(118) == 2 then
        if mult < 4 then
            per = fallout.get_critter_stat(fallout.party_member_obj(16777292), 1)
            ego_blast = fallout.random(1, per)
            if mult > 1 then
                ego_blast = ego_blast + fallout.random(1, per)
            end
            if mult > 2 then
                ego_blast = ego_blast + fallout.random(1, per)
            end
        end
        fallout.critter_dmg(fallout.party_member_obj(16777292), ego_blast, 0 | 256)
    end
    if fallout.global_var(121) == 2 then
        if mult < 4 then
            per = fallout.get_critter_stat(fallout.party_member_obj(16777426), 1)
            ego_blast = fallout.random(1, per)
            if mult > 1 then
                ego_blast = ego_blast + fallout.random(1, per)
            end
            if mult > 2 then
                ego_blast = ego_blast + fallout.random(1, per)
            end
        end
        fallout.critter_dmg(fallout.party_member_obj(16777426), ego_blast, 0 | 256)
    end
    if fallout.global_var(244) == 2 then
        if mult < 4 then
            per = fallout.get_critter_stat(fallout.party_member_obj(16777518), 1)
            ego_blast = fallout.random(1, per)
            if mult > 1 then
                ego_blast = ego_blast + fallout.random(1, per)
            end
            if mult > 2 then
                ego_blast = ego_blast + fallout.random(1, per)
            end
        end
        fallout.critter_dmg(fallout.party_member_obj(16777518), ego_blast, 0 | 256)
    end
    if fallout.global_var(26) == 5 then
        if mult < 4 then
            per = fallout.get_critter_stat(fallout.party_member_obj(16777279), 1)
            ego_blast = fallout.random(1, per)
            if mult > 1 then
                ego_blast = ego_blast + fallout.random(1, per)
            end
            if mult > 2 then
                ego_blast = ego_blast + fallout.random(1, per)
            end
        end
        fallout.critter_dmg(fallout.party_member_obj(16777279), ego_blast, 0 | 256)
    end
end

local exports = {}
exports.start = start
exports.spatial_p_proc = spatial_p_proc
return exports
