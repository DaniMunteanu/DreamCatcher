extends AudioStreamPlayer

var main_menu_audio = "res://background_music/MainMenu.wav"
var floor_audio = "res://background_music/Floor.wav"
var boss_audio = "res://background_music/Boss.wav"
var victory_audio = "res://background_music/Victory.wav"
var game_over_audio = "res://background_music/GameOver.wav"
var shop_audio = "res://background_music/Shop.wav"

func gradual_volume_down(duration: float):
	var volume_down_tween = create_tween()
	volume_down_tween.tween_property(self, "volume_db", -32, duration)

func play_audio(audio_file_path):
	stop()
	stream = load(audio_file_path)
	volume_db = -16
	play()
