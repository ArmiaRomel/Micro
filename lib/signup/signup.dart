import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:micro/gradient.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:micro/login/login.dart';
import 'package:micro/signup/verifyEmailV2.dart';
import 'package:email_otp/email_otp.dart';
// import 'package:device_preview/device_preview.dart';

final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
final RegExp uppercaseRegex = RegExp(r'[A-Z]');
final RegExp lowercaseRegex = RegExp(r'[a-z]');
final RegExp digitRegex = RegExp(r'[0-9]');
final RegExp specialCharRegex = RegExp(r'[\W_]+');

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> checkUserExists(String email, String phone) async {
    QuerySnapshot emailQuery = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    QuerySnapshot phoneQuery = await _firestore
        .collection('users')
        .where('phone', isEqualTo: phone)
        .get();

    if (emailQuery.docs.isNotEmpty || phoneQuery.docs.isNotEmpty) {
      return true;
    }
    return false;
  }
}

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

  final firstName = TextEditingController();
  final secondName = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  EmailOTP myauth = EmailOTP();

  bool isloading = false;

  @override
  void initState() {
    super.initState();

    _isObsecured = true;
  }

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

  final AuthService _authService = AuthService();

  Future<bool> signUp() async {
    bool userExists =
        await _authService.checkUserExists(email.text, phone.text);
    if (userExists) {
      isLoading(false);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('User already exists'),
          content:
              const Text('The email or phone number is already registered.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    print(screenheight);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: screenwidth / 14.4,
              right: screenwidth / 14.4,
            ),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenheight * 0.04213483146),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const Login()),
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
                  SizedBox(height: screenheight / 44.5),
                  Image(
                    image: const AssetImage('Icons/logo.png'),
                    width: screenwidth / 7.2,
                    height: screenheight / 14.24,
                  ),
                  SizedBox(height: screenheight / 44.5),
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
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenheight / 28.48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: screenheight / 11.125,
                            width: screenwidth / 2.4,
                            child: TextFormField(
                              controller: firstName,
                              onChanged: (value) {
                                setState(() {
                                  _firstName = value;
                                });
                              },
                              textAlign: TextAlign.center,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(fontSize: 14),
                                border: GradientOutlineInputBorder(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xff7762FF),
                                      Color(0xffC589E4),
                                      Color(0xffFC6590),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
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
                                                padding: EdgeInsets.all(
                                                    (screenheight / 67)),
                                                height:
                                                    screenheight * 0.1264044944,
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
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenheight / 11.125,
                        width: screenwidth / 2.4,
                        child: TextFormField(
                          controller: secondName,
                          onChanged: (value) {
                            setState(() {
                              _secondName = value;
                            });
                          },
                          textAlign: TextAlign.center,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(fontSize: 14),
                            border: GradientOutlineInputBorder(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xff7762FF),
                                  Color(0xffC589E4),
                                  Color(0xffFC6590),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
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
                                            padding: EdgeInsets.all(
                                                (screenheight / 67)),
                                            height: screenheight * 0.1264044944,
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
                          style: const TextStyle(fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenheight / 44.5),
                  SizedBox(
                    height: screenheight / 11.125,
                    width: screenwidth / 1.161290323,
                    child: TextFormField(
                      controller: phone,
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
                        labelStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        border: GradientOutlineInputBorder(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff7762FF),
                              Color(0xffC589E4),
                              Color(0xffFC6590),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Phone Number',
                        errorStyle: const TextStyle(fontSize: 0.0),
                        suffixIcon: _phone.length < 11
                            ? GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Container(
                                        padding:
                                            EdgeInsets.all((screenheight / 67)),
                                        height: screenheight * 0.1264044944,
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
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(height: screenheight / 44.5),
                  SizedBox(
                    height: screenheight / 11.125,
                    width: screenwidth / 1.161290323,
                    child: TextFormField(
                      controller: email,
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      textAlign: TextAlign.center,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        border: GradientOutlineInputBorder(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff7762FF),
                              Color(0xffC589E4),
                              Color(0xffFC6590),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Email',
                        errorStyle: const TextStyle(fontSize: 0.0),
                        suffixIcon: _email.length < 1
                            ? GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Container(
                                        padding:
                                            EdgeInsets.all((screenheight / 67)),
                                        height: screenheight * 0.1264044944,
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
                                            padding: EdgeInsets.all(
                                                (screenheight / 67)),
                                            height: screenheight * 0.1264044944,
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
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(height: screenheight / 44.5),
                  SizedBox(
                    height: screenheight / 11.125,
                    width: screenwidth / 1.161290323,
                    child: TextFormField(
                      controller: password,
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
                                        padding:
                                            EdgeInsets.all((screenheight / 67)),
                                        height: screenheight * 0.1264044944,
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
                                        padding:
                                            EdgeInsets.all((screenheight / 67)),
                                        height: screenheight * 0.1264044944,
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
                                        padding:
                                            EdgeInsets.all((screenheight / 67)),
                                        height: screenheight * 0.1264044944,
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
                                        padding:
                                            EdgeInsets.all((screenheight / 67)),
                                        height: screenheight * 0.1264044944,
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
                                        padding:
                                            EdgeInsets.all((screenheight / 67)),
                                        height: screenheight * 0.1264044944,
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
                        labelStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        border: GradientOutlineInputBorder(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff7762FF),
                              Color(0xffC589E4),
                              Color(0xffFC6590),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
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
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(height: screenheight / 20.34285714),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            isLoading(true);
                            Future<bool> check = signUp();
                            if (await check) {
                              myauth.setConfig(
                                  appEmail: "noreply@micro.com",
                                  appName: "Micro",
                                  userEmail: email.text,
                                  otpLength: 6,
                                  otpType: OTPType.digitsOnly);

                              if (await myauth.sendOTP() == true) {
                                isLoading(false);
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => verifyEmailV2(
                                            firstName: firstName.text,
                                            secondName: secondName.text,
                                            phone: phone.text,
                                            email: email.text,
                                            password: password.text,
                                            myauth: myauth,
                                          )),
                                );
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(screenwidth / 2, screenheight / 12.71428571),
                          backgroundColor: const Color(0xff6958D6),
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: (screenheight / 50.85714286),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenheight / 44.5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
