import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:micro/gradient.dart';
import 'package:local_auth/local_auth.dart';

class verifyFinger extends StatefulWidget {
  @override
  _verifyFingerState createState() => _verifyFingerState();

  static const routeName = '/verifyFinger';
}

class _verifyFingerState extends State<verifyFinger> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _authenticateWithFaceID();
  }

  Future<void> _authenticateWithFaceID() async {
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
      // Navigator.push(
      //   context,
      //   CupertinoPageRoute(builder: (context) => card()),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 50,
          top: 73,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage('Icons/verify.png'),
              width: 115,
              height: 115,
            ),
            Text(
              'Set up Fingerprint',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            GradientText(
              text: 'Please authenticate your fingerprint',
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
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('Icons/fingerID.png'),
                  width: 175,
                  height: 175,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
