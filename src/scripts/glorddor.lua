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

local CRIT_FAIL <const> = 0
local FAIL <const> = 1
local SUCC <const> = 2
local CRIT_SUCC <const> = 3

local PE_SHIFT <const> = 4
local LP_SHIFT <const> = 2
local TR_SHIFT <const> = 0

local PE_CRIT_FAIL <const> = CRIT_FAIL << PE_SHIFT
local PE_FAIL <const> = FAIL << PE_SHIFT
local PE_SUCC <const> = SUCC << PE_SHIFT
local PE_CRIT_SUCC <const> = CRIT_SUCC << PE_SHIFT

local LP_CRIT_FAIL <const> = CRIT_FAIL << PE_SHIFT
local LP_FAIL <const> = FAIL << PE_SHIFT
local LP_SUCC <const> = SUCC << PE_SHIFT
local LP_CRIT_SUCC <const> = CRIT_SUCC << PE_SHIFT

local TR_CRIT_FAIL <const> = CRIT_FAIL << PE_SHIFT
local TR_FAIL <const> = FAIL << PE_SHIFT
local TR_SUCC <const> = SUCC << PE_SHIFT
local TR_CRIT_SUCC <const> = CRIT_SUCC << PE_SHIFT

local DISPLAY_ARMED_AND_LOCKED_LOOKUP <const> = {
    [PE_CRIT_FAIL | LP_CRIT_FAIL | TR_CRIT_FAIL] = 124,
    [PE_CRIT_FAIL | LP_CRIT_FAIL | TR_FAIL] = 125,
    [PE_CRIT_FAIL | LP_CRIT_FAIL | TR_SUCC] = 126,
    [PE_CRIT_FAIL | LP_CRIT_FAIL | TR_CRIT_SUCC] = 127,

    [PE_CRIT_FAIL | LP_FAIL | TR_CRIT_FAIL] = 128,
    [PE_CRIT_FAIL | LP_FAIL | TR_FAIL] = 129,
    [PE_CRIT_FAIL | LP_FAIL | TR_SUCC] = 130,
    [PE_CRIT_FAIL | LP_FAIL | TR_CRIT_SUCC] = 131,

    [PE_CRIT_FAIL | LP_SUCC | TR_CRIT_FAIL] = 132,
    [PE_CRIT_FAIL | LP_SUCC | TR_FAIL] = 133,
    [PE_CRIT_FAIL | LP_SUCC | TR_SUCC] = 134,
    [PE_CRIT_FAIL | LP_SUCC | TR_CRIT_SUCC] = 135,

    [PE_CRIT_FAIL | LP_CRIT_SUCC | TR_CRIT_FAIL] = 136,
    [PE_CRIT_FAIL | LP_CRIT_SUCC | TR_FAIL] = 137,
    [PE_CRIT_FAIL | LP_CRIT_SUCC | TR_SUCC] = 138,
    [PE_CRIT_FAIL | LP_CRIT_SUCC | TR_CRIT_SUCC] = 139,

    [PE_FAIL | LP_CRIT_FAIL | TR_CRIT_FAIL] = 140,
    [PE_FAIL | LP_CRIT_FAIL | TR_FAIL] = 141,
    [PE_FAIL | LP_CRIT_FAIL | TR_SUCC] = 142,
    [PE_FAIL | LP_CRIT_FAIL | TR_CRIT_SUCC] = 143,

    [PE_FAIL | LP_FAIL | TR_CRIT_FAIL] = 144,
    [PE_FAIL | LP_FAIL | TR_FAIL] = 145,
    [PE_FAIL | LP_FAIL | TR_SUCC] = 146,
    [PE_FAIL | LP_FAIL | TR_CRIT_SUCC] = 147,

    [PE_FAIL | LP_SUCC | TR_CRIT_FAIL] = 148,
    [PE_FAIL | LP_SUCC | TR_FAIL] = 149,
    [PE_FAIL | LP_SUCC | TR_SUCC] = 150,
    [PE_FAIL | LP_SUCC | TR_CRIT_SUCC] = 151,

    [PE_FAIL | LP_CRIT_SUCC | TR_CRIT_FAIL] = 152,
    [PE_FAIL | LP_CRIT_SUCC | TR_FAIL] = 153,
    [PE_FAIL | LP_CRIT_SUCC | TR_SUCC] = 154,
    [PE_FAIL | LP_CRIT_SUCC | TR_CRIT_SUCC] = 155,

    [PE_SUCC | LP_CRIT_FAIL | TR_CRIT_FAIL] = 156,
    [PE_SUCC | LP_CRIT_FAIL | TR_FAIL] = 157,
    [PE_SUCC | LP_CRIT_FAIL | TR_SUCC] = 158,
    [PE_SUCC | LP_CRIT_FAIL | TR_CRIT_SUCC] = 159,

    [PE_SUCC | LP_FAIL | TR_CRIT_FAIL] = 160,
    [PE_SUCC | LP_FAIL | TR_FAIL] = 161,
    [PE_SUCC | LP_FAIL | TR_SUCC] = 162,
    [PE_SUCC | LP_FAIL | TR_CRIT_SUCC] = 163,

    [PE_SUCC | LP_SUCC | TR_CRIT_FAIL] = 164,
    [PE_SUCC | LP_SUCC | TR_FAIL] = 165,
    [PE_SUCC | LP_SUCC | TR_SUCC] = 166,
    [PE_SUCC | LP_SUCC | TR_CRIT_SUCC] = 167,

    [PE_SUCC | LP_CRIT_SUCC | TR_CRIT_FAIL] = 168,
    [PE_SUCC | LP_CRIT_SUCC | TR_FAIL] = 169,
    [PE_SUCC | LP_CRIT_SUCC | TR_SUCC] = 170,
    [PE_SUCC | LP_CRIT_SUCC | TR_CRIT_SUCC] = 171,

    [PE_CRIT_SUCC | LP_CRIT_FAIL | TR_CRIT_FAIL] = 172,
    [PE_CRIT_SUCC | LP_CRIT_FAIL | TR_FAIL] = 173,
    [PE_CRIT_SUCC | LP_CRIT_FAIL | TR_SUCC] = 174,
    [PE_CRIT_SUCC | LP_CRIT_FAIL | TR_CRIT_SUCC] = 175,

    [PE_CRIT_SUCC | LP_FAIL | TR_CRIT_FAIL] = 176,
    [PE_CRIT_SUCC | LP_FAIL | TR_FAIL] = 177,
    [PE_CRIT_SUCC | LP_FAIL | TR_SUCC] = 178,
    [PE_CRIT_SUCC | LP_FAIL | TR_CRIT_SUCC] = 179,

    [PE_CRIT_SUCC | LP_SUCC | TR_CRIT_FAIL] = 180,
    [PE_CRIT_SUCC | LP_SUCC | TR_FAIL] = 181,
    [PE_CRIT_SUCC | LP_SUCC | TR_SUCC] = 182,
    [PE_CRIT_SUCC | LP_SUCC | TR_CRIT_SUCC] = 183,

    [PE_CRIT_SUCC | LP_CRIT_SUCC | TR_CRIT_FAIL] = 184,
    [PE_CRIT_SUCC | LP_CRIT_SUCC | TR_FAIL] = 185,
    [PE_CRIT_SUCC | LP_CRIT_SUCC | TR_SUCC] = 186,
    [PE_CRIT_SUCC | LP_CRIT_SUCC | TR_CRIT_SUCC] = 187,
}

local DISPLAY_LOCKED_LOOKUP <const> = {
    [PE_CRIT_FAIL | LP_CRIT_FAIL] = 124,
    [PE_CRIT_FAIL | LP_FAIL] = 128,
    [PE_CRIT_FAIL | LP_SUCC] = 132,
    [PE_CRIT_FAIL | LP_CRIT_SUCC] = 136,

    [PE_FAIL | LP_CRIT_FAIL] = 140,
    [PE_FAIL | LP_FAIL] = 144,
    [PE_FAIL | LP_SUCC] = 148,
    [PE_FAIL | LP_CRIT_SUCC] = 152,

    [PE_SUCC | LP_CRIT_FAIL] = 156,
    [PE_SUCC | LP_FAIL] = 160,
    [PE_SUCC | LP_SUCC] = 164,
    [PE_SUCC | LP_CRIT_SUCC] = 168,

    [PE_CRIT_SUCC | LP_CRIT_FAIL] = 172,
    [PE_CRIT_SUCC | LP_FAIL] = 176,
    [PE_CRIT_SUCC | LP_SUCC] = 180,
    [PE_CRIT_SUCC | LP_CRIT_SUCC] = 184,
}

local DISPLAY_TRAPPED_LOOKUP <const> = {
    [PE_CRIT_FAIL | TR_CRIT_FAIL] = 188,
    [PE_CRIT_FAIL | TR_FAIL] = 189,
    [PE_CRIT_FAIL | TR_SUCC] = 190,
    [PE_CRIT_FAIL | TR_CRIT_SUCC] = 191,

    [PE_FAIL | TR_CRIT_FAIL] = 192,
    [PE_FAIL | TR_FAIL] = 193,
    [PE_FAIL | TR_SUCC] = 194,
    [PE_FAIL | TR_CRIT_SUCC] = 195,

    [PE_SUCC | TR_CRIT_FAIL] = 196,
    [PE_SUCC | TR_FAIL] = 197,
    [PE_SUCC | TR_SUCC] = 198,
    [PE_SUCC | TR_CRIT_SUCC] = 199,

    [PE_CRIT_SUCC | TR_CRIT_FAIL] = 200,
    [PE_CRIT_SUCC | TR_FAIL] = 201,
    [PE_CRIT_SUCC | TR_SUCC] = 202,
    [PE_CRIT_SUCC | TR_CRIT_SUCC] = 203,
}

local Locks = CRIT_FAIL
local Traps = CRIT_FAIL
local Per = CRIT_FAIL

function start()
    local script_action = fallout.script_action()
    if script_action == 6 then
        use_p_proc()
    elseif script_action == 15 then
        map_enter_p_proc()
    elseif script_action == 23 then
        map_update_p_proc()
    elseif script_action == 7 then
        use_obj_on_p_proc()
    elseif script_action == 21 then
        look_at_p_proc()
    elseif script_action == 3 then
        description_p_proc()
    elseif script_action == 8 then
        use_skill_on_p_proc()
    elseif script_action == 14 then
        damage_p_proc()
    end
end

function use_p_proc()
    local roll = fallout.roll_vs_skill(fallout.source_obj(), 11, -20)
    if fallout.global_var(224) == 0 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(305, 205))
    else
        if fallout.local_var(2) == 0 then
            if fallout.is_success(roll) then
                fallout.script_overrides()
                fallout.display_msg(fallout.message_str(305, 204))
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
                fallout.display_msg(fallout.message_str(305, 105))
            end
        end
    end
end

function use_skill_on_p_proc()
    if fallout.local_var(2) == 0 and fallout.obj_is_locked(fallout.self_obj()) then
        Trapped_And_Locked()
    elseif fallout.local_var(2) == 0 then
        Trapped_Door()
    elseif fallout.obj_is_locked(fallout.self_obj()) then
        Locked_Door()
    end
end

function use_obj_on_p_proc()
    local item_obj = fallout.obj_being_used_with()
    local item_pid = fallout.obj_pid(item_obj)
    if item_pid == 77 then
        fallout.script_overrides()
        if fallout.local_var(2) == 0 then
            local roll = fallout.roll_vs_skill(fallout.source_obj(), 11, -20)
            if fallout.is_success(roll) then
                fallout.display_msg(fallout.message_str(305, 204))
                fallout.reg_anim_func(2, fallout.source_obj())
            else
                fallout.set_local_var(0, fallout.local_var(0) + 1)
                Damage_Dude()
            end
        end
        if fallout.obj_is_locked(fallout.self_obj()) then
            local roll = fallout.roll_vs_skill(fallout.source_obj(), 9, -10)
            if fallout.is_success(roll) then
                fallout.obj_unlock(fallout.self_obj())
                fallout.set_local_var(3, 1)
                fallout.display_msg(fallout.message_str(305, 109))
                fallout.display_msg(fallout.message_str(766, 103) .. "45" .. fallout.message_str(766, 104))
                fallout.give_exp_points(45)
            else
                if fallout.is_critical(roll) then
                    fallout.display_msg(fallout.message_str(305, 121))
                    fallout.jam_lock(fallout.self_obj())
                    fallout.display_msg(fallout.message_str(305, 110))
                    fallout.rm_obj_from_inven(fallout.source_obj(), item_obj)
                    fallout.destroy_object(item_obj)
                else
                    fallout.display_msg(fallout.message_str(305, 122))
                end
            end
        end
    elseif item_pid == 96 then
        fallout.script_overrides()
        fallout.set_local_var(2, 1)
        fallout.obj_unlock(fallout.self_obj())
        fallout.set_local_var(3, 1)
        fallout.display_msg(fallout.message_str(305, 106))
    end
end

function look_at_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(305, 123))
end

function description_p_proc()
    fallout.script_overrides()
    if fallout.local_var(3) == 0 and fallout.local_var(2) == 0 then
        Skill_Checks()
        Display_Armed_And_Locked()
    elseif fallout.local_var(2) == 0 then
        Skill_Checks()
        Display_Trapped()
    elseif fallout.local_var(3) == 0 then
        Locks_Check()
        Display_Locked()
    else
        fallout.display_msg(fallout.message_str(305, 123))
    end
end

function damage_p_proc()
    if fallout.local_var(1) > 3 then
        fallout.set_local_var(2, 1)
        fallout.set_obj_visibility(fallout.self_obj(), true)
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
    local skill = fallout.action_being_used()
    if skill == 11 then
        fallout.script_overrides()
        local trap_roll = fallout.roll_vs_skill(fallout.source_obj(), 11, -20)
        if fallout.is_success(trap_roll) then
            fallout.display_msg(fallout.message_str(305, 113))
            fallout.set_local_var(2, 1)
            fallout.display_msg(fallout.message_str(766, 103) .. "45" .. fallout.message_str(766, 104))
            fallout.give_exp_points(45)
        else
            if fallout.is_critical(trap_roll) then
                fallout.display_msg(fallout.message_str(305, 114))
                fallout.jam_lock(fallout.self_obj())
                fallout.display_msg(fallout.message_str(305, 110))
                if fallout.local_var(0) == 0 then
                    fallout.set_local_var(0, 4)
                else
                    fallout.set_local_var(0, fallout.local_var(0) + 4)
                end
                Damage_Dude()
            else
                fallout.set_local_var(0, fallout.local_var(0) + 1)
                fallout.display_msg(fallout.message_str(305, 115))
                Damage_Dude()
            end
        end
    elseif skill == 9 then
        fallout.script_overrides()
        local lockpick_roll = fallout.roll_vs_skill(fallout.source_obj(), 9, -30)
        local trap_roll = fallout.roll_vs_skill(fallout.source_obj(), 11, -20)
        if fallout.is_success(trap_roll) then
            if fallout.is_success(lockpick_roll) then
                fallout.obj_unlock(fallout.self_obj())
                fallout.set_local_var(3, 1)
                fallout.display_msg(fallout.message_str(305, 116))
                fallout.display_msg(fallout.message_str(766, 103) .. "55" .. fallout.message_str(766, 104))
                fallout.give_exp_points(55)
            else
                if fallout.is_critical(lockpick_roll) then
                    fallout.jam_lock(fallout.self_obj())
                    fallout.display_msg(fallout.message_str(305, 110))
                    fallout.set_local_var(0, fallout.local_var(0) + 2)
                    fallout.display_msg(fallout.message_str(305, 117))
                    Damage_Dude()
                else
                    fallout.set_local_var(0, fallout.local_var(0) + 1)
                    fallout.display_msg(fallout.message_str(305, 118))
                    Damage_Dude()
                end
            end
        else
            if fallout.is_critical(trap_roll) then
                fallout.display_msg(fallout.message_str(305, 120))
                if fallout.local_var(0) == 0 then
                    fallout.set_local_var(0, 4)
                else
                    fallout.set_local_var(0, fallout.local_var(0) + 4)
                end
                Damage_Dude()
            else
                fallout.set_local_var(0, fallout.local_var(0) + 1)
                fallout.display_msg(fallout.message_str(305, 119))
                Damage_Dude()
            end
        end
    end
end

function Locked_Door()
    if fallout.action_being_used() == 9 then
        fallout.script_overrides()
        local roll = fallout.roll_vs_skill(fallout.source_obj(), 9, -30)
        if fallout.is_success(roll) then
            fallout.obj_unlock(fallout.self_obj())
            fallout.set_local_var(3, 1)
            fallout.display_msg(fallout.message_str(305, 116))
            fallout.display_msg(fallout.message_str(766, 103) .. "55" .. fallout.message_str(766, 104))
            fallout.give_exp_points(55)
        else
            if fallout.is_critical(roll) then
                fallout.jam_lock(fallout.self_obj())
                fallout.display_msg(fallout.message_str(305, 110))
                fallout.display_msg(fallout.message_str(305, 121))
                fallout.game_time_advance(fallout.game_ticks(600))
            else
                fallout.display_msg(fallout.message_str(305, 122))
            end
        end
    end
end

function Trapped_Door()
    if fallout.action_being_used() == 11 then
        fallout.script_overrides()
        local roll = fallout.roll_vs_skill(fallout.source_obj(), 11, -20)
        if fallout.is_success(roll) then
            fallout.display_msg(fallout.message_str(305, 113))
            fallout.set_local_var(2, 1)
            fallout.display_msg(fallout.message_str(766, 103) .. "45" .. fallout.message_str(766, 104))
            fallout.give_exp_points(45)
        else
            if fallout.is_critical(roll) then
                fallout.display_msg(fallout.message_str(305, 114))
                if fallout.local_var(0) == 0 then
                    fallout.set_local_var(0, 4)
                else
                    fallout.set_local_var(0, fallout.local_var(0) + 4)
                end
                Damage_Dude()
            else
                fallout.set_local_var(0, fallout.local_var(0) + 1)
                fallout.display_msg(fallout.message_str(305, 115))
                Damage_Dude()
            end
        end
    end
end

function Damage_Dude()
    fallout.critter_dmg(fallout.source_obj(), fallout.local_var(0), 4 | 256)
    if fallout.local_var(0) == 1 then
        fallout.display_msg(fallout.message_str(305, 101))
    else
        fallout.display_msg(fallout.message_str(305, 102) .. fallout.local_var(0) .. fallout.message_str(305, 103))
    end
end

function Skill_Checks()
    local traps_roll = fallout.roll_vs_skill(fallout.source_obj(), 11, 0)
    local lockpick_roll = fallout.roll_vs_skill(fallout.source_obj(), 9, -10)
    local perception_roll = fallout.do_check(fallout.source_obj(), 1, 0)
    if fallout.is_success(traps_roll) then
        if fallout.is_critical(traps_roll) then
            Locks_Check()
            Traps = CRIT_SUCC
        else
            Locks_Check()
            Traps = SUCC
        end
    else
        if fallout.is_critical(traps_roll) then
            Locks_Check()
            Traps = CRIT_FAIL
        else
            Locks_Check()
            Traps = FAIL
        end
    end
end

function Stat_Checks()
    local perception_roll = fallout.do_check(fallout.source_obj(), 1, 0)
    if fallout.is_success(perception_roll) then
        if fallout.is_critical(perception_roll) then
            Per = CRIT_SUCC
        else
            Per = SUCC
        end
    else
        if fallout.is_critical(perception_roll) then
            Per = CRIT_FAIL
        else
            Per = FAIL
        end
    end
end

function Locks_Check()
    local lockpick_roll = fallout.roll_vs_skill(fallout.source_obj(), 9, -10)
    local perception_roll = fallout.do_check(fallout.source_obj(), 1, 0)
    if fallout.is_success(lockpick_roll) then
        if fallout.is_critical(lockpick_roll) then
            Stat_Checks()
            Locks = CRIT_SUCC
        else
            Stat_Checks()
            Locks = SUCC
        end
    else
        if fallout.is_critical(lockpick_roll) then
            Stat_Checks()
            Locks = CRIT_FAIL
        else
            Stat_Checks()
            Locks = FAIL
        end
    end
end

function Display_Armed_And_Locked()
    local index = (Per << PE_SHIFT) | (Locks << LP_SHIFT) | (Traps << TR_SHIFT)
    fallout.display_msg(fallout.message_str(305, DISPLAY_ARMED_AND_LOCKED_LOOKUP[index]))
end

function Display_Locked()
    local index = (Per << PE_SHIFT) | (Locks << LP_SHIFT)
    fallout.display_msg(fallout.message_str(305, DISPLAY_LOCKED_LOOKUP[index]))
end

function Display_Trapped()
    local index = (Per << PE_SHIFT) | (Traps << TR_SHIFT)
    fallout.display_msg(fallout.message_str(305, DISPLAY_TRAPPED_LOOKUP[index]))
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
