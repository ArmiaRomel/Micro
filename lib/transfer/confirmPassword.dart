import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:micro/transfer/confirm.dart';

final RegExp uppercaseRegex = RegExp(r'[A-Z]');
final RegExp lowercaseRegex = RegExp(r'[a-z]');
final RegExp digitRegex = RegExp(r'[0-9]');
final RegExp specialCharRegex = RegExp(r'[\W_]+');

final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmPasswordController =
    TextEditingController();
bool _passwordsMatch = true;

class confirmPassword extends StatefulWidget {
  static const routeName = '/confirmPassword';
  const confirmPassword(
      {Key? Key,
      required this.userId,
      required this.userExists,
      required this.amount})
      : super(key: Key);

  final String userId, userExists, amount;

  @override
  State<confirmPassword> createState() => _confirmPasswordState();
}

class _confirmPasswordState extends State<confirmPassword> {
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

  Future<bool> checkUserPassword(String userId, String providedPassword) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(userId)
          .get();

      String storedPassword = userDoc.data()?['password'];
      return storedPassword == providedPassword;
    } catch (e) {
      print('Error checking password: $e');
      return false;
    }
  }

  void _showRetryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Password'),
          content: const Text('Your password is incorrect'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
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
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    const Image(
                      image: AssetImage('Icons/forgetPassword.png'),
                      width: 115,
                      height: 115,
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Enter your password',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 60),
                    SizedBox(
                      height: 64,
                      width: 310,
                      child: TextFormField(
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
                              if (_password.length < 1)
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                                            'Please enter your password',
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
                                padding:
                                    const EdgeInsetsDirectional.only(end: 1.0),
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
                          if (name!.length < 1) {
                            return '';
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(fontSize: 22.0),
                      ),
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      height: 64,
                      width: 310,
                      child: TextFormField(
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
                              if (_conformPassword != _passwordController.text)
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                                padding:
                                    const EdgeInsetsDirectional.only(end: 1.0),
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(fontSize: 22.0),
                      ),
                    ),
                    const SizedBox(height: 70),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              bool isPasswordCorrect = await checkUserPassword(
                                  widget.userId, _passwordController.text);

                              if (isPasswordCorrect) {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => confirm(
                                            userId: widget.userId,
                                            userExists: widget.userExists,
                                            amount: widget.amount,
                                          )),
                                );
                              } else {
                                _showRetryDialog();
                              }
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
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
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
        ),
      ),
    );
  }
}
