// Generated by CoffeeScript 1.6.3
(function() {
  this.Game = (function() {
    function Game() {
      var bp;
      this.is_pause = false;
      this.world = new CANNON.World();
      console.log(this.world);
      this.world.gravity = new CANNON.Vec3(0, 0, -50);
      bp = new CANNON.NaiveBroadphase();
      this.world.broadphase = bp;
    }

    Game.prototype.start = function() {
      var groundBody, groundShape;
      groundShape = new CANNON.Plane(new CANNON.Vec3(0, 0, 1));
      groundBody = new CANNON.RigidBody(0, groundShape);
      return this.world.add(groundBody);
    };

    Game.prototype.update = function() {
      if (!this.is_pause) {
        return this.world.step(1.0 / 30.0);
      }
    };

    return Game;

  })();

}).call(this);
