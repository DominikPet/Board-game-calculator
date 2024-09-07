import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monocalculator_app/models/player.dart';

class PlayerWidget extends StatelessWidget {
  final Player player;
  Function() passStart;
  Function() removePlayer;

  PlayerWidget({super.key, required this.passStart, required this.removePlayer, required this.player});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: InkWell(
          onLongPress: removePlayer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(player.name, style: const TextStyle(fontSize: 18)),
                  Text("${NumberFormat('#,###').format(player.amount).toString()}\$", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              TextButton(
                onPressed: passStart,
                style: TextButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                child: const Text('Passed start'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}