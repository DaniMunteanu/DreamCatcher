class_name Player

extends CharacterBody2D

var speed_multiplier = 30.0

@onready var animation_player = $PlayerAnimationManager/PlayerAnimation
@onready var hurt_animation_player = $PlayerAnimationManager/HurtAnimationPlayer
@onready var sprite = $PlayerAnimationManager/PlayerModel
@onready var portal1 = $Portal1
@onready var portal2 = $Portal2
@onready var canvas_layer = $PlayerCamera/CanvasLayer
@onready var pause_menu = $PlayerCamera/CanvasLayer/PauseMenu
@onready var status_bar = $PlayerCamera/CanvasLayer/StatusBar 
@onready var jump_marker = $JumpMarker
@onready var evade_timer = $EvadeTimer
@onready var player_health = $PlayerHealth

@export var evadeReady = true
var jump_speed = 200.0

const SHOP = preload("res://ui_elements/Shop.tscn")
@onready var opened_shop = SHOP.instantiate()

const PAUSE_MENU = preload("res://ui_elements/PauseMenu.tscn")

const BOSS_HP_BAR = preload("res://ui_elements/BossHealthBar.tscn")
var boss_hp_bar_instance

enum player_states {MOVE, JUMP, FIRE, SHOP, CUTSCENE, DEAD}
var current_state = player_states.MOVE

enum player_direction {LEFT, RIGHT, UP, DOWN}
@export var current_player_direction = player_direction.RIGHT

var jumping_direction = Vector2.ZERO
var jumping_target_position = Vector2.ZERO

var jumping_distance = 96.0

var player_save_file_path = "user://PlayerSaveData.tres"

func reset_stats_and_resources():
	Global.player_damage = 5
	Global.player_defense = 5
	Global.player_fire_rate = 5
	Global.player_luck = 5
	Global.player_shot_speed = 5
	Global.player_speed = 5
	
	Global.player_coins = 0
	Global.player_feathers = 0
	Global.player_quartz = 0
	
	status_bar.refresh()
	
func save_player_data():
	var player_data = PlayerSaveData.new()
	player_data.player_damage = Global.player_damage
	player_data.player_defense = Global.player_defense
	player_data.player_fire_rate = Global.player_fire_rate
	player_data.player_luck = Global.player_luck
	player_data.player_shot_speed = Global.player_shot_speed
	player_data.player_speed = Global.player_speed
	
	player_data.player_coins = Global.player_coins
	player_data.player_feathers = Global.player_feathers
	player_data.player_quartz = Global.player_quartz
	
	player_data.evade_cooldown_left = evade_timer.time_left
	
	player_data.current_health = player_health.current_health
	
	ResourceSaver.save(player_data, player_save_file_path)
	
func load_player_data():
	var player_data = ResourceLoader.load(player_save_file_path) as PlayerSaveData
	
	Global.player_damage = player_data.player_damage
	Global.player_defense = player_data.player_defense
	Global.player_fire_rate = player_data.player_fire_rate 
	Global.player_luck = player_data.player_luck
	Global.player_shot_speed = player_data.player_shot_speed
	Global.player_speed = player_data.player_speed
	
	Global.player_coins = player_data.player_coins
	Global.player_feathers = player_data.player_feathers
	Global.player_quartz = player_data.player_quartz
	
	#Reset jump cooldown if jump was not ready before saving
	if evadeReady == false:
		jump_marker.visible = false
		evade_timer.start(player_data.evade_cooldown_left)
		status_bar.get_node("StaminaBar").start_point = 5 - player_data.evade_cooldown_left
		
	player_health.current_health = player_data.current_health
	
	#Refresh status bar
	status_bar.refresh()

func _ready() -> void:
	
	Global.open_shop.connect(_on_open_shop)
	Global.close_shop.connect(_on_close_shop)
	Global.boss_summoned.connect(_on_boss_summoned)
	Global.boss_defeated.connect(_on_boss_defeated)
	opened_shop.character = self
	portal1.fire_timer = (2.0 - (0.2 * Global.player_fire_rate)) / 2.0 
	portal2.fire_timer = 0.0
	
func _on_boss_summoned():
	var boss = get_parent().placed_rooms[0].boss_instance
	boss_hp_bar_instance = BOSS_HP_BAR.instantiate()
	boss_hp_bar_instance.boss_health = boss.get_node("Health")
	canvas_layer.add_child(boss_hp_bar_instance)
	
func _on_boss_defeated():
	boss_hp_bar_instance.queue_free()
	
func _on_open_shop():
	canvas_layer.add_child(opened_shop)
	opened_shop.update()
	current_state = player_states.SHOP
	
func _on_close_shop():
	canvas_layer.remove_child(opened_shop)
	current_state = player_states.MOVE
	
func _on_evade_timer_timeout() -> void:
	evadeReady = true
	jump_marker.visible = true
	status_bar.get_node("StaminaBar").start_point = 0.0
	evade_timer.wait_time = 5

func update_movement():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = direction.normalized()
	velocity = direction * (speed_multiplier * Global.player_speed)
	move_and_slide()
	Global.player_current_position = global_position
	
func update_sprite():
	if Input.is_action_pressed("evade") and evadeReady:
		jumping_target_position = global_position.move_toward(get_global_mouse_position(), jumping_distance)
		jumping_direction = global_position.direction_to(jumping_target_position).normalized()
	
		set_collision_layer_value(2,false)
		evadeReady = false
		evade_timer.start()
		current_state = player_states.JUMP
		
	if Input.is_action_pressed("fire"):
		current_state = player_states.FIRE
	
	if velocity.length() > 0.0:
		var walking_angle = rad_to_deg(velocity.angle())
		if walking_angle < 0:
			walking_angle += 360
		match floor(walking_angle/45.0):
			5.0, 6.0:
				animation_player.play("PlayerWalkingUp")
				current_player_direction = player_direction.UP
			3.0, 4.0:
				animation_player.play("PlayerWalkingLeft")
				current_player_direction = player_direction.LEFT
			1.0, 2.0:
				animation_player.play("PlayerWalkingDown")
				current_player_direction = player_direction.DOWN
			0.0, 7.0:
				animation_player.play("PlayerWalkingRight")
				current_player_direction = player_direction.RIGHT
	else:
		match current_player_direction:
			player_direction.UP:
				animation_player.play("PlayerIdleUp")
			player_direction.LEFT:
				animation_player.play("PlayerIdleLeft")
			player_direction.DOWN:
				animation_player.play("PlayerIdleDown")
			player_direction.RIGHT:
				animation_player.play("PlayerIdleRight")

func jump(delta):
	jump_marker.visible = false
	animation_player.play("PlayerJumpingRight")
	if global_position.distance_to(jumping_target_position) > 3:
		velocity = global_position.direction_to(jumping_target_position) * jump_speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	
func fire(delta):
	if Input.is_action_pressed("evade") :
		jumping_target_position = global_position.move_toward(get_global_mouse_position(), jumping_distance)
		jumping_direction = global_position.direction_to(jumping_target_position).normalized()
		
		set_collision_layer_value(2,false)
		evadeReady = false
		evade_timer.start()
		current_state = player_states.JUMP
	
	portal1.fire(delta)
	portal2.fire(delta)
	
	var firing_angle = rad_to_deg(global_position.angle_to_point(get_global_mouse_position()))
	if firing_angle < 0.0:
		firing_angle += 360.0
	Global.cursor_angle = firing_angle
		
	match floor(Global.cursor_angle/45.0):
		5.0, 6.0:
			portal1.animation_player.play("ShootUp")
			portal2.animation_player.play("ShootUp")
			animation_player.play("PlayerFiringUp")
		3.0, 4.0:
			portal1.animation_player.play("Portal1ShootLeft")
			portal2.animation_player.play("Portal2ShootLeft")
			animation_player.play("PlayerFiringLeft")
		1.0, 2.0:
			portal1.animation_player.play("ShootDown")
			portal2.animation_player.play("ShootDown")
			animation_player.play("PlayerFiringDown")
		0.0, 7.0:
			portal1.animation_player.play("Portal1ShootRight")
			portal2.animation_player.play("Portal2ShootRight")
			animation_player.play("PlayerFiringRight")
			
	if Input.is_action_just_released("fire"):
		portal1.fire_timer = (2.0 - (0.2 * Global.player_fire_rate)) / 2.0 
		portal2.fire_timer = 0.0
		on_states_reset()
		
func on_states_reset():
	set_collision_layer_value(2,true)
	current_state = player_states.MOVE
	
func set_to_cutscene():
	current_state = player_states.CUTSCENE
	
func set_to_dead():
	current_state = player_states.DEAD

func _physics_process(delta):
	match current_state:
		player_states.MOVE:
			pause_menu.can_open_menu = true
			update_movement()
			update_sprite()
			get_node("JumpMarkerAnimation").play("JumpReady")
		player_states.JUMP: 
			pause_menu.can_open_menu = true
			jump(delta)
		player_states.FIRE:
			pause_menu.can_open_menu = true
			update_movement()
			fire(delta)
			get_node("JumpMarkerAnimation").play("JumpReady")
		player_states.SHOP:
			pause_menu.can_open_menu = false
		player_states.CUTSCENE:
			pause_menu.can_open_menu = false
			jump_marker.visible = false
			animation_player.play("PlayerIdleUp")
		player_states.DEAD:
			pause_menu.can_open_menu = false
			jump_marker.visible = false
			animation_player.play("PlayerDead")
			hurt_animation_player.play("RESET")
