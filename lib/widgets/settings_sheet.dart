import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monocalculator_app/widgets/player_list.dart';

class SettingsSheet extends StatefulWidget {
  final int currentStartValue;

  SettingsSheet({required this.currentStartValue, Key? key}) : super(key: key);

  @override
  _SettingsSheetState createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet> {
  final TextEditingController _valueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _valueController.text = widget.currentStartValue.toString();
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  void _changeStartValue() {
    startPassValue = int.parse(_valueController.text);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 100, maxHeight: 600),
      child: Column(
        children: [
          const SizedBox(height: 40),
          TextField(
            controller: _valueController,
            keyboardType: TextInputType.number,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text(
                "Start pass value \$",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _changeStartValue,
            child: const Text("Save", style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
    );
  }
}
