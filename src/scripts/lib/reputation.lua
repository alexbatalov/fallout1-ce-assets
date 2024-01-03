local fallout = require("fallout")

local function has_rep_berserker()
    local bad_monster = fallout.global_var(160)
    local good_monster = fallout.global_var(159)
    return bad_monster + good_monster >= 25 and (good_monster > 2 * bad_monster or fallout.global_var(156) == 1)
end

local function has_rep_champion()
    local bad_monster = fallout.global_var(160)
    local good_monster = fallout.global_var(159)
    return bad_monster + good_monster >= 25 and (bad_monster > 3 * good_monster or fallout.global_var(157) == 1)
end

local function inc_good_critter()
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
end

local function inc_evil_critter()
    if fallout.source_obj() == fallout.dude_obj() then
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(159) > (2 * fallout.global_var(160))) or (fallout.global_var(156) == 1)) then
            fallout.set_global_var(156, 1)
            fallout.set_global_var(157, 0)
        end
        if ((fallout.global_var(160) + fallout.global_var(159)) >= 25) and ((fallout.global_var(160) > (3 * fallout.global_var(159))) or (fallout.global_var(157) == 1)) then
            fallout.set_global_var(157, 1)
            fallout.set_global_var(156, 0)
        end
        fallout.set_global_var(160, fallout.global_var(160) + 1)
        if (fallout.global_var(160) % 6) == 0 then
            fallout.set_global_var(155, fallout.global_var(155) + 1)
        end
    end
end

local exports = {}
exports.has_rep_berserker = has_rep_berserker
exports.has_rep_champion = has_rep_champion
exports.inc_good_critter = inc_good_critter
exports.inc_evil_critter = inc_evil_critter
return exports
