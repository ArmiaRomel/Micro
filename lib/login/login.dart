import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: EdgeInsets.only(
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
                                  builder: (context) => Signup()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                          ),
                          child: Text(
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
                    Column(
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
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                            textAlign: TextAlign.center,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 14.0),
                              border: GradientOutlineInputBorder(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff7762FF),
                                    Color(0xffC589E4),
                                    Color(0xffFC6590),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Email',
                              errorStyle: TextStyle(fontSize: 0.0),
                              suffixIcon: _email.length < 1
                                  ? GestureDetector(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Container(
                                              padding: EdgeInsets.all(16),
                                              height: 90,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFC72C41),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                              child: Text(
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
                                      child: Icon(Icons.info),
                                    )
                                  : !emailRegex.hasMatch(_email)
                                      ? GestureDetector(
                                          onTap: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Container(
                                                  padding: EdgeInsets.all(16),
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFC72C41),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                  ),
                                                  child: Text(
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
                                          child: Icon(Icons.info),
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
                            style: TextStyle(fontSize: 22.0),
                          ),
                        ),
                        SizedBox(height: 25),
                        SizedBox(
                          height: 64,
                          width: 310,
                          child: TextFormField(
                            key: ValueKey('login_password'),
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                            textAlign: TextAlign.center,
                            obscureText: _isObsecured,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 0.0),
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
                                              padding: EdgeInsets.all(16),
                                              height: 90,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFC72C41),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                              child: Text(
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
                              labelStyle: TextStyle(fontSize: 14.0),
                              border: GradientOutlineInputBorder(
                                gradient: LinearGradient(
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
                            style: TextStyle(fontSize: 22.0),
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
                                      builder: (context) => forget()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                              ),
                              child: Text(
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
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => homePage()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(180, 56),
                            backgroundColor: Color(0xff6958D6),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white, // Set the font color to red
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
