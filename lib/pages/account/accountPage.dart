import 'login.dart';
import '../../colors.dart';
import '../../authentication/userAuthentication.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final Authentication _authenticatedUser = Authentication();
  late String appUserEmail = _authenticatedUser.getUserEmail();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.35;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Account',
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
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 160,
              height: 160,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 30),
                child: Image.asset('assets/splash.png'),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(children: [
                const SizedBox(height: 20),
                const Text('Welcome Back',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 20),
                Text(appUserEmail,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    )),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () async {
                    await _authenticatedUser.appSignOut();
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('email');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  icon: const Icon(Icons.output_outlined, color: Colors.black),
                  label: const Text('Logout',
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColor.activeButton1),
                    elevation: MaterialStateProperty.all<double>(3),
                    minimumSize: MaterialStateProperty.all(Size(width, 35)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.black26),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ]),
        ));
  }
}
