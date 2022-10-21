import '../../colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drinks/authentication/userAuthentication.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final Authentication _authenticatedUser = Authentication();
  late String appUserEmail = _authenticatedUser.getUserEmail();
  late Stream<QuerySnapshot> recipes = FirebaseFirestore.instance
      .collection(appUserEmail)
      .orderBy('time', descending: true)
      .snapshots();

  List<String> cleanRecipe(Map<String, dynamic> recipeDetails) {
    Map<String, dynamic> items = recipeDetails;
    List<String> description = [];
    final _teaType = RegExp(r'^[a-zA-Z]+Tea$');
    final _milkType = RegExp(r'^[a-zA-Z]+Milk$');
    final _iceLevel = RegExp(r'^[a-zA-Z]+Ice$');
    final _sugarLevel = RegExp(r'^[a-zA-Z]+Sugar$');
    final _toppings = RegExp(r'^[a-zA-Z]+\sjelly$');

    for (var key in items.keys) {
      var item = items[key];
      if (key != "recipe type" && key != "time" && items[key] != false) {
        if (items[key] is bool) {
          key = toBeginningOfSentenceCase(key)!;
          if (_toppings.hasMatch(key)) {
            var topping = key.split(" ");
            key = topping[0] + " " + "Jelly";
          }
          description.add(key);
        } else if (items[key] is String) {
          item = toBeginningOfSentenceCase(item);
          if (_teaType.hasMatch(item)) {
            item = item.split("Tea");
            item = item[0] + " " + "Tea";
          }
          if (_milkType.hasMatch(item)) {
            item = item.split("Milk");
            item = item[0] + " " + "Milk";
            if (item == 'TwoPerc Milk') {
              item = "2% Reduced Fat Milk";
            }
          }
          if (_iceLevel.hasMatch(item)) {
            item = item.split("Ice");
            item = item[0] + " " + "Ice";
          }
          if (_sugarLevel.hasMatch(item)) {
            item = item.split("Sugar");
            item = item[0] + " " + "Sugar";
          }
          if (item == 'ExtraDark') {
            item = 'Extra Dark';
          }
          description.add(item.toString());
        } else {
          String syrupName = "Caramel Syrup";
          if (key == "mocha count") {
            syrupName = "Mocha Syrup";
          } else if (key == 'vanilla count') {
            syrupName = "Vanilla Syrup";
          }
          if (item == 0) {
            description.add("0 pump");
          } else if (item == 1) {
            description.add(item.toString() + " pump of " + syrupName);
          } else {
            description.add(item.toString() + " pumps of " + syrupName);
          }
        }
      }
    }
    description.sort();
    return description;
  }

  TextStyle recipeTypeStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  TextStyle recipeTimeStyle = const TextStyle(fontSize: 15);
  TextStyle ingredientTextStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  TextStyle milkteaToppingsStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  TextStyle smoothieIngredientTypeTextStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

  Widget buildCoffee(Map<String, dynamic> item) {
    DateTime date = item['time'].toDate();
    String formattedDateTime = DateFormat('yyyy-MM-dd – hh:mm:a').format(date);
    final _coffeeMilkType = RegExp(r'^[a-zA-Z]+\sMilk$');
    final _coffeeIceLevel = RegExp(r'^[a-zA-Z]+\sIce');
    final _caramelCount = RegExp(r'^[0-9]+\s[a-z]+\sof\sCaramel\sSyrup$');
    final _mochaCount = RegExp(r'^[0-9]+\s[a-z]+\sof\sMocha\sSyrup$');
    final _vanillaCount = RegExp(r'^[0-9]+\s[a-z]+\sof\sVanilla\sSyrup$');

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColor.customizationBackground,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(item['recipe type'], style: recipeTypeStyle),
              ),
              const SizedBox(height: 5),

              // Coffee Roast Level
              for (var description in cleanRecipe(item))
                if (description == 'Light' ||
                    description == 'Medium' ||
                    description == 'Dark' ||
                    description == 'Extra Dark')
                  Text(
                    '\u2022\t' + description + ' Roast',
                    style: ingredientTextStyle,
                  ),

              // Coffee Milk Type
              for (var description in cleanRecipe(item))
                if (description != 'Without Milk' &&
                    (description == 'Oatmilk' ||
                        description == '2% Reduced Fat Milk' ||
                        _coffeeMilkType.hasMatch(description)))
                  Text('\u2022\t' + description, style: ingredientTextStyle),

              // Coffee Ice Level
              for (var description in cleanRecipe(item))
                if (description == 'Hot' ||
                    _coffeeIceLevel.hasMatch(description))
                  Text('\u2022\t' + description, style: ingredientTextStyle),

              // Caramel Syrup Count
              for (var description in cleanRecipe(item))
                if (description != '0 pump' &&
                    _caramelCount.hasMatch(description))
                  Text('\u2022\t' + description, style: ingredientTextStyle),

              // Mocha Syrup Count
              for (var description in cleanRecipe(item))
                if (description != '0 pump' &&
                    _mochaCount.hasMatch(description))
                  Text('\u2022\t' + description, style: ingredientTextStyle),

              // Vanilla Syrup Count
              for (var description in cleanRecipe(item))
                if (description != '0 pump' &&
                    _vanillaCount.hasMatch(description))
                  Text('\u2022\t' + description, style: ingredientTextStyle),

              // Whipped Cream
              for (var description in cleanRecipe(item))
                if (description == 'Whipped cream')
                  Text('\u2022\tWhipped Cream', style: ingredientTextStyle),

              const SizedBox(height: 10),
              Center(
                child: Text(formattedDateTime, style: recipeTimeStyle),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget buildMilkTea(Map<String, dynamic> item) {
    DateTime date = item['time'].toDate();
    String formattedDateTime = DateFormat('yyyy-MM-dd – hh:mm:a').format(date);
    final _teaType = RegExp(r'^[a-zA-Z]+\sTea');
    final _milkType = RegExp(r'^[a-zA-Z]+\sMilk');
    final _iceLevel = RegExp(r'^[a-zA-Z]+\sIce$');
    final _sugarLevel = RegExp(r'^[a-zA-Z]+\sSugar$');
    final _toppings = RegExp(r'^[a-zA-Z]+\sJelly$');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColor.customizationBackground,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(item['recipe type'],
                    style: recipeTypeStyle, textAlign: TextAlign.center),
              ),
              const SizedBox(height: 5),

              // Tea Type
              for (var description in cleanRecipe(item))
                if (_teaType.hasMatch(description))
                  Text('\u2022\t' + description, style: ingredientTextStyle),

              // Milk Type
              for (var description in cleanRecipe(item))
                if (description != 'Without Milk' &&
                    (description == 'Oatmilk' ||
                        description == '2% Reduced Fat Milk' ||
                        _milkType.hasMatch(description)))
                  Text('\u2022\t' + description, style: ingredientTextStyle),

              // Ice Level
              for (var description in cleanRecipe(item))
                if (description == 'Hot' || _iceLevel.hasMatch(description))
                  Text('\u2022\t' + description, style: ingredientTextStyle),

              // Sugar Level
              for (var description in cleanRecipe(item))
                if (_sugarLevel.hasMatch(description))
                  Text('\u2022\t' + description, style: ingredientTextStyle),

              // Cheese Foam
              for (var description in cleanRecipe(item))
                if (description == 'Cheese foam')
                  Text('\u2022\tCheese Foam', style: ingredientTextStyle),

              // Toppings
              // List all the toppings from the recipe if it contains toppings.
              for (var description in cleanRecipe(item))
                if (description == 'ContainToppings')
                  Text('\u2022\tToppings:', style: ingredientTextStyle),

              for (var description in cleanRecipe(item))
                if (_toppings.hasMatch(description) ||
                    description == 'Boba' ||
                    description == 'Pudding')
                  Text('\t\t\t' + description, style: milkteaToppingsStyle)
                else if (description == 'Red bean')
                  Text('\t\t\tRed Bean', style: milkteaToppingsStyle)
                else if (description == 'White pearl')
                  Text('\t\t\tWhite Pearl', style: milkteaToppingsStyle),

              const SizedBox(height: 10),
              Center(
                child: Text(formattedDateTime, style: recipeTimeStyle),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget buildSmoothie(Map<String, dynamic> item) {
    DateTime date = item['time'].toDate();
    String formattedDateTime = DateFormat('yyyy-MM-dd – hh:mm:a').format(date);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColor.customizationBackground,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(item['recipe type'], style: recipeTypeStyle),
              ),
              const SizedBox(height: 5),

              // List all the vegetables from the recipe if it contains vegetables.
              for (var description in cleanRecipe(item))
                if (description == 'ContainVegetables')
                  Text('\u2022\tVegetables:',
                      style: smoothieIngredientTypeTextStyle),

              for (var description in cleanRecipe(item))
                if (description == 'Broccoli' ||
                    description == 'Carrot' ||
                    description == 'Cucumber' ||
                    description == 'Lettuce' ||
                    description == 'Spinach' ||
                    description == 'Zucchini')
                  Text('\t\t\t' + description, style: ingredientTextStyle),

              // List all the fruits from the recipe if it contains fruits.
              for (var description in cleanRecipe(item))
                if (description == 'ContainFruits')
                  Column(
                    children: [
                      const SizedBox(height: 5),
                      Text('\u2022\tFruits:',
                          style: smoothieIngredientTypeTextStyle),
                    ],
                  ),

              for (var description in cleanRecipe(item))
                if (description == 'Apple' ||
                    description == 'Banana' ||
                    description == 'Blueberry' ||
                    description == 'Grapes' ||
                    description == 'Kiwi' ||
                    description == 'Mango' ||
                    description == 'Melon' ||
                    description == 'Orange' ||
                    description == 'Papaya' ||
                    description == 'Peach' ||
                    description == 'Pear' ||
                    description == 'Pineapple')
                  Text('\t\t\t' + description, style: ingredientTextStyle),

              // List the liquid from the recipe if it contains liquid.
              for (var description in cleanRecipe(item))
                if (description == 'ContainLiquid')
                  Column(
                    children: [
                      const SizedBox(height: 5),
                      Text('\u2022\tLiquid:',
                          style: smoothieIngredientTypeTextStyle),
                    ],
                  ),

              for (var description in cleanRecipe(item))
                if (description == 'Coconut water')
                  Text('\t\t\tCoconut Water', style: ingredientTextStyle)
                else if (description == 'Cold brew coffee')
                  Text('\t\t\tCold Brew Coffee', style: ingredientTextStyle)
                else if (description == 'Green tea')
                  Text('\t\t\tGreen Tea', style: ingredientTextStyle)
                else if (description == 'Juice' ||
                    description == 'Milk' ||
                    description == 'Yogurt')
                  Text('\t\t\t' + description, style: ingredientTextStyle),

              // List the protein boosters from the recipe if it contains protein boosters.
              for (var description in cleanRecipe(item))
                if (description == 'ContainProteinBoosters')
                  Column(
                    children: [
                      const SizedBox(height: 5),
                      Text('\u2022\tProtein Boosters:',
                          style: smoothieIngredientTypeTextStyle),
                    ],
                  ),

              for (var description in cleanRecipe(item))
                if (description == 'Flax seeds')
                  Text('\t\t\tFlax Seeds', style: ingredientTextStyle)
                else if (description == 'Hemp seeds')
                  Text('\t\t\tHemp Seeds', style: ingredientTextStyle)
                else if (description == 'Oats' || description == 'Walnuts')
                  Text('\t\t\t' + description, style: ingredientTextStyle),

              // List the sweeteners from the recipe if it contains sweeteners.
              for (var description in cleanRecipe(item))
                if (description == 'ContainSweeteners')
                  Column(
                    children: [
                      const SizedBox(height: 5),
                      Text('\u2022\tSweeteners:',
                          style: smoothieIngredientTypeTextStyle),
                    ],
                  ),

              for (var description in cleanRecipe(item))
                if (description == 'Dates' || description == 'Honey')
                  Text('\t\t\t' + description, style: ingredientTextStyle)
                else if (description == 'Maple syrup')
                  Text('\t\t\tMaple Syrup', style: ingredientTextStyle)
                else if (description == 'Peanut butter')
                  Text('\t\t\tPeanut Butter', style: ingredientTextStyle),

              const SizedBox(height: 10),
              Center(
                child: Text(formattedDateTime, style: recipeTimeStyle),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection(appUserEmail)
                    .get()
                    .then((snapshot) {
                  for (DocumentSnapshot doc in snapshot.docs) {
                    doc.reference.delete();
                  }
                });
              },
              icon: const Icon(Icons.delete_forever,
                  size: 30, color: Color(0xFFB95C50))),
          const SizedBox(width: 15)
        ],
        backgroundColor: AppColor.navigationTopBarBackground,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: recipes,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint('Check Firestore');
            return const Text('Data is unavailable, something is wrong.');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.orange.shade300),
                strokeWidth: 6,
              ),
            );
          }
          if (snapshot.data!.size == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.coffee_rounded,
                    size: 66,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'History List is empty.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.size,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  snapshot.data?.docs[index].data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Dismissible(
                  key: Key(snapshot.data!.docs[index].id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    FirebaseFirestore.instance
                        .collection(appUserEmail)
                        .doc(snapshot.data!.docs[index].id)
                        .delete();
                  },
                  background: Container(
                    color: Colors.red.shade300,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.cancel, color: Colors.brown.shade800),
                          const SizedBox(width: 5),
                          Text(
                            'Remove Recipe',
                            style: TextStyle(
                              color: Colors.brown.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  child: Card(
                    color: AppColor.customizationBackground,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColor.customizationBackground,
                        border: Border.all(width: 0.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          data['recipe type'] == 'Coffee'
                              ? buildCoffee(data)
                              : snapshot.data?.docs[index]['recipe type'] ==
                                          'Milk Tea' ||
                                      snapshot.data?.docs[index]
                                              ['recipe type'] ==
                                          'Tea'
                                  ? buildMilkTea(data)
                                  : snapshot.data?.docs[index]['recipe type'] ==
                                          'Smoothie'
                                      ? buildSmoothie(data)
                                      : const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
