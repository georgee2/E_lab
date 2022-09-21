import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool logIn = true;
  bool obscure = true;

  //account handle
  accountRegister(String email, String pass) async{
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  accountLogin(String email, String pass) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff292C31),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: _height,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Expanded(child: SizedBox()),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(),
                        Text(
                          logIn? 'SIGN IN' : 'SIGN UP',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffA9DED8),
                          ),
                        ),
                        const SizedBox(),
                        Padding(
                          padding: EdgeInsets.only(right: _width / 30, left: _width / 30),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white.withOpacity(.9)),
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(.5),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25)),
                              ),
                              prefixIcon: Icon(
                                Icons.email_rounded,
                                color: Colors.white.withOpacity(.7),
                              ),
                              hintMaxLines: 1,
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(.5),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty || value.length < 11) {
                                return 'enter valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: _width / 30, left: _width / 30),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white.withOpacity(.9)),
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(.5),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25)),
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.white.withOpacity(.7),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(obscure? Icons.visibility_off_outlined : Icons.visibility, color: Colors.white.withOpacity(.7),),
                                onPressed: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                },
                              ),
                              hintMaxLines: 1,
                              hintText: 'password',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(.5),
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: obscure,
                            validator: (value) {
                              if (value.isEmpty || value.length < 6) {
                                return 'must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            logIn? RichText(
                              text: TextSpan(
                                text: 'Forgotten password!',
                                style: const TextStyle(
                                  color: Color(0xffA9DED8),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    HapticFeedback.lightImpact();
                                    Fluttertoast.showToast(
                                        msg:
                                        'Forgotten password! button pressed');
                                  },
                              ),
                            ) : const SizedBox(),
                            logIn? SizedBox(width: _width / 10) : const SizedBox(),
                            RichText(
                              text: TextSpan(
                                text: logIn? 'Create a new Account' : 'Already have account?',
                                style: const TextStyle(color: Color(0xffA9DED8)),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      logIn = !logIn;
                                    });
                                  },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        //sign in button background
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(bottom: _width * .07),
                            height: _width * .7,
                            width: _width * .7,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                  Color(0xff09090A),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        //sign in button
                        Center(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              if(formKey.currentState.validate()){
                                logIn?
                                accountLogin(emailController.text, passwordController.text)
                                    : accountRegister(emailController.text, passwordController.text);
                              }
                            },
                            child: Container(
                              height: _width * .2,
                              width: _width * .2,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Color(0xffA9DED8),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                logIn? 'SIGN-IN' : 'SIGN-UP',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget component1(IconData icon, String hintText, bool isPassword, bool isEmail) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _width / 8,
      width: _width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: _width / 30),
      decoration: BoxDecoration(
        color: const Color(0xff212428),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white.withOpacity(.9)),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}