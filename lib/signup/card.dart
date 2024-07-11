import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:micro/signup/linkCard.dart';

class card extends StatefulWidget {
  const card(
      {Key? Key,
      this.firstName,
      this.secondName,
      this.phone,
      this.email,
      this.password,
      required this.userID})
      : super(key: Key);

  final String? firstName;
  final String? secondName;
  final String? phone;
  final String? email;
  final String? password;
  final String userID;

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
              const Image(
                image: AssetImage('Icons/card.png'),
                width: 300,
                height: 250,
              ),
              const Text(
                'Link your card',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => linkCard(
                                  firstName: widget.firstName,
                                  secondName: widget.secondName,
                                  phone: widget.phone,
                                  email: widget.email,
                                  password: widget.password,
                                  userID: widget.userID,
                                )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(180, 56),
                      backgroundColor: const Color(0xff6958D6),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    child: const Text(
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
