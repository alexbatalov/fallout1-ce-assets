local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local critter_p_proc
local destroy_p_proc
local look_at_p_proc

local hostile = false
local disguised = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 34)
        fallout.anim(self_obj, 1000, fallout.rotation_to_tile(fallout.tile_num(self_obj), 28113))
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 21 or script_action == 3 then
        look_at_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
    if fallout.obj_can_see_obj(fallout.self_obj(), fallout.dude_obj()) then
        disguised = false
        if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
            if fallout.metarule(16, 0) > 1 then
                disguised = false
            else
                disguised = true
            end
        end
        if not disguised then
            hostile = true
        end
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function look_at_p_proc()
    fallout.script_overrides()
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
exports.look_at_p_proc = look_at_p_proc
return exports
