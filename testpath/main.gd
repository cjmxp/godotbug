
extends Navigation2D
# Member variables
const SPEED = 200.0
var begin = Vector2()
var end = Vector2()
var path = []
var ppath=[]

func _draw():
	if(ppath.size()>1):
		for i in range(ppath.size()-1):
			draw_line(ppath[i],ppath[i+1],Color(1.0,0,0))

func _process(delta):
	self.update()
	#if (path.size() > 1):
	#	var to_walk = delta*SPEED
	#	while(to_walk > 0 and path.size() >= 2):
	#		var pfrom = path[path.size() - 1]
	#		var pto = path[path.size() - 2]
	#		var d = pfrom.distance_to(pto)
	#		if (d <= to_walk):
	#			path.remove(path.size() - 1)
	#			to_walk -= d
	#		else:
	#			path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
	#			to_walk = 0
	#	
	#	var atpos = path[path.size() - 1]
	#	get_node("/root/main/agent").set_pos(atpos)
	#	
	#	if (path.size() < 2):
	#		path = []


func _update_path():
	var p = get_simple_path(begin, end, true)
	path = Array(p) # Vector2array too complex to use, convert to regular array
	ppath=Array(path)
	path.invert()
	


func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON and event.pressed and event.button_index == 1):
		begin = get_node("/root/main/agent").get_pos()
		# Mouse to local navigation coordinates
		end = event.pos - get_pos()
		_update_path()


func _ready():
	set_process(true)
	set_process_input(true)
