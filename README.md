# HelloPong
My first 14h programming, incrementing prototype following godot engine step by step tutorials

Content :
Hello world scene : displays controls, shows the process delta value and two buttons link to pong scenes
WIP hello world scene : a singleton keeps track of the number of games won by each player (left or right) and a label in the hello world scene attemps to display the status in a label, but combining string and variables into a label isn't working yet.

Pong scene : up and down moves the right paddle. Q and A moves the left paddle. The ball bounces off the ceiling, floor and paddles. When bouncing off a paddle, the ball speed increases and the direction changes randomly. When the ball bounces off a wall, the score for the opposing players is increased by one. When the score reaches 10, the game ends and the hello world screen is showed again. The game can be paused and unpaused using a button at the bottom of the viewport.
WIP pong scene : when a player reaches 10 points, a singleton keeps track of the number of games won by each player (left or right).

Pong alt scene : changes to initial scene : up and down moves the right paddle, q speeds up the ball, a slows down the ball and changes its direction
