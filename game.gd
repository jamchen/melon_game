extends Node

@export var shake_threshold: float = 10.0  # 設定搖晃的靈敏度
@export var shake_force: float = 500.0  # 施加的搖晃力量
var last_accel := Vector3.ZERO

func _process(delta):
	var accel = Input.get_accelerometer()  # 讀取手機加速度
	var delta_accel = accel - last_accel  # 計算加速度變化量
	last_accel = accel
	
	# 若變化量超過閾值，觸發搖晃
	if delta_accel.length() > shake_threshold:
		shake_fruits()

func shake_fruits():
	print("手機搖晃偵測到，搖晃水果！")
	
	# 找到所有水果並施加隨機力
	for fruit in get_tree().get_nodes_in_group("fruits"):
		if fruit is RigidBody2D:
			var random_force = Vector2(randf_range(-shake_force, shake_force), randf_range(-shake_force, shake_force))
			fruit.apply_impulse(random_force)
