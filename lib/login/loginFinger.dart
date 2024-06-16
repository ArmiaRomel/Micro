import 'package:flutter/material.dart';
import 'package:micro/gradient.dart';
import 'package:micro/login/login.dart';

class loginFinger extends StatefulWidget {
  const loginFinger({super.key});

  @override
  State<loginFinger> createState() => _loginFingerState();
}

class _loginFingerState extends State<loginFinger> {
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
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Column(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                    ),
                    child: const Text(
                      'Sign In With Email',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
