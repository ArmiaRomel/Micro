import 'package:flutter/material.dart';
import 'package:micro/gradient.dart';
// import 'package:flutter_local_auth_invisible/flutter_local_auth_invisible.dart';

class verifyFace extends StatefulWidget {
  @override
  _verifyFaceState createState() => _verifyFaceState();

  static const routeName = '/verifyFace';
}

class _verifyFaceState extends State<verifyFace> {
  // final LocalAuthentication auth = LocalAuthentication();
  // String _authorized = 'Not Authorized';

  // @override
  // void initState() {
  //   super.initState();
  //   _authenticateWithFaceID();
  // }

  // Future<void> _authenticateWithFaceID() async {
  //   bool authenticated = false;
  //   try {
  //     authenticated = await LocalAuthentication.authenticate(
  //       localizedReason: 'Please authenticate to access this feature',
  //       biometricOnly: true,
  //     );
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  //   if (!mounted) return;

  //   setState(() {
  //     _authorized = authenticated ? 'Authorized' : 'Not Authorized';
  //   });

  //   if (!authenticated) {
  //     Navigator.pop(context, false); // Navigate back with failure
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 125,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Set up Face ID',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GradientText(
                  text: 'Please authenticate your face ID',
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
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('Icons/faceID.png'),
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
