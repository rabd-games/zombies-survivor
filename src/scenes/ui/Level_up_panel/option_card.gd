extends ColorRect

var mouse_over = false
@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var stat= select_random_stat()
@onready var amount

signal selected_stat(stat)

func _ready():
	connect("selected_stat", Callable(player, "upgrade_character"))
	amount = randi_range(1, 10)
	$BoxContainer/Option_name.text = stat + ": " + str(amount)
	
func _input(event):
	if event.is_action("click"):
		if mouse_over:
			emit_signal("selected_stat", stat, amount)

func select_random_stat():
	var stats_list = player.available_stats.keys()
	var random_stat = stats_list[randi() % player.available_stats.size()]
	player.available_stats.erase(random_stat)
	return random_stat

func _on_mouse_entered():
	mouse_over = true

func _on_mouse_exited():
	mouse_over = false
