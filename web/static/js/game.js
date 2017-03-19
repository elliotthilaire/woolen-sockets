window.onload = function() {

    var game = new Phaser.Game(800, 600, Phaser.AUTO, '', { preload: preload, create: create, update: update });

    var player
    var cursors
    var player_id
    var player_id_int

    var enemies

    var other_players = []
    var world_state = { players: {} }

    function preload () {

        game.load.image('sheep_1', 'images/sheep_1.png');

    }

    function create () {

        cursors = game.input.keyboard.createCursorKeys()

        enemies = game.add.group()

        player = game.add.sprite(game.world.centerX, game.world.centerY, 'sheep_1');
        player.anchor.setTo(0.5, 0.5);

        player_id_int = Math.floor(Math.random() * 1000)
        player_id = player_id_int.toString()

        channel.push("im_new_here", { player_id: player_id, position: { x: player.x, y: player.y }})

    }

    function update () {

        if (cursors.left.isDown) {
            player.x -= 4;
        }
        else if (cursors.right.isDown) {
            player.x += 4;
        }

        if (cursors.up.isDown) {
            player.y -= 4;
        }
        else if (cursors.down.isDown) {
           player.y += 4;
        }

        other_players.forEach(function(other_player) {
          var other_player_id = parseInt(other_player.player_id);

          if (other_player_id in world_state.players) {
            other_player.game_object.x = world_state.players[other_player_id].position.x
            other_player.game_object.y = world_state.players[other_player_id].position.y
          }
        })

        if (player_id_int in world_state.players) {
          if (world_state.players[player_id_int].position.x != player.x ||
                  world_state.players[player_id_int].position.y != player.y ) {
            channel.push("new_position", { player_id: player_id, position: { x: player.x, y: player.y }})
          }
        }

    }

    channel.on("update_world", payload => {

      world_state = payload

    })

    channel.on("new_player_joined", payload => {

      var other_player_id = payload.player_id
      var position = payload.position

      var new_player = game.add.sprite(position.x, position.y, 'sheep_1')
      new_player.anchor.setTo(0.5, 0.5)

      other_players.push({player_id: other_player_id, game_object: new_player})

    })

    channel.on("hello_world", payload => {

      Object.keys(payload.players).forEach(function(other_player_id) {
        if (other_player_id == player_id_int) { return }

        var new_player = game.add.sprite(payload.players[other_player_id].position.x, payload.players[other_player_id].position.y, 'sheep_1')
        new_player.anchor.setTo(0.5, 0.5);

        enemies.add(new_player)

        other_players.push({player_id: other_player_id, game_object: new_player})
      })

    })

};
