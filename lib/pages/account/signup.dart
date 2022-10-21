import '../../colors.dart';
import '../../model/user.dart';
import '../../authentication/userAuthentication.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // Initialize a form key for sign up page
  final _formKey = GlobalKey<FormState>();

  // Create an instance of authenticated user and get user's email
  late final Authentication _authenticatedUser = Authentication();

  // Initialize three text controllers
  final TextEditingController _emailSignUpController = TextEditingController();
  final TextEditingController _passwordSignUpController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);

    // Sign up Page Email Input Field
    final emailSignUpInputField = Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: AppColor.activeTextFieldIcon,
              ),
        ),
        child: TextFormField(
          controller: _emailSignUpController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onSaved: (value) {
            _emailSignUpController.text = value!;
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

    // Sign up Page Password Input Field
    final passwordSignUpInputField = Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: AppColor.activeTextFieldIcon,
              ),
        ),
        child: TextFormField(
          controller: _passwordSignUpController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          obscureText: true,
          onEditingComplete: () => focus.nextFocus(),
          onSaved: (value) {
            _passwordSignUpController.text = value!;
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

    // Confirm Password Input Field
    final confirmPasswordInputField = Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: AppColor.activeTextFieldIcon,
              ),
        ),
        child: TextFormField(
          controller: _confirmPasswordController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          obscureText: true,
          onSaved: (value) {
            _confirmPasswordController.text = value!;
          },
          validator: (value) {
            if (value != _passwordSignUpController.text) {
              return 'Passwords DO NOT Match';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Confirm Password',
            prefixIcon: const Icon(Icons.lock_outline),
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

    // Sign Up Button
    double width = MediaQuery.of(context).size.width * 0.35;
    final signUpButton = TextButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            dynamic result = await _authenticatedUser.appSignUp(AppUser(
                emailAddress: _emailSignUpController.text,
                password: _passwordSignUpController.text));
            if (result.uid == null) {
              Get.snackbar(
                "Fail to Sign Up",
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
                "Sign Up Successfully",
                "", // place holder for message Text
                messageText: const Text("Please login to your account",
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
              Navigator.of(context).pop();
            }
          }
        },
        child: const Text('Sign Up',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            )),
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
        appBar: AppBar(
          leading: IconButton(
              icon: Platform.isIOS
                  ? Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24,
                      color: AppColor.userAuth,
                    )
                  : Icon(Icons.arrow_back_outlined,
                      size: 24, color: AppColor.userAuth),
              onPressed: () => Navigator.of(context).pop()),
          title: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Text(
              'Login',
              style: TextStyle(color: AppColor.userAuth),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          leadingWidth: 20,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            physics: Platform.isIOS
                ? const BouncingScrollPhysics()
                : const ClampingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 10),
                  emailSignUpInputField,
                  const SizedBox(height: 15),
                  passwordSignUpInputField,
                  const SizedBox(height: 15),
                  confirmPasswordInputField,
                  const SizedBox(height: 20),
                  signUpButton,
                ],
              ),
            ),
          ),
        ));
  }
}
