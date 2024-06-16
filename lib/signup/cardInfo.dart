import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:micro/homePage/homePage.dart';

class cardInfo extends StatefulWidget {
  static const routeName = '/cardInfo';

  const cardInfo({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
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
                            labelStyle: TextStyle(fontSize: 12.5),
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
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
                            errorStyle: TextStyle(fontSize: 0.0),
                            suffixIcon: _cardNumber.length < 16
                                ? GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Container(
                                            padding: EdgeInsets.all(16),
                                            height: 90,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFC72C41),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            child: Text(
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
                                    child: Icon(Icons.info),
                                  )
                                : null,
                          ),
                          expiryDateDecoration: InputDecoration(
                            labelStyle: TextStyle(fontSize: 12.5),
                            labelText: 'Expired Date',
                            hintText: 'xx/xx',
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
                            errorStyle: TextStyle(fontSize: 0.0),
                            suffixIcon: _expiryDate.length < 5
                                ? GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Container(
                                            padding: EdgeInsets.all(16),
                                            height: 90,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFC72C41),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            child: Text(
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
                                    child: Icon(Icons.info),
                                  )
                                : null,
                          ),
                          cvvCodeDecoration: InputDecoration(
                            labelStyle: TextStyle(fontSize: 12.5),
                            labelText: 'CVV',
                            hintText: 'xxx',
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
                            errorStyle: TextStyle(fontSize: 0.0),
                            suffixIcon: _cvvCode.length < 3
                                ? GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Container(
                                            padding: EdgeInsets.all(16),
                                            height: 90,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFC72C41),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            child: Text(
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
                                    child: Icon(Icons.info),
                                  )
                                : null,
                          ),
                          cardHolderDecoration: InputDecoration(
                            labelText: 'Card Holder',
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
                            errorStyle: TextStyle(fontSize: 0.0),
                            suffixIcon: _cardHolderName.length < 1
                                ? GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Container(
                                            padding: EdgeInsets.all(16),
                                            height: 90,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFC72C41),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            child: Text(
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
                                    child: Icon(Icons.info),
                                  )
                                : null,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => homePage()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(180, 56),
                            backgroundColor: Color(0xff6958D6),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          child: Text(
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
}
