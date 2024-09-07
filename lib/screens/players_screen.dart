import 'package:flutter/material.dart';
import 'package:monocalculator_app/models/player.dart';
import 'package:monocalculator_app/widgets/player_list.dart';
import 'package:monocalculator_app/widgets/player_widget.dart';
import 'package:monocalculator_app/widgets/settings_sheet.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({Key? key}) : super(key: key);

  @override
  _PlayersScreenState createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  List<Player> players = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Monocalculator',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: _openSettings,
            icon: const Icon(Icons.settings),
          ),
        ],
        centerTitle: true,
      ),
      body: PlayerList(players),
    );
  }
  
    void _openSettings() {
    showModalBottomSheet(
      useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return SettingsSheet(currentStartValue: startPassValue);
        });
  }
}


