extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var timeElapsed=0
var pressed=0
var label_content = "No games recorded."

func _ready():
	get_node("Button").connect("pressed",self,"_on_button_pressed")
	get_node("Button 2").connect("pressed",self,"_on_button2_pressed")
	get_node("/root/global")._setscore(label_content)
	set_process(true)
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	timeElapsed += delta
	get_node("Label").set_text(str(timeElapsed))

func _on_button_pressed (): 
	get_node("Label1").set_text("HELLO!")
	var scene = load("res://pongscene.scn")
	pressed += 1
	if(pressed >3):
		get_tree().change_scene("res://pongscene.scn")

func _on_button2_pressed (): 
	get_tree().change_scene("res://pongscene-alt.tscn")
	
func _winner(label_content):
	get_node("Winner").set_text(label_content)