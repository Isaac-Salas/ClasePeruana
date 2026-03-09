extends CharacterBody2D
class_name Player

@export var SPEED : float = 300.0
@export var JUMP_VELOCITY : float = -300.0
@export var gravity_divider : float = 1.0
signal moving(direction : float)
signal stop
var direction : float :
	set(value):
		if value != direction:
			direction = value
			if direction != 0.0:
				moving.emit(direction)
			else:
				stop.emit()
				

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D


func _ready() -> void:

	moving.connect(_on_moving)
	stop.connect(_on_stop)

func _physics_process(delta : float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity()/gravity_divider * delta

	# Handle jump.
	if Input.is_action_just_pressed("salto"):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("izquierda", "derecha")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


func _on_moving(dir: float) -> void:
	sprite_2d.play("Walk")
	if dir > 0.0:
		sprite_2d.flip_h = false
	else:
		sprite_2d.flip_h = true


func _on_stop() -> void:
	sprite_2d.play("Idle")

func prueba():
	print("Esto es una prueba")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Piso:
		print("Esta cosa es una CLASE = piso")
	
	if body.is_in_group("Piso"):
		print("Esta cosa es un piso")
	elif body.is_in_group("Pinchos"):
		print("Esta cosa es un pinchp")
