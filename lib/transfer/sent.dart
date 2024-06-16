import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:micro/gradient.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:micro/homePage/homePage.dart';

class sent extends StatefulWidget {
  static const routeName = '/sent';
  const sent({super.key});

  @override
  State<sent> createState() => _sentState();
}

class _sentState extends State<sent> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 35,
              left: 310,
              child: CloseButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => homePage()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ),
            Positioned(
              left: 20,
              top: 105,
              child: Image(
                image: AssetImage('Icons/transfer/sent.png'),
                width: 115,
                height: 115,
              ),
            ),
            Positioned(
              left: 20,
              top: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaction\nsuccessful',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GradientText(
                    text: "Your transaction is all done!",
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
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 375,
              left: 20,
              right: 20,
              child: Image(
                image: AssetImage('Icons/transfer/sentContainer.png'),
                width: 300,
                height: 350,
              ),
            ),
            Positioned(
              left: 100,
              top: 425,
              right: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      border: GradientBoxBorder(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff7762FF),
                            Color(0xffC589E4),
                            Color(0xffFC6590),
                          ],
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image(
                          image: AssetImage('Icons/transfer/user.png'),
                          width: 55,
                          height: 55,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  GradientText(
                    text: "Armia Romel",
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
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    '\$150',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
