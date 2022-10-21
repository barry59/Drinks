// ignore_for_file: prefer_const_constructors
import 'signup.dart';
import '../../colors.dart';
import '../../home_page.dart';
import '../../model/user.dart';
import '../../authentication/userAuthentication.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  // Remove splash screen
  void initialization() async => FlutterNativeSplash.remove();

  // Initialize a form key for login page
  final _formKey = GlobalKey<FormState>();

  // Initialize two text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Create an instance of authenticated user and get user's email
  late final Authentication _authenticatedUser = Authentication();
  late final String appUserEmail = _authenticatedUser.getUserEmail();

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    // Email Input Field
    final emailInputField = Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: AppColor.activeTextFieldIcon,
              ),
        ),
        child: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onSaved: (value) {
            _emailController.text = value!;
          },
          validator: (value) {
            if (value != null &&
                value.contains('@') &&
                (value.endsWith('.com') || value.endsWith('.net'))) {
              return null;
            }
            return 'Please enter a valid Email Address';
          },
          decoration: InputDecoration(
            hintText: 'Email',
            prefixIcon: const Icon(Icons.email_outlined),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColor.activeTextFieldBorder, width: 2),
                borderRadius: BorderRadius.circular(10)),
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          cursorColor: Colors.black,
        ));

    // Password Input Field
    final passwordInputField = Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: AppColor.activeTextFieldIcon,
              ),
        ),
        child: TextFormField(
          controller: _passwordController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          obscureText: _isObscure,
          onSaved: (value) {
            _passwordController.text = value!;
          },
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Password field is required.';
            } else if (value.trim().length < 6) {
              return 'Password must be at least 6 characters in length';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
                onPressed: () => {
                      setState(() {
                        _isObscure = !_isObscure;
                      })
                    },
                icon: Icon(_isObscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColor.activeTextFieldBorder, width: 2),
                borderRadius: BorderRadius.circular(10)),
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          cursorColor: Colors.black,
        ));

    // Login-in Button
    double width = MediaQuery.of(context).size.width * 0.35;
    final loginButton = TextButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            dynamic result = await _authenticatedUser.appLogin(AppUser(
                emailAddress: _emailController.text,
                password: _passwordController.text));
            if (result.uid == null) {
              Get.snackbar(
                "Fail to Login",
                "", // place holder for message Text
                messageText: Text(result.errorCode,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w300)),
                icon: Icon(Elusive.cancel_circled2,
                    size: 22, color: Colors.red.shade800),
                shouldIconPulse: false,
                snackPosition: SnackPosition.TOP,
                margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
                backgroundColor: AppColor.snackbarBackground,
                isDismissible: true,
              );
            } else {
              Get.snackbar(
                "Login Successfully",
                "", // place holder for message Text
                messageText: const Text("Have fun with customizing your drinks",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
                icon: Icon(Elusive.ok_circled2,
                    size: 22, color: Colors.green.shade800),
                shouldIconPulse: false,
                snackPosition: SnackPosition.TOP,
                margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
                backgroundColor: AppColor.snackbarBackground,
                isDismissible: true,
              );
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('email', appUserEmail);
              // Navigate to home page if user logins successfully.
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            }
          }
        },
        child: const Text('Login',
            style: TextStyle(color: Colors.black, fontSize: 18)),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColor.activeButton1),
            minimumSize: MaterialStateProperty.all(Size(width, 35)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.black26),
            ))));

    return Scaffold(
      body: SingleChildScrollView(
        physics: Platform.isIOS
            ? const BouncingScrollPhysics()
            : const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              const SizedBox(height: 120),
              SizedBox(
                width: 160,
                height: 160,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 30,
                  ),
                  child: Image.asset(
                    'assets/splash.png',
                  ),
                ),
              ),
              const Text(
                'Hello',
                style: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                'Login to your account',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              emailInputField,
              const SizedBox(height: 15),
              passwordInputField,
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Don't have an account? ",
                    style: TextStyle(fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    // temporary
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: AppColor.userAuth,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 15),
              loginButton,
            ]),
          ),
        ),
      ),
    );
  }
}
