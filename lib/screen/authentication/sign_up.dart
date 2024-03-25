import 'package:brava/api/api_service.dart';
import 'package:brava/screen/authentication/log_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:quickalert/quickalert.dart';

class SignUp_screen extends StatefulWidget {
  const SignUp_screen({super.key});

  @override
  State<SignUp_screen> createState() => _SignUp_screenState();
}

class _SignUp_screenState extends State<SignUp_screen> {
  final _formKey = GlobalKey<FormState>();
  bool isVisible = false;
  ApiService service = ApiService();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Color outlineColor = Theme.of(context).primaryColor;
    Color fillColor = Colors.white;
    Color textColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: outlineColor,
        title: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: fillColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(50),
            SvgPicture.asset(
              'assets/svg/signin.svg',
              width: 100,
              height: 150,
            ),
            const Gap(60),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Row(
                    children: [
                      FirstNameAndLastNameCard(
                        outlineColor: outlineColor,
                        controller: firstnameController,
                        textColor: textColor,
                        hint: 'First Name',
                      ),
                      FirstNameAndLastNameCard(
                        outlineColor: outlineColor,
                        controller: lastnameController,
                        textColor: textColor,
                        hint: 'Last Name',
                      ),
                    ],
                  ),
                  const Gap(15),
                  EmailAndPasswordAndConfirmPasswordCard(
                    fillColor: fillColor,
                    outlineColor: outlineColor,
                    controller: emailController,
                    textColor: textColor,
                    icon: Icons.email_outlined,
                    hint: 'Email',
                  ),
                  const Gap(10),
                  EmailAndPasswordAndConfirmPasswordCard(
                    fillColor: fillColor,
                    outlineColor: outlineColor,
                    controller: passwordController,
                    textColor: textColor,
                    icon: Icons.password_outlined,
                    hint: 'Confirm Password',
                  ),
                  const Gap(10),
                  EmailAndPasswordAndConfirmPasswordCard(
                    fillColor: fillColor,
                    outlineColor: outlineColor,
                    controller: confirmPasswordController,
                    textColor: textColor,
                    icon: Icons.password_outlined,
                    hint: 'Confirm Password',
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: outlineColor,
                          ),
                        ),
                      ),
                      const Gap(10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login_screen()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: outlineColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(40),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (firstnameController.text.isEmpty ||
                            lastnameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            confirmPasswordController.text.isEmpty) {
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              text: "Please fill all fields");
                          return;
                        } else {
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'SomeThing Went Wrong',
                                text:
                                    'Password and Confirm Password Don\'t match',
                                autoCloseDuration: const Duration(seconds: 3));
                            return;
                          }
                          print(firstnameController.text);
                          print(lastnameController.text);
                          print(emailController.text);
                          print(passwordController.text);
                          print(confirmPasswordController.text);
                          // service.signUp(
                          service.signUp(
                              firstnameController.text,
                              lastnameController.text,
                              emailController.text,
                              passwordController.text,
                              context);
                        }
                      },
                      child: Container(
                        height: 45,
                        width: 308,
                        decoration: BoxDecoration(
                          color: outlineColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailAndPasswordAndConfirmPasswordCard extends StatelessWidget {
  const EmailAndPasswordAndConfirmPasswordCard({
    super.key,
    required this.fillColor,
    required this.outlineColor,
    required this.controller,
    required this.textColor,
    required this.hint,
    required this.icon,
  });

  final Color fillColor;
  final Color outlineColor;
  final TextEditingController controller;
  final Color textColor;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: outlineColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Gap(10),
              Icon(
                icon,
                color: outlineColor,
                size: 29,
              ),
              const Gap(10),
              Expanded(
                child: TextField(
                  controller: controller,
                  style: TextStyle(
                    color: outlineColor,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: textColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstNameAndLastNameCard extends StatelessWidget {
  const FirstNameAndLastNameCard({
    super.key,
    required this.outlineColor,
    required this.controller,
    required this.textColor,
    required this.hint,
  });
  final String hint;
  final Color outlineColor;
  final TextEditingController controller;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 50,
        width: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: outlineColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Gap(10),
              Expanded(
                child: TextField(
                  controller: controller,
                  style: TextStyle(
                    color: outlineColor,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: textColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
