import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:micro/gradient.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:micro/signup/signup.dart';
import 'package:micro/login/forgetPassword/forget.dart';
import 'package:micro/homePage/homePage.dart';

final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

class Login extends StatefulWidget {
  const Login({Key? Key}) : super(key: Key);

  static const routeName = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  var _isObsecured;
  String _email = '', _password = '';

  @override
  void initState() {
    super.initState();

    _isObsecured = true;
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void isLoading(bool isloading) {
    isloading
        ? showDialog(
            context: context,
            builder: (context) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Color(0xff7762FF),
                backgroundColor: Colors.grey,
              ));
            })
        : Navigator.of(context).pop();
  }

  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _emailController.text)
          .where('password', isEqualTo: _passwordController.text)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String userId = querySnapshot.docs.first.id;
        await saveUserId(userId);
        await saveUserSignUpState();
        isLoading(false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => homePage(
                    userId: userId,
                  )),
        );
      } else {
        isLoading(false);
        _showErrorDialog('Email or password are invalid');
      }
    } catch (e) {
      isLoading(false);
      _showErrorDialog('Something went wrong');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 50,
                bottom: 25,
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const Signup()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 15),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage('Icons/logo.png'),
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Sign in to Micro',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // SizedBox(height: 16),
                        GradientText(
                          text: "Welcome back, you've been missed!",
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff7762FF),
                              Color(0xffC589E4),
                              Color(0xffFC6590),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 64,
                          width: 310,
                          child: TextFormField(
                            controller: _emailController,
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                            textAlign: TextAlign.center,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(fontSize: 14.0),
                              border: GradientOutlineInputBorder(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff7762FF),
                                    Color(0xffC589E4),
                                    Color(0xffFC6590),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Email',
                              errorStyle: const TextStyle(fontSize: 0.0),
                              suffixIcon: _email.length < 1
                                  ? GestureDetector(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Container(
                                              padding: const EdgeInsets.all(16),
                                              height: 90,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFC72C41),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                              child: const Text(
                                                'Email is required',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                          ),
                                        );
                                      },
                                      child: const Icon(Icons.info),
                                    )
                                  : !emailRegex.hasMatch(_email)
                                      ? GestureDetector(
                                          onTap: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Container(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  height: 90,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xFFC72C41),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                  ),
                                                  child: const Text(
                                                    'Invalid email format',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.transparent,
                                                elevation: 0,
                                              ),
                                            );
                                          },
                                          child: const Icon(Icons.info),
                                        )
                                      : null,
                            ),
                            validator: (name) {
                              if (name!.length < 1) {
                                return '';
                              } else if (!emailRegex.hasMatch(_email)) {
                                return 'Invalid email format';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(fontSize: 22.0),
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          height: 64,
                          width: 310,
                          child: TextFormField(
                            controller: _passwordController,
                            key: const ValueKey('login_password'),
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                            textAlign: TextAlign.center,
                            obscureText: _isObsecured,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(fontSize: 0.0),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (_password.length < 1)
                                    GestureDetector(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Container(
                                              padding: const EdgeInsets.all(16),
                                              height: 90,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFC72C41),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                              child: const Text(
                                                'Invalid Password',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                          ),
                                        );
                                      },
                                      child: Icon(Icons.info),
                                    ),
                                  IconButton(
                                    padding: const EdgeInsetsDirectional.only(
                                        end: 1.0),
                                    icon: _isObsecured
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isObsecured = !_isObsecured;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              labelStyle: const TextStyle(fontSize: 14.0),
                              border: GradientOutlineInputBorder(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff7762FF),
                                    Color(0xffC589E4),
                                    Color(0xffFC6590),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Password',
                            ),
                            validator: (name) {
                              if (name!.length < 1) {
                                return '';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(fontSize: 22.0),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => const forget()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                              ),
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              isLoading(true);
                              _signInWithEmailAndPassword();
                              // Navigator.push(
                              //   context,
                              //   CupertinoPageRoute(
                              //       builder: (context) => homePage()),
                              // );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(180, 56),
                            backgroundColor: Color(0xff6958D6),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white, // Set the font color to red
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveUserSignUpState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedUp', true);
  }
}
