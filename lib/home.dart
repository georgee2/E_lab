import 'package:e_lab/categories.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0,0.0),
                      blurRadius: 10.0,
                    )
                  ]
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 50,left: 20,right: 20),
                child: Text(
                  'E-Lab',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0,left: 20.0),
                    child: MaterialButton(
                      onPressed: (){},
                      child: Stack(
                        children: [
                          Container(
                            width: 170,
                            height: 150,
                            decoration:  BoxDecoration(
                                color: HexColor('2F409C'),
                                borderRadius:BorderRadius.circular(30.0) ,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0,0.0),
                                    blurRadius: 15.0,
                                  )
                                ]
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.add_sharp,
                              color:HexColor('2F409C') ,
                              size: 40,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 110,left: 15.0),
                            child: Text(
                              'Clinic visit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0,right: 20.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const DiagnoseScreen()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 150,
                        decoration:  BoxDecoration(
                            color: Colors.white,
                            borderRadius:BorderRadius.circular(30.0) ,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0,0.0),
                                blurRadius: 15.0,
                              )
                            ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(image: NetworkImage(
                              'https://play-lh.googleusercontent.com/ERvhdJbFlpZHN4thd1eZIFk4imE2owV_V-FeUrQsR2cTnc9Dt-SH3lYmO3sTzcvPAzQ',
                            ),
                              width: 110,
                              height: 110,
                            ),
                            Text(
                              'Diagnose',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                    color: HexColor("2F409C"),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 30.0, left: 16),
                        child: Text(
                          'Popular Doctors',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    MaterialButton(
                                      onPressed: (){},
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        height: 200,
                                        decoration:  BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:BorderRadius.circular(30.0) ,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(0.0,0.0),
                                                blurRadius: 15.0,
                                              )
                                            ]
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Image(image: NetworkImage(
                                              'https://cdn-icons-png.flaticon.com/512/1869/1869354.png',
                                            ),
                                              fit: BoxFit.cover,
                                              width: 70,
                                              height: 70,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text('Dr:Jony',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            const Text('internally',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.star_rate),
                                                Text('4.9')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    MaterialButton(
                                      onPressed: (){},
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        height: 200,
                                        decoration:  BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:BorderRadius.circular(30.0) ,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(0.0,0.0),
                                                blurRadius: 15.0,
                                              )
                                            ]
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Image(image: NetworkImage(
                                              'https://cdn-icons-png.flaticon.com/512/1869/1869354.png',
                                            ),
                                              fit: BoxFit.cover,
                                              width: 70,
                                              height: 70,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text('Dr:Jony',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            const Text('internally',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.star_rate),
                                                Text('4.9')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    MaterialButton(
                                      onPressed: (){},
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        height: 200,
                                        decoration:  BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:BorderRadius.circular(30.0) ,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(0.0,0.0),
                                                blurRadius: 15.0,
                                              )
                                            ]
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Image(image: NetworkImage(
                                              'https://cdn-icons-png.flaticon.com/512/1869/1869354.png',
                                            ),
                                              fit: BoxFit.cover,
                                              width: 70,
                                              height: 70,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text('Dr:Jony',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            const Text('internally',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.star_rate),
                                                Text('4.9')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    MaterialButton(
                                      onPressed: (){},
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        height: 200,
                                        decoration:  BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:BorderRadius.circular(30.0) ,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(0.0,0.0),
                                                blurRadius: 15.0,
                                              )
                                            ]
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Image(image: NetworkImage(
                                              'https://cdn-icons-png.flaticon.com/512/1869/1869354.png',
                                            ),
                                              fit: BoxFit.cover,
                                              width: 70,
                                              height: 70,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text('Dr:Jony',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            const Text('internally',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.star_rate),
                                                Text('4.9')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
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