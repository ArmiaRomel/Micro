import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:micro/transfer/sent.dart';
import 'package:micro/transfer/transfer.dart';

class confirm extends StatefulWidget {
  static const routeName = '/confirm';
  const confirm({Key? Key}) : super(key: Key);

  @override
  State<confirm> createState() => _confirmState();
}

class _confirmState extends State<confirm> {
  static final int cardNumber = 1170117011701170;
  final String _maskedCardNumber = maskCardNumber('$cardNumber');
  final int _walletID = 588476312;
  final String _phoneNumber = '0661287111';
  final String _receiverName = 'Armia Romel';
  final double _amount = 150;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            left: 25,
            right: 25,
            top: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 64,
                width: 310,
                child: TextFormField(
                  controller: TextEditingController(text: _maskedCardNumber),
                  enabled: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 14.0, color: Colors.black),
                    border: GradientOutlineInputBorder(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff7762FF),
                          Color(0xffC589E4),
                          Color(0xffFC6590),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Card number',
                  ),
                  style: TextStyle(fontSize: 22.0, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 64,
                width: 310,
                child: TextFormField(
                  controller: TextEditingController(text: '$_walletID'),
                  enabled: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 14.0, color: Colors.black),
                    border: GradientOutlineInputBorder(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff7762FF),
                          Color(0xffC589E4),
                          Color(0xffFC6590),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Receiver's wallet ID",
                  ),
                  style: TextStyle(fontSize: 22.0, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 64,
                width: 310,
                child: TextFormField(
                  controller: TextEditingController(text: _phoneNumber),
                  enabled: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 14.0, color: Colors.black),
                    border: GradientOutlineInputBorder(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff7762FF),
                          Color(0xffC589E4),
                          Color(0xffFC6590),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Phone number',
                  ),
                  style: TextStyle(fontSize: 22.0, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 64,
                width: 310,
                child: TextFormField(
                  controller: TextEditingController(text: _receiverName),
                  enabled: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 14.0, color: Colors.black),
                    border: GradientOutlineInputBorder(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff7762FF),
                          Color(0xffC589E4),
                          Color(0xffFC6590),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Receiver's name",
                  ),
                  style: TextStyle(fontSize: 22.0, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 64,
                width: 310,
                child: TextFormField(
                  controller: TextEditingController(text: '$_amount'),
                  enabled: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 14.0, color: Colors.black),
                    border: GradientOutlineInputBorder(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff7762FF),
                          Color(0xffC589E4),
                          Color(0xffFC6590),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Amount',
                  ),
                  style: TextStyle(fontSize: 22.0, color: Colors.black),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(builder: (context) => transfer()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(135, 56),
                      backgroundColor: Color(0xff6958D6),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white, // Set the font color to red
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => sent()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(135, 56),
                      backgroundColor: Color(0xff6958D6),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    child: Text(
                      'Send',
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

String maskCardNumber(String cardNumber) {
  String sanitizedCardNumber = cardNumber.replaceAll(' ', '');

  if (sanitizedCardNumber.length < 4) {
    return sanitizedCardNumber;
  }

  String firstFour = sanitizedCardNumber.substring(0, 4);
  String lastFour =
      sanitizedCardNumber.substring(sanitizedCardNumber.length - 4);

  String maskedString = firstFour + ' **** **** ' + lastFour;

  return maskedString;
}
