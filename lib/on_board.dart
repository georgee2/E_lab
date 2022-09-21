import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'log_in.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
          [
            Image.asset('assets/ex.png',
              scale: 4.0,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.08,
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black12,
                    onPressed: () async{
                      SharedPreferences _pref = await SharedPreferences.getInstance();
                      _pref.setString('firstTime', 'done');
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context)=> const LoginScreen(),
                      ),
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}