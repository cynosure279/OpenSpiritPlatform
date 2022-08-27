extends Control
onready var _player = $AudioStreamPlayer
# 是否可拖动
var dragging = true

var text_path = "./test.txt"
var character_path = ""

var audio_path = ""

var video_path = ""

#var text_list = Array()
var text_list = Array()

var audio_list = Array()

var video_list = Array()


# Called when the node enters the scene tree for the first time.
func _ready():
	print(text_path)
	# 设背景为透明
	get_tree().root.set_transparent_background(true)
	_loader_senior()
	# pass # Replace with function body.

func _input(event):
	# 判是否处于拖动状态
	if event is InputEventMouseButton :
		if event.button_index == BUTTON_LEFT and event.is_pressed() :
			dragging = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			dragging = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		var textlabel = get_node("RichTextLabel")
		var text1 = _random(text_list)
		textlabel.text = text1
		var track = _load_senior(["./tets.mp3"])
		_player.stream = track
		_player.play()
		
	if event is InputEventMouseMotion and dragging == true :
		OS.set_window_position(OS.window_position + event.relative.normalized() *12)

func _loader(path):
	var file = File.new()
	file.open(path,File.READ)
	var content = file.get_as_text()
	file.close()
	var object_path_list = content.split("\n")
	return object_path_list

func _loader_senior():
	var text_list = _loader(text_path)
	_loader(character_path)
	_loader(audio_path)
	_loader(video_path)
func _load_senior(list):
	var path = _random(list)
	var track = load(path)
	return track

func _random(list):
	var random = RandomNumberGenerator.new()
	random.randomize()
	var rdn = random.randi_range(0,list.size()-1)
	var obj = list[rdn]
	return obj
	
	
func _random_senior():
	
	#text = _random(text_list)
	pass
func _reload():
	_random_senior()

