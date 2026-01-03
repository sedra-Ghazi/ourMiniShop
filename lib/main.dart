import 'package:flutter/material.dart';
import 'package:flutter_application_5/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? globalSharedPrefs;


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  globalSharedPrefs = await SharedPreferences.getInstance();
  runApp( MyApp());
}





