import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:micro/gradient.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:micro/login/login.dart';
import 'package:micro/signup/verifyEmailV2.dart';

final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
final RegExp uppercaseRegex = RegExp(r'[A-Z]');
final RegExp lowercaseRegex = RegExp(r'[a-z]');
final RegExp digitRegex = RegExp(r'[0-9]');
final RegExp specialCharRegex = RegExp(r'[\W_]+');

class Signup extends StatefulWidget {
  const Signup({Key? Key}) : super(key: Key);
  static const routeName = '/signup';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formkey = GlobalKey<FormState>();
  var _isObsecured;
  String _firstName = '',
      _secondName = '',
      _phone = '',
      _email = '',
      _password = '';

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
          child: Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(builder: (context) => Login()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Image(
                    image: AssetImage('Icons/logo.png'),
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Welcome To Micro',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(height: 16),
                  const GradientText(
                    text: 'Create an account to join Micro!',
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
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 64,
                            width: 150,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _firstName = value;
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
                                labelText: 'First Name',
                                errorStyle: const TextStyle(fontSize: 0.0),
                                suffixIcon: _firstName.length < 3
                                    ? GestureDetector(
                                        onTap: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                height: 90,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFC72C41),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                ),
                                                child: const Text(
                                                  'First name should not be less than 3 characters',
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
                                if (name!.length < 3) {
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
                        ],
                      ),
                      SizedBox(
                        height: 64,
                        width: 150,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              _secondName = value;
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
                            labelText: 'Last Name',
                            errorStyle: const TextStyle(fontSize: 0.0),
                            suffixIcon: _secondName.length < 3
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
                                              'Last name should not be less than 3 characters',
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
                                : null,
                          ),
                          validator: (name) {
                            if (name!.length < 3) {
                              return '';
                            } else {
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: const TextStyle(fontSize: 22.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 64,
                    width: 310,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _phone = value;
                        });
                      },
                      textAlign: TextAlign.center,
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
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
                        labelText: 'Phone Number',
                        errorStyle: const TextStyle(fontSize: 0.0),
                        suffixIcon: _phone.length < 11
                            ? GestureDetector(
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
                                          'Phone number should not be less than 11 numbers',
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
                            : null,
                      ),
                      validator: (name) {
                        if (name!.length < 11) {
                          return '';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(fontSize: 22.0),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                                            padding: const EdgeInsets.all(16),
                                            height: 90,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFC72C41),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            child: const Text(
                                              'Invalid email format',
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(fontSize: 22.0),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 64,
                    width: 310,
                    child: TextFormField(
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
                            if (_password.length < 8)
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
                            else if (!specialCharRegex.hasMatch(_password))
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
                              padding:
                                  const EdgeInsetsDirectional.only(end: 1.0),
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(fontSize: 22.0),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => verifyEmailV2()),
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
                          'Create Account',
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
    );
  }
}
