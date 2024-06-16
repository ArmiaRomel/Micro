import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:micro/gradient.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:micro/homePage/homePage.dart';
import 'package:micro/transfer/confirmPassword.dart';

class transfer extends StatefulWidget {
  static const routeName = '/transfer';
  const transfer({super.key});

  @override
  State<transfer> createState() => _transferState();
}

class _transferState extends State<transfer> {
  List<String?> items = ['**** 1982', '**** 4932', '**** 8601'];
  String? selectedItem = '**** 1982';
  Map<String, String> itemBalances = {
    '**** 1982': '\$25,000.00',
    '**** 4932': '\$55,100.00',
    '**** 8601': '\$75,300.00',
  };

  String selectedMethod = 'Phone number';
  final List<String> methods = ['Phone number', 'Bank account'];
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _phone = '', _bank_number = '', _amount = '';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
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
                                    builder: (context) => homePage()),
                                (Route<dynamic> route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                      Container(
                        width: 150,
                        padding: const EdgeInsets.only(left: 16.0, right: 9.0),
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
                                            color: Colors.white, fontSize: 14)),
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
                        height: 450,
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
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  dropdownColor: const Color(0xff323558),
                                  iconEnabledColor: Colors.white,
                                  value: selectedMethod,
                                  items: methods
                                      .map(
                                        (method) => DropdownMenuItem<String>(
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
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(130, 50),
                                              backgroundColor:
                                                  const Color(0xffF6F4FF),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                            ).copyWith(
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                      EdgeInsets.zero),
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
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(130, 50),
                                              backgroundColor:
                                                  const Color(0xffFFF9EC),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                            ).copyWith(
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                      EdgeInsets.zero),
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
                                                      color: Colors.black,
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
                                          keyboardType: TextInputType.phone,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                11),
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
                                            labelText: 'Phone Number',
                                            errorStyle:
                                                const TextStyle(fontSize: 0.0),
                                            suffixIcon: _phone.length < 11
                                                ? GestureDetector(
                                                    onTap: () {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16),
                                                            height: 90,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color(
                                                                  0xFFC72C41),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)),
                                                            ),
                                                            child: const Text(
                                                              'Phone number should not be less than 11 numbers',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ),
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          elevation: 0,
                                                        ),
                                                      );
                                                    },
                                                    child:
                                                        const Icon(Icons.info),
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
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style:
                                              const TextStyle(fontSize: 22.0),
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
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(130, 50),
                                              backgroundColor:
                                                  const Color(0xffF6F4FF),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                            ).copyWith(
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                      EdgeInsets.zero),
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
                                                      color: Colors.black,
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
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                16),
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
                                            labelText: 'Bank account number',
                                            errorStyle:
                                                const TextStyle(fontSize: 0.0),
                                            suffixIcon: _bank_number.length < 16
                                                ? GestureDetector(
                                                    onTap: () {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16),
                                                            height: 90,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color(
                                                                  0xFFC72C41),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)),
                                                            ),
                                                            child: const Text(
                                                              'Bank account number should not be less than 16 numbers',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ),
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          elevation: 0,
                                                        ),
                                                      );
                                                    },
                                                    child:
                                                        const Icon(Icons.info),
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
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style:
                                              const TextStyle(fontSize: 22.0),
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
                                  onChanged: (value) {
                                    setState(() {
                                      _amount = value;
                                    });
                                  },
                                  textAlign: TextAlign.center,
                                  obscureText: false,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  decoration: InputDecoration(
                                    labelStyle: const TextStyle(fontSize: 14.0),
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
                                    errorStyle: const TextStyle(fontSize: 0.0),
                                  ),
                                  validator: (name) {
                                    if (name!.length < 1) {
                                      return '';
                                    } else {
                                      return null;
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: const TextStyle(fontSize: 22.0),
                                ),
                              ),
                              const SizedBox(height: 22),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  const confirmPassword()),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(180, 56),
                                      backgroundColor: const Color(0xff6958D6),
                                      elevation: 0,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
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
      ),
    );
  }
}
