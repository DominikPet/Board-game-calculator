import 'package:flutter/material.dart';
import 'package:monocalculator_app/screens/players_screen.dart';

class MonoApp extends StatelessWidget{
  const MonoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PlayersScreen(),
      theme: ThemeData().copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white
          ),
      )
      )
    );
  }
}