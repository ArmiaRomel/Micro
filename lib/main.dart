import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:micro/firebase_options.dart';
import 'package:email_otp/email_otp.dart';
import 'package:micro/signup/signup.dart';
import 'package:micro/signup/verifyFace.dart';
import 'package:micro/signup/verifyFinger.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CreateAccount());
}

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: transfer(),
      initialRoute: Signup.routeName,
      routes: {
        Login.routeName: (context) => const Login(),
        forget.routeName: (context) => const forget(),
        resetWithPhone.routeName: (context) => resetWithPhone(),
        resetPassword.routeName: (context) => const resetPassword(),
        Signup.routeName: (context) => const Signup(),
        verifyEmailV2.routeName: (context) => verifyEmailV2(
              myauth: EmailOTP(),
            ),
        verifyPhone.routeName: (context) => verifyPhone(verificationId: ''),
        card.routeName: (context) => card(),
        linkCard.routeName: (context) => linkCard(),
        cardInfo.routeName: (context) => const cardInfo(),
        homePage.routeName: (context) => homePage(),
        transfer.routeName: (context) => const transfer(),
        confirmPassword.routeName: (context) => const confirmPassword(),
        confirm.routeName: (context) => const confirm(),
        sent.routeName: (context) => const sent(),
        verifyFace.routeName: (context) => verifyFace(),
        verifyFinger.routeName: (context) => verifyFinger(),
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