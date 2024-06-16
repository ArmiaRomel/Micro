import 'package:flutter/material.dart';
import 'package:micro/signup/signup.dart';
import 'package:micro/signup/cardInfo.dart';
import 'package:micro/signup/card.dart';
import 'package:micro/signup/linkCard.dart';
import 'package:micro/signup/verifyEmailV2.dart';
import 'package:micro/signup/verifyPhone.dart';
import 'package:micro/login/login.dart';
import 'package:micro/login/forgetPassword/forget.dart';
import 'package:micro/login/forgetPassword/resetWithPhone.dart';
import 'package:micro/login/forgetPassword/resetPassword.dart';
import 'package:micro/homePage/homePage.dart';
import 'package:micro/transfer/transfer.dart';
import 'package:micro/transfer/transferFinger.dart';
import 'package:micro/transfer/transferFace.dart';
import 'package:micro/transfer/confirmPassword.dart';
import 'package:micro/transfer/confirm.dart';
import 'package:micro/transfer/sent.dart';

void main() {
  runApp(CreateAccount());
}

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: transfer(),
      initialRoute: transfer.routeName,
      routes: {
        Login.routeName: (context) => Login(),
        forget.routeName: (context) => forget(),
        resetWithPhone.routeName: (context) => resetWithPhone(),
        resetPassword.routeName: (context) => resetPassword(),
        Signup.routeName: (context) => Signup(),
        verifyEmailV2.routeName: (context) => verifyEmailV2(),
        verifyPhone.routeName: (context) => verifyPhone(),
        card.routeName: (context) => card(),
        linkCard.routeName: (context) => linkCard(),
        cardInfo.routeName: (context) => cardInfo(),
        homePage.routeName: (context) => homePage(),
        transfer.routeName: (context) => transfer(),
        confirmPassword.routeName: (context) => confirmPassword(),
        confirm.routeName: (context) => confirm(),
        sent.routeName: (context) => sent(),
      },
    );
  }
}
// cardInfo
// card
// Signup
// verifyEmailV2
// linkCard
// loginFace
// loginFinger
// Login
// forget
// resetPassword
// homePage
// transferFace
// transferFinger
// confirmPassword
// confirm
// sent