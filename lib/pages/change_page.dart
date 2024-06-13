import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:newsletter/pages/account_page.dart';
import 'package:newsletter/pages/all_files.dart';
import 'package:newsletter/pages/home_page.dart';
import 'package:newsletter/pages/pdfView_screen.dart';

class ChangePage extends StatefulWidget {
  const ChangePage({super.key});

  @override
  State<ChangePage> createState() => _ChangePageState();
}

class _ChangePageState extends State<ChangePage> {
  int _selectedIndex = 0;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> pdfData = [];

  void getAllPdfs() async {
    final results = await _firebaseFirestore.collection("pdfs").get();

    pdfData = results.docs.map((e) => e.data()).toList();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    getAllPdfs();
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _screens = [
    AllFiles(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: Container(
          // decoration: BoxDecoration(
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.grey,
          //       blurRadius: 5,
          //     )
          //   ],
          // ),
          child: Stack(alignment: AlignmentDirectional.center, children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.grey.shade400, width: 1))),
              child: BottomNavigationBar(
                backgroundColor: Colors.grey.shade200,
                selectedItemColor: Color(0xFFf58634),
                currentIndex: _selectedIndex,
                onTap: _navigateBottomBar,
                items: [
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Icon(Icons.timer),
                      ),
                      label: 'Recent'),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Icon(Icons.person),
                      ),
                      label: 'Profile')
                ],
              ),
            ),
            Positioned(
                child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => pdfViewerScreen(
                          pdfUrl: pdfData[0]['url'],
                          showIndicator: false,
                          showNavigation: true,
                        )));
              },
              shape: CircleBorder(),
              backgroundColor: Color(0xFFf58634),
              child: Icon(
                Icons.book,
                color: Colors.white,
              ),
            ))
          ]),
        ),
      ),
      //   floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.of(context).push(MaterialPageRoute(
      //           builder: (context) => pdfViewerScreen(
      //                 pdfUrl: pdfData[0]['url'],
      //                 showIndicator: false,
      //                 showNavigation: true,
      //               )));
      //     },
      //     shape: CircleBorder(),
      //     backgroundColor: Color(0xFFf58634),
      //     child: Icon(
      //       Icons.book,
      //       color: Colors.white,
      //     ),
      //   ),
      //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
