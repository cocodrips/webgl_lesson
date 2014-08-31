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
    @renderer.setClearColorHex(0xffffff, 1)
    document.body.appendChild(@renderer.domElement)
    @directionalLight = new THREE.DirectionalLight(0xffccff, 10)
    @directionalLight.position.set(1, 50, 5)

    @scene.add(@directionalLight)

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
    if @turn % 8 == 0
      @createFlowers()

    R = 0.3 + 0.7 * (Math.abs(360 - @turn % 720) / 360.0)
#    @directionalLight.setHex(new THREE.color(R, R - 0.1, R + 0.1))
    @directionalLight.color.r = R
    @directionalLight.color.g = R - 0.1
    @directionalLight.color.r = 1 - R

    @renderer.render(@scene, @camera)
    @turn++

  cameraX:()->
    @camera.lookAt.x += 1

  toggleUp: ()->
    @isUp = !@isUp

class @Flower
  constructor: (x, scale, @speed)->
    f_texture = new THREE.ImageUtils.loadTexture('image/f.png')
    geometry = new THREE.CubeGeometry(scale, scale, 0.00001)
    material = new THREE.MeshPhongMaterial({map: f_texture})
    material.transparent = true
    material.opacity = 0.3 + Math.random() * 0.7
    material.ambient = new THREE.Color( 0, 0, 0 )
#    material = new THREE.MeshBasicMaterial({ color: 0x00ff00 })
    @flower = new THREE.Mesh(geometry, material)
    @flower.position.x = x
    @flower.position.y = 5
    @flower.position.z = scale * 0.01

  update: (isUp)->
    if not isUp
      @flower.rotation.z -= 0.03
      @flower.position.x -= 0.002
      @flower.position.y -= @speed
    else
      @flower.rotation.z += 0.03
      @flower.position.y += @speed
