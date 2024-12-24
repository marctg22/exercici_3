class_name Player
extends Control


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
	progress_bar.max_value = moral
	progress_bar.value = moral
	valor_moral.text = str(moral)
	get_tree().get_first_node_in_group("battle").connect("StartBattle", start_battle)


func start_battle()->void:
	print("player ataca")
	get_tree().get_first_node_in_group("enemic_grup").connect("EnemicAtac", enemic_atac)
	get_tree().get_first_node_in_group("enemic_grup").connect("EnemicMort", player_win)
	timer.start()


func _on_timer_timeout() -> void:
	print(atac)
	PlayerAtac.emit(atac)

func enemic_atac(valor):
	progress_bar.value -= valor
	valor_moral.text = str(progress_bar.value)

func player_win():
	timer.stop()
	PlayerWin.emit()
