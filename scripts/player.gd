class_name Player
extends Control



static var ref:Player

#Constructor
func _init() -> void:
	if not ref:ref=self
	else:queue_free()



signal PlayerAtac
signal PlayerWin

var enemic_signal = preload("res://escenes/enemic_scene.tscn")


@onready var label_nom: Label = $VBoxContainer2/PanelContainer2/VBoxContainer/Nom
@onready var progress_bar: ProgressBar = $VBoxContainer2/PanelContainer2/VBoxContainer/ProgressBar
@onready var valor_moral: Label = $VBoxContainer2/PanelContainer2/VBoxContainer/ValorMoral
@onready var timer: Timer = $Timer


var moral: int = 1000
var atac: int = 2


func _ready() -> void:
	print("
/////////////    PLAYER.GD   /////////////////////////
****   funcio _ready   ******
#	indica valors :
#		progress_bar
#		valor_moral
#	es connecta al battle
#		StartBattle
#		RestartBattle
***********************************
//////////////////////////////////////////////////////
	")
	progress_bar.max_value = moral
	progress_bar.value = moral
	valor_moral.text = str(moral)
	get_tree().get_first_node_in_group("battle").connect("StartBattle", start_battle)
	get_tree().get_first_node_in_group("battle").connect("RestartBattle", restart_battle)


func connect_enemic_signals()->void:
	get_tree().get_first_node_in_group("enemic_grup").connect("EnemicAtac", enemic_atac)
	get_tree().get_first_node_in_group("enemic_grup").connect("EnemicMort", player_win)


func start_battle()->void:
	print("
/////////////    PLAYER.GD   /////////////////////////
****   funcio start_battle   ******
#	rebuda senyal de battle(StartBattle)
#	connectat a enemic_grup:
#		EnemicAtac
#		EnemicMort
#	timer start()
***********************************
//////////////////////////////////////////////////////
	")
	connect_enemic_signals()
	timer.start()

func restart_battle()->void:
	print("
/////////////    PLAYER.GD   /////////////////////////
****   funcio restart_battle   ******
#	rebuda senyal de battle(RestartBattle)
#	timer.start() del PLayer
***********************************
//////////////////////////////////////////////////////
	")
	timer.start()

func _on_timer_timeout() -> void:
	print("
/////////////    PLAYER.GD   /////////////////////////
****   funcio _on_timer_timeout   ******
#	envia senyal PlayerAtac amb el valor %s
***********************************
//////////////////////////////////////////////////////
	"%atac)
	PlayerAtac.emit(atac)

func enemic_atac(valor):
	print("
/////////////    PLAYER.GD   /////////////////////////
****   funcio enemic_atac   ******
#	rebuda senyal de enemic_grup(enemic_atac)
#	modifica valor ProgresBar
#	modifica vlaor Label
***********************************
//////////////////////////////////////////////////////
	")
	progress_bar.value -= valor
	valor_moral.text = str(progress_bar.value)

func player_win():
	print("
/////////////    PLAYER.GD   /////////////////////////
-----------------------------------------------------
-----------		PLAYER WIN !!!!	---------------------
-----------------------------------------------------
****   funcio player_win   ******
#	es para el TIMER del Player
#	envia senyal PlayerWin
***********************************
//////////////////////////////////////////////////////
	")
	timer.stop()
	PlayerWin.emit(random_enemic_lvl())

func random_enemic_lvl():
	var ran = str(randi_range(1,5))
	return ran
