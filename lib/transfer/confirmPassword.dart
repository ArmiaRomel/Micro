import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  const confirmPassword({Key? Key}) : super(key: Key);

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
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    Image(
                      image: AssetImage('Icons/forgetPassword.png'),
                      width: 115,
                      height: 115,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Enter your password',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 60),
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
                          errorStyle: TextStyle(fontSize: 0.0),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_password.length < 1)
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                                  child: Icon(Icons.info),
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                    SizedBox(height: 35),
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
                          errorStyle: TextStyle(fontSize: 0.0),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_conformPassword != _passwordController.text)
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                                  child: Icon(Icons.info),
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
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                    SizedBox(height: 70),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => confirm()),
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
