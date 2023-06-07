import 'package:flutter/material.dart';
import 'package:my_grocery/controller/controllers.dart';
import 'package:my_grocery/extention/string_extention.dart';

import '../../../components/input_outline_button.dart';
import '../../../components/input_text_button.dart';
import '../../../components/input_text_filed.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Text(
                  'Create Account,',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Sign Up to started!',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2,
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
                InputTextField(
                  title: 'Full Name',
                  textEditingController: fullNameController,
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'This field required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                InputTextField(
                  title: 'Email',
                  textEditingController: emailController,
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'This field required';
                    } else {
                      if (!value.isValidEmail) {
                        return 'please enter a valid email';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                InputTextField(
                  title: 'Password',
                  textEditingController: passwordController,
                  validation: (String? value) {
                    // ignore: no_leading_underscores_for_local_identifiers
                    List<String> _validation = [];
                    if (value == null || value.isEmpty) {
                      return 'This field required';
                    } else {
                      if (!value.isValidPasswordHasNumber) {
                        _validation.add('Must contine 1 number');
                      }
                      if (!value.isValidPasswordHasCapitalLetter) {
                        _validation.add('Must contine 1 Capital Letter');
                      }
                      if (!value.isValidPasswordHasLowerCaseLetter) {
                        _validation.add('Must contine 1 LowerCase Letter');
                      }
                      if (!value.isValidPasswordHasSpecialCharacter) {
                        _validation.add(
                            'Must contine 1 Special Character [! @ # \$ %]');
                      }
                    }
                    String msg = '';
                    if (_validation.isNotEmpty) {
                      for (var i = 0; i < _validation.length; i++) {
                        msg = msg + _validation[i];
                        if ((i + 1) != _validation.length) {
                          msg = '$msg\n';
                        }
                      }
                    }
                    return msg.isNotEmpty ? msg : null;
                  },
                  obsecureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                InputTextField(
                  title: 'Confirm Password',
                  textEditingController: confirmPasswordController,
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'This field required';
                    } else if (passwordController.text != value) {
                      return 'Confirm password not match';
                    }
                    return null;
                  },
                  obsecureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Spacer(),
                InputTextButton(
                  title: 'Sign Up',
                  onClick: () {
                    if (_formkey.currentState!.validate()) {
                      authController.signUp(
                        fullName: fullNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                InputOutlineButton(
                  title: 'Back',
                  onClick: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Spacer(
                  flex: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "I Alredy Have Account, ",
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
