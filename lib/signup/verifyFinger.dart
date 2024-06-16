import 'package:flutter/material.dart';
import 'package:micro/gradient.dart';

class verifyFinger extends StatefulWidget {
  @override
  _verifyFingerState createState() => _verifyFingerState();
}

class _verifyFingerState extends State<verifyFinger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
