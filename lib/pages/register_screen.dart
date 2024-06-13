import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _joinCodeController = TextEditingController();

  bool _isSigningUp = false;

  Future signUp() async {
    try {
      if (passwordConfirmed()) {
        setState(() {
          _isSigningUp = true;
        });
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

        setState(() {
          _isSigningUp = false;
        });

        //add user details
        addUserDetails(
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _emailController.text.trim(),
            _joinCodeController.text.trim());

        MotionToast.success(
          description: Text(
            'User Registered Successfully',
          ),
          title: Text(
            'Success',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          animationType: AnimationType.fromLeft,
        ).show(context);
      } else {
        setState(() {
          _isSigningUp = false;
        });
        MotionToast.error(
          description: Text(
            'Password does not Match',
          ),
          title: Text(
            'Error',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          animationType: AnimationType.fromLeft,
        ).show(context);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isSigningUp = false;
      });
      MotionToast.error(
        description: Text(
          'Some error occured : ${e.code}',
        ),
        title: Text(
          'Error',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        animationType: AnimationType.fromLeft,
      ).show(context);
    }
  }

  Future addUserDetails(
      String firstName, String lastName, String email, String code) async {
    final User? user = await FirebaseAuth.instance.currentUser;
    final _uid = user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(_uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'code': code,
      'id': _uid,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _joinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 10,
                ),
                //Hello Again

                Text(
                  "Hello There!",
                  style: GoogleFonts.bebasNeue(fontSize: 52),
                ),

                SizedBox(
                  height: 10,
                ),

                Text(
                  "Register below with your details!",
                  style: TextStyle(fontSize: 20),
                ),

                SizedBox(
                  height: 40,
                ),

                //first name Text Field

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFf58634)),
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'First Name'),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                //Email Text Field

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFf58634)),
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Last Name'),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                //Email Text Field

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFf58634)),
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Email'),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                //Password Text Field

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFf58634)),
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Password'),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // confirm password text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFf58634)),
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Confirm Password'),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                //Email Text Field

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _joinCodeController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFf58634)),
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Joining Code'),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                //Sign in Button

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xFFf58634),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: _isSigningUp
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                //Register Now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('I am a memeber! ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        'Login Now',
                        style: TextStyle(
                            color: Color(0xFF00aeef),
                            fontWeight: FontWeight.bold),
                      ),
                    )
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
