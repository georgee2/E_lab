import 'package:e_lab/diseases/skin_cancer.dart';
import 'package:e_lab/skinchest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'diseases/diabetes.dart';

class DiagnoseScreen extends StatelessWidget {
  const DiagnoseScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: HexColor("2F409C"),
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            const Text(
              'Diagnose',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.w600,
                color: Colors.white
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                      )
                    ]),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      const Text(
                        'Diseases',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35.0,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      MaterialButton(
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const SkinCancer())),
                        child: Container(
                          height: 55.0,
                          width: 270.0,
                          decoration: BoxDecoration(
                            color: HexColor("2F409C"),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 50.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: const Align(
                            child: Text(
                              'Skin Cancer',
                              style: TextStyle(color: Colors.white, fontSize: 30.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      MaterialButton(
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const SkinChest(title: 'Chest X Ray',))),
                        child: Container(
                          height: 55.0,
                          width: 270.0,
                          decoration: BoxDecoration(
                            color: HexColor("2F409C"),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 50.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: const Align(
                            child: Text(
                              'Chest X Ray',
                              style: TextStyle(color: Colors.white, fontSize: 30.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      MaterialButton(
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const Diabetes())),
                        child: Container(
                          height: 55.0,
                          width: 270.0,
                          decoration: BoxDecoration(
                            color: HexColor("2F409C"),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 50.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: const Align(
                            child: Text(
                              'Diabete',
                              style: TextStyle(color: Colors.white, fontSize: 30.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
