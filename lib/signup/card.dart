import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:micro/signup/linkCard.dart';

class card extends StatefulWidget {
  static const routeName = '/card';

  @override
  _cardState createState() => _cardState();
}

class _cardState extends State<card> {
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
            bottom: 25,
            top: 25,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('Icons/card.png'),
                width: 300,
                height: 250,
              ),
              Text(
                'Link your card',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => linkCard()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(180, 56),
                      backgroundColor: Color(0xff6958D6),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white, // Set the font color to red
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
