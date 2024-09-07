import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monocalculator_app/mono_app.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((fn) {
  runApp(const MonoApp());
  });
}