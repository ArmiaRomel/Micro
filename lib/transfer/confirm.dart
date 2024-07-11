import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:micro/transfer/sent.dart';
import 'package:micro/transfer/transfer.dart';

class confirm extends StatefulWidget {
  static const routeName = '/confirm';
  const confirm(
      {Key? Key,
      required this.userId,
      required this.userExists,
      required this.amount})
      : super(key: Key);

  final String userId, userExists, amount;

  @override
  State<confirm> createState() => _confirmState();
}

class _confirmState extends State<confirm> {
  Future<Map<String, dynamic>> getData(String userExists, String userId) async {
    DocumentSnapshot doc2 = await FirebaseFirestore.instance
        .collection('users')
        .doc(userExists)
        .get();

    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    return {
      'userExistsData': doc2.data() as Map<String, dynamic>,
      'userIdData': doc.data() as Map<String, dynamic>,
    };
  }

  Future<void> send(var reciverData, var userData) async {
    int amountInt = int.parse(widget.amount);
    int reciverAmount = amountInt + int.parse('${reciverData['amount']}');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userExists)
        .update({
      'amount': reciverAmount,
    });

    int userAmount = int.parse('${userData['amount']}') - amountInt;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .update({
      'amount': userAmount,
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: FutureBuilder<Map<String, dynamic>>(
        future: getData(widget.userExists, widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Color(0xff7762FF),
              backgroundColor: Colors.grey,
            ));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No user data found'));
          }
          var data = snapshot.data!;
          var reciverData = data['userExistsData'];
          var userData = data['userIdData'];
          final String _maskedCardNumber =
              maskCardNumber('${reciverData['card number']}');
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(
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
                      controller:
                          TextEditingController(text: _maskedCardNumber),
                      enabled: false,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                            fontSize: 14.0, color: Colors.black),
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
                        labelText: 'Card number',
                      ),
                      style:
                          const TextStyle(fontSize: 22.0, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 64,
                    width: 310,
                    child: TextFormField(
                      controller:
                          TextEditingController(text: widget.userExists),
                      enabled: false,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                            fontSize: 14.0, color: Colors.black),
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
                        labelText: "Receiver's wallet ID",
                      ),
                      style:
                          const TextStyle(fontSize: 22.0, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 64,
                    width: 310,
                    child: TextFormField(
                      controller: TextEditingController(
                          text: '${reciverData['phone']}'),
                      enabled: false,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                            fontSize: 14.0, color: Colors.black),
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
                        labelText: 'Phone number',
                      ),
                      style:
                          const TextStyle(fontSize: 22.0, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 64,
                    width: 310,
                    child: TextFormField(
                      controller: TextEditingController(
                          text:
                              '${reciverData['first name']} ${reciverData['last name']}'),
                      enabled: false,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                            fontSize: 14.0, color: Colors.black),
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
                        labelText: "Receiver's name",
                      ),
                      style:
                          const TextStyle(fontSize: 22.0, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 64,
                    width: 310,
                    child: TextFormField(
                      controller:
                          TextEditingController(text: '${widget.amount}'),
                      enabled: false,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                            fontSize: 14.0, color: Colors.black),
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
                        labelText: 'Amount',
                      ),
                      style:
                          const TextStyle(fontSize: 22.0, color: Colors.black),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    transfer(userId: widget.userId)),
                            (Route<dynamic> route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(135, 56),
                          backgroundColor: const Color(0xff6958D6),
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white, // Set the font color to red
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          send(reciverData, userData);
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => sent(
                                      userId: widget.userId,
                                      name:
                                          '${reciverData['first name']} ${reciverData['last name']}',
                                      amount: widget.amount,
                                    )),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(135, 56),
                          backgroundColor: const Color(0xff6958D6),
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        child: const Text(
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
          );
        },
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
