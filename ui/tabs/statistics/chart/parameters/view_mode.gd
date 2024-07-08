extends OptionButton

func _on_pressed():
	var popup: PopupMenu = get_popup()
	popup.position.y = int(global_position.y) - popup.size.y
