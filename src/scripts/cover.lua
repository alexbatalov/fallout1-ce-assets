local fallout = require("fallout")

local start
local do_stuff
local coverend
local cover00
local cover01
local cover01a

local damage = 0
local testa = 0
local bonus = 0
local dude_tile = 0
local OPEN = 0

function start()
    local v0 = 0
    if fallout.script_action() == 6 then
        fallout.script_overrides()
        do_stuff()
    end
end

function do_stuff()
    OPEN = fallout.map_var(fallout.local_var(0))
    if OPEN == 1 then
        cover00()
    else
        cover01()
    end
end

function coverend()
end

function cover00()
    fallout.set_map_var(fallout.local_var(0), 0)
    fallout.display_msg(fallout.message_str(18, 100))
    dude_tile = fallout.tile_num(fallout.dude_obj())
end

function cover01()
    bonus = 3 - fallout.local_var(0)
    testa = fallout.do_check(fallout.dude_obj(), 0, bonus)
    cover01a()
end

function cover01a()
    if fallout.is_success(testa) then
        fallout.set_local_var(0, 0)
        fallout.set_map_var(fallout.local_var(0), 1)
        fallout.display_msg(fallout.message_str(18, 101))
    else
        fallout.set_local_var(0, fallout.local_var(0) + 1)
        if fallout.is_critical(testa) then
            fallout.display_msg(fallout.message_str(18, 102))
            damage = fallout.random(1, 6) - 4
            if damage < 1 then
                damage = 1
            end
            fallout.critter_dmg(fallout.dude_obj(), damage, 0)
        else
            fallout.display_msg(fallout.message_str(18, 103))
        end
    end
end

local exports = {}
exports.start = start
return exports
