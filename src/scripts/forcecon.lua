local fallout = require("fallout")

local start
local description_p_proc
local use_p_proc

function start()
    local script_action = fallout.script_action()
    if script_action == 3 then
        description_p_proc()
    elseif script_action == 6 then
        use_p_proc()
    end
end

function description_p_proc()
    fallout.script_overrides()
    fallout.display_msg(fallout.message_str(545, 100))
end

function use_p_proc()
    fallout.set_external_var("field_change", "toggle")

    local self_obj = fallout.self_obj()
    local self_tile_num = fallout.tile_num(self_obj)
    local self_elevation = fallout.elevation(self_obj)
    local cur_map_index = fallout.cur_map_index()
    if cur_map_index == 31 then
        if self_elevation == 0 then
            if self_tile_num == 16308 then
                fallout.use_obj(fallout.map_var(0))
            elseif self_tile_num == 16280 then
                fallout.use_obj(fallout.map_var(1))
            elseif self_tile_num == 25912 then
                fallout.use_obj(fallout.map_var(2))
            elseif self_tile_num == 25878 then
                fallout.use_obj(fallout.map_var(7))
            elseif self_tile_num == 21664 then
                fallout.use_obj(fallout.map_var(8))
            end
        elseif self_elevation == 1 then
            if self_tile_num == 15502 then
                fallout.use_obj(fallout.map_var(10))
            elseif self_tile_num == 26706 then
                fallout.use_obj(fallout.map_var(11))
            end
        end
    elseif cur_map_index == 32 then
        if self_elevation == 0 then
            if self_tile_num == 17120 then
                fallout.use_obj(fallout.map_var(0))
            elseif self_tile_num == 24326 then
                fallout.use_obj(fallout.map_var(1))
            end
        end
    end
end

local exports = {}
exports.start = start
exports.description_p_proc = description_p_proc
exports.use_p_proc = use_p_proc
return exports
