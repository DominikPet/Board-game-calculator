import 'package:flutter/material.dart';
import 'package:monocalculator_app/models/player.dart';

class SendMoneyScreen extends StatefulWidget {
  final List<Player> players;
  final Function(Player? sender, Player? receiver, int amount) addMoneyToMain;

  SendMoneyScreen({required this.players, required this.addMoneyToMain});

  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  String? selectedSender;
  String? selectedReceiver;
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void addMoney(String? senderName, String? receiverName, int amount) {
    Player? sender;
    Player? receiver;

    try {
      sender = widget.players.firstWhere(
        (player) => player.name == senderName,
      );
    } catch (e) {
      sender = null; // Handle the case where the player is not found
    }

    try {
      receiver = widget.players.firstWhere(
        (player) => player.name == receiverName,
      );
    } catch (e) {
      receiver = null; // Handle the case where the player is not found
    }

    widget.addMoneyToMain(sender, receiver, amount);
  }

  List<String> get playerNames {
    return widget.players.map((player) => player.name).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Send Money'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Sender',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              value: selectedSender,
              onChanged: (String? newValue) {
                setState(() {
                  selectedSender = newValue;
                  // Reset receiver when sender changes
                  if (selectedReceiver == selectedSender) {
                    selectedReceiver = null;
                  }
                });
              },
              items: (playerNames + ['Bank'])
                  .map<DropdownMenuItem<String>>((String name) {
                return DropdownMenuItem<String>(
                  value: name,
                  child: Text(name),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Receiver',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              value: selectedReceiver,
              onChanged: (String? newValue) {
                setState(() {
                  selectedReceiver = newValue;
                });
              },
              items: (playerNames + ['Bank'])
                  .where((String name) => name != selectedSender)
                  .map<DropdownMenuItem<String>>((String name) {
                return DropdownMenuItem<String>(
                  value: name,
                  child: Text(name),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    addMoney(selectedSender, selectedReceiver,
                        int.parse(_amountController.text));
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Send'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
