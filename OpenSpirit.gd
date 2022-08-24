extends Control
onready var _player = $AudioStreamPlayer
# 是否可拖动
var dragging = true

var text_path = ""

var character_path = ""

var audio_path = ""

var video_path = ""

#var text_list = Array()
var text_list = ["人生就是这样，不能放弃，不能轻易放弃。","如果对别人见死不救的话，那还不如一起死了算了。","我能理解现在的现状，却不会放弃最后的挣扎","就算这里只是假想世界，我对你的情感也是真实的，如果我们得以回到原来的世界，我绝对要再见到你，然后在喜欢上你。 "]

var audio_list = Array()

var video_list = Array()


# Called when the node enters the scene tree for the first time.
func _ready():
	# 设背景为透明
	get_tree().root.set_transparent_background(true)
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
		var track = load('res://test.mp3')
		_player.stream = track
		_player.play()
		
	if event is InputEventMouseMotion and dragging == true :
		OS.set_window_position(OS.window_position + event.relative.normalized() *12)

func _loader(path):
	pass

func _loader_senior():
	_loader(text_path)
	_loader(character_path)
	_loader(audio_path)
	_loader(video_path)


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

