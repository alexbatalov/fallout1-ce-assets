local fallout = require("fallout")

local start
local do_stuff
local ladderend
local ladder00
local ladder01
local ladder01a

local testa = 0
local testb = 0
local bonus = 0
local damage = 0
local manhole_open = 0

function start()
    if fallout.script_action() == 6 then
        fallout.script_overrides()
        do_stuff()
    end
end

function do_stuff()
    manhole_open = fallout.map_var(fallout.local_var(0))
    if manhole_open then
        ladder00()
    else
        ladder01()
    end
end

function ladderend()
end

function ladder00()
    fallout.move_to(fallout.dude_obj(), fallout.local_var(1), fallout.local_var(2))
end

function ladder01()
    bonus = 1 - fallout.local_var(0)
    testa = fallout.do_check(fallout.dude_obj(), 0, bonus)
    ladder01a()
end

function ladder01a()
    if fallout.is_success(testa) then
        fallout.set_local_var(0, 0)
        fallout.display_msg(fallout.message_str(20, 100))
        ladder00()
    else
        fallout.set_local_var(0, fallout.local_var(0) + 1)
        if fallout.is_critical(testa) then
            fallout.display_msg(fallout.message_str(20, 101))
            damage = fallout.random(1, 6) - 4
            if damage < 1 then
                damage = 1
            end
            fallout.critter_dmg(fallout.dude_obj(), damage, 0)
        else
            fallout.display_msg(fallout.message_str(20, 102))
            testb = fallout.do_check(fallout.dude_obj(), 5, 0)
            if fallout.is_success(testb) then
                fallout.display_msg(fallout.message_str(20, 103))
            else
                fallout.display_msg(fallout.message_str(20, 104))
            end
        end
    end
end

local exports = {}
exports.start = start
return exports
