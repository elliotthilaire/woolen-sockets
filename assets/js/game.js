window.onload = function() {

    var game = new Phaser.Game(800, 600, Phaser.AUTO, 'phaser-game', { preload: preload, create: create, update: update })

    var player
    var player_id

    var enemies

    var other_players = []
    var world_state = { players: {} }

    function preload () {

        // load images
        game.load.image('sheep_1', 'images/sheep_1.png')
        game.load.image('field', 'images/field.jpg')

        // show all on page without scroll bar
        game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL
        game.scale.windowConstraints.bottom = "visual"

    }

    function create () {

        // add background
        game.add.sprite(0, 0, 'field')

        // start physics used for storing sheep velocity
        game.physics.startSystem(Phaser.Physics.ARCADE)

        // limit to one pointer object
        game.input.maxPointers = 1

        // create enemies group before player
        enemies = game.add.group()

        // add player after enemy so it displays on top
        player = game.add.sprite(game.world.centerX, game.world.centerY, 'sheep_1')
        player.anchor.setTo(0.5, 0.5)
        game.physics.enable(player, Phaser.Physics.ARCADE)

        // create a random number for id
        player_id = Math.floor(Math.random() * 1000)

        channel.push("im_new_here", serialize_player_for_channel(player_id, player))

    }

    function update () {

        // follow the cursor
        if (game.physics.arcade.distanceToPointer(player) > 10) {
          game.physics.arcade.moveToPointer(player, 300)
        }

        make_player_face_correct_direction(player)

        // send details to game server
        if (player_id in world_state.players) {
          if (world_state.players[player_id].position.x != player.x ||
                  world_state.players[player_id].position.y != player.y ) {
            channel.push("new_position", serialize_player_for_channel(player_id, player))
          }
        }

    }


    channel.on("update_world", payload => {

      // save the state of the world
      world_state = payload

      // update other_players with most recent world information
      other_players.forEach(function(other_player) {
        var other_player_id = other_player.player_id

        if (other_player_id in payload.players) {
          other_player.game_object.x = payload.players[other_player_id].position.x
          other_player.game_object.y = payload.players[other_player_id].position.y

          other_player.game_object.body.velocity.x = payload.players[other_player_id].velocity.x
          other_player.game_object.body.velocity.y = payload.players[other_player_id].velocity.y

          make_player_face_correct_direction(other_player)

        }
      })

    })

    // add a new player to the game
    channel.on("new_player_joined", payload => {
      var other_player_id = payload.id
      var position = payload.position

      var new_player = game.add.sprite(position.x, position.y, 'sheep_1')
      new_player.anchor.setTo(0.5, 0.5)
      game.physics.enable(new_player, Phaser.Physics.ARCADE)

      other_players.push({player_id: other_player_id, game_object: new_player})

    })

    // show already existing players
    channel.on("hello_world", payload => {

      Object.keys(payload.players).forEach(function(other_player_id) {
        if (other_player_id == player_id) { return }

        var new_player = game.add.sprite(payload.players[other_player_id].position.x, payload.players[other_player_id].position.y, 'sheep_1')
        new_player.anchor.setTo(0.5, 0.5)
        game.physics.enable(new_player, Phaser.Physics.ARCADE)

        enemies.add(new_player)

        other_players.push({player_id: other_player_id, game_object: new_player})
      })

    })

    // remove a player when they leave
    channel.on("player_left", payload => {
      remove_from_game(payload.player_id)
    })

    // remove from phaser and from other_players array
    function remove_from_game (player_id) {

      other_players = other_players.filter(function(player) {
        if (player.player_id == player_id){
          player.game_object.destroy()
        }
        return player.player_id !== player_id
      })

    }

}

function serialize_player_for_channel (player_id, player) {
  return {
    player_id: player_id,
    position: { x: player.x, y: player.y },
    velocity: { x: player.body.velocity.x, y: player.body.velocity.y }
  }
}

function make_player_face_correct_direction (player) {
  if (player.body.velocity.x > 0) {
    player.scale.x = 1
  } else if (player.body.velocity.x < 0) {
    player.scale.x = -1
  }
}
