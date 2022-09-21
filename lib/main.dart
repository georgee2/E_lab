import 'package:e_lab/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences _pref = await SharedPreferences.getInstance();
  String firstTime = _pref.getString('firstTime');

  runApp(MyApp(firstTime: firstTime,));
}

class MyApp extends StatelessWidget {
  final String firstTime;

  const MyApp({Key key, this.firstTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Bauhaus_',
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
