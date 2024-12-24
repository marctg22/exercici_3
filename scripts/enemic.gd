class_name Enemic
extends Control


signal EnemicAtac
signal EnemicMort

var stats: EnemicsStats = null

@onready var current_health: int = stats.starting_health


@onready var progress_bar: ProgressBar = $VBoxContainer2/PanelContainer2/VBoxContainer/ProgressBar
@onready var label_nom: Label = $VBoxContainer2/PanelContainer2/VBoxContainer/LabelNom
@onready var timer: Timer = $Timer
@onready var valor_moral: Label = $VBoxContainer2/PanelContainer2/VBoxContainer/ValorMoral


func load_stats(enemic_stats: EnemicsStats)->void:
	stats = enemic_stats
	

func _ready() -> void:
	progress_bar.max_value = stats.max_health
	progress_bar.value = stats.starting_health
	label_nom.text = stats.nom
	get_tree().get_first_node_in_group("battle").connect("StartBattle", start_battle)
	get_tree().get_first_node_in_group("player_grup").connect("PlayerAtac", player_atac)

func start_battle():
	print("l'enemic ataca")
	timer.start()

func _on_timer_timeout() -> void:
	#print(stats.atac)
	EnemicAtac.emit(stats.atac)


func player_atac(valor):
	#print(valor)
	var moral_actual = progress_bar.value - valor
	
	if moral_actual <= 0:
		progress_bar.value = 0
		valor_moral.text = "0"
		EnemicMort.emit()
		#timer.stop()
		queue_free()
		return
	
	progress_bar.value = moral_actual
	valor_moral.text = str(moral_actual)
