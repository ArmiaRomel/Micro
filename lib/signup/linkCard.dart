import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:micro/signup/cardInfo.dart';

class linkCard extends StatefulWidget {
  const linkCard(
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

  static const routeName = '/linkCard';

  @override
  _linkCardState createState() => _linkCardState();
}

class _linkCardState extends State<linkCard> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
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
              const Text(
                'Link your card',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bank account',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => cardInfo(
                                          firstName: widget.firstName,
                                          secondName: widget.secondName,
                                          phone: widget.phone,
                                          email: widget.email,
                                          password: widget.password,
                                          userID: widget.userID,
                                        )),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Container(
                              height: 63,
                              width: 63,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F5F6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Image(
                                  image: AssetImage('Icons/banks/1.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'NBE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Container(
                              height: 63,
                              width: 63,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F5F6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Image(
                                  image: AssetImage('Icons/banks/2.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Deutsche',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Container(
                              height: 63,
                              width: 63,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F5F6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Image(
                                  image: AssetImage('Icons/banks/3.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'HSBS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Container(
                              height: 63,
                              width: 63,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F5F6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Image(
                                  image: AssetImage('Icons/banks/4.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Citibank',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Container(
                              height: 63,
                              width: 63,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F5F6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Image(
                                  image: AssetImage('Icons/banks/5.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'PNC',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Container(
                              height: 63,
                              width: 63,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F5F6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Image(
                                  image: AssetImage('Icons/banks/6.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Fidelity',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Container(
                              height: 63,
                              width: 63,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F5F6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Image(
                                  image: AssetImage('Icons/banks/7.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Acbank',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Container(
                              height: 63,
                              width: 63,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F5F6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Image(
                                  image: AssetImage('Icons/banks/8.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Union Bank',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(110, 40),
                          backgroundColor: const Color(0xff05061B),
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'International Card',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Container(
                              height: 63,
                              width: 63,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F5F6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Image(
                                  image: AssetImage('Icons/banks/9.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Paypal',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Container(
                              height: 63,
                              width: 63,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F5F6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Image(
                                  image: AssetImage('Icons/banks/10.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Mastercard',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Container(
                              height: 63,
                              width: 63,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F5F6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Image(
                                  image: AssetImage('Icons/banks/11.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Visa',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Container(
                              height: 63,
                              width: 63,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F5F6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Image(
                                  image: AssetImage('Icons/banks/12.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Payoneer',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(110, 40),
                          backgroundColor: const Color(0xff05061B),
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
