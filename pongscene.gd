extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
# Member variables
var screen_size
var pad_size
var direction = Vector2(1.0, 0.0)

# Constant for pad speed (in pixels/second)
const INITIAL_BALL_SPEED = 180
# Speed of the ball (also in pixels/second) 
var ball_speed = INITIAL_BALL_SPEED
# Constant for pads speed
const PAD_SPEED = 150
var score_left_player = 0
var score_right_player = 0


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here	
	screen_size = get_viewport_rect().size
	pad_size = get_node("Left").get_texture().get_size() 
	set_process(true)
	get_node("Label").set_text(str(screen_size))
	get_node("Label1").set_text(str(pad_size))
	get_node("Pause").connect("pressed",self,"_on_button_pressed")
	get_node("PausePanel/Unpause").connect("pressed",self,"_on_button2_pressed")
	pass
	
func _on_button2_pressed():
	get_node("PausePanel").hide()
	get_tree().set_pause(false)
	
func _on_button_pressed():
	get_node("PausePanel").show()
	get_tree().set_pause(true)
	
func _process(delta):
	var ball_pos = get_node("Ball").get_pos()
	var left_rect = Rect2( get_node("Left").get_pos() - pad_size*0.5, pad_size ) 
	var right_rect = Rect2( get_node("Right").get_pos() - pad_size*0.5, pad_size )
	# Print variable values
	get_node("Label2").set_text(str(ball_speed))
	get_node("Label3").set_text(str(ball_pos))
	get_node("Label4").set_text(str(right_rect))
	get_node("Label6").set_text(str(left_rect))
	# Update ball position
	ball_pos += direction * ball_speed * delta
	
	# Players move padles with input
	# Get original position of paddle
	var left_pos = get_node("Left").get_pos()
	# Move up if not outside of the screen already
	if (left_pos.y > 0 and Input.is_action_pressed("left_move_up")): 
		left_pos.y += -PAD_SPEED * delta
	if (left_pos.y < screen_size.y and Input.is_action_pressed("left_move_down")): 
		left_pos.y += PAD_SPEED * delta
	get_node("Left").set_pos(left_pos)
	
	# Get original position of paddle
	var right_pos = get_node("Right").get_pos()
	#Check if paddle is inside screen while input and move if yes
	if (right_pos.y > 0 and Input.is_action_pressed("right_move_up")):
		right_pos.y += -PAD_SPEED * delta
	if (right_pos.y < screen_size.y and Input.is_action_pressed("right_move_down")):
		right_pos.y += PAD_SPEED * delta
	get_node("Right").set_pos(right_pos)
	
	# Check if the ball needs to bounce off the roof and floor
	if ((ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0)):
		direction.y = -direction.y
	# Check if the ball needs to bounce off the walls
	if ((ball_pos.x < 0 and direction.x < 0)):
		direction.x = -direction.x
		# Score points !
		score_left_player += 1
		get_node("score-left").set_text(str(score_left_player))
		# reset ball position and speed
		ball_pos = get_viewport_rect().size/2
		get_node("Ball").set_pos(ball_pos)
		ball_speed = INITIAL_BALL_SPEED
		
	if ((ball_pos.x > screen_size.x and direction.x > 0)):
		direction.x = -direction.x
		# Score points !
		score_right_player += 1
		get_node("score-right").set_text(str(score_right_player))
		# reset ball position and speed
		ball_pos = get_viewport_rect().size/2
		get_node("Ball").set_pos(ball_pos)
		ball_speed = INITIAL_BALL_SPEED
		
	# Make ball bonce off paddles and speed up
	if ((left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0)):
		direction.x = -direction.x
		direction.y = randf()*2.0 - 1
		direction = direction.normalized()
		ball_speed *= 1.1
	# Actually move the ball if nothing else needs to happen first
	get_node("Ball").set_pos(ball_pos)
	
	if (score_left_player > 9):
		get_tree().change_scene("res://HelloWorld.tscn")
		get_node("/root/global")._leftwins()
	if (score_right_player > 9):
		get_tree().change_scene("res://HelloWorld.tscn")
		get_node("/root/global")._rightwins()
		
