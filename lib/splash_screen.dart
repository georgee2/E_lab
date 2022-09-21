import 'package:e_lab/auth_screen.dart';
import 'package:e_lab/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;

    Future.delayed(const Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => user == null ? const AuthScreen() : const HomeScreen()));
    });

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.jpg',),
                  fit: BoxFit.fitWidth,
                )
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.1,
              child: LoadingIndicator(
                indicatorType: Indicator.ballSpinFadeLoader, /// Required, The loading type of the widget
                colors: [HexColor("2F409C")],       /// Optional, The color collections
                strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
              ),
            )
          ],
        ),
      ),
    );
  }
}