extends CanvasLayer

signal next_generation
signal randomize_matrix
signal clear_matrix
signal zoom_value_changed

func _ready():
	emit_signal("zoom_value_changed", $ZoomLabel/ZoomSlider.value)
	

func update_counter(counter):
	$GenerationCounter.text = str(counter)


func _on_NextGenButton_pressed():
	emit_signal("next_generation")


func _on_PopulateRandom_pressed():
	emit_signal("randomize_matrix")


func _on_ClearButton_pressed():
	emit_signal("clear_matrix")


func _on_HSlider_value_changed(value):
	emit_signal("zoom_value_changed", value)
