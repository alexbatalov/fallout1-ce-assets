local fallout = require("fallout")

local start
local farli0
local farli1
local farli2
local farli3
local farli4

local Herebefore = 0

function start()
    if (fallout.script_action() == 21) or (fallout.script_action() == 3) then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(315, 100))
    else
        if fallout.script_action() == 18 then
            if fallout.source_obj() == fallout.dude_obj() then
                if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
                    fallout.set_global_var(156, 1)
                    fallout.set_global_var(157, 0)
                end
                if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
                    fallout.set_global_var(157, 1)
                    fallout.set_global_var(156, 0)
                end
                fallout.set_global_var(159, fallout.global_var(159) + 1)
                if (fallout.global_var(159) % 2) == 0 then
                    fallout.set_global_var(155, fallout.global_var(155) - 1)
                end
            end
        else
            if fallout.script_action() == 11 then
                fallout.script_overrides()
                if Herebefore > 1 then
                    farli4()
                else
                    if Herebefore == 1 then
                        Herebefore = Herebefore + 1
                        farli3()
                    else
                        Herebefore = Herebefore + 1
                        fallout.start_gdialog(315, fallout.self_obj(), 4, -1, -1)
                        fallout.gsay_start()
                        farli0()
                        fallout.gsay_end()
                        fallout.end_dialogue()
                    end
                end
            end
        end
    end
end

function farli0()
    fallout.gsay_reply(315, 101)
    fallout.giq_option(3, 315, 102, farli1, 50)
end

function farli1()
    fallout.gsay_reply(315, 103)
    fallout.giq_option(3, 315, fallout.message_str(315, 104) .. fallout.proto_data(fallout.obj_pid(fallout.dude_obj()), 1) .. fallout.message_str(315, 105), farli2, 50)
end

function farli2()
    local v0 = 0
    fallout.gsay_message(315, 106, 50)
    v0 = fallout.create_object_sid(95, 0, 0, -1)
    fallout.add_obj_to_inven(fallout.dude_obj(), v0)
end

function farli3()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(315, 107), 0)
end

function farli4()
    fallout.float_msg(fallout.self_obj(), fallout.message_str(315, 108), 0)
end

local exports = {}
exports.start = start
return exports
