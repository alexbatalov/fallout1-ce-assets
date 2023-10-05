local fallout = require("fallout")

local start
local do_stuff
local ladderend
local ladder01

local damage = 0
local testa = 0
local testb = 0
local open = 0
local dude_tile = 0

function start()
    if fallout.script_action() == 6 then
        fallout.load_map("VaultEnt.map", 1)
    end
end

function do_stuff()
    testa = fallout.do_check(fallout.dude_obj(), 5, 2)
    fallout.script_overrides()
    ladder01()
end

function ladderend()
end

function ladder01()
    if fallout.is_success(testa) then
        fallout.display_msg(fallout.message_str(291, 100))
    else
        if fallout.is_critical(testa) then
            damage = fallout.random(1, 6) + fallout.random(1, 6) + fallout.random(1, 6) - 9
            if damage < 1 then
                fallout.display_msg(fallout.message_str(291, 101))
            else
                fallout.display_msg(fallout.message_str(291, 102) + damage + fallout.message_str(291, 103))
                fallout.critter_dmg(fallout.dude_obj(), damage, 0)
            end
        else
            fallout.display_msg(fallout.message_str(291, 104))
        end
        fallout.move_to(fallout.dude_obj(), fallout.local_var(1), fallout.local_var(2))
    end
end

local exports = {}
exports.start = start
return exports
