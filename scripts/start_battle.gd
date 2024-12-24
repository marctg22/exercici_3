extends PanelContainer



signal StartBattle

@export var h_box_container: HBoxContainer
@export var enemic_scene: PackedScene
@onready var button: Button = $HBoxContainer/Button

func _ready() -> void:
	get_tree().get_first_node_in_group("player_grup").connect("PlayerWin", _on_button_pressed)


func _on_button_pressed() -> void:
	spaw_enemic(random_enemic_lvl())
	
	#if button:
	button.visible = false


func random_enemic_lvl():
	var ran = str(randi_range(1,5))
	return ran


func spaw_enemic(enemic_lvl: String)->void:
	var stats:= load("res://resources/enemics/areas/area_1/enemic_%s.tres" % enemic_lvl) as EnemicsStats
	var enemic := enemic_scene.instantiate() as Enemic
	enemic.load_stats(stats)
	h_box_container.add_child(enemic)
	start_battle()
 
func start_battle()->void:
	StartBattle.emit()
