local fallout = require("fallout")

local function signal_end_game()
    fallout.metarule(13, 0)
end

local function map_first_run()
    return fallout.metarule(14, 0) ~= 0
end

local function party_member_count()
    return fallout.metarule(16, 0)
end

local function is_loading_game()
    return fallout.metarule(22, 0) ~= 0
end

local exports = {}
exports.signal_end_game = signal_end_game
exports.map_first_run = map_first_run
exports.party_member_count = party_member_count
exports.is_loading_game = is_loading_game
return exports
