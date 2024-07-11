import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:micro/gradient.dart';

class verifyFace extends StatefulWidget {
  @override
  _verifyFaceState createState() => _verifyFaceState();

  static const routeName = '/verifyFace';
}

class _verifyFaceState extends State<verifyFace> {
  static const platform = MethodChannel('com.example.micro/biometric');
  String _authorized = 'Not Authorized';

  @override
  void initState() {
    super.initState();
    _authenticateWithFaceID();
  }

  Future<void> _authenticateWithFaceID() async {
    String authorized;
    try {
      final bool result = await platform.invokeMethod('authenticateWithFace');
      authorized = result ? 'Authorized' : 'Not Authorized';
    } on PlatformException catch (e) {
      authorized = "Failed to authenticate: '${e.message}'.";
    }
    setState(() {
      _authorized = authorized;
    });
  }

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
