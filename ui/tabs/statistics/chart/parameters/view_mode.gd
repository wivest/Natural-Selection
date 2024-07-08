extends OptionButton

func _ready():
	var popup: PopupMenu = get_popup()
	print(popup.position, popup.size)
	popup.position = Vector2i(100, 100)

func _on_pressed():
	var popup: PopupMenu = get_popup()
	popup.position.y = int(global_position.y) - popup.size.y
