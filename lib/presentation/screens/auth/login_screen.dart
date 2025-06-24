import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kurakani/core/common/custom_button.dart';
import 'package:kurakani/core/common/custom_text_field.dart';
import 'package:kurakani/presentation/screens/auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  final _passwordFocus = FocusNode();
  final _emailFocus = FocusNode();

  ///password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a password";
    }
    if (value.length < 8) {
      return "Password must be atleast 8 character long";
    }
    return null;
  }

  ///email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email address";
    }
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Please enter a valid email address. (e.g laxman@gmail.com )";
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  "Welcome Back",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Sign in to continue",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 38),

                ///Email text field
                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: Icon(Icons.mail_outline),
                  validator: _validateEmail,
                  focusNode: _emailFocus,
                ),
                SizedBox(height: 16),

                ///Password text field
                CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                  validator: _validatePassword,
                  prefixIcon: Icon(Icons.lock_outline_sharp),
                  focusNode: _passwordFocus,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                        debugPrint("Visibility: $isPasswordVisible");
                      });
                    },
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                SizedBox(height: 35),
                CustomButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState?.validate() ?? false) {}
                    debugPrint("Button clicked");
                  },
                  text: "Login",
                ),
                SizedBox(height: 35),

                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: " Sign up",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
