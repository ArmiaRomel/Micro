import 'package:flutter/material.dart';
import 'package:micro/gradient.dart';

class transferFinger extends StatefulWidget {
  const transferFinger({super.key});

  @override
  State<transferFinger> createState() => _transferFingerState();
}

class _transferFingerState extends State<transferFinger> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(
            left: 25,
            right: 25,
            top: 175,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Insert your fingerprint',
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
                ],
              ),
              SizedBox(height: 100),
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
      ),
    );
  }
}
