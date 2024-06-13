// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AccountPage extends StatefulWidget {
//   const AccountPage({super.key});

//   @override
//   State<AccountPage> createState() => _AccountPageState();
// }

// class _AccountPageState extends State<AccountPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('Account Page'),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:newsletter/components/account_tile.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User? user;
  Map<String, dynamic>? userDetails;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      setState(() {
        user = currentUser;
        userDetails = userDoc.data() as Map<String, dynamic>?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: userDetails == null
            ? Lottie.asset('lib/Images/Loading.json', repeat: true, width: 200)
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border:
                            Border.all(width: 2, color: Colors.grey.shade400)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        fit: BoxFit.fill,
                        'lib/Images/profile.png',
                        width: 150,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${userDetails!['firstName']} ${userDetails!['lastName']}',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    '${userDetails!['email']}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut();

                        MotionToast.success(
                          description: Text(
                            'Logged Out Succesfully',
                          ),
                          title: Text(
                            'Success',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          animationType: AnimationType.fromLeft,
                        ).show(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFFf58634),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: ListView(
                          children: [
                            AccountTile(
                                icon: Icon(
                                  Icons.person,
                                  size: 30,
                                ),
                                title: 'Full Name',
                                subtitle:
                                    '${userDetails!['firstName']} ${userDetails!['lastName']}'),
                            AccountTile(
                                icon: Icon(
                                  Icons.email,
                                  size: 30,
                                ),
                                title: 'Email',
                                subtitle: '${userDetails!['email']}'),
                            AccountTile(
                                icon: Icon(
                                  Icons.code,
                                  size: 30,
                                ),
                                title: 'Code',
                                subtitle: '${userDetails!['code']}'),
                            AccountTile(
                                icon: Icon(
                                  Icons.card_membership,
                                  size: 30,
                                ),
                                title: 'Id',
                                subtitle: '${userDetails!['id']}')
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
