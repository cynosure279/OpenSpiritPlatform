class_name Loader

var path = ""
var files = []

func _init(path: String):
	self.path = path

static func _load(path: String):
	var dir = Directory.new()
	var file = ""
	var files = []
	if dir.open(path) != OK:
		return files
	else:
		dir.list_dir_begin(true)
		file = dir.get_next()
		while file != "":
			if dir.current_is_dir():
				var temp = _load(file)
				files += temp
			else :
				var name = path + "/" + file
				files.push_back(name)
			file = dir.get_next()
		dir.list_dir_end()
	return files

func start():
	self.files = self._load(self.path)
	return self.files
