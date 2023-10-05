local fallout = require("fallout")

local start
local description_p_proc
local use_p_proc

function start()
    if fallout.script_action() == 3 then
        description_p_proc()
    else
        if fallout.script_action() == 6 then
            use_p_proc()
        end
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(545, 100))
end

function use_p_proc()
    fallout.set_external_var("field_change", "toggle")
    if fallout.cur_map_index() == 31 then
        if fallout.elevation(fallout.self_obj()) == 0 then
            if fallout.tile_num(fallout.self_obj()) == 16308 then
                fallout.use_obj(fallout.map_var(0))
            else
                if fallout.tile_num(fallout.self_obj()) == 16280 then
                    fallout.use_obj(fallout.map_var(1))
                else
                    if fallout.tile_num(fallout.self_obj()) == 25912 then
                        fallout.use_obj(fallout.map_var(2))
                    else
                        if fallout.tile_num(fallout.self_obj()) == 25878 then
                            fallout.use_obj(fallout.map_var(7))
                        else
                            if fallout.tile_num(fallout.self_obj()) == 21664 then
                                fallout.use_obj(fallout.map_var(8))
                            end
                        end
                    end
                end
            end
        else
            if fallout.elevation(fallout.self_obj()) == 1 then
                if fallout.tile_num(fallout.self_obj()) == 15502 then
                    fallout.use_obj(fallout.map_var(10))
                else
                    if fallout.tile_num(fallout.self_obj()) == 26706 then
                        fallout.use_obj(fallout.map_var(11))
                    end
                end
            end
        end
    else
        if fallout.cur_map_index() == 32 then
            if fallout.elevation(fallout.self_obj()) == 0 then
                if fallout.tile_num(fallout.self_obj()) == 17120 then
                    fallout.use_obj(fallout.map_var(0))
                else
                    if fallout.tile_num(fallout.self_obj()) == 24326 then
                        fallout.use_obj(fallout.map_var(1))
                    end
                end
            end
        end
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
return exports
