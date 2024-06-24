local ENABLED = true -- An on or off button I guess
local mania = true -- bar will be closer to strums in middlescroll

local location = 'left' -- left, right, or center

local icons = {P1 = {['left'] = true}, P2 = {['right'] = true}}

local health = {['left'] = -220, ['right'] = 940, ['center'] = 364, y = 354}
local offset = {['left'] = 200,  ['right'] = 200, ['center'] = 200}

function onCreatePost()
	-- timebar in front so icons don't block it
	setObjectOrder('timeBarBG', getObjectOrder('iconP2')+1)
	setObjectOrder('timeBar', getObjectOrder('iconP2')+2)
	setObjectOrder('timeTxt', getObjectOrder('iconP2')+3)

 	setObjectOrder('healthBar', getObjectOrder('strumLineNotes') - 1)
	setObjectOrder('healthBarBG', getObjectOrder('healthBar') - 1)
	setProperty('healthBar.numDivisions', 10000)

	setObjectOrder('iconP1', getObjectOrder('strumLineNotes') - 1)
	setObjectOrder('iconP2', getObjectOrder('strumLineNotes') - 1)

	if ENABLED then
		if middlescroll and mania then
			health['left'] = health['left'] + 300
			health['right'] = health['right'] - 295
		end

		setProperty('iconP1.flipX', icons.P1[location] or false)
		setProperty('iconP2.flipX', icons.P2[location] or false)

		scaleObject('healthBar', 0.93, 0.93)
		scaleObject('healthBarBG', 0.93, 0.93)

		setProperty('healthBar.angle', 90)
		setProperty('healthBar.x', health[location] or health['left'])

		setProperty('healthBar.y', health.y)
	end
end

local per = 50
local equationPart 
function onUpdatePost(e)
	if ENABLED then
		updateHitbox('healthBar')
		updateHitbox('healthBarBG')

		per = math.lerp(per, getProperty('healthBar.percent'), (e * 10))
		setProperty('healthBar.percent', per)
		equationPart = (getProperty('healthBar.width') * per * (getProperty('healthBar.scale.y') * 0.03))
	
		local P1Mult = getProperty('healthBar.y') - (equationPart + (150 * getProperty('iconP1.scale.x') - 150)) + 250
		local P2Mult = getProperty('healthBar.y') - (equationPart - (150 * getProperty('iconP2.scale.x')))
	
		setProperty('iconP1.y', P1Mult + (getProperty('iconP1.offset.y') / 100))
		setProperty('iconP2.y', P2Mult + (getProperty('iconP2.offset.y') / 1000))
		
		setProperty('iconP1.x', getProperty('healthBar.x') + offset[location])
		setProperty('iconP2.x', getProperty('healthBar.x') + offset[location])

		setProperty('iconP1.origin.y', -150)
		setProperty('iconP2.origin.y', 300)		
	end
end

function math.lerp(a, b, t)
    return (b - a) * t + a
end