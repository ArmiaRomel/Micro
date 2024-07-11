import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:micro/gradient.dart';
import 'package:micro/login/forgetPassword/forget.dart';
import 'package:micro/login/forgetPassword/resetPassword.dart';

class resetWithPhone extends StatefulWidget {
  static const routeName = '/resetWithPhone';

  const resetWithPhone(
      {Key? key, required this.verificationId, required this.userId})
      : super(key: key);
  final String verificationId, userId;

  @override
  _resetWithPhoneState createState() => _resetWithPhoneState();
}

class _resetWithPhoneState extends State<resetWithPhone> {
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
  //   isLoading(false);
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
  //       Navigator.push(
  //       context,
  //       CupertinoPageRoute(
  //           builder: (context) => card(
  //               firstName: widget.firstName,
  //               secondName: widget.secondName,
  //               phone: widget.phone,
  //               email: widget.email,
  //               password: widget.password)),
  //     );
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

  Future<void> _checkAndAuthenticate(UserCredential value) async {
    bool isSupported = false;
    try {
      isSupported = await auth.isDeviceSupported();
    } on Exception catch (e) {
      print(e);
    }

    if (!isSupported) {
      isLoading(false);
      User? phoneUser = value.user!;
      String userId;
      if (phoneUser != null) {
        userId = phoneUser.uid;
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => resetPassword(
                    userId: widget.userId,
                  )),
        );
      }
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

    if (availableBiometrics.contains(BiometricType.weak)) {
      isLoading(false);
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
        isLoading(false);
        User? phoneUser = value.user;
        String userId;
        if (phoneUser != null) {
          userId = phoneUser.uid;
          Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => resetPassword(
                      userId: widget.userId,
                    )),
          );
        }
      }
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
                            builder: (context) => const forget()),
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
                              PhoneAuthCredential credential =
                                  await PhoneAuthProvider.credential(
                                      verificationId: widget.verificationId,
                                      smsCode: controllers
                                          .map((controller) => controller.text)
                                          .join());
                              isLoading(true);
                              FirebaseAuth.instance
                                  .signInWithCredential(credential)
                                  .then((value) {
                                isLoading(true);
                                _checkAndAuthenticate(value);
                              }).catchError((error) {
                                isLoading(false);
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
