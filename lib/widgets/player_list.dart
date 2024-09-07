import 'package:flutter/material.dart';
import 'package:monocalculator_app/models/player.dart';
import 'package:monocalculator_app/screens/add_player_screen.dart';
import 'package:monocalculator_app/screens/send_money_screen.dart';
import 'package:monocalculator_app/widgets/player_widget.dart';
import 'package:monocalculator_app/widgets/settings_sheet.dart';

  int startPassValue = 1500;
// ignore: must_be_immutable
class PlayerList extends StatefulWidget {
  List<Player> players;


  PlayerList(this.players, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _PlayerListState(players);
  }
}

class _PlayerListState extends State {
  _PlayerListState(this.players);

  List<Player> players;

  checkForBankrupcy(){
    if(players.any((player) => player.amount < 0)){
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text("Oh no!"),
          content: const Text(
              "It seems that a player has gone bankrupt."),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Okay"))
          ],
    ),
    );
    Player playerToRemove = players.firstWhere((player) => player.amount < 0);
    setState(() {
      players.remove(playerToRemove);
    });
  }
  }

  passedStart(int playerIndex) {
    setState(() {
      players[playerIndex].amount += startPassValue;
    });
  }

  removePlayerFromList(int playerIndex) {
    setState(() {
      players.remove(players[playerIndex]);
    });
  }

  sendMoney(Player? sender, Player? receiver, int amount){
    if(sender != null){
      setState(() {
      sender.amount -= amount;
      });
    }
    if(receiver != null){
      setState(() {
      receiver.amount += amount;
      });
    }
    Navigator.pop(context);
    checkForBankrupcy();
  }

  void addPlayers(Player newPlayer) {
    setState(() {
      players.add(newPlayer);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 600, minHeight: 56.0),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: [
              for (Player playerNew in players)
                PlayerWidget(
                  passStart: () {
                    passedStart(players.indexOf(playerNew));
                  },
                  removePlayer: () {
                  removePlayerFromList(players.indexOf(playerNew));},
                  player: playerNew,
                )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPlayerScreen(addPlayerToList: addPlayers, playerList: players,)),
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          child: const Text('+ Add player'),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(25),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SendMoneyScreen(players: players, addMoneyToMain: sendMoney)),
            );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Send money \$'),
          ),
        ),
      ],
    );
  }
}
