import '../../colors.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import '../../authentication/userAuthentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Smoothie extends StatefulWidget {
  const Smoothie({Key? key}) : super(key: key);

  @override
  State<Smoothie> createState() => _SmoothieState();
}

class _SmoothieState extends State<Smoothie> {
  // Boolean variables for vegetables
  bool _broccoli = false;
  bool _carrot = false;
  bool _cucumber = false;
  bool _lettuce = false;
  bool _spinach = false;
  bool _zucchini = false;

  // Boolean variables for fruits
  bool _apple = false;
  bool _banana = false;
  bool _blueberry = false;
  bool _grapes = false;
  bool _kiwi = false;
  bool _mango = false;
  bool _melon = false;
  bool _orange = false;
  bool _papaya = false;
  bool _peach = false;
  bool _pear = false;
  bool _pineapple = false;

  // Boolean variables for liquid
  bool _coconutWater = false;
  bool _coldBrewCoffee = false;
  bool _greenTea = false;
  bool _juice = false;
  bool _milk = false;
  bool _yogurt = false;

  // Boolean variables for protein boosters
  bool _flaxSeeds = false;
  bool _hempSeeds = false;
  bool _oats = false;
  bool _walnuts = false;

  // Boolean variables for sweeteners
  bool _dates = false;
  bool _honey = false;
  bool _mapleSyrup = false;
  bool _peanutButter = false;

  // Boolean variables that indicate the status of the checkboxes for each ingredient section.
  bool _containVeggies = false; // vegetables
  bool _containFruits = false; // fruits
  bool _containLiquid = false; // liquid
  bool _containPB = false; // protein boosters
  bool _containSweeteners = false; // sweeteners

  // Change the status of each ingredient section if the checkboxes are selected.
  void _ingredientStatus() {
    // Set _containVeggies to true if any checkboxes are selected for vegetables.
    if (_broccoli ||
        _carrot ||
        _cucumber ||
        _lettuce ||
        _spinach ||
        _zucchini) {
      setState(() {
        _containVeggies = true;
      });
    }

    // Set _containFruits to true if any checkboxes are selected for fruits.
    if (_apple ||
        _banana ||
        _blueberry ||
        _grapes ||
        _kiwi ||
        _mango ||
        _melon ||
        _orange ||
        _papaya ||
        _peach ||
        _pear ||
        _pineapple) {
      setState(() {
        _containFruits = true;
      });
    }

    // Set _containLiquid to true if any checkboxes are selected for liquid.
    if (_coconutWater ||
        _coldBrewCoffee ||
        _greenTea ||
        _juice ||
        _milk ||
        _yogurt) {
      setState(() {
        _containLiquid = true;
      });
    }

    // Set _containPB to true if any checkboxes are selected for protein boosters.
    if (_flaxSeeds || _hempSeeds || _oats || _walnuts) {
      setState(() {
        _containPB = true;
      });
    }

    // Set _containSweeteners to true if any checkboxes are selected for sweeteners.
    if (_dates || _honey || _mapleSyrup || _peanutButter) {
      setState(() {
        _containSweeteners = true;
      });
    }

    // debugPrint('$_containVeggies');
    // debugPrint('$_containFruits');
    // debugPrint('$_containLiquid');
    // debugPrint('$_containPB');
    // debugPrint('$_containSweeteners');
  }

  // Reset all the checkboxes back to default.
  void _resetCustomization() {
    // Reset all the checkboxes for vegetables.
    // Set _containVeggies to false.
    if (_broccoli ||
        _carrot ||
        _cucumber ||
        _lettuce ||
        _spinach ||
        _zucchini) {
      setState(() {
        _broccoli = false;
        _carrot = false;
        _cucumber = false;
        _lettuce = false;
        _spinach = false;
        _zucchini = false;
        _containVeggies = false;
      });
    }

    // Reset all the checkboxes for fruits.
    // Set _containFruits to false.
    if (_apple ||
        _banana ||
        _blueberry ||
        _grapes ||
        _kiwi ||
        _mango ||
        _melon ||
        _orange ||
        _papaya ||
        _peach ||
        _pear ||
        _pineapple) {
      setState(() {
        _apple = false;
        _banana = false;
        _blueberry = false;
        _grapes = false;
        _kiwi = false;
        _mango = false;
        _melon = false;
        _orange = false;
        _papaya = false;
        _peach = false;
        _pear = false;
        _pineapple = false;
        _containFruits = false;
      });
    }

    // Reset all the checkboxes for liquid.
    // Set _containLiquid to false.
    if (_coconutWater ||
        _coldBrewCoffee ||
        _greenTea ||
        _juice ||
        _milk ||
        _yogurt) {
      setState(() {
        _coconutWater = false;
        _coldBrewCoffee = false;
        _greenTea = false;
        _juice = false;
        _milk = false;
        _yogurt = false;
        _containLiquid = false;
      });
    }

    // Reset all the checkboxes for protein boosters.
    // Set _containPB to false.
    if (_flaxSeeds || _hempSeeds || _oats || _walnuts) {
      setState(() {
        _flaxSeeds = false;
        _hempSeeds = false;
        _oats = false;
        _walnuts = false;
        _containPB = false;
      });
    }

    // Reset all the checkboxes for sweeteners.
    // Set _containSweeteners to false.
    if (_dates || _honey || _mapleSyrup || _peanutButter) {
      setState(() {
        _dates = false;
        _honey = false;
        _mapleSyrup = false;
        _peanutButter = false;
        _containSweeteners = false;
      });
    }

    // debugPrint('$_containVeggies');
    // debugPrint('$_containFruits');
    // debugPrint('$_containLiquid');
    // debugPrint('$_containPB');
    // debugPrint('$_containSweeteners');
  }

  // Add current user email as a collection in firestore.
  final Authentication _authenticatedUser = Authentication();
  late String appUserEmail = _authenticatedUser.getUserEmail();
  late final CollectionReference _currentUser =
      FirebaseFirestore.instance.collection(appUserEmail);

  // Add recipe as a document to corresponding user collection.
  Future<void> _addSmoothieRecipe() async {
    await _currentUser.add({
      // recipe type
      'recipe type': 'Smoothie',

      // vegetables
      'ContainVegetables': _containVeggies,
      'broccoli': _broccoli,
      'carrot': _carrot,
      'cucumber': _cucumber,
      'lettuce': _lettuce,
      'spinach': _spinach,
      'zucchini': _zucchini,

      // fruits
      'ContainFruits': _containFruits,
      'apple': _apple,
      'banana': _banana,
      'blueberry': _blueberry,
      'grapes': _grapes,
      'kiwi': _kiwi,
      'mango': _mango,
      'melon': _melon,
      'orange': _orange,
      'papaya': _papaya,
      'peach': _peach,
      'pear': _pear,
      'pineapple': _pineapple,

      // liquid
      'ContainLiquid': _containLiquid,
      'coconut water': _coconutWater,
      'cold brew coffee': _coldBrewCoffee,
      'green tea': _greenTea,
      'juice': _juice,
      'milk': _milk,
      'yogurt': _yogurt,

      // protein boosters
      'ContainProteinBoosters': _containPB,
      'flax seeds': _flaxSeeds,
      'hemp seeds': _hempSeeds,
      'oats': _oats,
      'walnuts': _walnuts,

      // sweeteners
      'ContainSweeteners': _containSweeteners,
      'dates': _dates,
      'honey': _honey,
      'maple syrup': _mapleSyrup,
      'peanut butter': _peanutButter,

      'time': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    // Modify left padding if viewport's width is less than 425
    // Targeting all iOS models before iPhone 12
    double screenWidth = MediaQuery.of(context).size.width;
    double leftPadding = screenWidth <= 415 && Platform.isIOS ? 10 : 25;

    return Column(
      children: [
        // Checkboxes for vegetables
        Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColor.customizationBackground,
                borderRadius: BorderRadius.circular(5)),
            child: Column(children: [
              Row(children: const [
                Text('Vegetables:',
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
                                    value: _broccoli,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _broccoli = value!;
                                      });
                                      // debugPrint('$_broccoli');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Broccoli',
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
                                    value: _carrot,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _carrot = value!;
                                      });
                                      // debugPrint('$_carrot');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Carrot',
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
                                    value: _cucumber,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _cucumber = value!;
                                      });
                                      // debugPrint('$_cucumber');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Cucumber',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))
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
                                scale: 0.75,
                                child: Checkbox(
                                    value: _lettuce,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _lettuce = value!;
                                      });
                                      // debugPrint('$_lettuce');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Lettuce',
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
                                    value: _spinach,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _spinach = value!;
                                      });
                                      // debugPrint('$_spinach');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Spinach',
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
                                  value: _zucchini,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _zucchini = value!;
                                    });
                                    // debugPrint('$_zucchini');
                                  },
                                  activeColor: AppColor.activeCheckbox),
                            ),
                            const Text('Zucchini',
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ])),
                    )
                  ])
                ])
              ])
            ])), // End of vegetables
        const SizedBox(height: 5),

        // Checkboxes for fruits
        Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColor.customizationBackground,
                borderRadius: BorderRadius.circular(5)),
            child: Column(children: [
              Row(
                children: const [
                  Text('Fruits:',
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
                                scale: 0.75,
                                child: Checkbox(
                                    value: _apple,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _apple = value!;
                                      });
                                      // debugPrint('$_apple');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Apple',
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
                                    value: _banana,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _banana = value!;
                                      });
                                      // debugPrint('$_banana');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Banana',
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
                                    value: _blueberry,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _blueberry = value!;
                                      });
                                      // debugPrint('$_blueBerries');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Blueberry',
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
                                    value: _grapes,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _grapes = value!;
                                      });
                                      // debugPrint('$_grapes');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Grapes',
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
                                    value: _kiwi,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _kiwi = value!;
                                      });
                                      // debugPrint('$_kiwi');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Kiwi',
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
                                    value: _mango,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _mango = value!;
                                      });
                                      // debugPrint('$_mango');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Mango',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))
                            ])))
                  ])
                ]),
                const SizedBox(width: 30),
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
                                  value: _melon,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _melon = value!;
                                    });
                                    // debugPrint('$_melon');
                                  },
                                  activeColor: AppColor.activeCheckbox),
                            ),
                            const Text('Melon',
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ])),
                    )
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
                                  value: _orange,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _orange = value!;
                                    });
                                    // debugPrint('$_o');
                                  },
                                  activeColor: AppColor.activeCheckbox),
                            ),
                            const Text('Orange',
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ])),
                    )
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
                                  value: _papaya,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _papaya = value!;
                                    });
                                    // debugPrint('$_papaya');
                                  },
                                  activeColor: AppColor.activeCheckbox),
                            ),
                            const Text('Papaya',
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ])),
                    )
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
                                  value: _peach,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _peach = value!;
                                    });
                                    // debugPrint('$_peach');
                                  },
                                  activeColor: AppColor.activeCheckbox),
                            ),
                            const Text('Peach',
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ])),
                    )
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
                                    value: _pear,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _pear = value!;
                                      });
                                      // debugPrint('$_pear');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Pear',
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
                                    value: _pineapple,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _pineapple = value!;
                                      });
                                      // debugPrint('$_pineapple');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Pineapple',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))
                            ])))
                  ]),
                ])
              ])
            ])), // End of fruits
        const SizedBox(height: 5),

        // Checkboxes for liquid
        Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColor.customizationBackground,
                borderRadius: BorderRadius.circular(5)),
            child: Column(children: [
              Row(children: const [
                Text('Liquid:',
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
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 0.75,
                                  child: Checkbox(
                                      value: _coconutWater,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _coconutWater = value!;
                                        });
                                        // debugPrint('$_coconutWater');
                                      },
                                      activeColor: AppColor.activeCheckbox),
                                ),
                                const Text('Coconut Water',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ))
                              ],
                            )))
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
                                    value: _coldBrewCoffee,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _coldBrewCoffee = value!;
                                      });
                                      // debugPrint('$_coldBrewCoffee');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text("Cold Brew Coffee",
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
                                    value: _greenTea,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _greenTea = value!;
                                      });
                                      // debugPrint('$_greenTea');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Green Tea',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))
                            ])))
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
                                scale: 0.75,
                                child: Checkbox(
                                    value: _juice,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _juice = value!;
                                      });
                                      // debugPrint('$_juice');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Juice',
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
                                  value: _milk,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _milk = value!;
                                    });
                                    // debugPrint('$_milk');
                                  },
                                  activeColor: AppColor.activeCheckbox),
                            ),
                            const Text('Milk',
                                style: TextStyle(
                                  fontSize: 16,
                                ))
                          ])),
                    )
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
                                    value: _yogurt,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _yogurt = value!;
                                      });
                                      // debugPrint('$_yogurt');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Yogurt',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))
                            ])))
                  ])
                ])
              ])
            ])), // End of liquid
        const SizedBox(height: 5),

        // Checkboxes for protein boosters
        Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColor.customizationBackground,
                borderRadius: BorderRadius.circular(5)),
            child: Column(children: [
              Row(children: const [
                Text('Protein Boosters:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ))
              ]),
              const SizedBox(height: 5),
              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            height: 20,
                            child: Container(
                                padding: EdgeInsets.only(left: leftPadding),
                                child: Row(children: [
                                  Transform.scale(
                                    scale: 0.75,
                                    child: Checkbox(
                                        value: _flaxSeeds,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _flaxSeeds = value!;
                                          });
                                          // debugPrint('$_flaxSeeds');
                                        },
                                        activeColor: AppColor.activeCheckbox),
                                  ),
                                  const Text('Flax Seeds',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ))
                                ])))
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(
                            height: 20,
                            child: Container(
                                padding: EdgeInsets.only(left: leftPadding),
                                child: Row(children: [
                                  Transform.scale(
                                    scale: 0.75,
                                    child: Checkbox(
                                        value: _hempSeeds,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _hempSeeds = value!;
                                          });
                                          // debugPrint('$_hempSeeds');
                                        },
                                        activeColor: AppColor.activeCheckbox),
                                  ),
                                  const Text('Hemp Seeds',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ))
                                ])))
                      ],
                    )
                  ],
                ),
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
                                    value: _oats,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _oats = value!;
                                      });
                                      // debugPrint('$_oats');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Oats',
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
                                    value: _walnuts,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _walnuts = value!;
                                      });
                                      // debugPrint('$_walnuts');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Walnuts',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))
                            ])))
                  ])
                ])
              ])
            ])), // End of protein boosters
        const SizedBox(height: 5),

        // Checkboxes for sweeteners
        Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColor.customizationBackground,
                borderRadius: BorderRadius.circular(5)),
            child: Column(children: [
              Row(children: const [
                Text('Sweeteners:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ))
              ]),
              const SizedBox(height: 5),
              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          child: Container(
                              padding: EdgeInsets.only(left: leftPadding),
                              child: Row(children: [
                                Transform.scale(
                                  scale: 0.75,
                                  child: Checkbox(
                                      value: _dates,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _dates = value!;
                                        });
                                        // debugPrint('$_dates');
                                      },
                                      activeColor: AppColor.activeCheckbox),
                                ),
                                const Text('Dates',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ))
                              ])),
                        )
                      ],
                    ),
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
                                      value: _honey,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _honey = value!;
                                        });
                                        // debugPrint('$_honey');
                                      },
                                      activeColor: AppColor.activeCheckbox),
                                ),
                                const Text('Honey',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ))
                              ])))
                    ]),
                  ],
                ),
                const SizedBox(width: 45),
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
                                    value: _mapleSyrup,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _mapleSyrup = value!;
                                      });
                                      // debugPrint('$_mapleSyrup');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Maple Syrup',
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
                                    value: _peanutButter,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _peanutButter = value!;
                                      });
                                      // debugPrint('$_peanutButter');
                                    },
                                    activeColor: AppColor.activeCheckbox),
                              ),
                              const Text('Peanut Butter',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))
                            ])))
                  ])
                ])
              ])
            ])), // End of sweeteners

        // Save Button and Reset Button
        Container(
          padding: const EdgeInsets.only(left: 60, right: 60),
          child: Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _ingredientStatus();
                  if (_containVeggies ||
                      _containFruits ||
                      _containLiquid ||
                      _containPB ||
                      _containSweeteners) {
                    _addSmoothieRecipe();
                    Get.snackbar(
                      "Save Successfully", // snackbar Title
                      "", // place holder for message Text
                      messageText: (const Text(
                          "You have save your Smoothie Recipe successfully",
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
                    Get.snackbar(
                      "Save Unsuccessfully", // snackbar Title
                      "", // place holder for message Text
                      messageText: (const Text(
                          "An empty recipe can not be saved!",
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
                icon: const Icon(Icons.save_alt_rounded, color: Colors.black),
                label: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColor.activeButton1),
                  elevation: MaterialStateProperty.all<double>(3),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              ElevatedButton.icon(
                onPressed: () {
                  _ingredientStatus();
                  // Notification for reset button
                  Get.snackbar(
                    "Reset Title", // place holder for reset notification title
                    "Reset Message", // place holder for reset notification message text
                    titleText: (_containVeggies ||
                            _containFruits ||
                            _containLiquid ||
                            _containPB ||
                            _containSweeteners)
                        ? const Text("Reset Successfully",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))
                        : const Text("Reset Unsuccessful",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                    messageText: (_containVeggies ||
                            _containFruits ||
                            _containLiquid ||
                            _containPB ||
                            _containSweeteners)
                        ? const Text(
                            "You have reset Smoothie's customization back to default",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300))
                        : const Text(
                            "You have not modify Smoothie's default customization",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300)),
                    icon: (_containVeggies ||
                            _containFruits ||
                            _containLiquid ||
                            _containPB ||
                            _containSweeteners)
                        ? Icon(Elusive.ok_circled2,
                            size: 22, color: Colors.green.shade800)
                        : Icon(Elusive.cancel_circled2,
                            size: 22, color: Colors.red.shade800),
                    shouldIconPulse: false,
                    snackPosition: SnackPosition.TOP,
                    margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
                    backgroundColor: AppColor.snackbarBackground,
                    isDismissible: true,
                  );
                  _resetCustomization();
                },
                icon:
                    const Icon(Icons.restart_alt_rounded, color: Colors.black),
                label: const Text('Reset',
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColor.activeButton1),
                  elevation: MaterialStateProperty.all<double>(3),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ), // End of Save and Reset Button
      ],
    );
  }
}
