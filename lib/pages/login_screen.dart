// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:newsletter/pages/forgot_pw_page.dart';

// class LoginScreen extends StatefulWidget {
//   final VoidCallback showRegisterPage;
//   const LoginScreen({super.key, required this.showRegisterPage});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   Future signIn() async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text.trim());
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found' || e.code == 'wrong-password') {
//         Fluttertoast.showToast(
//             msg: "Invalid Email or Password",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white);
//       } else {
//         Fluttertoast.showToast(
//             msg: 'An Error Occured : ${e.code}',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white);
//       }
//     }
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ignore: prefer_const_constructors
//     return Scaffold(
//       // ignore: prefer_const_constructors
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               // ignore: prefer_const_literals_to_create_immutables
//               children: [
//                 Container(
//                   width: 120,
//                   child: Image.asset(
//                     "lib/Images/logo.png",
//                   ),
//                 ),

//                 SizedBox(
//                   height: 20,
//                 ),
//                 //Hello Again

//                 Text(
//                   "Hello Again!",
//                   style: GoogleFonts.bebasNeue(fontSize: 52),
//                 ),

//                 SizedBox(
//                   height: 10,
//                 ),

//                 Text(
//                   "Welcome back, you\'ve been missed!",
//                   style: TextStyle(fontSize: 20),
//                 ),

//                 SizedBox(
//                   height: 50,
//                 ),

//                 //Email Text Field

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         border: Border.all(color: Colors.white),
//                         borderRadius: BorderRadius.circular(15)),
//                     child: TextField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(15)),
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Color(0xFFf58634)),
//                               borderRadius: BorderRadius.circular(15)),
//                           hintText: 'Email'),
//                     ),
//                   ),
//                 ),

//                 SizedBox(
//                   height: 10,
//                 ),
//                 //Password Text Field

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         border: Border.all(color: Colors.white),
//                         borderRadius: BorderRadius.circular(15)),
//                     child: TextField(
//                       controller: _passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.white),
//                               borderRadius: BorderRadius.circular(15)),
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Color(0xFFf58634)),
//                               borderRadius: BorderRadius.circular(15)),
//                           hintText: 'Password'),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(context,
//                               MaterialPageRoute(builder: (context) {
//                             return ForgotPasswordPage();
//                           }));
//                         },
//                         child: Text(
//                           "Forgot Password?",
//                           style: TextStyle(
//                               color: Color(0xFF00aeef),
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 SizedBox(
//                   height: 10,
//                 ),

//                 //Sign in Button

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: GestureDetector(
//                     onTap: signIn,
//                     child: Container(
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Color(0xFFf58634),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Sign In',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(
//                   height: 25,
//                 ),

//                 //Register Now
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('Not a member? ',
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     GestureDetector(
//                       onTap: widget.showRegisterPage,
//                       child: Text(
//                         'Register Now',
//                         style: TextStyle(
//                             color: Color(0xFF00aeef),
//                             fontWeight: FontWeight.bold),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:newsletter/pages/forgot_pw_page.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginScreen({super.key, required this.showRegisterPage});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSigning = false;

  Future<void> signIn() async {
    try {
      setState(() {
        _isSigning = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      setState(() {
        _isSigning = false;
      });

      MotionToast.success(
        description: Text(
          'Successfully Logged in',
        ),
        title: Text(
          'Success',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        animationType: AnimationType.fromLeft,
      ).show(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        setState(() {
          _isSigning = false;
        });
        MotionToast.error(
          description: Text(
            'Invalid Email or password',
          ),
          title: Text(
            'Error',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          animationType: AnimationType.fromLeft,
        ).show(context);
      } else {
        setState(() {
          _isSigning = false;
        });
        MotionToast.error(
          description: Text(
            'An error occured : ${e.code}',
          ),
          title: Text(
            'Error',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          animationType: AnimationType.fromLeft,
        ).show(context);
      }
    } catch (e) {
      setState(() {
        _isSigning = false;
      });
      MotionToast.error(
        description: Text(
          'An Unexpected Error Occured',
        ),
        title: Text(
          'Error',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        animationType: AnimationType.fromLeft,
      ).show(context);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  child: Image.asset("lib/Images/logo.png"),
                ),
                SizedBox(height: 20),
                Text(
                  "Hello Again!",
                  style: GoogleFonts.bebasNeue(fontSize: 52),
                ),
                SizedBox(height: 10),
                Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFf58634)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Email',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFf58634)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ForgotPasswordPage();
                          }));
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Color(0xFF00aeef),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xFFf58634),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: _isSigning
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member? ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          color: Color(0xFF00aeef),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
