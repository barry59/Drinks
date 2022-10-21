// ignore_for_file: prefer_const_constructors
import 'coffee.dart';
import 'milk_tea.dart';
import 'smoothie.dart';
import '../../colors.dart';
import 'package:flutter/material.dart';

class DIYPage extends StatefulWidget {
  const DIYPage({Key? key}) : super(key: key);

  @override
  State<DIYPage> createState() => _DIYPageState();
}

class _DIYPageState extends State<DIYPage> {
  bool isPressed0 = true; // 0 is the index of Coffee Button
  bool isPressed1 = false; // 1 is the index of Milk Tea Button
  bool isPressed2 = false; // 2 is the index of Smoothie Button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Customize the Drink',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColor.navigationTopBarBackground,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: ListView(children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(children: [
                ElevatedButton(
                    onPressed: () => {
                          setState(() {
                            isPressed0 = true;
                            isPressed1 = false;
                            isPressed2 = false;
                          })
                        },
                    child: Text('Coffee',
                        style: TextStyle(
                            color: isPressed0 ? Colors.black : Colors.white,
                            fontSize: 18,
                            wordSpacing: 3)),
                    style: ButtonStyle(
                      backgroundColor: isPressed0
                          ? MaterialStateProperty.all<Color>(
                              AppColor.activeButton)
                          : MaterialStateProperty.all<Color>(
                              AppColor.inactiveButton),
                      elevation: isPressed0
                          ? MaterialStateProperty.all<double>(3)
                          : MaterialStateProperty.all<double>(1),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color:
                                isPressed0 ? Colors.black26 : Colors.white70),
                      )),
                    )),
                Expanded(child: Container()),
                ElevatedButton(
                    onPressed: () => {
                          setState(() {
                            isPressed0 = false;
                            isPressed1 = true;
                            isPressed2 = false;
                          })
                        },
                    child: Text('Milk Tea',
                        style: TextStyle(
                          color: isPressed1 ? Colors.black : Colors.white,
                          fontSize: 18,
                        )),
                    style: ButtonStyle(
                        backgroundColor: isPressed1
                            ? MaterialStateProperty.all<Color>(
                                AppColor.activeButton)
                            : MaterialStateProperty.all<Color>(
                                AppColor.inactiveButton),
                        elevation: isPressed1
                            ? MaterialStateProperty.all<double>(3)
                            : MaterialStateProperty.all<double>(1),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color:
                                  isPressed1 ? Colors.black26 : Colors.white70),
                        )))),
                Expanded(child: Container()),
                ElevatedButton(
                    onPressed: () => {
                          setState(() {
                            isPressed0 = false;
                            isPressed1 = false;
                            isPressed2 = true;
                          })
                        },
                    child: Text('Smoothie',
                        style: TextStyle(
                          color: isPressed2 ? Colors.black : Colors.white,
                          fontSize: 18,
                        )),
                    style: ButtonStyle(
                        backgroundColor: isPressed2
                            ? MaterialStateProperty.all<Color>(
                                AppColor.activeButton)
                            : MaterialStateProperty.all<Color>(
                                AppColor.inactiveButton),
                        elevation: isPressed2
                            ? MaterialStateProperty.all<double>(3)
                            : MaterialStateProperty.all<double>(1),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color:
                                  isPressed2 ? Colors.black26 : Colors.white70),
                        )))),
              ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: isPressed0
                ? Coffee()
                : isPressed1
                    ? MilkTea()
                    : isPressed2
                        ? Smoothie()
                        : Container(),
          ),
        ]));
  }
}
