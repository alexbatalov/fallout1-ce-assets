local fallout = require("fallout")

local TIME_MORNING_HOUR <const> = 600
local TIME_DAY_HOUR <const> = 700
local TIME_EVENING_HOUR <const> = 1800
local TIME_NIGHT_HOUR <const> = 1900

local TICKS_PER_SECOND <const> = 10
local TICKS_PER_MINUTE <const> = TICKS_PER_SECOND * 60
local TICKS_PER_HOUR <const> = TICKS_PER_MINUTE * 60
local TICKS_PER_DAY <const> = TICKS_PER_HOUR * 24
local TICKS_PER_YEAR <const> = TICKS_PER_DAY * 365

local function is_morning()
    local game_time_hour = fallout.game_time_hour()
    return game_time_hour >= TIME_MORNING_HOUR and game_time_hour < TIME_DAY_HOUR
end

local function is_day()
    local game_time_hour = fallout.game_time_hour()
    return game_time_hour >= TIME_DAY_HOUR and game_time_hour < TIME_EVENING_HOUR
end

local function is_evening()
    local game_time_hour = fallout.game_time_hour()
    return game_time_hour >= TIME_EVENING_HOUR and game_time_hour < TIME_NIGHT_HOUR
end

local function is_night()
    local game_time_hour = fallout.game_time_hour()
    return game_time_hour >= TIME_NIGHT_HOUR or game_time_hour < TIME_MORNING_HOUR
end

local function game_time_in_years()
    return fallout.game_time() // TICKS_PER_YEAR
end

local function game_time_in_days()
    return fallout.game_time() // TICKS_PER_DAY
end

local function game_time_in_hours()
    return fallout.game_time() // TICKS_PER_HOUR
end

local function game_time_in_seconds()
    return fallout.game_time() // TICKS_PER_SECOND
end

local exports = {}
exports.is_morning = is_morning
exports.is_day = is_day
exports.is_evening = is_evening
exports.is_night = is_night
exports.game_time_in_years = game_time_in_years
exports.game_time_in_days = game_time_in_days
exports.game_time_in_hours = game_time_in_hours
exports.game_time_in_seconds = game_time_in_seconds
return exports
