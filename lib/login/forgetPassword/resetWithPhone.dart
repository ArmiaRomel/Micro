import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:micro/gradient.dart';
import 'package:micro/login/forgetPassword/forget.dart';
import 'package:micro/login/forgetPassword/resetPassword.dart';

class resetWithPhone extends StatefulWidget {
  static const routeName = '/resetWithPhone';

  @override
  _resetWithPhoneState createState() => _resetWithPhoneState();
}

class _resetWithPhoneState extends State<resetWithPhone> {
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CloseButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const forget()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              ),
              const Image(
                image: AssetImage('Icons/verify.png'),
                width: 115,
                height: 115,
              ),
              const Text(
                'Verify Code',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const GradientText(
                text: 'Please enter authorization code sent on your Phone',
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
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    height: 68,
                    width: 64,
                    child: TextField(
                      controller: controllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: Theme.of(context).textTheme.headline6,
                      onChanged: (value) {
                        if (value.length == 1 && index < 4) {
                          FocusScope.of(context).nextFocus();
                          if (controllers[0].text.length == 1 &&
                              controllers[1].text.length == 1 &&
                              controllers[2].text.length == 1 &&
                              controllers[3].text.length == 1) {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const resetPassword()),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                        ),
                        child: const Text(
                          'Resend Code',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                        ),
                        child: const Text(
                          'Reset password with Email',
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
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
