import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kurakani/core/common/custom_button.dart';
import 'package:kurakani/core/common/custom_text_field.dart';
import 'package:kurakani/presentation/screens/auth/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  final _nameFocus = FocusNode();
  final _userNameFocus = FocusNode();
  final _phoneNumberFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _emailFocus = FocusNode();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneNoController.dispose();
    userNameController.dispose();
    _nameFocus.dispose();
    _userNameFocus.dispose();
    _emailFocus.dispose();
    _phoneNumberFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }

  ///Name validation
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your name";
    }
    return null;
  }

  ///User name validation
  String? _validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your user name";
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

  ///phone number validation
  String? _validatePhoneNo(String? value) {
    if (value == null || value.isEmpty) {
      return "Please your phone number";
    }
    final RegExp phoneNoPattern = RegExp(r'^\d+$');
    if (!phoneNoPattern.hasMatch(value)) {
      return "Please enter a valid phone number";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Account",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Please fill in the details to continue",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 20),

                /// Text field for Name
                CustomTextField(
                  controller: nameController,
                  hintText: "Full Name",
                  validator: _validateName,
                  focusNode: _nameFocus,
                  prefixIcon: Icon(Icons.person),
                ),
                SizedBox(height: 20),

                /// Text field for User Name
                CustomTextField(
                  controller: userNameController,
                  hintText: "User Name",
                  focusNode: _userNameFocus,
                  validator: _validateUserName,
                  prefixIcon: Icon(Icons.alternate_email_sharp),
                ),
                SizedBox(height: 20),

                /// Text field for Email
                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                  focusNode: _emailFocus,
                  validator: _validateEmail,
                  prefixIcon: Icon(Icons.mail_outline),
                ),
                SizedBox(height: 20),

                /// Text field for Phone no
                CustomTextField(
                  controller: phoneNoController,
                  hintText: "Phone Number",
                  validator: _validatePhoneNo,
                  focusNode: _phoneNumberFocus,
                  prefixIcon: Icon(Icons.phone),
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                SizedBox(height: 20),

                /// Text field for Password
                CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: !_isPasswordVisible,
                  prefixIcon: Icon(Icons.lock_outline_sharp),
                  validator: _validatePassword,
                  focusNode: _passwordFocus,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                CustomButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState?.validate() ?? false) {}
                    debugPrint("Create account button clicked");
                  },
                  text: "Create Account",
                ),

                SizedBox(height: 15),

                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: " Login",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
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
