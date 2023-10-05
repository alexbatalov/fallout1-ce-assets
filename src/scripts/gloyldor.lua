local fallout = require("fallout")

local start
local use_p_proc
local use_skill_on_p_proc
local use_obj_on_p_proc
local look_at_p_proc
local description_p_proc
local damage_p_proc
local map_enter_p_proc
local map_update_p_proc
local Trapped_And_Locked
local Locked_Door
local Trapped_Door
local Damage_Dude
local Skill_Checks
local Stat_Checks
local Locks_Check
local Display_Armed_And_Locked
local Display_Locked
local Display_Trapped

local Only_Once = 0
local Locks = 0
local Traps = 0
local Per = 0

function start()
    if fallout.script_action() == 6 then
        use_p_proc()
    else
        if fallout.script_action() == 15 then
            map_enter_p_proc()
        else
            if fallout.script_action() == 23 then
                map_update_p_proc()
            else
                if fallout.script_action() == 7 then
                    use_obj_on_p_proc()
                else
                    if fallout.script_action() == 21 then
                        look_at_p_proc()
                    else
                        if fallout.script_action() == 3 then
                            description_p_proc()
                        else
                            if fallout.script_action() == 8 then
                                use_skill_on_p_proc()
                            else
                                if fallout.script_action() == 14 then
                                    damage_p_proc()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function use_p_proc()
    local v0 = 0
    v0 = fallout.roll_vs_skill(fallout.source_obj(), 11, -20)
    if fallout.global_var(224) == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(832, 205))
    else
        if fallout.local_var(2) == 0 then
            if fallout.is_success(v0) then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(832, 204))
                fallout.reg_anim_func(2, fallout.source_obj())
            else
                if fallout.obj_is_locked(fallout.self_obj()) then
                    fallout.script_overrides()
                    fallout.set_local_var(0, fallout.local_var(0) + 1)
                    Damage_Dude()
                else
                    fallout.script_overrides()
                    fallout.set_local_var(0, fallout.local_var(0) + 1)
                    Damage_Dude()
                end
            end
        else
            if fallout.local_var(3) == 0 then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(832, 105))
            end
        end
    end
end

function use_skill_on_p_proc()
    if (fallout.local_var(2) == 0) and fallout.obj_is_locked(fallout.self_obj()) then
        Trapped_And_Locked()
    else
        if fallout.local_var(2) == 0 then
            Trapped_Door()
        else
            if fallout.obj_is_locked(fallout.self_obj()) then
                Locked_Door()
            end
        end
    end
end

function use_obj_on_p_proc()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    v0 = fallout.obj_pid(fallout.obj_being_used_with())
    if v0 == 77 then
        fallout.script_overrides()
        if fallout.local_var(2) == 0 then
            v1 = fallout.roll_vs_skill(fallout.source_obj(), 11, -20)
            if fallout.is_success(v1) then
                fallout.display_msg(204)
                fallout.reg_anim_func(2, fallout.source_obj())
            else
                fallout.set_local_var(0, fallout.local_var(0) + 1)
                Damage_Dude()
            end
        end
        if fallout.obj_is_locked(fallout.self_obj()) then
            v2 = fallout.roll_vs_skill(fallout.source_obj(), 9, -10)
            if fallout.is_success(v2) then
                fallout.obj_unlock(fallout.self_obj())
                fallout.set_local_var(3, 1)
                fallout.display_msg(fallout.message_str(832, 109))
                fallout.display_msg(fallout.message_str(766, 103) + "55" + fallout.message_str(766, 104))
                fallout.give_exp_points(55)
            else
                if fallout.is_critical(v2) then
                    fallout.display_msg(fallout.message_str(832, 121))
                    fallout.jam_lock(fallout.self_obj())
                    fallout.display_msg(fallout.message_str(63, 110))
                    fallout.rm_obj_from_inven(fallout.source_obj(), v0)
                    fallout.destroy_object(v0)
                else
                    fallout.display_msg(fallout.message_str(832, 122))
                end
            end
        end
    else
        if v0 == 223 then
            fallout.script_overrides()
            fallout.set_local_var(2, 1)
            fallout.obj_unlock(fallout.self_obj())
            fallout.set_local_var(3, 1)
            fallout.display_msg(fallout.message_str(832, 106))
        end
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(832, 123))
end

function description_p_proc()
    fallout.script_overrides()
    if (fallout.local_var(3) == 0) and (fallout.local_var(2) == 0) then
        Skill_Checks()
        Display_Armed_And_Locked()
    else
        if fallout.local_var(2) == 0 then
            Skill_Checks()
            Display_Trapped()
        else
            if fallout.local_var(3) == 0 then
                Locks_Check()
                Display_Locked()
            else
                fallout.display_msg(fallout.message_str(832, 123))
            end
        end
    end
end

function damage_p_proc()
    if fallout.local_var(1) > 3 then
        fallout.set_local_var(2, 1)
        fallout.set_obj_visibility(fallout.self_obj(), 1)
        fallout.obj_open(fallout.self_obj())
        fallout.set_local_var(3, 1)
    end
end

function map_enter_p_proc()
    if fallout.local_var(3) == 0 then
        fallout.obj_lock(fallout.self_obj())
    end
end

function map_update_p_proc()
    if fallout.local_var(3) == 0 then
        fallout.obj_lock(fallout.self_obj())
    else
        fallout.obj_unlock(fallout.self_obj())
    end
end

function Trapped_And_Locked()
    local v0 = 0
    local v1 = 0
    if fallout.action_being_used() == 11 then
        fallout.script_overrides()
        v0 = fallout.roll_vs_skill(fallout.source_obj(), 11, -20)
        if fallout.is_success(v0) then
            fallout.display_msg(fallout.message_str(832, 113))
            fallout.set_local_var(2, 1)
            fallout.display_msg(fallout.message_str(766, 103) + "45" + fallout.message_str(766, 104))
            fallout.give_exp_points(45)
        else
            if fallout.is_critical(v0) then
                fallout.display_msg(fallout.message_str(832, 114))
                if fallout.local_var(0) == 0 then
                    fallout.set_local_var(0, 4)
                else
                    fallout.set_local_var(0, fallout.local_var(0) + 4)
                end
                Damage_Dude()
            else
                fallout.set_local_var(0, fallout.local_var(0) + 1)
                fallout.display_msg(fallout.message_str(832, 115))
                Damage_Dude()
            end
        end
    else
        if fallout.action_being_used() == 9 then
            fallout.script_overrides()
            v0 = fallout.roll_vs_skill(fallout.source_obj(), 9, -30)
            v1 = fallout.roll_vs_skill(fallout.source_obj(), 11, -20)
            if fallout.is_success(v1) then
                if fallout.is_success(v0) then
                    fallout.obj_unlock(fallout.self_obj())
                    fallout.set_local_var(3, 1)
                    fallout.display_msg(fallout.message_str(832, 116))
                    fallout.display_msg(fallout.message_str(766, 103) + "55" + fallout.message_str(766, 104))
                    fallout.give_exp_points(55)
                else
                    if fallout.is_critical(v0) then
                        fallout.set_local_var(0, fallout.local_var(0) + 2)
                        fallout.display_msg(fallout.message_str(832, 117))
                        fallout.jam_lock(fallout.self_obj())
                        fallout.display_msg(fallout.message_str(832, 110))
                        Damage_Dude()
                    else
                        fallout.set_local_var(0, fallout.local_var(0) + 1)
                        fallout.display_msg(fallout.message_str(832, 118))
                        Damage_Dude()
                    end
                end
            else
                if fallout.is_critical(v1) then
                    fallout.display_msg(fallout.message_str(832, 120))
                    if fallout.local_var(0) == 0 then
                        fallout.set_local_var(0, 4)
                    else
                        fallout.set_local_var(0, fallout.local_var(0) + 4)
                    end
                    Damage_Dude()
                else
                    fallout.set_local_var(0, fallout.local_var(0) + 1)
                    fallout.display_msg(fallout.message_str(832, 119))
                    Damage_Dude()
                end
            end
        end
    end
end

function Locked_Door()
    local v0 = 0
    if fallout.action_being_used() == 9 then
        fallout.script_overrides()
        v0 = fallout.roll_vs_skill(fallout.source_obj(), 9, -30)
        if fallout.is_success(v0) then
            fallout.obj_unlock(fallout.self_obj())
            fallout.set_local_var(3, 1)
            fallout.display_msg(fallout.message_str(832, 116))
        else
            if fallout.is_critical(v0) then
                fallout.display_msg(fallout.message_str(832, 121))
                fallout.jam_lock(fallout.self_obj())
                fallout.display_msg(fallout.message_str(832, 110))
                fallout.game_time_advance(fallout.game_ticks(600))
            else
                fallout.display_msg(fallout.message_str(832, 122))
            end
        end
    end
end

function Trapped_Door()
    local v0 = 0
    if fallout.action_being_used() == 11 then
        fallout.script_overrides()
        v0 = fallout.roll_vs_skill(fallout.source_obj(), 11, -20)
        if fallout.is_success(v0) then
            fallout.display_msg(fallout.message_str(832, 113))
            fallout.set_local_var(2, 1)
        else
            if fallout.is_critical(v0) then
                fallout.display_msg(fallout.message_str(832, 114))
                if fallout.local_var(0) == 0 then
                    fallout.set_local_var(0, 4)
                else
                    fallout.set_local_var(0, fallout.local_var(0) + 4)
                end
                Damage_Dude()
            else
                fallout.set_local_var(0, fallout.local_var(0) + 1)
                fallout.display_msg(fallout.message_str(832, 115))
                Damage_Dude()
            end
        end
    end
end

function Damage_Dude()
    fallout.critter_dmg(fallout.source_obj(), fallout.local_var(0), 4 | 256)
    if fallout.local_var(0) == 1 then
        fallout.display_msg(fallout.message_str(832, 101))
    else
        fallout.display_msg(fallout.message_str(832, 102) + fallout.local_var(0) + fallout.message_str(832, 103))
    end
end

function Skill_Checks()
    local v0 = 0
    local v1 = 0
    local v2 = 0
    v0 = fallout.roll_vs_skill(fallout.source_obj(), 11, 0)
    v1 = fallout.roll_vs_skill(fallout.source_obj(), 9, -10)
    v2 = fallout.do_check(fallout.source_obj(), 1, 0)
    if fallout.is_success(v0) then
        if fallout.is_critical(v0) then
            Locks_Check()
            Traps = 3
        else
            Locks_Check()
            Traps = 2
        end
    else
        if fallout.is_critical(v0) then
            Locks_Check()
            Traps = 0
        else
            Locks_Check()
            Traps = 1
        end
    end
end

function Stat_Checks()
    local v0 = 0
    v0 = fallout.do_check(fallout.source_obj(), 1, 0)
    if fallout.is_success(v0) then
        if fallout.is_critical(v0) then
            Per = 3
        else
            Per = 2
        end
    else
        if fallout.is_critical(v0) then
            Per = 0
        else
            Per = 1
        end
    end
end

function Locks_Check()
    local v0 = 0
    local v1 = 0
    v0 = fallout.roll_vs_skill(fallout.source_obj(), 9, -10)
    v1 = fallout.do_check(fallout.source_obj(), 1, 0)
    if fallout.is_success(v0) then
        if fallout.is_critical(v0) then
            Stat_Checks()
            Locks = 3
        else
            Stat_Checks()
            Locks = 2
        end
    else
        if fallout.is_critical(v0) then
            Stat_Checks()
            Locks = 0
        else
            Stat_Checks()
            Locks = 1
        end
    end
end

function Display_Armed_And_Locked()
    if Per == 0 then
        if Locks == 0 then
            if Traps == 0 then
                fallout.display_msg(fallout.message_str(832, 124))
            else
                if Traps == 1 then
                    fallout.display_msg(fallout.message_str(832, 125))
                else
                    if Traps == 2 then
                        fallout.display_msg(fallout.message_str(832, 126))
                    else
                        fallout.display_msg(fallout.message_str(832, 127))
                    end
                end
            end
        else
            if Locks == 1 then
                if Traps == 0 then
                    fallout.display_msg(fallout.message_str(832, 128))
                else
                    if Traps == 1 then
                        fallout.display_msg(fallout.message_str(832, 129))
                    else
                        if Traps == 2 then
                            fallout.display_msg(fallout.message_str(832, 130))
                        else
                            fallout.display_msg(fallout.message_str(832, 131))
                        end
                    end
                end
            else
                if Locks == 2 then
                    if Traps == 0 then
                        fallout.display_msg(fallout.message_str(832, 132))
                    else
                        if Traps == 1 then
                            fallout.display_msg(fallout.message_str(832, 133))
                        else
                            if Traps == 2 then
                                fallout.display_msg(fallout.message_str(832, 134))
                            else
                                fallout.display_msg(fallout.message_str(832, 135))
                            end
                        end
                    end
                else
                    if Traps == 0 then
                        fallout.display_msg(fallout.message_str(832, 136))
                    else
                        if Traps == 1 then
                            fallout.display_msg(fallout.message_str(832, 137))
                        else
                            if Traps == 2 then
                                fallout.display_msg(fallout.message_str(832, 138))
                            else
                                fallout.display_msg(fallout.message_str(832, 139))
                            end
                        end
                    end
                end
            end
        end
    else
        if Per == 1 then
            if Locks == 0 then
                if Traps == 0 then
                    fallout.display_msg(fallout.message_str(832, 140))
                else
                    if Traps == 1 then
                        fallout.display_msg(fallout.message_str(832, 141))
                    else
                        if Traps == 2 then
                            fallout.display_msg(fallout.message_str(832, 142))
                        else
                            fallout.display_msg(fallout.message_str(832, 143))
                        end
                    end
                end
            else
                if Locks == 1 then
                    if Traps == 0 then
                        fallout.display_msg(fallout.message_str(832, 144))
                    else
                        if Traps == 1 then
                            fallout.display_msg(fallout.message_str(832, 145))
                        else
                            if Traps == 2 then
                                fallout.display_msg(fallout.message_str(832, 146))
                            else
                                fallout.display_msg(fallout.message_str(832, 147))
                            end
                        end
                    end
                else
                    if Locks == 2 then
                        if Traps == 0 then
                            fallout.display_msg(fallout.message_str(832, 148))
                        else
                            if Traps == 1 then
                                fallout.display_msg(fallout.message_str(832, 149))
                            else
                                if Traps == 2 then
                                    fallout.display_msg(fallout.message_str(832, 150))
                                else
                                    fallout.display_msg(fallout.message_str(832, 151))
                                end
                            end
                        end
                    else
                        if Traps == 0 then
                            fallout.display_msg(fallout.message_str(832, 152))
                        else
                            if Traps == 1 then
                                fallout.display_msg(fallout.message_str(832, 153))
                            else
                                if Traps == 2 then
                                    fallout.display_msg(fallout.message_str(832, 154))
                                else
                                    fallout.display_msg(fallout.message_str(832, 155))
                                end
                            end
                        end
                    end
                end
            end
        else
            if Per == 2 then
                if Locks == 0 then
                    if Traps == 0 then
                        fallout.display_msg(fallout.message_str(832, 156))
                    else
                        if Traps == 1 then
                            fallout.display_msg(fallout.message_str(832, 157))
                        else
                            if Traps == 2 then
                                fallout.display_msg(fallout.message_str(832, 158))
                            else
                                fallout.display_msg(fallout.message_str(832, 159))
                            end
                        end
                    end
                else
                    if Locks == 1 then
                        if Traps == 0 then
                            fallout.display_msg(fallout.message_str(832, 160))
                        else
                            if Traps == 1 then
                                fallout.display_msg(fallout.message_str(832, 161))
                            else
                                if Traps == 2 then
                                    fallout.display_msg(fallout.message_str(832, 162))
                                else
                                    fallout.display_msg(fallout.message_str(832, 163))
                                end
                            end
                        end
                    else
                        if Locks == 2 then
                            if Traps == 0 then
                                fallout.display_msg(fallout.message_str(832, 164))
                            else
                                if Traps == 1 then
                                    fallout.display_msg(fallout.message_str(832, 165))
                                else
                                    if Traps == 2 then
                                        fallout.display_msg(fallout.message_str(832, 166))
                                    else
                                        fallout.display_msg(fallout.message_str(832, 167))
                                    end
                                end
                            end
                        else
                            if Traps == 0 then
                                fallout.display_msg(fallout.message_str(832, 168))
                            else
                                if Traps == 1 then
                                    fallout.display_msg(fallout.message_str(832, 169))
                                else
                                    if Traps == 2 then
                                        fallout.display_msg(fallout.message_str(832, 170))
                                    else
                                        fallout.display_msg(fallout.message_str(832, 171))
                                    end
                                end
                            end
                        end
                    end
                end
            else
                if Locks == 0 then
                    if Traps == 0 then
                        fallout.display_msg(fallout.message_str(832, 172))
                    else
                        if Traps == 1 then
                            fallout.display_msg(fallout.message_str(832, 173))
                        else
                            if Traps == 2 then
                                fallout.display_msg(fallout.message_str(832, 174))
                            else
                                fallout.display_msg(fallout.message_str(832, 175))
                            end
                        end
                    end
                else
                    if Locks == 1 then
                        if Traps == 0 then
                            fallout.display_msg(fallout.message_str(832, 176))
                        else
                            if Traps == 1 then
                                fallout.display_msg(fallout.message_str(832, 177))
                            else
                                if Traps == 2 then
                                    fallout.display_msg(fallout.message_str(832, 178))
                                else
                                    fallout.display_msg(fallout.message_str(832, 179))
                                end
                            end
                        end
                    else
                        if Locks == 2 then
                            if Traps == 0 then
                                fallout.display_msg(fallout.message_str(832, 180))
                            else
                                if Traps == 1 then
                                    fallout.display_msg(fallout.message_str(832, 181))
                                else
                                    if Traps == 2 then
                                        fallout.display_msg(fallout.message_str(832, 182))
                                    else
                                        fallout.display_msg(fallout.message_str(832, 183))
                                    end
                                end
                            end
                        else
                            if Traps == 0 then
                                fallout.display_msg(fallout.message_str(832, 184))
                            else
                                if Traps == 1 then
                                    fallout.display_msg(fallout.message_str(832, 185))
                                else
                                    if Traps == 2 then
                                        fallout.display_msg(fallout.message_str(832, 186))
                                    else
                                        fallout.display_msg(fallout.message_str(832, 187))
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

function Display_Locked()
    if Per == 0 then
        if Locks == 0 then
            fallout.display_msg(fallout.message_str(832, 124))
        else
            if Locks == 1 then
                fallout.display_msg(fallout.message_str(832, 128))
            else
                if Locks == 2 then
                    fallout.display_msg(fallout.message_str(832, 132))
                else
                    fallout.display_msg(fallout.message_str(832, 136))
                end
            end
        end
    else
        if Per == 1 then
            if Locks == 0 then
                fallout.display_msg(fallout.message_str(832, 140))
            else
                if Locks == 1 then
                    fallout.display_msg(fallout.message_str(832, 144))
                else
                    if Locks == 2 then
                        fallout.display_msg(fallout.message_str(832, 148))
                    else
                        fallout.display_msg(fallout.message_str(832, 152))
                    end
                end
            end
        else
            if Per == 2 then
                if Locks == 0 then
                    fallout.display_msg(fallout.message_str(832, 156))
                else
                    if Locks == 1 then
                        fallout.display_msg(fallout.message_str(832, 160))
                    else
                        if Locks == 2 then
                            fallout.display_msg(fallout.message_str(832, 164))
                        else
                            fallout.display_msg(fallout.message_str(832, 168))
                        end
                    end
                end
            else
                if Locks == 0 then
                    fallout.display_msg(fallout.message_str(832, 172))
                else
                    if Locks == 1 then
                        fallout.display_msg(fallout.message_str(832, 176))
                    else
                        if Locks == 2 then
                            fallout.display_msg(fallout.message_str(832, 180))
                        else
                            fallout.display_msg(fallout.message_str(832, 184))
                        end
                    end
                end
            end
        end
    end
end

function Display_Trapped()
    if Per == 0 then
        if Traps == 0 then
            fallout.display_msg(fallout.message_str(832, 188))
        else
            if Traps == 1 then
                fallout.display_msg(fallout.message_str(832, 189))
            else
                if Traps == 2 then
                    fallout.display_msg(fallout.message_str(832, 190))
                else
                    fallout.display_msg(fallout.message_str(832, 191))
                end
            end
        end
    else
        if Per == 1 then
            if Traps == 0 then
                fallout.display_msg(fallout.message_str(832, 192))
            else
                if Traps == 1 then
                    fallout.display_msg(fallout.message_str(832, 193))
                else
                    if Traps == 2 then
                        fallout.display_msg(fallout.message_str(832, 194))
                    else
                        fallout.display_msg(fallout.message_str(832, 195))
                    end
                end
            end
        else
            if Per == 2 then
                if Traps == 0 then
                    fallout.display_msg(fallout.message_str(832, 196))
                else
                    if Traps == 1 then
                        fallout.display_msg(fallout.message_str(832, 197))
                    else
                        if Traps == 2 then
                            fallout.display_msg(fallout.message_str(832, 198))
                        else
                            fallout.display_msg(fallout.message_str(832, 199))
                        end
                    end
                end
            else
                if Traps == 0 then
                    fallout.display_msg(fallout.message_str(832, 200))
                else
                    if Traps == 1 then
                        fallout.display_msg(fallout.message_str(832, 201))
                    else
                        if Traps == 2 then
                            fallout.display_msg(fallout.message_str(832, 202))
                        else
                            fallout.display_msg(fallout.message_str(832, 203))
                        end
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.use_p_proc = use_p_proc
exports.use_skill_on_p_proc = use_skill_on_p_proc
exports.use_obj_on_p_proc = use_obj_on_p_proc
exports.look_at_p_proc = look_at_p_proc
exports.description_p_proc = description_p_proc
exports.damage_p_proc = damage_p_proc
exports.map_enter_p_proc = map_enter_p_proc
exports.map_update_p_proc = map_update_p_proc
return exports
