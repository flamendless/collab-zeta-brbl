function love.conf(t)
	t.window.title = "Collab"
	t.window.width = 480
	t.window.height = 720
	io.stdout:setvbuf("no")

	game = {}
	game.wWidth = 480
	game.wHeight = 720
	game.gWidth = 96
	game.gHeight = 144
	game.ratio = math.min(
		(game.wWidth/game.gWidth),
		(game.wHeight/game.gHeight))
end
