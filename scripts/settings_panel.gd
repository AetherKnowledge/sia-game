extends BlurredPanel

@onready var touch_control_toggle: CheckButton = %TouchControlToggle
@onready var master_volume: VBoxContainer = %MasterVolume
@onready var music_volume: VBoxContainer = %MusicVolume
@onready var sfx_volume: VBoxContainer = %SFXVolume
@onready var point_lights_toggle: CheckButton = %PointLightsToggle
@onready var bullet_lights_toggle: CheckButton = %BulletLightsToggle
@onready var dynamic_shadows_toggle: CheckButton = %DynamicShadowsToggle


func _ready() -> void:
	update_contents()
	animation_finished.connect(update_contents)

func _on_back_btn_pressed() -> void:
	play_backwards()

func _on_master_volume_value_changed(value: float) -> void:
	var dB = linear_to_db(value/100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), dB)

func update_contents():
	master_volume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))) * 100
	music_volume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))) * 100
	sfx_volume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))) * 100
	
	touch_control_toggle.button_pressed = Settings.TouchControlsEnabled
	point_lights_toggle.button_pressed = Settings.PointLightsEnabled
	point_lights_toggle.button_pressed = Settings.PointLightsEnabled
	bullet_lights_toggle.button_pressed = Settings.BulletLightsEnabled
	dynamic_shadows_toggle.button_pressed = Settings.DynamicShadowEnabled
	
func _on_music_volume_value_changed(value: float) -> void:
	var dB = linear_to_db(value/100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), dB)

func _on_sfx_volume_value_changed(value: float) -> void:
	var dB = linear_to_db(value/100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), dB)
	
func _on_touch_control_toggle_toggled(toggled_on: bool) -> void:
	Settings.TouchControlsEnabled = toggled_on

func _on_point_light_toggled(toggled_on: bool) -> void:
	Settings.PointLightsEnabled = toggled_on


func _on_bullet_lights_toggle_toggled(toggled_on: bool) -> void:
	Settings.BulletLightsEnabled = toggled_on


func _on_dynamic_shadows_toggle_toggled(toggled_on: bool) -> void:
	Settings.DynamicShadowEnabled = toggled_on
