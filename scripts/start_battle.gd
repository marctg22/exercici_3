class_name BattleManager
extends PanelContainer

static var ref:BattleManager


#Constructor
func _init() -> void:
	if not ref:ref=self
	else:queue_free()



signal StartBattle
signal RestartBattle

@export var h_box_container: HBoxContainer
@export var enemic_scene: PackedScene
@onready var button: Button = $HBoxContainer/Button



func _ready() -> void:
	get_tree().get_first_node_in_group("player_grup").connect("PlayerWin", respawn_enemic)


#	click button per començar la batalla
#	direcciona a la funció pel spawn de l'enemic
#	oculta el button
func _on_button_pressed() -> void:
	print("
/////////////    START_BATTLE.GD   /////////////////////////
****   funcio _on_button_pressed   ******
#	click button per començar la batalla
#	direcciona a la funció pel spawn de l'enemic
#	oculta el button
***********************************
//////////////////////////////////////////////////////
	")
	spawn_enemic(random_enemic_lvl())
	button.visible = false

#	funció per obtenir numero rando
func random_enemic_lvl():
	var ran = str(randi_range(1,5))
	return ran

#	spawn enemic
#	carguem el resource amb elnumero rando
#	instanciem l'escena de l'enemic
#	carguem els stats del resource
#	afegim l'escena al arbre
#	cridem la funció start_battle
func spawn_enemic(enemic_lvl: String)->void:
	print("
/////////////    START_BATTLE.GD   /////////////////////////
****   funcio spawn_enemic   ******
#	spawn enemic
#	carguem el resource amb elnumero rando
#	instanciem l'escena de l'enemic
#	carguem els stats del resource
#	afegim l'escena al arbre
#	cridem la funció start_battle
***********************************
//////////////////////////////////////////////////////
	")
	var stats:= load("res://resources/enemics/areas/area_1/enemic_%s.tres" % enemic_lvl) as EnemicsStats
	var enemic := enemic_scene.instantiate() as Enemic
	enemic.load_stats(stats)
	h_box_container.add_child(enemic)
	start_battle()
 

#	envia senyal StartBattle
func start_battle()->void:
	print("
/////////////    START_BATTLE.GD   /////////////////////////
****   funcio start_battle   ******
#	envia senyal StartBattle
***********************************
//////////////////////////////////////////////////////
	")
	StartBattle.emit()



func respawn_enemic(enemic_lvl: String)->void:
	print("
/////////////    START_BATTLE.GD   /////////////////////////
****   funcio respawn_enemic   ******
#	rebuda senyal de player_grup(PlayerWin)
#	carga resource del enemic nou
#	carga els stats
#	instancia enemic al HBC
#	crida la funcio restart_battle
***********************************
//////////////////////////////////////////////////////
	")
	var stats:= load("res://resources/enemics/areas/area_1/enemic_%s.tres" % enemic_lvl) as EnemicsStats
	var enemic := enemic_scene.instantiate() as Enemic
	enemic.load_stats(stats)
	h_box_container.add_child(enemic)
	restart_battle()

func restart_battle()->void:
	print("
/////////////    START_BATTLE.GD   /////////////////////////
****   funcio restart_battle   ******
#	envia senyal RestartBattle
***********************************
//////////////////////////////////////////////////////
	")
	RestartBattle.emit()
