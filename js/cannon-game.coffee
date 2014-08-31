
class @Game
  constructor: ()->
    @is_pause = false
    @world = new CANNON.World()
    console.log @world
    @world.gravity = new CANNON.Vec3(0, 0, -50)
    bp = new CANNON.NaiveBroadphase()
    @world.broadphase = bp

  start: ()->
    groundShape = new CANNON.Plane(new CANNON.Vec3(0, 0, 1))
    groundBody = new CANNON.RigidBody(0, groundShape)
    @world.add(groundBody)

  update: ()->
    if not @is_pause
      @world.step(1.0/30.0)
#      for

