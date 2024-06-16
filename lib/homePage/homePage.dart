import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro/gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:micro/transfer/transfer.dart';
import 'sun.dart';
import 'cloud.dart';

class homePage extends StatefulWidget {
  static const routeName = '/homePage';

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  // int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  List<String> items = ['**** 1982', '**** 4932', '**** 8601'];
  String? selectedItem;
  Map<String, String> itemBalances = {
    '**** 1982': '\$25,000.00',
    '**** 4932': '\$55,100.00',
    '**** 8601': '\$75,300.00',
  };

  @override
  Widget build(BuildContext context) {
    selectedItem ??= items[0];
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffFFE4C9),
                      Color(0xffF8F7FF),
                      Color(0xffF8F7FF)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              width: 225,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Icon(Icons.wb_sunny, size: 25, color: Colors.orange),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Good morning,", style: TextStyle(fontSize: 22)),
                        Text("Armia Romel",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 60,
              left: 305,
              child: cloud(sized: 65),
            ),
            Positioned(
              top: 120,
              left: 260,
              child: sun(),
            ),
            Positioned(
              top: 120,
              left: 210,
              child: cloud(sized: 80),
            ),
            Positioned(
              top: 170,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      padding: EdgeInsets.only(left: 16.0, right: 9.0),
                      decoration: BoxDecoration(
                          color: Color(0xff323558),
                          borderRadius: BorderRadius.circular(15)),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),
                        dropdownColor: Color(0xff323558),
                        iconEnabledColor: Colors.white,
                        value: selectedItem,
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text('Card $item',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                ))
                            .toList(),
                        onChanged: (item) =>
                            setState(() => selectedItem = item),
                      ),
                    ),
                    SizedBox(height: 10),
                    GradientText(
                      text: 'Your available balance',
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
                    SizedBox(height: 5),
                    Text(itemBalances[selectedItem]!,
                        style: TextStyle(color: Colors.white, fontSize: 32)),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              top: 365,
              height: 235,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => transfer()),
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
                                color: Color(0xffF8F7FF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Image(
                                  image: AssetImage(
                                      'Icons/homePaage/transfer.png'),
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Transfer',
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
                                color: Color(0xffF8F7FF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Image(
                                  image: AssetImage(
                                      'Icons/homePaage/request_money.png'),
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Request\n Money',
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
                                color: Color(0xffF8F7FF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Image(
                                  image: AssetImage(
                                      'Icons/homePaage/pay_bills.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Pay Bills',
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
                                color: Color(0xffF8F7FF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Image(
                                  image: AssetImage(
                                      'Icons/homePaage/donations.png'),
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Donations',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                color: Color(0xffF8F7FF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Image(
                                  image: AssetImage(
                                      'Icons/homePaage/assurance.png'),
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Assurance',
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
                                color: Color(0xffF8F7FF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Image(
                                  image: AssetImage(
                                      'Icons/homePaage/transaction_history.png'),
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Transaction\n    History',
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
                                color: Color(0xffF8F7FF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Image(
                                  image: AssetImage(
                                      'Icons/homePaage/vouchers.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Vouchers',
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
                                color: Color(0xffF8F7FF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Image(
                                  image: AssetImage('Icons/homePaage/more.png'),
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'More',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xffF8F7FF),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            // onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    'Icons/homePaage/navHome.png',
                    color: Color(0xff6958D6),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    'Icons/homePaage/navLog.png',
                    color: Colors.grey,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff6958D6),
                      borderRadius: BorderRadius.circular(18)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        'Icons/homePaage/navQR.png',
                        color: Color(0xffF8F7FF),
                      ),
                    ),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    'Icons/homePaage/navNotification.png',
                    color: Colors.grey,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    'Icons/homePaage/navProfile.png',
                    color: Colors.grey,
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
