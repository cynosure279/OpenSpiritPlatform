extends Control

# 是否处于拖动状态
var dragging = false
var text_path = ""
var character_path = ""
var audio_path = ""
var video_path = ""
var text_list = ["人生就是这样，不能放弃，不能轻易放弃。","如果对别人见死不救的话，那还不如一起死了算了。","我能理解现在的现状，却不会放弃最后的挣扎","就算这里只是假想世界，我对你的情感也是真实的，如果我们得以回到原来的世界，我绝对要再见到你，然后在喜欢上你。 "]
var audio_list = Array()
var video_list = Array()
var mouse = ""
var speed = 12

func _ready():
	# 设背景为透明
	get_tree().root.set_transparent_background(true)
	$PopupMenu.connect("id_pressed",self,"_on_popmenu_pressed")

func _input(event):
	# 判是否处于拖动状态
	if event is InputEventMouseButton :
		if event.is_pressed() :
			dragging = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			dragging = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton :
		if event.is_pressed() :
			if event.button_index == BUTTON_LEFT :
				mouse = "left"
				left_pressed(event)
			elif event.button_index == BUTTON_RIGHT :
				mouse = "right"
				right_pressed(event)
	if event is InputEventMouseMotion :
		if dragging == true :
			OS.set_window_position(OS.window_position + event.relative.normalized() * speed)
			if mouse == "left" :
				left_dragged(event)
			elif mouse == "right" :
				right_dragged(event)

# 鼠标左键被按下
func left_pressed(event):
	var textlabel = get_node("RichTextLabel")
	var text1 = _random(text_list)
	textlabel.text = text1

# 使用鼠标左键拖动
func left_dragged(event):
	pass

# 鼠标右键被按下
func right_pressed(event):
	var popmenu = get_node("PopupMenu")
	popmenu.set_position(event.position)
	popmenu.popup()

# 使用鼠标右键拖动
func right_dragged(event):
	pass

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
func _on_popmenu_pressed(id) :
	if id == 3:
		print(id)
		get_tree().quit(-1)
	else:
		print(id)
