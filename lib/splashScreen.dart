import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:micro/login/login.dart';
import 'package:micro/signup/signup.dart';
import 'package:micro/homePage/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key, required this.isSignedUp});

  final bool isSignedUp;

  static const routeName = '/splashScreen';

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    _goHome();
    super.initState();
  }

  _goHome() async {
    if (widget.isSignedUp) {
      _checkAndAuthenticate();
    } else {
      await Future.delayed(const Duration(milliseconds: 4000), () {});
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => const Signup()),
      );
    }
  }

  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;

  Future<void> _checkAndAuthenticate() async {
    bool authenticated = false;
    _isAuthenticating = false;

    bool isSupported = false;
    try {
      isSupported = await auth.isDeviceSupported();
    } on Exception catch (e) {
      print(e);
    }

    if (!isSupported) {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => const Login()),
      );
    }

    while (!authenticated && !_isAuthenticating) {
      setState(() {
        _isAuthenticating = true;
      });
      try {
        authenticated = await auth.authenticate(
          localizedReason: 'Insert your fingerprint',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
      } on PlatformException catch (e) {
        print(e);
        _showRetryDialog();
        return;
      }

      if (!mounted) return;

      if (authenticated) {
        setState(() {
          _isAuthenticating = false;
        });
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => FutureBuilder<String>(
              future: getUserId(),
              builder: (context, snapshot) {
                return homePage(userId: snapshot.data!);
              },
            ),
          ),
        );
      } else {
        _showRetryDialog();
      }
    }
  }

  void _showRetryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Authentication Failed'),
          content: const Text(
              'Try to insert your fingerprint again or sign in with email'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _checkAndAuthenticate();
              },
              child: const Text('Retry'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => const Login()),
                );
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId == null) {
      throw Exception('User ID not found in SharedPreferences');
    }

    return userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff7762FF),
              Color(0xffC589E4),
              Color(0xffFC6590),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Micro',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
