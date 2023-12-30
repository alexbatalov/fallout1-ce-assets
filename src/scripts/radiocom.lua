local fallout = require("fallout")

local start
local description_p_proc
local use_p_proc

local initialized = false

function start()
    if not initialized then
        fallout.set_external_var("radio_computer", fallout.self_obj())
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 3 then
        description_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    end
end

function description_p_proc()
    local msg = fallout.message_str(607, 100)
    local dude_obj = fallout.dude_obj()
    if fallout.is_success(fallout.do_check(dude_obj, 1, fallout.has_trait(0, dude_obj, 0))) then
        if fallout.global_var(608) ~= 0 then
            msg = msg .. fallout.message_str(607, 101)
        else
            msg = msg .. fallout.message_str(607, 102)
        end
    end
    fallout.display_msg(msg)
end

function use_p_proc()
    local dude_obj = fallout.dude_obj()
    if fallout.source_obj() == dude_obj then
        if fallout.is_success(fallout.roll_vs_skill(dude_obj, 12, 0)) then
            if fallout.global_var(608) ~= 0 then
                fallout.display_msg(fallout.message_str(607, 103))
                fallout.set_global_var(608, 0)
            else
                fallout.display_msg(fallout.message_str(607, 104))
                fallout.set_global_var(608, 1)
            end
        else
            fallout.display_msg(fallout.message_str(607, 105))
        end
    else
        fallout.set_global_var(608, 1)
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
return exports
