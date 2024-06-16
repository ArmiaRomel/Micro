import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:micro/gradient.dart';
import 'package:micro/login/login.dart';
import 'package:gradient_borders/gradient_borders.dart';

final RegExp uppercaseRegex = RegExp(r'[A-Z]');
final RegExp lowercaseRegex = RegExp(r'[a-z]');
final RegExp digitRegex = RegExp(r'[0-9]');
final RegExp specialCharRegex = RegExp(r'[\W_]+');

final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmPasswordController =
    TextEditingController();
bool _passwordsMatch = true;

class resetPassword extends StatefulWidget {
  static const routeName = '/resetPassword';
  const resetPassword({Key? Key}) : super(key: Key);

  @override
  State<resetPassword> createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  final _formkey = GlobalKey<FormState>();
  var _isObsecuredf;
  var _isObsecureds;
  String _password = '', _conformPassword = '';

  @override
  void initState() {
    super.initState();

    _isObsecuredf = true;
    _isObsecureds = true;
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
                top: 25,
                bottom: 50,
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CloseButton(
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const Login()),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ),
                      ],
                    ),
                    const Image(
                      image: AssetImage('Icons/resetPassword.png'),
                      width: 115,
                      height: 115,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Forget your password?',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GradientText(
                          text: "Enter your phone number to reset password",
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
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        SizedBox(
                          height: 64,
                          width: 310,
                          child: TextFormField(
                            key: const ValueKey('resetPassword_password'),
                            controller: _passwordController,
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                            textAlign: TextAlign.center,
                            obscureText: _isObsecuredf,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(fontSize: 0.0),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (_password.length < 8)
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
                                                'Password should not be less than 8 characters',
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
                                  else if (!uppercaseRegex.hasMatch(_password))
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
                                                'Password must contain at least one uppercase letter',
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
                                  else if (!lowercaseRegex.hasMatch(_password))
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
                                                'Password must contain at least one lowercase letter',
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
                                  else if (!digitRegex.hasMatch(_password))
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
                                                'Password must contain at least one digit',
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
                                  else if (!specialCharRegex
                                      .hasMatch(_password))
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
                                                'Password must contain at least one special character',
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
                                    ),
                                  IconButton(
                                    padding: const EdgeInsetsDirectional.only(
                                        end: 1.0),
                                    icon: _isObsecuredf
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isObsecuredf = !_isObsecuredf;
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
                              if (name!.length < 8 ||
                                  !uppercaseRegex.hasMatch(_password) ||
                                  !lowercaseRegex.hasMatch(_password) ||
                                  !digitRegex.hasMatch(_password) ||
                                  !specialCharRegex.hasMatch(_password)) {
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
                        const SizedBox(height: 25),
                        SizedBox(
                          height: 64,
                          width: 310,
                          child: TextFormField(
                            key:
                                const ValueKey('resetPassword_confirmPassword'),
                            controller: _confirmPasswordController,
                            onChanged: (value) {
                              setState(() {
                                _conformPassword = value;
                                _passwordsMatch = _passwordController.text ==
                                    _confirmPasswordController.text;
                              });
                            },
                            textAlign: TextAlign.center,
                            obscureText: _isObsecureds,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(fontSize: 0.0),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (_conformPassword !=
                                      _passwordController.text)
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
                                                'Passwords do not match',
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
                                    ),
                                  IconButton(
                                    padding: const EdgeInsetsDirectional.only(
                                        end: 1.0),
                                    icon: _isObsecureds
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isObsecureds = !_isObsecureds;
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
                              labelText: 'Confirm Password',
                            ),
                            validator: (name) {
                              if (name != _passwordController.text ||
                                  name!.length < 1) {
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
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const Login()),
                                (Route<dynamic> route) => false,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(180, 56),
                            backgroundColor: const Color(0xff6958D6),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          child: const Text(
                            'Sign in',
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
}
