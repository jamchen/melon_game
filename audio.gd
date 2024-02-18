extends AudioStreamPlayer
class_name Audio

const combine2 := preload("res://sfx/combine2.wav")
const combine3 := preload("res://sfx/combine3.wav")
const combine4 := preload("res://sfx/combine4.wav")
const combine5 := preload("res://sfx/combine5.wav")
const combine6 := preload("res://sfx/combine6.wav")
const combine7 := preload("res://sfx/combine7.wav")
const combine := preload("res://sfx/combine.wav")
const pop := preload("res://sfx/pop.wav")
const pop_big2 := preload("res://sfx/pop_big2.wav")
const pop_big3 := preload("res://sfx/pop_big3.wav")
const pop_big := preload("res://sfx/pop_big.wav")
const pop_med := preload("res://sfx/pop_med.wav")
const pop_small2 := preload("res://sfx/pop_small2.wav")
const pop_small3 := preload("res://sfx/pop_small3.wav")
const pop_small := preload("res://sfx/pop_small.wav")

var _streams := [] 

func _add_stream():
	pass # Replace with function body.

func play_audio(sample: AudioStream, pitch : float, volume : float):
	for a in _streams:
		if a.playing:
			continue

		a.stream = sample
		a.pitch_scale = pitch
		a.volume_db = volume
		a.play()
		print_debug("playing sample: " + str(sample))
		return

	print_debug("adding " + str(len(_streams)) + "th stream to play " + str(sample))
	var new_stream : AudioStreamPlayer = duplicate()
	_streams.append(new_stream)
	add_child(new_stream)
	new_stream.stream = sample
	new_stream.pitch_scale = pitch
	new_stream.volume_db = volume
	new_stream.play()
