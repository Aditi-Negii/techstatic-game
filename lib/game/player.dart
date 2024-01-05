// ignore_for_file: unused_import, prefer_const_declarations

import 'dart:math';

import 'package:flame/collisions.dart';
// import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/particles.dart';
import 'package:flame/components.dart';
// import 'package:flame_noise/flame_noise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
import 'package:provider/provider.dart';

import '../models/player_data.dart';
import '../models/spaceship_details.dart';

import 'game.dart';
import 'enemy.dart';
import 'bullet.dart';
import 'command.dart';
import 'audio_player_component.dart';

// This component class represents the player character in game.
class Player extends SpriteComponent
    with CollisionCallbacks, HasGameReference<SpacescapeGame>, KeyboardHandler {
  // Player joystick
  JoystickComponent joystick;

  // Player health.
  int _health = 100;
  int get health => _health;

  // Details of current spaceship.
  Spaceship _spaceship;

  // Type of current spaceship.
  SpaceshipType spaceshipType;

  // A reference to PlayerData so that
  // we can modify money.
  late PlayerData _playerData;
  int get score => _playerData.currentScore;

  // If true, player will shoot 3 bullets at a time.
  bool _shootMultipleBullets = false;

  // Controls for how long multi-bullet power up is active.
  late Timer _powerUpTimer;

  // Holds an object of Random class to generate random numbers.
  final _random = Random();


  
  // This method generates a random vector such that
  // its x component lies between [-100 to 100] and
  // y component lies between [200, 400]
  Vector2 getRandomVector() {
    return (Vector2.random(_random) - Vector2(0.5, -1)) * 200;
  }

  //to move the player
  Vector2 _moveDirection = Vector2.zero();
  double _speed = 300;

  Player({
    required this.joystick,
    required this.spaceshipType,
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  })  : _spaceship = Spaceship.getSpaceshipByType(spaceshipType),
        super(sprite: sprite, position: position, size: size) {
    // Sets power up timer to 4 seconds. After 4 seconds,
    // multiple bullet will get deactivated.
    _powerUpTimer = Timer(4, onTick: () {
      _shootMultipleBullets = false;
    });
  }

  //override the update method from base class
  @override
  void updateTree(double dt) {
    super.updateTree(dt);

    this.position += _moveDirection.normalized() * _speed * dt;
  }

  void setMoveDirection(Vector2 newMoveDirection) {
    _moveDirection = newMoveDirection;
  }

  @override
  void onMount() {
    super.onMount();

    // Adding a circular hitbox with radius as 0.8 times
    // the smallest dimension of this components size.
    final shape = CircleHitbox.relative(
      0.8,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);

    _playerData = Provider.of<PlayerData>(game.buildContext!, listen: false);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // If other entity is an Enemy, reduce player's health by 10.
    if (other is Enemy) {
      // Make the camera shake, with custom intensity.
      // TODO: Investigate how camera shake should be implemented in new camera system.
      // game.primaryCamera.viewfinder.add(
      //   MoveByEffect(
      //     Vector2.all(10),
      //     PerlinNoiseEffectController(duration: 1),
      //   ),
      // );

      _health -= 10;
      if (_health <= 0) {
        _health = 0;
      }
    }
  }

  // Vector2 keyboardDelta = Vector2.zero();
  // static final _keysWatched = {
  //   LogicalKeyboardKey.keyW,
  //   LogicalKeyboardKey.keyA,
  //   LogicalKeyboardKey.keyS,
  //   LogicalKeyboardKey.keyD,
  //   LogicalKeyboardKey.space,
  // };

  // @override
  // bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
  //   // Set this to zero first - if the user releases all keys pressed, then
  //   // the set will be empty and our vector non-zero.
  //   keyboardDelta.setZero();

  //   if (!_keysWatched.contains(event.logicalKey)) return true;

  //   if (event is RawKeyDownEvent &&
  //       !event.repeat &&
  //       event.logicalKey == LogicalKeyboardKey.space) {
  //     // pew pew!
  //     joystickAction();
  //   }

  //   if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
  //     keyboardDelta.y = -1;
  //   }
  //   if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
  //     keyboardDelta.x = -1;
  //   }
  //   if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
  //     keyboardDelta.y = 1;
  //   }
  //   if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
  //     keyboardDelta.x = 1;
  //   }

  //   // Handled keyboard input
  //   return false;
  // }

  // This method is called by game class for every frame.
  @override
  void update(double dt) {
    super.update(dt);

    _powerUpTimer.update(dt);

    // Increment the current position of player by (speed * delta time) along moveDirection.
    // Delta time is the time elapsed since last update. For devices with higher frame rates, delta time
    // will be smaller and for devices with lower frame rates, it will be larger. Multiplying speed with
    // delta time ensure that player speed remains same irrespective of the device FPS.
    if (!joystick.delta.isZero()) {
      position.add(joystick.relativeDelta * _spaceship.speed * dt);
    }

    // if (!keyboardDelta.isZero()) {
    //   position.add(keyboardDelta * _spaceship.speed * dt);
    // }

    // Clamp position of player such that the player sprite does not go outside the screen size.
    position.clamp(
      Vector2.zero() + size / 2,
      game.fixedResolution - size / 2,
    );

    // Adds thruster particles.
    final particleComponent = ParticleSystemComponent(
      particle: Particle.generate(
        count: 10,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
          acceleration: getRandomVector(),
          speed: getRandomVector(),
          position: (position.clone() + Vector2(0, size.y / 3)),
          child: CircleParticle(
            radius: 1,
            paint: Paint()..color = Colors.white,
          ),
        ),
      ),
    );

    game.world.add(particleComponent);
  }

  void joystickAction() {
    Bullet bullet = Bullet(
      sprite: game.spriteSheet.getSpriteById(28),
      size: Vector2(64, 64),
      position: position.clone(),
      level: _spaceship.level,
    );

    // Anchor it to center and add to game world.
    bullet.anchor = Anchor.center;
    game.world.add(bullet);

    // Ask audio player to play bullet fire effect.
    game.addCommand(Command<AudioPlayerComponent>(action: (audioPlayer) {
      audioPlayer.playSfx('laserSmall_001.ogg');
    }));

    // If multiple bullet is on, add two more
    // bullets rotated +-PI/6 radians to first bullet.
    if (_shootMultipleBullets) {
      for (int i = -1; i < 2; i += 2) {
        Bullet bullet = Bullet(
          sprite: game.spriteSheet.getSpriteById(28),
          size: Vector2(64, 64),
          position: position.clone(),
          level: _spaceship.level,
        );

        // Anchor it to center and add to game world.
        bullet.anchor = Anchor.center;
        bullet.direction.rotate(i * pi / 6);
        game.world.add(bullet);
      }
    }
  }

  // Adds given points to player score
  /// and also add it to [PlayerData.money].
  void addToScore(int points) {
    _playerData.currentScore += points;
    _playerData.money += points;

    // Saves player data to disk.
    _playerData.save();
  }

  // Increases health by give amount.
  void increaseHealthBy(int points) {
    _health += points;
    // Clamps health to 100.
    if (_health > 100) {
      _health = 100;
    }
  }

  // Resets player score, health and position. Should be called
  // while restarting and exiting the game.
  void reset() {
    _playerData.currentScore = 0;
    _health = 100;
    position = game.fixedResolution / 2;
  }

  // Changes the current spaceship type with given spaceship type.
  // This method also takes care of updating the internal spaceship details
  // as well as the spaceship sprite.
  void setSpaceshipType(SpaceshipType spaceshipType) {
    spaceshipType = spaceshipType;
    _spaceship = Spaceship.getSpaceshipByType(spaceshipType);
    sprite = game.spriteSheet.getSpriteById(_spaceship.spriteId);
  }

  // Allows player to first multiple bullets for 4 seconds when called.
  void shootMultipleBullets() {
    _shootMultipleBullets = true;
    _powerUpTimer.stop();
    _powerUpTimer.start();
  }

 





  //service acc details
  // {
  // "type": "service_account",
  // "project_id": "techstatic-sheets-test",
  // "private_key_id": "1c8932d14185499ae5c3a1814eec56962217c75d",
  // "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDD9tCz4pIMp1ig\nC5QuVGCmx37JJCtGUwLtXTia7oFzfYetfry2LUNfPIb0oSrN8DLtOIqxj+4tE4QK\nssLNIPUDJZMzGqTluDrwOZ8PMplud/uIHhw7zyhsyY2BkeaBQPIhj8E/8yvx0BJt\nk++WDKF+s33NyRKU0q8SDIWLGf1FwHTftRi2rAsCcJlC5IIpUNRRgqBtaBIJaNhU\nMhKRUvyGsIz01IvE5bXwtOrrhGMK0uSBnnywmpuBiXnUxfcebdVEKYA/qAL0rFIy\nY0EDEXIyGpwOMNKrCwjmPSDcJKOMS5flgo4Z1HrRVzk7MN+pqvhVXkvhiipHKwMs\nH2ThfnotAgMBAAECggEABoDXIb/L5Cwcj+klIIQlK1EVDHn3uVnRZSJcxHV+/x/E\nGYD1JHWW617v7/KLoAclOtlPbv+YDPpoEs57vQDSPhRokL+vsmjyrxy2bN5wwulW\nmV3ocXVZQdekK3qK+VtNUx75GpUdw6S0VoXG48ZPs2D5Ceku8ENCqJkY8x9obUCx\naszYL8YrfV4+kH9rVteADOuNOhDLRiDTsf/7cKUOPf9M/e3bnIaRq7nPus5b9LwA\nKbR1vEwUFMuV73pBDaeqJ14n4/ChX/RUaWyqSvoNj7d5orw8X0eS0nd0kNVL21xM\nFpWKeIO6svPrriww+BqF9Cs3aOGWUeDLUq0sDMwc2QKBgQD9ZhITaV4zr7cM3zo3\nerkjE+R7eD3wvIjg8kNWOHiHAkDRgXEglST8UgAB8bEflDI1G9SARRN0j5K59wlU\n8aStkmNoZnuA/k3ST5jRsvxFdENLWNo1hAgM+EtzVUwuRzdkmYD75EMJd3dV2bR0\nQDY3Rare6ojXcZxGRFG4Z8Fv1QKBgQDF+c6c0wFSLIf7ja2gVMhMP7Hr1kYxPSs9\ngacoe+kY5/sgXbgBS2l7aEASo8CYkDlVAUEA1UnrllwCDu9j8uNd+PgJ45GZccnz\nffJ6a1cETCwetS1JWpzDrlmvxLdSOWDkQv8LNsVL4S7IzDsRAjqmW9ihidLf9SNn\n6mdAwkPk+QKBgGI+bamrA4Pkj4LlFUwnP5pS/xXDw7gPUL5uDx9hm5E0lW7k0biB\nOqq9HBWk4DhPG7wtgxEMNwPNGmURW0PcwC0vgW0btqyHbCKrC6PZ0icXcXPICioP\ne5OTvKUFoBidMePGBBUlJbyI3fKiCm2764k4cIwmwFFPUfiISmrFh2DVAoGAESlL\naLq9xZLIotywLVLMHhfzY18qrIAB7I39oHvFQ/xv/2lAVxRja2gpDbSWMGNoJN87\n9EeI5dwd06vZwo8+eFnpnmnUqDl96RaE22nMnDnCJVNNPquVJT1K1vq1bXI93OuV\n0jIIPkCh3pQdlqbb0KnriG07E2Dbldly4+EzI3kCgYEA6419A9pBGGKLFGRULqYG\n4bPdNcdsTwukel66R71Q/uaucbS3psVSDtd1MuHAcpNB7CnBGDnhkUjxQa9QXTv1\nJtt9wzTcCw3OIAI2qHIyDVbQL9Ecxd5hYk61+r7Bd9McHWgau9jEcF7yE2N5k4EJ\nfOiR7V6yoDcNtVhOQAQGd7k=\n-----END PRIVATE KEY-----\n",
  // "client_email": "techstatic-test@techstatic-sheets-test.iam.gserviceaccount.com",
  // "client_id": "107320639282399450955",
  // "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  // "token_uri": "https://oauth2.googleapis.com/token",
  // "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  // "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/techstatic-test%40techstatic-sheets-test.iam.gserviceaccount.com",
  // "universe_domain": "googleapis.com"
}



