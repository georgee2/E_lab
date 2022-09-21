import 'package:e_lab/api/receive_data.dart';
import 'package:e_lab/api/send_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class Diabetes extends StatefulWidget {
  const Diabetes({Key key}) : super(key: key);

  @override
  State<Diabetes> createState() => _DiabetesState();
}

class _DiabetesState extends State<Diabetes> {
  final TextEditingController _editingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int age;
  String gender;
  String polydipsia;
  String polyuria;
  String suddenWeightLoss;
  String alopecia;

  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: HexColor("2F409C"),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Text(
              'Diabetes',
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 25.0, // soften the shadow
                      spreadRadius: 10.0, //extend the shadow
                      offset: Offset(
                        15.0, // Move to right 10  horizontally
                        15.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 15, left: 15, top: 5, bottom: 2),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Age',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: _editingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: '35',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: HexColor('2F409C')),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: Colors.greenAccent),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    age = int.parse(value);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 1,
                          child: Container(
                            color: Colors.black12,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Gender',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              decoration: BoxDecoration(
                                color: HexColor('2F409C'),
                                border: Border.all(),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: DropdownButton(
                                value: gender,
                                elevation: 30,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                hint: const Text(
                                  'Male',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                dropdownColor: HexColor('2F409C'),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    gender = newValue;
                                  });
                                },
                                underline: Container(
                                  height: 0,
                                  color: Colors.black,
                                ),
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                items: ['Male', 'Female']
                                    .map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      e,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    value: e,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 1,
                          child: Container(
                            color: Colors.black12,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: const Text(
                                  'Sudden weight loss?',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              decoration: BoxDecoration(
                                color: HexColor('2F409C'),
                                border: Border.all(),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: DropdownButton(
                                value: suddenWeightLoss,
                                elevation: 30,
                                dropdownColor: HexColor('2F409C'),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                                hint: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    suddenWeightLoss = newValue;
                                  });
                                },
                                underline: Container(
                                  height: 0,
                                  color: Colors.black,
                                ),
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                items: ['Yes', 'No']
                                    .map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      e,
                                      style:
                                      const TextStyle(color: Colors.white),
                                    ),
                                    value: e,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 1,
                          child: Container(
                            color: Colors.black12,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Polyuria',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        )),
                                    Text(
                                      'If you unrinate more than 6-7 times a day',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              decoration: BoxDecoration(
                                color: HexColor('2F409C'),
                                border: Border.all(),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: DropdownButton(
                                value: polyuria,
                                elevation: 30,
                                dropdownColor: HexColor('2F409C'),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                hint: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    polyuria = newValue;
                                  });
                                },
                                underline: Container(
                                  height: 0,
                                  color: Colors.black,
                                ),
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                items: ['Yes', 'No']
                                    .map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      e,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    value: e,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 1,
                          child: Container(
                            color: Colors.black12,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Alopecia',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        )),
                                    Text(
                                      'Do you suffer from hair loss?',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade700),
                                    ),
                                  ],
                                )
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              decoration: BoxDecoration(
                                color: HexColor('2F409C'),
                                border: Border.all(),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: DropdownButton(
                                value: alopecia,
                                elevation: 30,
                                dropdownColor: HexColor('2F409C'),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                                hint: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    alopecia = newValue;
                                  });
                                },
                                underline: Container(
                                  height: 0,
                                  color: Colors.black,
                                ),
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                items: ['Yes', 'No']
                                    .map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      e,
                                      style:
                                      const TextStyle(color: Colors.white),
                                    ),
                                    value: e,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 1,
                          child: Container(
                            color: Colors.black12,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Polydipsia',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        )),
                                    Text(
                                      'If you feel abnormally thirsty',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade700),
                                    ),
                                  ],
                                )
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              decoration: BoxDecoration(
                                color: HexColor('2F409C'),
                                border: Border.all(),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: DropdownButton(
                                value: polydipsia,
                                elevation: 30,
                                dropdownColor: HexColor('2F409C'),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                                hint: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    polydipsia = newValue;
                                  });
                                },
                                underline: Container(
                                  height: 0,
                                  color: Colors.black,
                                ),
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                items: ['Yes', 'No']
                                    .map<DropdownMenuItem<String>>((e) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      e,
                                      style:
                                      const TextStyle(color: Colors.white),
                                    ),
                                    value: e,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 1,
                          child: Container(
                            color: Colors.black12,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: HexColor('2F409C'),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 20.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                                offset: Offset(
                                  8.0, // Move to right 10  horizontally
                                  15.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (age == null ||
                                  gender == null ||
                                  polyuria == null ||
                                  polydipsia == null ||
                                  suddenWeightLoss == null ||
                                  alopecia == null) {
                                fToast.showToast(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0, vertical: 12.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        color: HexColor('2F409C'),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(Icons.check),
                                          SizedBox(
                                            width: 12.0,
                                          ),
                                          Text(
                                              "Make sure your choices are valid"),
                                        ],
                                      ),
                                    ),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: const Duration(seconds: 2),
                                    positionedToastBuilder: (context, child) {
                                      return Positioned(
                                        child: child,
                                        top: 16.0,
                                        left: 16.0,
                                      );
                                    });
                                _editingController.clear();
                              } else {
                                ReceiveData().getData();
                                SendData().dioDiabetes();
                                fToast.showToast(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0, vertical: 12.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        color: Colors.greenAccent,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(Icons.check),
                                          SizedBox(
                                            width: 12.0,
                                          ),
                                          Text("Wait for your result"),
                                        ],
                                      ),
                                    ),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: const Duration(seconds: 2),
                                    positionedToastBuilder: (context, child) {
                                      return Positioned(
                                        child: child,
                                        top: 16.0,
                                        left: 16.0,
                                      );
                                    });
                              }
                            },
                            child: const Text(
                              'Start',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
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
