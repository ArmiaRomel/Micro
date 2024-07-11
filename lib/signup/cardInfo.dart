import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:micro/homePage/homePage.dart';

class cardInfo extends StatefulWidget {
  const cardInfo(
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

  static const routeName = '/cardInfo';

  @override
  _cardInfoState createState() => _cardInfoState();
}

class _cardInfoState extends State<cardInfo> {
  String _cardNumber = '';
  String _expiryDate = '';
  String _cardHolderName = '';
  String _cvvCode = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  int generateRandomNumber(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  'Link your card',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CreditCardWidget(
                cardNumber: _cardNumber,
                expiryDate: _expiryDate,
                cardHolderName: _cardHolderName,
                cvvCode: _cvvCode,
                showBackView: isCvvFocused,
                onCreditCardWidgetChange: (CreditCardBrand brand) {},
                obscureCardNumber: false,
                obscureCardCvv: false,
                backgroundImage: 'Icons/creditCard.png',
                // labelCardHolder: 'CARD HOLDER',
                isHolderNameVisible: true,
                isChipVisible: true,
                chipColor: Color(0xFFE9C595),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    CreditCardForm(
                      cardNumber: _cardNumber,
                      expiryDate: _expiryDate,
                      cardHolderName: _cardHolderName,
                      cvvCode: _cvvCode,
                      onCreditCardModelChange: onCreditCardModelChange,
                      formKey: formKey,
                      cardNumberValidator: (_cardNumber) {
                        if (_cardNumber!.length < 16) {
                          return '';
                        } else {
                          return null;
                        }
                      },
                      expiryDateValidator: (_expiryDate) {
                        if (_expiryDate!.length < 5) {
                          return '';
                        } else {
                          return null;
                        }
                      },
                      cvvValidator: (_cvvCode) {
                        if (_cvvCode!.length < 3) {
                          return '';
                        } else {
                          return null;
                        }
                      },
                      cardHolderValidator: (_cardHolderName) {
                        if (_cardHolderName!.length < 1) {
                          return '';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputConfiguration: InputConfiguration(
                        cardNumberDecoration: InputDecoration(
                          labelStyle: const TextStyle(fontSize: 12.5),
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          border: GradientOutlineInputBorder(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff7762FF),
                                Color(0xffC589E4),
                                Color(0xffFC6590),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          errorStyle: const TextStyle(fontSize: 0.0),
                          suffixIcon: _cardNumber.length < 16
                              ? GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Container(
                                          padding: const EdgeInsets.all(16),
                                          height: 90,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFC72C41),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          child: const Text(
                                            'Please input valid number',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.info),
                                )
                              : null,
                        ),
                        expiryDateDecoration: InputDecoration(
                          labelStyle: const TextStyle(fontSize: 12.5),
                          labelText: 'Expired Date',
                          hintText: 'xx/xx',
                          border: GradientOutlineInputBorder(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff7762FF),
                                Color(0xffC589E4),
                                Color(0xffFC6590),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          errorStyle: const TextStyle(fontSize: 0.0),
                          suffixIcon: _expiryDate.length < 5
                              ? GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Container(
                                          padding: const EdgeInsets.all(16),
                                          height: 90,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFC72C41),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          child: const Text(
                                            'Please input valid date',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.info),
                                )
                              : null,
                        ),
                        cvvCodeDecoration: InputDecoration(
                          labelStyle: const TextStyle(fontSize: 12.5),
                          labelText: 'CVV',
                          hintText: 'xxx',
                          border: GradientOutlineInputBorder(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff7762FF),
                                Color(0xffC589E4),
                                Color(0xffFC6590),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          errorStyle: const TextStyle(fontSize: 0.0),
                          suffixIcon: _cvvCode.length < 3
                              ? GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Container(
                                          padding: const EdgeInsets.all(16),
                                          height: 90,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFC72C41),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          child: const Text(
                                            'Please input valid CVV',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.info),
                                )
                              : null,
                        ),
                        cardHolderDecoration: InputDecoration(
                          labelText: 'Card Holder',
                          border: GradientOutlineInputBorder(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff7762FF),
                                Color(0xffC589E4),
                                Color(0xffFC6590),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          errorStyle: const TextStyle(fontSize: 0.0),
                          suffixIcon: _cardHolderName.length < 1
                              ? GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Container(
                                          padding: const EdgeInsets.all(16),
                                          height: 90,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFC72C41),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          child: const Text(
                                            'Please input valid name',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.info),
                                )
                              : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading(true);

                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.userID)
                                .set({
                              'first name': widget.firstName,
                              'last name': widget.secondName,
                              'phone': widget.phone,
                              'email': widget.email,
                              'password': widget.password,
                              'card number': _cardNumber,
                              'amount': generateRandomNumber(5000, 50000)
                            });
                            await saveUserId(widget.userID);
                            await saveUserSignUpState();
                            isLoading(false);
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => homePage(
                                        userId: widget.userID,
                                      )),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(180, 56),
                          backgroundColor: const Color(0xff6958D6),
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white, // Set the font color to red
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      _cardNumber = creditCardModel.cardNumber;
      _expiryDate = creditCardModel.expiryDate;
      _cardHolderName = creditCardModel.cardHolderName;
      _cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Future<void> saveUserSignUpState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedUp', true);
  }
}
