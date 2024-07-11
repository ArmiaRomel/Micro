import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:micro/gradient.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:micro/homePage/homePage.dart';
import 'package:micro/transfer/confirmPassword.dart';
import 'package:micro/transfer/confirm.dart';

class transfer extends StatefulWidget {
  static const routeName = '/transfer';
  const transfer({Key? Key, required this.userId}) : super(key: Key);

  final String userId;

  @override
  State<transfer> createState() => _transferState();
}

class _transferState extends State<transfer> {
  Future<Map<String, dynamic>> getUserData(String userId) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return doc.data() as Map<String, dynamic>;
  }

  String selectedMethod = 'Phone number';
  final List<String> methods = ['Phone number', 'Bank account'];
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _phone = '', _bank_number = '', _amount = '';

  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;

  late Future<Map<String, dynamic>> userDataFuture;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    userDataFuture = getUserData(widget.userId);
  }

  Future doesPhoneNumberExist(var phoneNumber) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('phone', isEqualTo: phoneNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    }
  }

  Future doesCardNumberExist(var cardNumber) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('card number', isEqualTo: cardNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    }
  }

  void validatePhone(var userData) async {
    String? userExists = await doesPhoneNumberExist(phoneController.text);

    if (userExists != null) {
      if (int.parse(amount.text) > int.parse('${userData['amount']}')) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Can't Perform Transaction"),
            content: const Text('Your account balance is not enough'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        _checkAndAuthenticate(userExists);
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Phone Number'),
          content: const Text('Invalid phone number or the user may not exist'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void validateCard(var userData) async {
    String bankNumber = formatCardNumber(bankController.text);

    String? userExists = await doesCardNumberExist(bankNumber);

    if (userExists != null) {
      if (int.parse(amount.text) > int.parse('${userData['amount']}')) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Can't Perform Transaction"),
            content: const Text('Your account balance is not enough'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        _checkAndAuthenticate(userExists);
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Card Number'),
          content: const Text('Invalid card number or the user may not exist'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  // Future<void> _checkAndAuthenticate() async {
  //   bool authenticated = false;
  //   _isAuthenticating = false;
  //   while (!authenticated && !_isAuthenticating) {
  //     setState(() {
  //       _isAuthenticating = true;
  //     });
  //     try {
  //       authenticated = await auth.authenticate(
  //         localizedReason: 'Look at the camira',
  //         options: const AuthenticationOptions(
  //           stickyAuth: true,
  //           biometricOnly: true,
  //         ),
  //       );
  //     } on PlatformException catch (e) {
  //       print(e);
  //       _showRetryDialog();
  //       return;
  //     }

  //     if (!mounted) return;

  //     if (authenticated) {
  //       setState(() {
  //         _isAuthenticating = false;
  //       });
  //       Navigator.push(
  //         context,
  //         CupertinoPageRoute(
  //             builder: (context) => confirm(
  //                   userId: widget.userId,
  //                   userExists: userExists,
  //                 )),
  //       );
  //     } else {
  //       _showRetryDialog();
  //     }
  //   }
  // }

  // void _showRetryDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Authentication Failed'),
  //         content: const Text('Face ID not recognized. Try again?'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               _checkAndAuthenticate();
  //             },
  //             child: const Text('Retry'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               setState(() {
  //                 _isAuthenticating = false;
  //               });
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<void> _checkAndAuthenticate(var userExists) async {
    bool isSupported = false;
    try {
      isSupported = await auth.isDeviceSupported();
    } on Exception catch (e) {
      print(e);
    }

    if (!isSupported) {
      Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => confirmPassword(
                  userId: widget.userId,
                  userExists: userExists,
                  amount: amount.text,
                )),
      );
    }

    List<BiometricType> availableBiometrics = [];
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
      print('Available biometrics: $availableBiometrics');
    } on Exception catch (e) {
      print(e);
    }

    if (!mounted) {
      return;
    }

    if (availableBiometrics.contains(BiometricType.weak)) {
      bool authenticated = false;
      try {
        authenticated = await auth.authenticate(
          localizedReason: 'Insert your fingerprint',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
      } on Exception catch (e) {
        print(e);
      }
      if (!mounted) return;

      if (authenticated) {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => confirm(
                    userId: widget.userId,
                    userExists: userExists,
                    amount: amount.text,
                  )),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: FutureBuilder<Map<String, dynamic>>(
          future: userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff7762FF),
                  backgroundColor: Colors.grey,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: const Text('No user data found'));
            } else {
              userData = snapshot.data!;
              final String maskedCardNumber =
                  maskCardNumber('${userData!['card number']}');

              List<String> items = [maskedCardNumber];
              String? selectedItem;
              Map<String, String> itemBalances = {
                maskedCardNumber: '${userData!['amount']}',
              };
              selectedItem ??= items[0];
              return Scaffold(
                backgroundColor: Colors.black,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 35,
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CloseButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => homePage(
                                                  userId: widget.userId,
                                                )),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Container(
                                width: 150,
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 9.0),
                                decoration: BoxDecoration(
                                    color: const Color(0xff323558),
                                    borderRadius: BorderRadius.circular(15)),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  dropdownColor: const Color(0xff323558),
                                  iconEnabledColor: Colors.white,
                                  value: selectedItem,
                                  items: items
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text('Card $item',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14)),
                                          ))
                                      .toList(),
                                  onChanged: (item) =>
                                      setState(() => selectedItem = item!),
                                ),
                              ),
                              const SizedBox(height: 30),
                              const GradientText(
                                text: 'Amount',
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
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(itemBalances[selectedItem]!,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 32)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: Container(
                                width: 360,
                                height: 515,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        40.0), // Adjust the radius as needed
                                    topRight: Radius.circular(
                                        40.0), // Adjust the radius as needed
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 275,
                                        height: 60,
                                        padding: const EdgeInsets.only(
                                            left: 16.0, right: 9.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff323558),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          dropdownColor:
                                              const Color(0xff323558),
                                          iconEnabledColor: Colors.white,
                                          value: selectedMethod,
                                          items: methods
                                              .map(
                                                (method) =>
                                                    DropdownMenuItem<String>(
                                                  value: method,
                                                  child: Text(
                                                    method,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (method) {
                                            setState(
                                              () {
                                                selectedMethod = method!;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      if (selectedMethod == 'Phone number')
                                        SizedBox(
                                          height: 150,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      minimumSize:
                                                          const Size(130, 50),
                                                      backgroundColor:
                                                          const Color(
                                                              0xffF6F4FF),
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                    ).copyWith(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all<EdgeInsets>(
                                                                  EdgeInsets
                                                                      .zero),
                                                    ),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Image(
                                                          image: AssetImage(
                                                              'Icons/transfer/scan.png'),
                                                          width: 30,
                                                          height: 30,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          'Scan QR',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      minimumSize:
                                                          const Size(130, 50),
                                                      backgroundColor:
                                                          const Color(
                                                              0xffFFF9EC),
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                    ).copyWith(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all<EdgeInsets>(
                                                                  EdgeInsets
                                                                      .zero),
                                                    ),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Image(
                                                          image: AssetImage(
                                                              'Icons/transfer/contact.png'),
                                                          width: 30,
                                                          height: 30,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          'Contact',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              SizedBox(
                                                height: 64,
                                                width: 310,
                                                child: TextFormField(
                                                  controller: phoneController,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _phone = value;
                                                    });
                                                  },
                                                  textAlign: TextAlign.center,
                                                  obscureText: false,
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    LengthLimitingTextInputFormatter(
                                                        11),
                                                  ],
                                                  decoration: InputDecoration(
                                                    labelStyle: const TextStyle(
                                                        fontSize: 14.0),
                                                    border:
                                                        GradientOutlineInputBorder(
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          Color(0xff7762FF),
                                                          Color(0xffC589E4),
                                                          Color(0xffFC6590),
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    labelText: 'Phone Number',
                                                    errorStyle: const TextStyle(
                                                        fontSize: 0.0),
                                                    suffixIcon:
                                                        _phone.length < 11
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            16),
                                                                        height:
                                                                            90,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          color:
                                                                              Color(0xFFC72C41),
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(20)),
                                                                        ),
                                                                        child:
                                                                            const Text(
                                                                          'Phone number should not be less than 11 numbers',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                18,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      behavior:
                                                                          SnackBarBehavior
                                                                              .floating,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      elevation:
                                                                          0,
                                                                    ),
                                                                  );
                                                                },
                                                                child: const Icon(
                                                                    Icons.info),
                                                              )
                                                            : null,
                                                  ),
                                                  validator: (name) {
                                                    if (name!.length < 11) {
                                                      return '';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  style: const TextStyle(
                                                      fontSize: 22.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (selectedMethod == 'Bank account')
                                        SizedBox(
                                          height: 150,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      minimumSize:
                                                          const Size(130, 50),
                                                      backgroundColor:
                                                          const Color(
                                                              0xffF6F4FF),
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                    ).copyWith(
                                                      padding:
                                                          MaterialStateProperty
                                                              .all<EdgeInsets>(
                                                                  EdgeInsets
                                                                      .zero),
                                                    ),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Image(
                                                          image: AssetImage(
                                                              'Icons/transfer/scan.png'),
                                                          width: 30,
                                                          height: 30,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          'Scan QR',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              SizedBox(
                                                height: 64,
                                                width: 310,
                                                child: TextFormField(
                                                  controller: bankController,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _bank_number = value;
                                                    });
                                                  },
                                                  textAlign: TextAlign.center,
                                                  obscureText: false,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    LengthLimitingTextInputFormatter(
                                                        16),
                                                  ],
                                                  decoration: InputDecoration(
                                                    labelStyle: const TextStyle(
                                                        fontSize: 14.0),
                                                    border:
                                                        GradientOutlineInputBorder(
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          Color(0xff7762FF),
                                                          Color(0xffC589E4),
                                                          Color(0xffFC6590),
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    labelText:
                                                        'Bank account number',
                                                    errorStyle: const TextStyle(
                                                        fontSize: 0.0),
                                                    suffixIcon:
                                                        _bank_number.length < 16
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            16),
                                                                        height:
                                                                            90,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          color:
                                                                              Color(0xFFC72C41),
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(20)),
                                                                        ),
                                                                        child:
                                                                            const Text(
                                                                          'Bank account number should not be less than 16 numbers',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                18,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      behavior:
                                                                          SnackBarBehavior
                                                                              .floating,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      elevation:
                                                                          0,
                                                                    ),
                                                                  );
                                                                },
                                                                child: const Icon(
                                                                    Icons.info),
                                                              )
                                                            : null,
                                                  ),
                                                  validator: (name) {
                                                    if (name!.length < 16) {
                                                      return '';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  style: const TextStyle(
                                                      fontSize: 22.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 64,
                                        width: 310,
                                        child: TextFormField(
                                          controller: amount,
                                          onChanged: (value) {
                                            setState(() {
                                              _amount = value;
                                            });
                                          },
                                          textAlign: TextAlign.center,
                                          obscureText: false,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(6),
                                          ],
                                          decoration: InputDecoration(
                                            labelStyle:
                                                const TextStyle(fontSize: 14.0),
                                            border: GradientOutlineInputBorder(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xff7762FF),
                                                  Color(0xffC589E4),
                                                  Color(0xffFC6590),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            labelText: 'Amount',
                                            errorStyle:
                                                const TextStyle(fontSize: 0.0),
                                          ),
                                          validator: (name) {
                                            if (name!.length < 1) {
                                              return '';
                                            } else {
                                              return null;
                                            }
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style:
                                              const TextStyle(fontSize: 22.0),
                                        ),
                                      ),
                                      const SizedBox(height: 22),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                if (selectedMethod ==
                                                    'Phone number') {
                                                  validatePhone(userData);
                                                } else {
                                                  validateCard(userData);
                                                }
                                                // Navigator.push(
                                                //   context,
                                                //   CupertinoPageRoute(
                                                //       builder: (context) =>
                                                //           const confirmPassword()),
                                                // );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(180, 56),
                                              backgroundColor:
                                                  const Color(0xff6958D6),
                                              elevation: 0,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                            ),
                                            child: const Text(
                                              'Continue',
                                              style: TextStyle(
                                                color: Colors
                                                    .white, // Set the font color to red
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}

String maskCardNumber(String cardNumber) {
  String sanitizedCardNumber = cardNumber.replaceAll(' ', '');

  if (sanitizedCardNumber.length < 4) {
    return sanitizedCardNumber;
  }

  // String firstFour = sanitizedCardNumber.substring(0, 4);
  String lastFour =
      sanitizedCardNumber.substring(sanitizedCardNumber.length - 4);

  String maskedString = ' **** ' + lastFour;

  return maskedString;
}

String formatCardNumber(String cardNumber) {
  String formattedCardNumber = '';
  for (int i = 0; i < cardNumber.length; i++) {
    if (i > 0 && i % 4 == 0) {
      formattedCardNumber += ' ';
    }
    formattedCardNumber += cardNumber[i];
  }

  return formattedCardNumber;
}
