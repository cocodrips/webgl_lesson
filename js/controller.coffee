$ ->
  $("#start-button").click ()->
    game = new Game()
    game.start()
    game.render()


class @Game
  constructor: ()->
    @scene = new THREE.Scene()
    @camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)
    @renderer = new THREE.WebGLRenderer()

  start: () ->
    @renderer.setSize(window.innerWidth, window.innerHeight)
    document.body.appendChild(@renderer.domElement)

    geometry = new THREE.CubeGeometry(1, 1, 1)
    material = new THREE.MeshBasicMaterial({ color: 0x00ff00 })
    @cube = new THREE.Mesh(geometry, material)
    @scene.add(@cube)
    @camera.position.z = 5

#    @render(scene, camera,)

  render: () ->
    requestAnimationFrame =>
      @render()

    @cube.rotation.x += 0.1;
    @cube.rotation.y += 0.1;

    @renderer.render(@scene, @camera)

