import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:micro/gradient.dart';
import 'package:micro/signup/verifyPhone.dart';

class verifyEmail extends StatefulWidget {
  const verifyEmail({super.key});

  @override
  State<verifyEmail> createState() => _verifyEmailState();
}

class _verifyEmailState extends State<verifyEmail> {
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());

  final TextEditingController _pinController1 = TextEditingController();
  final TextEditingController _pinController2 = TextEditingController();
  final TextEditingController _pinController3 = TextEditingController();
  final TextEditingController _pinController4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 25,
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
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Image(
                image: AssetImage('Icons/verify.png'),
                width: 115,
                height: 115,
              ),
              Text(
                'Verify Code',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GradientText(
                text: 'Please enter authorization code sent on your email',
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
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextFormField(
                      controller: _pinController1,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextFormField(
                      controller: _pinController2,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextFormField(
                      controller: _pinController3,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 68,
                    width: 64,
                    child: TextFormField(
                      controller: _pinController4,
                      onChanged: (value) {
                        (value) {
                          if (value.length == 1) {
                            if (_pinController1.text.length == 1 &&
                                _pinController2.text.length == 1 &&
                                _pinController3.text.length == 1 &&
                                _pinController4.text.length == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => verifyPhone()),
                              );
                            }
                          }
                        };
                      },
                      style: Theme.of(context).textTheme.headline6,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                    ),
                    child: Text(
                      'Resend Code',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// @override
// Widget OtpForm(BuildContext context) {
//   return Form(
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         SizedBox(
//           height: 68,
//           width: 64,
//           child: TextFormField(
//             onChanged: (value) {
//               if (value.length == 1) {
//                 FocusScope.of(context).nextFocus();
//               }
//             },
//             style: Theme.of(context).textTheme.headline6,
//             keyboardType: TextInputType.number,
//             textAlign: TextAlign.center,
//             inputFormatters: [
//               LengthLimitingTextInputFormatter(1),
//               FilteringTextInputFormatter.digitsOnly,
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 68,
//           width: 64,
//           child: TextFormField(
//             onChanged: (value) {
//               if (value.length == 1) {
//                 FocusScope.of(context).nextFocus();
//               }
//             },
//             style: Theme.of(context).textTheme.headline6,
//             keyboardType: TextInputType.number,
//             textAlign: TextAlign.center,
//             inputFormatters: [
//               LengthLimitingTextInputFormatter(1),
//               FilteringTextInputFormatter.digitsOnly,
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 68,
//           width: 64,
//           child: TextFormField(
//             onChanged: (value) {
//               if (value.length == 1) {
//                 FocusScope.of(context).nextFocus();
//               }
//             },
//             style: Theme.of(context).textTheme.headline6,
//             keyboardType: TextInputType.number,
//             textAlign: TextAlign.center,
//             inputFormatters: [
//               LengthLimitingTextInputFormatter(1),
//               FilteringTextInputFormatter.digitsOnly,
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 68,
//           width: 64,
//           child: TextFormField(
//             onChanged: (value) {
//               if (value.length == 1) {
//                 FocusScope.of(context).nextFocus();
//               }
//             },
//             style: Theme.of(context).textTheme.headline6,
//             keyboardType: TextInputType.number,
//             textAlign: TextAlign.center,
//             inputFormatters: [
//               LengthLimitingTextInputFormatter(1),
//               FilteringTextInputFormatter.digitsOnly,
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }