function onCreate()
    makeAnimatedLuaSprite('Static', 'Static')
    addAnimationByPrefix('Static', 'Static', 'Static', 24, true)
    setObjectCamera('Static', 'HUD')
    playAnim('Static', 'Static', true)
    addLuaSprite('Static', false)
    setBlendMode('Static', 'screen')
    setProperty('Static.alpha', 0.1)
end