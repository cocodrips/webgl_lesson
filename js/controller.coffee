window.onload = ->
  window.game = new Game()
  window.game.start()
  window.game.render()
$ ->
  $("#isup").click ()->
    window.game.toggleUp()



class @Game
  constructor: ()->
    @scene = new THREE.Scene()
    @camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)
    @renderer = new THREE.WebGLRenderer()
    @isUp = false
    @flowers = Array()
    @turn = 0

  start: () ->
    @renderer.setSize(window.innerWidth, window.innerHeight)
    @renderer.setClearColorHex( 0xffffff, 1 )
    document.body.appendChild(@renderer.domElement)

    @camera.position.z = 5
    @createFlowers()

  createFlowers: ()->
    x = Math.random() * 40 - 20
    scale = 0.3 + Math.random() * 1.5
    speed = 0.005 + Math.random() * 0.01
    flower = new Flower(x, scale, speed)
    @flowers.push(flower)
    @scene.add(flower.flower)

  render: () ->
    requestAnimationFrame =>
      @render()

    for flower in @flowers
      flower.update(@isUp)
    if @turn % 30 == 0
      @createFlowers()



    @renderer.render(@scene, @camera)
    @turn++

  toggleUp: ()->
    @isUp = !@isUp

class @Flower
  constructor: (x, scale, @speed)->
    #    f_texture  = new THREE.ImageUtils.loadTexture('image/f.png')
    geometry = new THREE.CubeGeometry(scale, scale, 0.01)
    #    material = new THREE.MeshPhongMaterial({map:f_texture})
    material = new THREE.MeshBasicMaterial({ color: 0x00ff00 })
    @flower = new THREE.Mesh(geometry, material)
    @flower.position.x = x
    @flower.position.y = 5

  update: (isUp)->
    if not isUp
      @flower.rotation.z += 0.03
      @flower.position.y -= @speed
    else
      @flower.rotation.z -= 0.03
      @flower.position.y += @speed
