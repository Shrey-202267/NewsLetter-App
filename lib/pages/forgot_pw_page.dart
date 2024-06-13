// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:motion_toast/motion_toast.dart';

// class ForgotPasswordPage extends StatefulWidget {
//   const ForgotPasswordPage({super.key});

//   @override
//   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final _emailController = TextEditingController();

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _emailController.dispose();
//     super.dispose();
//   }

//   Future passwordReset() async {
//     try {
//       await FirebaseAuth.instance
//           .sendPasswordResetEmail(email: _emailController.text.trim());

//       MotionToast.info(
//         description: Text(
//           'Password reset link sent!',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         title: Text('Link Sent'),
//         animationType: AnimationType.fromLeft,
//       ).show(context);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         MotionToast.error(
//           description: Text(
//             'Invalid credential',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           title: Text('Error'),
//           animationType: AnimationType.fromLeft,
//         ).show(context);
//       } else {
//         MotionToast.error(
//           description: Text(
//             'An error occured : ${e.code}',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           title: Text('Error'),
//           animationType: AnimationType.fromLeft,
//         ).show(context);
//       }
//     } catch (e) {
//       MotionToast.error(
//         description: Text(
//           'An Unexpected Error Occured',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         title: Text('Error'),
//         animationType: AnimationType.fromLeft,
//       ).show(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Enter Your Email, We will send you password resetting link.',
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 20),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25.0),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   border: Border.all(color: Colors.white),
//                   borderRadius: BorderRadius.circular(15)),
//               child: TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white),
//                         borderRadius: BorderRadius.circular(15)),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Color(0xFFf58634)),
//                         borderRadius: BorderRadius.circular(15)),
//                     hintText: 'Email'),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25),
//             child: GestureDetector(
//               onTap: passwordReset,
//               child: Container(
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFf58634),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Send',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      MotionToast.error(
        description: Text(
          'Please enter an email.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        title: Text('Error'),
        animationType: AnimationType.fromLeft,
      ).show(context);
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      MotionToast.info(
        description: Text(
          'Password reset link sent!',
          style: TextStyle(),
        ),
        title: Text(
          'Link Sent',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        animationType: AnimationType.fromLeft,
      ).show(context);
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException caught: ${e.code}");
      if (e.code == 'user-not-found') {
        MotionToast.error(
          description: Text(
            'No user found for that email.',
          ),
          title: Text('Error', style: TextStyle(fontWeight: FontWeight.bold)),
          animationType: AnimationType.fromLeft,
        ).show(context);
      } else {
        MotionToast.error(
          description: Text(
            'An error occurred: ${e.message}',
          ),
          title: Text(
            'Error',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          animationType: AnimationType.fromLeft,
        ).show(context);
      }
    } catch (e) {
      print("An unexpected error occurred: $e");
      MotionToast.error(
        description: Text(
          'An unexpected error occurred',
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enter your email, we will send you a password reset link.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
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
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: GestureDetector(
              onTap: passwordReset,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFf58634),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Send',
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
        ],
      ),
    );
  }
}
