import 'package:e_lab/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool logIn = true;
  bool visibility = true;

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key : formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    logIn? 'Login' : 'Sing up',
                    style: const TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      prefixIcon: Icon(
                        Icons.email_rounded,
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(visibility? Icons.visibility_off_outlined : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              visibility = !visibility;
                            });
                          },
                        ),
                        prefixIcon: const Icon(Icons.lock),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: visibility,
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return 'must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Container(
                    decoration: BoxDecoration(
                        color: HexColor('2F409C'),
                        borderRadius: BorderRadius.circular(25),
                    ),
                    width: double.infinity,
                    child: TextButton(
                        onPressed: (){
                          if(formKey.currentState.validate()){
                            logIn?
                            accountLogin(emailController.text, passwordController.text)
                                : accountRegister(emailController.text, passwordController.text);
                          }
                        },
                        child: Text(
                          logIn? 'Login' : 'Sign up',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        )
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        logIn? 'Dont have account?' : 'Already have account',
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            logIn = !logIn;
                          });
                        },
                        child: Text(
                          logIn? 'Create new one' : 'Log in',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
