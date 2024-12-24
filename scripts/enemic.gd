class_name Enemic
extends Control


#static var ref:Enemic
#
#
##Constructor
#func _init() -> void:
	#if not ref:ref=self
	#else:queue_free()
#

signal EnemicAtac
signal EnemicMort

var stats: EnemicsStats = null

@onready var current_health: int = stats.starting_health

@onready var pc_enemic_scene: Enemic = $"."

@onready var progress_bar: ProgressBar = $VBoxContainer2/PanelContainer2/VBoxContainer/ProgressBar
@onready var label_nom: Label = $VBoxContainer2/PanelContainer2/VBoxContainer/LabelNom
@onready var timer: Timer = $Timer
@onready var valor_moral: Label = $VBoxContainer2/PanelContainer2/VBoxContainer/ValorMoral


func load_stats(enemic_stats: EnemicsStats)->void:
	stats = enemic_stats
	

func _ready() -> void:
	print("
/////////////    ENEMIC.GD   /////////////////////////
****   funcio _ready   ******
#	indica valors :
#		progress_bar
#		label_nom
#	es connecta al battle
#		StartBattle
#		RestartBattle
#	es connecta al player_grup
#		PlayerAtac
***********************************
//////////////////////////////////////////////////////
	")
	
	print("max_health: %s"%stats.max_health)
	print("starting_health: %s"%stats.starting_health)
	print("label_nom: %s"%stats.nom)
	
	progress_bar.max_value = stats.max_health
	progress_bar.value = stats.starting_health
	label_nom.text = stats.nom
	get_tree().get_first_node_in_group("battle").connect("StartBattle", start_battle)
	get_tree().get_first_node_in_group("battle").connect("RestartBattle", restart_battle)
	get_tree().get_first_node_in_group("player_grup").connect("PlayerAtac", player_atac)

func start_battle():
	print("
/////////////    ENEMIC.GD   /////////////////////////
****   funcio start_battle   ******
#	rebuda senyal de battle(StartBattle)
#	timer start() del Enemic
***********************************
//////////////////////////////////////////////////////
	")
	timer.start()
	
	
func restart_battle():
	print("
/////////////    ENEMIC.GD   /////////////////////////
****   funcio restart_battle   ******
#	rebuda senyal de battle(RestartBattle)
#	timer start() del Enemic
***********************************
//////////////////////////////////////////////////////
	")
	timer.start()

func _on_timer_timeout() -> void:
	print("
/////////////    ENEMIC.GD   /////////////////////////
****   funcio _on_timer_timeout   ******
#	envia senyal EnemicAtac amb el valor %s
***********************************
//////////////////////////////////////////////////////
	"%stats.atac)
	EnemicAtac.emit(stats.atac)


func player_atac(valor):
	
	var moral_actual = progress_bar.value - valor
	
	print("
/////////////    ENEMIC.GD   /////////////////////////
****   funcio player_atac   ******
#	rebuda senyal de player_grup(PlayerAtac)
#	modifica el valor del progressbar del mob
#	MORAL ACTUAL = %s
#	si arriba a 0:
#		envia senyal EnemicMort
#		elimina el pc_enemic_scene
***********************************
//////////////////////////////////////////////////////
	"%moral_actual)
	
	if moral_actual <= 0:
		moral_actual = 0
		set_moral(moral_actual)
		
		#pc_enemic_scene.queue_free()
		#self.queue_free()
		EnemicMort.emit()
		print("EnemicMort.emit()")
		queue_free()
		print("queue_free()")
	
	set_moral(moral_actual)


func set_moral(valor)->void:
	progress_bar.value = valor
	valor_moral.text = str(valor)
