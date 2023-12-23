local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local critter_p_proc
local description_p_proc
local destroy_p_proc
local pickup_p_proc

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 34)
        fallout.critter_add_trait(self_obj, 1, 5, 48)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 12 then
        critter_p_proc()
    elseif script_action == 3 then
        description_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 4 then
        pickup_p_proc()
    end
end

function critter_p_proc()
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        if fallout.global_var(146) ~= 0 then
            hostile = true
        else
            if not (fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113) then
                hostile = true
            end
        end
    end
    -- FIXME: Missing hostility behaviour (`fallout.attack`)?
end

function description_p_proc()
    fallout.display_msg(fallout.message_str(370, 100))
end

function destroy_p_proc()
    fallout.set_external_var("Team9_Count", fallout.external_var("Team9_Count") - 1)
    reputation.inc_evil_critter()
end

function pickup_p_proc()
    hostile = true
end

local exports = {}
exports.start = start
exports.critter_p_proc = critter_p_proc
exports.description_p_proc = description_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.pickup_p_proc = pickup_p_proc
return exports
