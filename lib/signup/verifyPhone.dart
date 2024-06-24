import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:micro/gradient.dart';
import 'package:micro/signup/signup.dart';
import 'package:micro/signup/card.dart';
import 'package:micro/signup/verifyFace.dart';
import 'package:micro/signup/verifyFinger.dart';

class verifyPhone extends StatefulWidget {
  const verifyPhone({
    Key? key,
    this.firstName,
    this.secondName,
    this.phone,
    this.email,
    this.password,
    required this.verificationId,
  }) : super(key: key);

  final String? firstName;
  final String? secondName;
  final String? phone;
  final String? email;
  final String? password;
  final String verificationId;

  static const routeName = '/verifyEmailV2';

  @override
  _verifyPhoneState createState() => _verifyPhoneState();
}

class _verifyPhoneState extends State<verifyPhone> {
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());

  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;

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

  // Future<void> _checkAndAuthenticate() async {
  //   bool authenticated = false;
  //   _isAuthenticating = false;
  //   while (!authenticated && !_isAuthenticating) {
  //     setState(() {
  //       _isAuthenticating = true;
  //     });
  //     try {
  //       authenticated = await auth.authenticate(
  //         localizedReason: 'Look at the camira',
  //         options: const AuthenticationOptions(
  //           stickyAuth: true,
  //           biometricOnly: true,
  //         ),
  //       );
  //     } on PlatformException catch (e) {
  //       print(e);
  //       _showRetryDialog();
  //       return;
  //     }

  //     if (!mounted) return;

  //     if (authenticated) {
  //       setState(() {
  //         _isAuthenticating = false;
  //       });
  //       Navigator.pushReplacement(
  //         context,
  //         CupertinoPageRoute(builder: (context) => card()),
  //       );
  //     } else {
  //       _showRetryDialog();
  //     }
  //   }
  // }

  // void _showRetryDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Authentication Failed'),
  //         content: const Text('Face ID not recognized. Try again?'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               _checkAndAuthenticate();
  //             },
  //             child: const Text('Retry'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               setState(() {
  //                 _isAuthenticating = false;
  //               });
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<void> _checkAndAuthenticate() async {
    bool isSupported = false;
    try {
      isSupported = await auth.isDeviceSupported();
    } on Exception catch (e) {
      print(e);
    }

    if (!isSupported) {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => card()),
      );
    }

    List<BiometricType> availableBiometrics = [];
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
      print('Available biometrics: $availableBiometrics');
    } on Exception catch (e) {
      print(e);
    }

    if (!mounted) {
      return;
    }

    // if (availableBiometrics.contains(BiometricType.weak)) {
    //   Navigator.push(
    //     context,
    //     CupertinoPageRoute(builder: (context) => verifyFace()),
    //   );
    // }
    if (availableBiometrics.contains(BiometricType.weak)) {
      bool authenticated = false;
      try {
        authenticated = await auth.authenticate(
          localizedReason: 'Insert your fingerprint',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
      } on Exception catch (e) {
        print(e);
      }
      if (!mounted) return;

      if (authenticated) {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => card()),
        );
      }
    } else {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => card()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 25,
            top: 25,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            builder: (context) => const Signup()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              ),
              const Image(
                image: AssetImage('Icons/verify.png'),
                width: 115,
                height: 115,
              ),
              const Text(
                'Verify Code',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const GradientText(
                text: 'Please enter authorization code sent on your Phone',
                gradient: LinearGradient(
                  colors: [
                    Color(0xff7762FF),
                    Color(0xffC589E4),
                    Color(0xffFC6590)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    height: 68,
                    width: 40,
                    child: TextField(
                      controller: controllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: Theme.of(context).textTheme.headline6,
                      onChanged: (value) async {
                        if (value.length == 1) {
                          if (index < 5) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).unfocus();
                          }
                          if (controllers.every(
                              (controller) => controller.text.length == 1)) {
                            try {
                              isLoading(true);
                              PhoneAuthCredential credential =
                                  await PhoneAuthProvider.credential(
                                      verificationId: widget.verificationId,
                                      smsCode: controllers
                                          .map((controller) => controller.text)
                                          .join());
                              isLoading(false);
                              FirebaseAuth.instance
                                  .signInWithCredential(credential)
                                  .then((value) {
                                _checkAndAuthenticate();
                              });
                            } catch (ex) {}
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                    ),
                    child: const Text(
                      'Resend Code',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
