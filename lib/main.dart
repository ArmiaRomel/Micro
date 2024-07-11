import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:micro/firebase_options.dart';
import 'package:email_otp/email_otp.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:micro/transfer/confirmPassword.dart';
import 'package:micro/transfer/confirm.dart';
import 'package:micro/transfer/sent.dart';
import 'package:micro/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  final isSignedUp = await checkUserSignUpState();
  runApp(CreateAccount(isSignedUp: isSignedUp));
}

Future<bool> checkUserSignUpState() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isSignedUp') ?? false;
}

Future<String?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId');
}

class CreateAccount extends StatelessWidget {
  final bool isSignedUp;

  const CreateAccount({Key? key, required this.isSignedUp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: transfer(),
      initialRoute: splashScreen.routeName,

      routes: {
        splashScreen.routeName: (context) => splashScreen(
              isSignedUp: isSignedUp,
            ),
        Login.routeName: (context) => Login(),
        forget.routeName: (context) => const forget(),
        resetWithPhone.routeName: (context) => const resetWithPhone(
              verificationId: '',
              userId: '',
            ),
        resetPassword.routeName: (context) => const resetPassword(userId: ''),
        Signup.routeName: (context) => const Signup(),
        verifyEmailV2.routeName: (context) => verifyEmailV2(
              email: '',
              password: '',
              myauth: EmailOTP(),
            ),
        verifyPhone.routeName: (context) => verifyPhone(
              verificationId: '',
              email: '',
              password: '',
            ),
        card.routeName: (context) => const card(
              userID: '',
            ),
        linkCard.routeName: (context) => const linkCard(
              userID: '',
            ),
        cardInfo.routeName: (context) => const cardInfo(
              userID: '',
            ),
        homePage.routeName: (context) => const homePage(
              userId: '',
            ),
        transfer.routeName: (context) => const transfer(
              userId: '',
            ),
        confirmPassword.routeName: (context) =>
            const confirmPassword(userId: '', userExists: '', amount: ''),
        confirm.routeName: (context) =>
            const confirm(userId: '', userExists: '', amount: ''),
        sent.routeName: (context) =>
            const sent(userId: '', name: '', amount: ''),
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