@tool
extends EditorInspectorPlugin

const NodeSelectorProperty = preload("./NodeSelectorProperty.gd")

var node_selector: NodeSelectorProperty

# Properties
var anim_player: AnimationPlayer

# Options
var replace = false

# Signals
signal animation_updated(animation_player)

func _can_handle(object):
	if object is AnimationPlayer:
		anim_player = object
		
		return true
	return false

func _parse_end(object):
	var headerstyle = StyleBoxFlat.new()
	headerstyle.bg_color = Color8(64, 69, 83)
	
	var header = Label.new()
	header.add_theme_stylebox_override("custom_styles/normal", headerstyle)
	header.offset_top = 10
	header.set_custom_minimum_size(Vector2(0, 25))
	header.text = "Import AnimatedSprite"
	header.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
	header.set_vertical_alignment(VERTICAL_ALIGNMENT_CENTER)
	
	add_custom_control(header)

	node_selector = NodeSelectorProperty.new(anim_player)
	node_selector.label = "AnimatedSprite Node"
	
	node_selector.connect(
		"animation_updated", 
		_on_animation_updated,
		CONNECT_DEFERRED)
	
	add_custom_control(node_selector)
	
	var replace_option := ReplaceEditorProp.new()
	replace_option.label = "Replace"
	
	var replace_check := CheckBox.new()
	replace_check.toggle_mode = replace
	node_selector.replace = replace
	replace_check.connect("toggled", _on_replace_set)
	replace_check.connect("toggled", node_selector.set_override)
	replace_option.add_child(replace_check)
	
	
	add_custom_control(replace_option)
	
	var button := Button.new()
	button.text = "Import"
	button.set_custom_minimum_size(Vector2(0, 26))
	button.connect("button_down", node_selector.convert_sprites)
	
	var buttonstyle = StyleBoxFlat.new()
	buttonstyle.bg_color = Color8(32, 37, 49)
	button.add_theme_stylebox_override("custom_styles/normal", buttonstyle)
	add_custom_control(button)


func _on_replace_set(_replace):
	replace = _replace
	
	
func _on_animation_updated():
	emit_signal("animation_updated", anim_player)

class ReplaceEditorProp extends EditorProperty:
	func get_tooltip_text():
		return "If true, replace existing animations."
