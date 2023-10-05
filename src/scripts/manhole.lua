local fallout = require("fallout")

local start
local do_stuff
local manholeend
local manhole00

local OPEN = 0

function start()
    if fallout.script_action() == 6 then
        fallout.script_overrides()
        do_stuff()
    end
end

function do_stuff()
    OPEN = fallout.map_var(fallout.local_var(0))
    if OPEN then
        manhole00()
    end
end

function manholeend()
end

function manhole00()
    fallout.move_to(fallout.dude_obj(), fallout.local_var(1), fallout.local_var(2))
end

local exports = {}
exports.start = start
return exports
