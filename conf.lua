function love.conf(t)
	t.window.title = "Collab"
	t.window.width = 1080
	t.window.height = 720

	--print to console in real time
	io.stdout:setvbuf("no")
	
	--for debugging tests
	debugging = true

	--defaults
	game = {}
	game.wWidth = 1080
	game.wHeight = 720
	game.gWidth = 1080/5
	game.gHeight = 720/5
	game.ratio = math.min(
		(game.wWidth/game.gWidth),
		(game.wHeight/game.gHeight))
	game.scale = true
end
