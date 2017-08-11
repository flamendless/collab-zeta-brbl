function love.conf(t)
	--defaults
	game = {}
	game.wWidth = 640
	game.wHeight = 640
	--game.gWidth = 1080/5
	--game.gHeight = 720/5
	game.gWidth = 64
	game.gHeight = 64
	game.ratio = math.min(
		(game.wWidth/game.gWidth),
		(game.wHeight/game.gHeight))
	game.scale = true

	--for debugging tests
	debugging = false
	debug_gameBorder = false

	t.window.title = "Last Lad"
	t.window.width = game.wWidth
	t.window.height = game.wHeight
	t.window.icon = "assets/icon.png"
	t.console = debugging

	--print to console in real time
	io.stdout:setvbuf("no")
	
	--set up globals/macro
	global = {}
	global.playerDeath = false
	global.groundY = game.gHeight - 12
	global.shake = false
	global.done = false
	global.enemyDone = false

end
