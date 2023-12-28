--- @meta fallout

--- @alias Object lightuserdata

local fallout = {}

--- @param identifier string
function fallout.create_external_var(identifier) end

--- @param identifier string
--- @return number | string | Object | nil
function fallout.external_var(identifier) end

--- @param identifier string
--- @param value number | string | Object | nil
function fallout.set_external_var(identifier, value) end

--- @param xp integer
function fallout.give_exp_points(xp) end

--- @param value integer
function fallout.scr_return(value) end

--- @param name string
function fallout.play_sfx(name) end

--- @param obj Object
function fallout.obj_name(obj) end

--- @param obj Object
--- @param action integer
--- @return string
--- @nodiscard
function fallout.sfx_build_open_name(obj, action) end

--- @param stat integer
--- @return integer
--- @nodiscard
function fallout.get_pc_stat(stat) end

--- @param tile integer
--- @param elevation integer
--- @param pid integer
--- @return Object
--- @nodiscard
function fallout.tile_contains_pid_obj(tile, elevation, pid) end

--- @param x integer
--- @param y integer
--- @param elevation integer
--- @param rotation integer
function fallout.set_map_start(x, y, elevation, rotation) end

--- @param x integer
--- @param y integer
--- @param elevation integer
--- @param rotation integer
function fallout.override_map_start(x, y, elevation, rotation) end

--- @param obj Object
--- @param skill integer
--- @return integer
--- @nodiscard
function fallout.has_skill(obj, skill) end

--- @param obj Object
--- @param skill integer
--- @return boolean
--- @nodiscard
function fallout.using_skill(obj, skill) end

--- @param obj Object
--- @param skill integer
--- @param modifier integer
--- @return integer
--- @nodiscard
function fallout.roll_vs_skill(obj, skill, modifier) end

--- @param obj Object
--- @param stat integer
--- @param modifier integer
--- @return integer
--- @nodiscard
function fallout.do_check(obj, stat, modifier) end

--- @param roll integer
--- @return boolean
--- @nodiscard
function fallout.is_success(roll) end

--- @param roll integer
--- @return boolean
--- @nodiscard
function fallout.is_critical(roll) end

--- @return integer
--- @nodiscard
function fallout.how_much() end

--- @param min integer
--- @param max integer
--- @return integer
--- @nodiscard
function fallout.random(min, max) end

--- @param obj Object
--- @param tile integer
--- @param elevation integer
--- @return integer
function fallout.move_to(obj, tile, elevation) end

--- @param pid integer
--- @param tile integer
--- @param elevation integer
--- @param sid integer
--- @return Object
function fallout.create_object_sid(pid, tile, elevation, sid) end

--- @param msg string
function fallout.display_msg(msg) end

function fallout.script_overrides() end

--- @param obj Object
--- @param pid integer
--- @return integer
--- @nodiscard
function fallout.obj_is_carrying_obj_pid(obj, pid) end

--- @param tile integer
--- @param elevation integer
--- @param pid integer
--- @return boolean
--- @nodiscard
function fallout.tile_contains_obj_pid(tile, elevation, pid) end

--- @return Object
--- @nodiscard
function fallout.self_obj() end

--- @return Object
--- @nodiscard
function fallout.source_obj() end

--- @return Object
--- @nodiscard
function fallout.target_obj() end

--- @return Object
--- @nodiscard
function fallout.dude_obj() end

--- @return Object
--- @nodiscard
function fallout.obj_being_used_with() end

--- @param idx integer
--- @return number
--- @nodiscard
function fallout.local_var(idx) end

--- @param idx integer
--- @param value number
function fallout.set_local_var(idx, value) end

--- @param idx integer
--- @return number
--- @nodiscard
function fallout.map_var(idx) end

--- @param idx integer
--- @param value number
function fallout.set_map_var(idx, value) end

--- @param idx integer
--- @return integer
--- @nodiscard
function fallout.global_var(idx) end

--- @param idx integer
--- @param value integer
function fallout.set_global_var(idx, value) end

--- @return integer
--- @nodiscard
function fallout.script_action() end

--- @param obj Object
--- @return integer
--- @nodiscard
function fallout.obj_type(obj) end

--- @param obj Object
--- @return integer
--- @nodiscard
function fallout.obj_item_subtype(obj) end

--- @param obj Object
--- @param stat integer
--- @return integer
--- @nodiscard
function fallout.get_critter_stat(obj, stat) end

--- @param obj Object
--- @param stat integer
--- @param value integer
--- @return boolean
function fallout.set_critter_stat(obj, stat, value) end

--- @param obj Object
function fallout.animate_stand_obj(obj) end

--- @param obj Object
function fallout.animate_stand_reverse_obj(obj) end

--- @param obj Object
--- @param tile integer
--- @param flags integer
function fallout.animate_move_obj_to_tile(obj, tile, flags) end

--- @param target Object
--- @param a2 integer
--- @param a3 integer
--- @param to_hit_bonus integer
--- @param min_damage integer
--- @param max_damage integer
--- @param attacker_flags integer
--- @param defender_flags integer
function fallout.attack(target, a2, a3, to_hit_bonus, min_damage, max_damage, attacker_flags, defender_flags) end

--- @param tile1 integer
--- @param tile2 integer
--- @return integer
--- @nodiscard
function fallout.tile_distance(tile1, tile2) end

--- @param obj1 Object
--- @param obj2 Object
--- @return integer
--- @nodiscard
function fallout.tile_distance_objs(obj1, obj2) end

--- @param obj Object
--- @return integer
--- @nodiscard
function fallout.tile_num(obj) end

--- @param tile integer
--- @param rotation integer
--- @param distance integer
--- @return integer
--- @nodiscard
function fallout.tile_num_in_direction(tile, rotation, distance) end

--- @param obj Object
function fallout.pickup_obj(obj) end

--- @param obj Object
function fallout.drop_obj(obj) end

--- @param owner Object
--- @param item Object
function fallout.add_obj_to_inven(owner, item) end

--- @param owner Object
--- @param item Object
function fallout.rm_obj_from_inven(owner, item) end

--- @param owner Object
--- @param item Object
function fallout.wield_obj_critter(owner, item) end

--- @param obj Object
function fallout.use_obj(obj) end

--- @param obj1 Object
--- @param obj2 Object
--- @return boolean
--- @nodiscard
function fallout.obj_can_see_obj(obj1, obj2) end

--- @param script_idx integer
--- @param obj Object
--- @param mood integer
--- @param head integer
--- @param background integer
function fallout.start_gdialog(script_idx, obj, mood, head, background) end

function fallout.end_dialogue() end

--- @param mood integer
function fallout.dialogue_reaction(mood) end

--- @param obj Object
--- @param invisible boolean
function fallout.set_obj_visibility(obj, invisible) end

--- @param map string | integer
--- @param param integer
function fallout.load_map(map, param) end

--- @return integer
--- @nodiscard
function fallout.anim_busy() end

--- @param obj Object
--- @param amount integer
--- @return integer
function fallout.critter_heal(obj, amount) end

--- @param intensity integer
function fallout.set_light_level(intensity) end

--- @return integer
--- @nodiscard
function fallout.game_time() end

--- @return integer
--- @nodiscard
function fallout.game_time_in_seconds() end

--- @param obj Object
--- @return integer
--- @nodiscard
function fallout.elevation(obj) end

--- @param obj Object
--- @param frame integer
function fallout.kill_critter(obj, frame) end

--- @param pid integer
--- @param frame integer
function fallout.kill_critter_type(pid, frame) end

--- @param obj Object
--- @param delay integer
--- @param param integer
function fallout.add_timer_event(obj, delay, param) end

--- @param obj Object
function fallout.rm_timer_event(obj) end

--- @param seconds integer
--- @return integer
--- @nodiscard
function fallout.game_ticks(seconds) end

--- @param type integer
--- @param obj Object
--- @param param integer
--- @return integer
--- @nodiscard
function fallout.has_trait(type, obj, param) end

--- @param obj Object
function fallout.destroy_object(obj) end

--- @param obj1 Object
--- @param obj2 Object
--- @return boolean
--- @nodiscard
function fallout.obj_can_hear_obj(obj1, obj2) end

--- @return integer
--- @nodiscard
function fallout.game_time_hour() end

--- @return integer
--- @nodiscard
function fallout.fixed_param() end

--- @param tile integer
--- @return boolean
--- @nodiscard
function fallout.tile_is_visible(tile) end

function fallout.dialogue_system_enter() end

--- @return integer
--- @nodiscard
function fallout.action_being_used() end

--- @param obj Object
--- @return integer
--- @nodiscard
function fallout.critter_state(obj) end

--- @param ticks integer
function fallout.game_time_advance(ticks) end

--- @param obj Object
--- @param amount integer
function fallout.radiation_inc(obj, amount) end

--- @param obj Object
--- @param amount integer
function fallout.radiation_dec(obj, amount) end

--- @param obj Object
--- @param tile integer
--- @param elevation integer
--- @return integer
function fallout.critter_attempt_placement(obj, tile, elevation) end

--- @param obj Object
--- @return integer
--- @nodiscard
function fallout.obj_pid(obj) end

--- @return integer
--- @nodiscard
function fallout.cur_map_index() end

--- @param obj Object
--- @param trait integer
--- @param param1 integer
--- @param param2 integer
--- @return integer
function fallout.critter_add_trait(obj, trait, param1, param2) end

--- @param obj Object
--- @param trait integer
--- @param param1 integer
--- @param param2 integer
--- @return integer
function fallout.critter_rm_trait(obj, trait, param1, param2) end

--- @param pid integer
--- @param member integer
--- @return integer | string
--- @nodiscard
function fallout.proto_data(pid, member) end

--- @param list_idx integer
--- @param idx integer
--- @return string
--- @nodiscard
function fallout.message_str(list_idx, idx) end

--- @param obj Object
--- @param type integer
--- @return integer | Object | nil
--- @nodiscard
function fallout.critter_inven_obj(obj, type) end

--- @param obj Object
--- @param intensity integer
--- @param distance integer
function fallout.obj_set_light_level(obj, intensity, distance) end

function fallout.world_map() end

function fallout.town_map() end

--- @param obj Object
--- @param msg string
--- @param color integer
function fallout.float_msg(obj, msg, color) end

--- @param rule integer
--- @param param integer
--- @return integer
function fallout.metarule(rule, param) end

--- @param obj Object
--- @param anim integer
--- @param frame integer
function fallout.anim(obj, anim, frame) end

--- @param obj Object
--- @param pid integer
--- @return Object | nil
--- @nodiscard
function fallout.obj_carrying_pid_obj(obj, pid) end

--- @param cmd integer
--- @param param integer | Object
function fallout.reg_anim_func(cmd, param) end

--- @param obj Object
--- @param anim integer
--- @param delay integer
function fallout.reg_anim_animate(obj, anim, delay) end

--- @param obj Object
--- @param anim integer
--- @param delay integer
function fallout.reg_anim_animate_reverse(obj, anim, delay) end

--- @param obj Object
--- @param target_obj Object
--- @param delay integer
function fallout.reg_anim_obj_move_to_obj(obj, target_obj, delay) end

--- @param obj Object
--- @param target_obj Object
--- @param delay integer
function fallout.reg_anim_obj_run_to_obj(obj, target_obj, delay) end

--- @param obj Object
--- @param target_tile integer
--- @param delay integer
function fallout.reg_anim_obj_move_to_tile(obj, target_tile, delay) end

--- @param obj Object
--- @param target_tile integer
--- @param delay integer
function fallout.reg_anim_obj_run_to_tile(obj, target_tile, delay) end

--- @param movie integer
function fallout.play_gmovie(movie) end

--- @param owner Object
--- @param item Object
--- @param qty integer
function fallout.add_mult_objs_to_inven(owner, item, qty) end

--- @param owner Object
--- @param item Object
--- @param qty integer
--- @return integer
function fallout.rm_mult_objs_from_inven(owner, item, qty) end

--- @return integer
--- @nodiscard
function fallout.get_month() end

--- @return integer
--- @nodiscard
function fallout.get_day() end

--- @param tile integer
--- @param elevation integer
--- @param damage integer
function fallout.explosion(tile, elevation, damage) end

--- @return integer
--- @nodiscard
function fallout.days_since_visited() end

function fallout.gsay_start() end

function fallout.gsay_end() end

--- @param message_list_idx integer
--- @param message_idx_or_msg integer | string
function fallout.gsay_reply(message_list_idx, message_idx_or_msg) end

--- @param message_list_idx integer
--- @param message_idx_or_msg integer | string
--- @param callback function
--- @param reaction integer
function fallout.gsay_option(message_list_idx, message_idx_or_msg, callback, reaction) end

--- @param message_list_idx integer
--- @param message_idx_or_msg integer | string
--- @param reaction integer
function fallout.gsay_message(message_list_idx, message_idx_or_msg, reaction) end

--- @param iq integer
--- @param message_list_idx integer
--- @param message_idx_or_msg integer | string
--- @param callback function
--- @param reaction integer
function fallout.giq_option(iq, message_list_idx, message_idx_or_msg, callback, reaction) end

--- @param obj Object
--- @param amount integer
function fallout.poison(obj, amount) end

--- @param obj Object
--- @return integer
--- @nodiscard
function fallout.get_poison(obj) end

--- @param obj Object
function fallout.party_add(obj) end

--- @param obj Object
function fallout.party_remove(obj) end

--- @param obj Object
--- @param anim integer
function fallout.reg_anim_animate_forever(obj, anim) end

--- @param obj Object
--- @param flags integer
function fallout.critter_injure(obj, flags) end

--- @return boolean
--- @nodiscard
function fallout.combat_is_initialized() end

--- @param modifier integer
function fallout.gdialog_barter(modifier) end

--- @return integer
--- @nodiscard
function fallout.difficulty_level() end

--- @return integer
--- @nodiscard
function fallout.running_burning_guy() end

function fallout.inven_unwield() end

--- @param obj Object
--- @return boolean
--- @nodiscard
function fallout.obj_is_locked(obj) end

--- @param obj Object
function fallout.obj_lock(obj) end

--- @param obj Object
function fallout.obj_unlock(obj) end

--- @param obj Object
function fallout.obj_open(obj) end

--- @param obj Object
--- @return boolean
--- @nodiscard
function fallout.obj_is_open(obj) end

--- @param obj Object
function fallout.obj_close(obj) end

function fallout.game_ui_disable() end

function fallout.game_ui_enable() end

--- @return boolean
--- @nodiscard
function fallout.game_ui_is_disabled() end

--- @param a1 integer
function fallout.gfade_out(a1) end

--- @param a2 integer
function fallout.gfade_in(a2) end

--- @param obj Object
--- @return integer
--- @nodiscard
function fallout.item_caps_total(obj) end

--- @param obj Object
--- @param amount integer
--- @return integer
function fallout.item_caps_adjust(obj, amount) end

--- @param obj Object
--- @param anim integer
--- @return integer
--- @nodiscard
function fallout.anim_action_frame(obj, anim) end

--- @param obj Object
--- @param sound string
--- @param delay integer
function fallout.reg_anim_play_sfx(obj, sound, delay) end

--- @param obj Object
--- @param skill integer
--- @param points integer
function fallout.critter_mod_skill(obj, skill, points) end

--- @param obj Object
--- @param anim integer
--- @param extra integer
--- @return string
--- @nodiscard
function fallout.sfx_build_char_name(obj, anim, extra) end

--- @param base string
--- @return string
--- @nodiscard
function fallout.sfx_build_ambient_name(base) end

--- @param base string
--- @return string
--- @nodiscard
function fallout.sfx_build_interface_name(base) end

--- @param base string
--- @return string
--- @nodiscard
function fallout.sfx_build_item_name(base) end

--- @param type integer
--- @param weapon_obj Object
--- @param hit integer
--- @param target_obj Object | nil
--- @return string
--- @nodiscard
function fallout.sfx_build_weapon_name(type, weapon_obj, hit, target_obj) end

--- @param base string
--- @param action integer
--- @param type integer
--- @return string
--- @nodiscard
function fallout.sfx_build_scenery_name(base, action, type) end

--- @param attacker Object
--- @param defender Object
function fallout.attack_setup(attacker, defender) end

--- @param obj Object
--- @param quantity integer
function fallout.destroy_mult_objs(obj, quantity) end

--- @param item Object
--- @param target Object
function fallout.use_obj_on_obj(item, target) end

function fallout.endgame_slideshow() end

--- @param obj1 Object
--- @param obj2 Object
function fallout.move_obj_inven_to_obj(obj1, obj2) end

function fallout.endgame_movie() end

--- @param obj Object
--- @return integer
--- @nodiscard
function fallout.obj_art_fid(obj) end

--- @param fid integer
--- @return integer
--- @nodiscard
function fallout.art_anim(fid) end

--- @param pid integer
--- @return Object | nil
--- @nodiscard
function fallout.party_member_obj(pid) end

--- @param tile1 integer
--- @param tile2 integer
--- @return integer
--- @nodiscard
function fallout.rotation_to_tile(tile1, tile2) end

--- @param obj Object
function fallout.jam_lock(obj) end

--- @param modifier integer
function fallout.gdialog_set_barter_mod(modifier) end

--- @return integer
--- @nodiscard
function fallout.combat_difficulty() end

--- @param obj Object
--- @return boolean
--- @nodiscard
function fallout.obj_on_screen(obj) end

--- @param obj Object
--- @return boolean
--- @nodiscard
function fallout.critter_is_fleeing(obj) end

--- @param obj Object
--- @param fleeing boolean
function fallout.critter_set_flee_state(obj, fleeing) end

function fallout.terminate_combat() end

--- @param msg string
function fallout.debug_msg(msg) end

--- @param obj Object
function fallout.critter_stop_attacking(obj) end

return fallout
