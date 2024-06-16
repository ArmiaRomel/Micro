import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:micro/gradient.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:micro/login/login.dart';
import 'package:micro/login/forgetPassword/resetWithPhone.dart';

final _formkey = GlobalKey<FormState>();

class forget extends StatefulWidget {
  static const routeName = '/forget';
  const forget({Key? Key}) : super(key: Key);

  @override
  State<forget> createState() => _forgetState();
}

class _forgetState extends State<forget> {
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
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
                  image: AssetImage('Icons/forgetPassword.png'),
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
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => resetWithPhone()),
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
                        'Next',
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
    );
  }
}
