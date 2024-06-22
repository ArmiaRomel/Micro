import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:micro/gradient.dart';
// import 'package:flutter_local_auth_invisible/flutter_local_auth_invisible.dart';
import 'package:micro/signup/card.dart';

class verifyFinger extends StatefulWidget {
  @override
  _verifyFingerState createState() => _verifyFingerState();

  static const routeName = '/verifyFinger';
}

class _verifyFingerState extends State<verifyFinger> {
  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Not Authorized';

  @override
  void initState() {
    super.initState();
    _authenticateWithFingerprint();
  }

  Future<void> _authenticateWithFingerprint() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to access this feature',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 50,
          top: 73,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(
              image: AssetImage('Icons/verify.png'),
              width: 115,
              height: 115,
            ),
            const Text(
              'Set up Fingerprint',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const GradientText(
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
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('Icons/fingerID.png'),
                  width: 175,
                  height: 175,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _authorized,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
