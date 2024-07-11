import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:micro/gradient.dart';
import 'package:micro/signup/signup.dart';
import 'package:micro/signup/verifyPhone.dart';
import 'package:email_otp/email_otp.dart';

var enteredOTP;

class verifyEmailV2 extends StatefulWidget {
  const verifyEmailV2(
      {Key? key,
      this.firstName,
      this.secondName,
      this.phone,
      this.email,
      this.password,
      required this.myauth})
      : super(key: key);

  final String? firstName;
  final String? secondName;
  final String? phone;
  final String? email;
  final String? password;
  final EmailOTP myauth;

  static const routeName = '/verifyEmailV2';

  @override
  _verifyEmailV2State createState() => _verifyEmailV2State();
}

class _verifyEmailV2State extends State<verifyEmailV2> {
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());

  void isLoading(bool isloading) {
    isloading
        ? showDialog(
            context: context,
            builder: (context) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Color(0xff7762FF),
                backgroundColor: Colors.grey,
              ));
            })
        : Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
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
                            builder: (context) => const Signup()),
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
                text: 'Please enter authorization code sent on your Email',
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
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    height: 68,
                    width: 40,
                    child: TextField(
                      controller: controllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: Theme.of(context).textTheme.headline6,
                      onChanged: (value) async {
                        if (value.length == 1) {
                          if (index < 5) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).unfocus();
                          }
                          if (controllers.every(
                              (controller) => controller.text.length == 1)) {
                            enteredOTP = controllers
                                .map((controller) => controller.text)
                                .join();
                            bool isVerified =
                                await widget.myauth.verifyOTP(otp: enteredOTP);

                            if (isVerified) {
                              isLoading(true);
                              String phoneNumber = '+2${widget.phone}';
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) {},
                                  verificationFailed:
                                      (FirebaseAuthException ex) {},
                                  codeSent: (String verificationId,
                                      int? resendtoken) {
                                    isLoading(false);
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => verifyPhone(
                                          firstName: widget.firstName,
                                          secondName: widget.secondName,
                                          phone: widget.phone,
                                          email: widget.email,
                                          password: widget.password,
                                          verificationId: verificationId,
                                        ),
                                      ),
                                    );
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verficationId) {},
                                  phoneNumber: phoneNumber);
                            }
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 130),
            ],
          ),
        ),
      ),
    );
  }
}
