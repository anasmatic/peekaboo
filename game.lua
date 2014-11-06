
system.activate( "multitouch" )
local composer = require( "composer" )
local scene = composer.newScene()

local boo
local isBoo = true
local peekabooTimer
local peekaDelay = 10000
local booDelay = 3000
function scene:create( event )

	local sceneGroup = self.view

	local background = display.newImageRect( "art/peeka.jpg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0

	sceneGroup:insert( background )

	boo = display.newImageRect( "art/boo.png", display.contentWidth, display.contentHeight )
	boo.anchorX = 0
	boo.anchorY = 0
	boo.x, boo.y = 0, 0

	boo.isVisible = false

	sceneGroup:insert( boo )

	Runtime:addEventListener( "touch", onTouch )
end

function onTouch( event ) 
	if event.phase == "began" then
		if isBoo == false  then doBoo()	end
	end
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		peekabooTimer = timer.performWithDelay( peekaDelay, onTimer, 1 )
	end	
end

function onTimer( event )
	if isBoo == false then
		doBoo()
	else
		isBoo = false
		boo.isVisible = true
		peekabooTimer = timer.performWithDelay( peekaDelay, onTimer, 1 )
	end		
end

function doBoo(  )
	timer.cancel( peekabooTimer )

	isBoo = ture
	boo.isVisible = false
	peekabooTimer = timer.performWithDelay( booDelay, onTimer, 1 )
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
--[[	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
]]	
end
---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene