local fallout = require("fallout")
local reputation = require("lib.reputation")

local start
local pickup_p_proc
local talk_p_proc
local critter_p_proc
local destroy_p_proc
local Francis04
local Francis05
local Francis06
local Francis07_1
local Francis07_2
local Francis08_1
local Francis08_2
local Francis09_1
local Francis09_2
local Francis10_1
local Francis10_2
local Francis11_1
local Francis11_2
local Francis12_1
local Francis12_2
local Francis13
local Francis14
local Francis15_1
local Francis15_2
local Francis15_3
local Francis16
local Francis17_1
local Francis17_2
local Francis18
local Francis19
local Francis20
local Francis21_1
local Francis21_2
local Francis22
local FrancisEnd
local Combat

local hostile = false
local initialized = false

function start()
    if not initialized then
        local self_obj = fallout.self_obj()
        fallout.critter_add_trait(self_obj, 1, 6, 20)
        fallout.critter_add_trait(self_obj, 1, 5, 67)
        initialized = true
    end

    local script_action = fallout.script_action()
    if script_action == 21 or script_action == 3 then
        fallout.script_overrides()
        fallout.display_msg(fallout.message_str(399, 100))
    elseif script_action == 4 then
        pickup_p_proc()
    elseif script_action == 12 then
        critter_p_proc()
    elseif script_action == 18 then
        destroy_p_proc()
    elseif script_action == 11 then
        talk_p_proc()
    end
end

function pickup_p_proc()
    hostile = true
end

function talk_p_proc()
    fallout.script_overrides()
    if fallout.global_var(195) == 1 then
        fallout.float_msg(fallout.self_obj(), fallout.message_str(399, 101), 0)
    else
        if fallout.local_var(0) == 1 then
            fallout.float_msg(fallout.self_obj(), fallout.message_str(399, 102), 0)
        else
            if (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 1)) == 3) or (fallout.obj_item_subtype(fallout.critter_inven_obj(fallout.dude_obj(), 2)) == 3) then
                fallout.float_msg(fallout.self_obj(), fallout.message_str(399, 103), 0)
            else
                if not (fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113) and (reputation.has_rep_berserker() or (fallout.global_var(158) > 2)) then
                    fallout.float_msg(fallout.self_obj(), fallout.message_str(399, 104), 0)
                else
                    fallout.start_gdialog(399, fallout.self_obj(), 4, -1, -1)
                    fallout.gsay_start()
                    if not (fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113) then
                        Francis04()
                    else
                        if fallout.obj_pid(fallout.critter_inven_obj(fallout.dude_obj(), 0)) == 113 then
                            Francis05()
                        else
                            Francis06()
                        end
                    end
                    fallout.gsay_end()
                    fallout.end_dialogue()
                    fallout.set_local_var(0, 1)
                end
            end
        end
    end
end

function critter_p_proc()
    if hostile then
        hostile = false
        fallout.attack(fallout.dude_obj(), 0, 1, 0, 0, 30000, 0, 0)
    end
end

function destroy_p_proc()
    reputation.inc_evil_critter()
end

function Francis04()
    fallout.gsay_reply(399, 105)
    fallout.giq_option(7, 399, 106, Francis07_1, 50)
    fallout.giq_option(7, 399, 107, Francis08_1, 50)
    fallout.giq_option(4, 399, 108, Francis09_1, 50)
    fallout.giq_option(4, 399, 109, Francis10_1, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 399, 110, Francis11_1, 50)
    end
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 399, 111, Francis12_1, 50)
    end
    fallout.giq_option(-3, 399, 112, Francis13, 50)
end

function Francis05()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(399, 113)
    else
        fallout.gsay_reply(399, 114)
    end
    fallout.giq_option(7, 399, 115, Francis14, 50)
    fallout.giq_option(7, 399, 116, Francis15_1, 50)
    fallout.giq_option(4, 399, 117, Francis16, 50)
    fallout.giq_option(4, 399, 118, Francis17_1, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 399, 119, Francis18, 50)
    end
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 399, 120, Francis19, 50)
    end
    fallout.giq_option(-3, 399, 121, Francis20, 50)
end

function Francis06()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_reply(399, 160)
    else
        fallout.gsay_reply(399, 161)
    end
    fallout.giq_option(7, 399, 122, Francis21_1, 50)
    fallout.giq_option(7, 399, 123, Francis15_1, 50)
    fallout.giq_option(4, 399, 124, Francis09_1, 50)
    fallout.giq_option(4, 399, 125, Francis22, 50)
    if fallout.global_var(194) == 1 then
        fallout.giq_option(4, 399, 126, Francis11_1, 50)
    end
    if reputation.has_rep_berserker() then
        fallout.giq_option(4, 399, 127, Francis12_1, 50)
    end
    fallout.giq_option(-3, 399, 128, Francis13, 50)
end

function Francis07_1()
    fallout.gsay_message(399, fallout.message_str(399, 129) .. fallout.message_str(399, 130), 50)
end

function Francis07_2()
end

function Francis08_1()
    fallout.gsay_message(399, fallout.message_str(399, 131) .. fallout.message_str(399, 132), 50)
end

function Francis08_2()
end

function Francis09_1()
    fallout.gsay_message(399, fallout.message_str(399, 133) .. fallout.message_str(399, 134), 50)
end

function Francis09_2()
    fallout.gsay_message(399, fallout.message_str(399, 134), 50)
end

function Francis10_1()
    fallout.gsay_message(399, fallout.message_str(399, 135) .. fallout.message_str(399, 136), 50)
end

function Francis10_2()
end

function Francis11_1()
    fallout.gsay_message(399, fallout.message_str(399, 137) .. fallout.message_str(399, 138), 50)
end

function Francis11_2()
end

function Francis12_1()
    fallout.gsay_message(399, fallout.message_str(399, 139) .. fallout.message_str(399, 140), 50)
end

function Francis12_2()
end

function Francis13()
    fallout.gsay_message(399, fallout.message_str(399, 141), 50)
end

function Francis14()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(399, 142, 50)
    else
        fallout.gsay_message(399, 143, 50)
    end
end

function Francis15_1()
    fallout.gsay_message(399,
        fallout.message_str(399, 144) .. fallout.message_str(399, 145) .. fallout.message_str(399, 146), 50)
end

function Francis15_2()
end

function Francis15_3()
end

function Francis16()
    fallout.gsay_message(399, 147, 50)
end

function Francis17_1()
    fallout.gsay_message(399, fallout.message_str(399, 148) .. fallout.message_str(399, 149), 50)
end

function Francis17_2()
end

function Francis18()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(399, 150, 50)
    else
        fallout.gsay_message(399, 151, 50)
    end
end

function Francis19()
    fallout.gsay_message(399, 152, 50)
end

function Francis20()
    if fallout.get_critter_stat(fallout.dude_obj(), 34) == 0 then
        fallout.gsay_message(399, 153, 50)
    else
        fallout.gsay_message(399, 154, 50)
    end
end

function Francis21_1()
    fallout.gsay_message(399, fallout.message_str(399, 155) .. fallout.message_str(399, 156), 50)
end

function Francis21_2()
end

function Francis22()
    fallout.gsay_message(399, 157, 50)
end

function FrancisEnd()
end

local exports = {}
exports.start = start
exports.pickup_p_proc = pickup_p_proc
exports.talk_p_proc = talk_p_proc
exports.critter_p_proc = critter_p_proc
exports.destroy_p_proc = destroy_p_proc
return exports
