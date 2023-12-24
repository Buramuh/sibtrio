extends ItemContainerScene

func hit():
	if not opened:
		$LidSprite.hide()
		open.emit($SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position, current_direction)
		opened = true
