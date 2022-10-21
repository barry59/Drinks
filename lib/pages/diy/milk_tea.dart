import '../../colors.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:fluttericon/elusive_icons.dart';
import '../../authentication/userAuthentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MilkTea extends StatefulWidget {
  const MilkTea({Key? key}) : super(key: key);

  @override
  State<MilkTea> createState() => _MilkTeaState();
}

class _MilkTeaState extends State<MilkTea> {
  String _teaType = 'blackTea';
  String _milkType = 'wholeMilk';
  String _iceLevel = 'regularIce';
  String _sugarLevel = 'regularSugar';
  bool _cheeseFoam = false;

  // Boolean variables for toppings
  bool _aiyuJelly = false;
  bool _boba = false;
  bool _coconutJelly = false;
  bool _coffeeJelly = false;
  bool _herbalJelly = false;
  bool _pudding = false;
  bool _redBean = false;
  bool _whitePearl = false;

  // A boolean variable to keep track of toppings.
  bool _containToppings = false;

  // If toppings are added to recipe, set _containToppings to true.
  void _toppingStatus() {
    if (_aiyuJelly ||
        _boba ||
        _coconutJelly ||
        _coffeeJelly ||
        _herbalJelly ||
        _pudding ||
        _redBean ||
        _whitePearl) {
      setState(() {
        _containToppings = true;
      });
    }
  }

  // Add current user email as a collection in firestore.
  final Authentication _authenticatedUser = Authentication();
  late String appUserEmail = _authenticatedUser.getUserEmail();
  late final CollectionReference _currentUser =
      FirebaseFirestore.instance.collection(appUserEmail);

  // Add recipe as a document to corresponding user collection.
  Future<void> _addMilkTeaRecipe() async {
    await _currentUser.add({
      'recipe type': _milkType == 'withoutMilk' ? 'Tea' : 'Milk Tea',
      'tea type': _teaType,
      'milk type': _milkType,
      'ice level': _iceLevel,
      'sugar level': _sugarLevel,
      'cheese foam': _cheeseFoam,
      'containToppings': _containToppings,
      'aiyu jelly': _aiyuJelly,
      'boba': _boba,
      'coconut jelly': _coconutJelly,
      'coffee jelly': _coffeeJelly,
      'herbal jelly': _herbalJelly,
      'pudding': _pudding,
      'red bean': _redBean,
      'white pearl': _whitePearl,
      'time': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    // Modify left padding if viewport's width is less than 425
    // Targetting all iOS models before iPhone 12
    double screenWidth = MediaQuery.of(context).size.width;
    double leftPadding = screenWidth <= 415 && Platform.isIOS ? 10 : 25;

    return Column(children: [
      // Radio Buttons for tea type
      Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColor.customizationBackground,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(children: [
            Row(children: const [
              Text('Tea:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ))
            ]),
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'blackTea',
                                  groupValue: _teaType,
                                  onChanged: (value) {
                                    setState(() {
                                      _teaType = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Black tea',
                                style: TextStyle(fontSize: 16)),
                          ])))
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'greenTea',
                                  groupValue: _teaType,
                                  onChanged: (value) {
                                    setState(() {
                                      _teaType = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Green tea',
                                style: TextStyle(fontSize: 16)),
                          ])))
                ])
              ]),
              const SizedBox(width: 25),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'whiteTea',
                                  groupValue: _teaType,
                                  onChanged: (value) {
                                    setState(() {
                                      _teaType = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('White tea',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'oolongTea',
                                  groupValue: _teaType,
                                  onChanged: (value) {
                                    setState(() {
                                      _teaType = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Oolong tea',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
              ])
            ])
          ])), // End of tea type
      const SizedBox(height: 5),

      // Radio Buttons for milk type
      Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColor.customizationBackground,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(children: [
            Row(
              children: const [
                Text('Milk:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ))
              ],
            ),
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'almondMilk',
                                  groupValue: _milkType,
                                  onChanged: (value) {
                                    setState(() {
                                      _milkType = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Almond Milk',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'coconutMilk',
                                  groupValue: _milkType,
                                  onChanged: (value) {
                                    setState(() {
                                      _milkType = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Coconut Milk',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'organicMilk',
                                  groupValue: _milkType,
                                  onChanged: (value) {
                                    setState(() {
                                      _milkType = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Organic Milk',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'wholeMilk',
                                  groupValue: _milkType,
                                  onChanged: (value) {
                                    setState(() {
                                      _milkType = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Whole Milk',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'oatmilk',
                                  groupValue: _milkType,
                                  onChanged: (value) {
                                    setState(() {
                                      _milkType = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Oatmilk',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'skimMilk',
                                  groupValue: _milkType,
                                  onChanged: (value) {
                                    setState(() {
                                      _milkType = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Skim Milk',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'soyMilk',
                                  groupValue: _milkType,
                                  onChanged: (value) {
                                    setState(() {
                                      _milkType = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Soy Milk',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'twoPercMilk',
                                  groupValue: _milkType,
                                  onChanged: (value) {
                                    setState(() {
                                      _milkType = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('2% Milk',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ])
              ])
            ]),
            const SizedBox(height: 5),
            Container(
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: const DottedLine(
                  dashColor: Colors.black38,
                  dashLength: 5,
                  dashGapLength: 6,
                )),
            const SizedBox(height: 5),
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                    height: 20,
                    child: Container(
                        padding: EdgeInsets.only(left: leftPadding),
                        child: Row(children: [
                          Transform.scale(
                            scale: 0.8,
                            child: Radio(
                                value: 'withoutMilk',
                                groupValue: _milkType,
                                onChanged: (value) {
                                  setState(() {
                                    _milkType = value as String;
                                  });
                                },
                                activeColor: AppColor.activeRadioButton),
                          ),
                          const Text('Without Milk',
                              style: TextStyle(fontSize: 16)),
                        ])))
              ])
            ])
          ])), // End of milk type
      const SizedBox(height: 5),

      // Checkboxes for toppings
      Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColor.customizationBackground,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(children: [
            Row(children: const [
              Text('Toppings:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ))
            ]),
            const SizedBox(height: 5),
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.75,
                              child: Checkbox(
                                  value: _aiyuJelly,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _aiyuJelly = value!;
                                    });
                                    // debugPrint('$_aiyuJelly');
                                  },
                                  activeColor: AppColor.activeCheckbox),
                            ),
                            const Text('Ai-yu Jelly',
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ])))
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.75,
                              child: Checkbox(
                                  value: _boba,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _boba = value!;
                                    });
                                    // debugPrint('$_boba');
                                  },
                                  activeColor: AppColor.activeCheckbox),
                            ),
                            const Text('Boba',
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ])))
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.75,
                              child: Checkbox(
                                  value: _coconutJelly,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _coconutJelly = value!;
                                    });
                                    // debugPrint('$_coconutJelly');
                                  },
                                  activeColor: AppColor.activeCheckbox),
                            ),
                            const Text('Coconut jelly',
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ])))
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.75,
                              child: Checkbox(
                                  value: _coffeeJelly,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _coffeeJelly = value!;
                                    });
                                    // debugPrint('$_coffeeJelly');
                                  },
                                  activeColor: AppColor.activeCheckbox),
                            ),
                            const Text('Coffee Jelly',
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ])))
                ])
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.75,
                              child: Checkbox(
                                  value: _herbalJelly,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _herbalJelly = value!;
                                    });
                                    // debugPrint('$_herbalJelly');
                                  },
                                  activeColor: AppColor.activeCheckbox),
                            ),
                            const Text('Herbal Jelly',
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ])))
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.75,
                              child: Checkbox(
                                  value: _pudding,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _pudding = value!;
                                    });
                                    // debugPrint('$_pudding');
                                  },
                                  activeColor: AppColor.activeCheckbox),
                            ),
                            const Text('Pudding',
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ])))
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.75,
                              child: Checkbox(
                                  value: _redBean,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _redBean = value!;
                                    });
                                    // debugPrint('$_redBean');
                                  },
                                  activeColor: AppColor.activeCheckbox),
                            ),
                            const Text('Red Bean',
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ])))
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.75,
                              child: Checkbox(
                                  value: _whitePearl,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _whitePearl = value!;
                                    });
                                    // debugPrint('$_whitePearl');
                                  },
                                  activeColor: AppColor.activeCheckbox),
                            ),
                            const Text('White Pearl',
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ])))
                ])
              ]),
            ]),
          ])), // End of toppings
      const SizedBox(height: 5),

      // Radio Buttons for ice level
      Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: AppColor.customizationBackground,
              borderRadius: BorderRadius.circular(5)),
          child: Column(children: [
            Row(
              children: const [
                Text('Ice Level:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ))
              ],
            ),
            const SizedBox(height: 5),
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'noIce',
                                  groupValue: _iceLevel,
                                  onChanged: (value) {
                                    setState(() {
                                      _iceLevel = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('No Ice',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'lessIce',
                                  groupValue: _iceLevel,
                                  onChanged: (value) {
                                    setState(() {
                                      _iceLevel = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Less Ice',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
              ]),
              const SizedBox(width: 35),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'regularIce',
                                  groupValue: _iceLevel,
                                  onChanged: (value) {
                                    setState(() {
                                      _iceLevel = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Regular Ice',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'extraIce',
                                  groupValue: _iceLevel,
                                  onChanged: (value) {
                                    setState(() {
                                      _iceLevel = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Extra Ice',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
              ])
            ]),
            const SizedBox(height: 5),
            Container(
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: const DottedLine(
                  dashColor: Colors.black38,
                  dashLength: 5,
                  dashGapLength: 6,
                )),
            const SizedBox(height: 5),
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                    height: 20,
                    child: Container(
                        padding: EdgeInsets.only(left: leftPadding),
                        child: Row(children: [
                          Transform.scale(
                            scale: 0.8,
                            child: Radio(
                                value: 'hot',
                                groupValue: _iceLevel,
                                onChanged: (value) {
                                  setState(() {
                                    _iceLevel = value as String;
                                  });
                                },
                                activeColor: AppColor.activeRadioButton),
                          ),
                          const Text('Hot', style: TextStyle(fontSize: 16)),
                        ])))
              ])
            ])
          ])), // End of ice level
      const SizedBox(height: 5),

      // Radio Buttons for sugar level
      Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: AppColor.customizationBackground,
              borderRadius: BorderRadius.circular(5)),
          child: Column(children: [
            Row(
              children: const [
                Text('Sugar Level:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ))
              ],
            ),
            const SizedBox(height: 5),
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'noSugar',
                                  groupValue: _sugarLevel,
                                  onChanged: (value) {
                                    setState(() {
                                      _sugarLevel = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('No Sugar',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'littleSugar',
                                  groupValue: _sugarLevel,
                                  onChanged: (value) {
                                    setState(() {
                                      _sugarLevel = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Little Sugar',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'halfSugar',
                                  groupValue: _sugarLevel,
                                  onChanged: (value) {
                                    setState(() {
                                      _sugarLevel = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Half Sugar',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
              ]),
              const SizedBox(width: 13),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'lessSugar',
                                  groupValue: _sugarLevel,
                                  onChanged: (value) {
                                    setState(() {
                                      _sugarLevel = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Less Sugar',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'regularSugar',
                                  groupValue: _sugarLevel,
                                  onChanged: (value) {
                                    setState(() {
                                      _sugarLevel = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Regular Sugar',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  SizedBox(
                      height: 20,
                      child: Container(
                          padding: EdgeInsets.only(left: leftPadding),
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.8,
                              child: Radio(
                                  value: 'extraSugar',
                                  groupValue: _sugarLevel,
                                  onChanged: (value) {
                                    setState(() {
                                      _sugarLevel = value as String;
                                    });
                                  },
                                  activeColor: AppColor.activeRadioButton),
                            ),
                            const Text('Extra Sugar',
                                style: TextStyle(fontSize: 16)),
                          ]))),
                ]),
              ])
            ])
          ])), // End of sugar level
      const SizedBox(height: 5),

      // Toggle Switch for cheese foam
      Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColor.customizationBackground,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(children: [
            const Text('Cheese Foam:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            Expanded(child: Container()),
            Transform.scale(
              scale: 0.60,
              child: CupertinoSwitch(
                  value: _cheeseFoam,
                  onChanged: (value) {
                    setState(() {
                      _cheeseFoam = value;
                    });
                  },
                  activeColor: AppColor.activeSwitch,
                  trackColor: AppColor.inactiveSwitch),
            )
          ])), // End of cheese foam

      // Save Button and Reset Button
      Container(
          padding: const EdgeInsets.only(left: 60, right: 60),
          child: Row(children: [
            ElevatedButton.icon(
                onPressed: () {
                  _toppingStatus();
                  _addMilkTeaRecipe();
                  Get.snackbar(
                    "Save Successfully", // snackbar Title
                    "", // place holder for message Text
                    messageText: (const Text(
                        "You have save your Milk Tea Recipe successfully",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300))),
                    icon: Icon(Elusive.ok_circled2,
                        size: 22, color: Colors.green.shade800),
                    shouldIconPulse: false,
                    snackPosition: SnackPosition.TOP,
                    margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
                    backgroundColor: AppColor.snackbarBackground,
                    isDismissible: true,
                  );
                },
                icon: const Icon(Icons.save_alt_rounded, color: Colors.black),
                label: const Text('Save',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    )),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColor.activeButton1),
                    elevation: MaterialStateProperty.all<double>(3),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )))),
            Expanded(child: Container()),
            ElevatedButton.icon(
                onPressed: () {
                  if (_teaType != 'blackTea' ||
                      _milkType != 'wholeMilk' ||
                      _iceLevel != 'regularIce' ||
                      _sugarLevel != 'regularSugar' ||
                      _cheeseFoam != false ||
                      _aiyuJelly != false ||
                      _boba != false ||
                      _coconutJelly != false ||
                      _coffeeJelly != false ||
                      _herbalJelly != false ||
                      _pudding != false ||
                      _redBean != false ||
                      _whitePearl != false) {
                    setState(() {
                      _teaType = 'blackTea';
                      _milkType = 'wholeMilk';
                      _iceLevel = 'regularIce';
                      _sugarLevel = 'regularSugar';
                      _cheeseFoam = false;
                      _aiyuJelly = false;
                      _boba = false;
                      _coconutJelly = false;
                      _coffeeJelly = false;
                      _herbalJelly = false;
                      _pudding = false;
                      _redBean = false;
                      _whitePearl = false;
                    });
                    // Notification for a successful reset
                    Get.snackbar(
                      "Reset Successfully", // snackbar Title
                      "", // place holder for message Text
                      messageText: (const Text(
                          "You have reset Milk Tea's customization back to default",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300))),
                      icon: Icon(Elusive.ok_circled2,
                          size: 22, color: Colors.green.shade800),
                      shouldIconPulse: false,
                      snackPosition: SnackPosition.TOP,
                      margin:
                          const EdgeInsets.only(left: 15, top: 10, right: 15),
                      backgroundColor: AppColor.snackbarBackground,
                      isDismissible: true,
                    );
                  } else {
                    // Notification for an unsuccessfull reset
                    Get.snackbar(
                      "Reset Unsuccessful", // snackbar Title
                      "", // place holder for message Text
                      messageText: (const Text(
                          "You have not modify Milk Tea's default customization",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300))),
                      icon: Icon(Elusive.cancel_circled2,
                          size: 22, color: Colors.red.shade800),
                      shouldIconPulse: false,
                      snackPosition: SnackPosition.TOP,
                      margin:
                          const EdgeInsets.only(left: 15, top: 10, right: 15),
                      backgroundColor: AppColor.snackbarBackground,
                      isDismissible: true,
                    );
                  }
                },
                icon:
                    const Icon(Icons.restart_alt_rounded, color: Colors.black),
                label: const Text('Reset',
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColor.activeButton1),
                    elevation: MaterialStateProperty.all<double>(3),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))))
          ])), // End of Save and Reset Button
    ]);
  }
}
