import 'package:brava/api/api_service.dart';
import 'package:brava/screen/authentication/log_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SignUp_screen extends StatefulWidget {
  const SignUp_screen({super.key});

  @override
  State<SignUp_screen> createState() => _SignUp_screenState();
}

class _SignUp_screenState extends State<SignUp_screen> {
  bool isVisible = false;
  ApiService service = ApiService();
  TextEditingController nameController = TextEditingController();
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
            )),
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
              // add key and tartibat
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Row(
                    children: [
                      Padding(
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
                                    controller: nameController,
                                    style: TextStyle(
                                      color: outlineColor,
                                      fontSize: 18,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "First Name",
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 50,
                          width: 170,
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
                                Expanded(
                                  child: TextField(
                                    controller: lastnameController,
                                    style: TextStyle(
                                      color: outlineColor,
                                      fontSize: 18,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Last Name",
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
                      ),
                    ],
                  ),
                  const Gap(15),
                  Padding(
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
                              Icons.email_outlined,
                              color: outlineColor,
                              size: 29,
                            ),
                            const Gap(10),
                            Expanded(
                              child: TextField(
                                controller: emailController,
                                style: TextStyle(
                                  color: outlineColor,
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
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
                  ),
                  const Gap(10),
                  Padding(
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
                              Icons.password_outlined,
                              color: outlineColor,
                              size: 29,
                            ),
                            const Gap(10),
                            Expanded(
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                //obscureText: !isVisible,
                                style: TextStyle(
                                  color: outlineColor,
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    color: textColor,
                                    fontSize: 18,
                                  ),
                                  // suffixIcon: IconButton(
                                  //   onPressed: () {
                                  //     setState(() {
                                  //       isVisible = !isVisible;
                                  //     });
                                  //   },
                                  //   icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                                  //   color: outlineColor,
                                  // ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Padding(
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
                              Icons.password_outlined,
                              color: outlineColor,
                              size: 29,
                            ),
                            const Gap(10),
                            Expanded(
                              child: TextField(
                                controller: confirmPasswordController,
                                obscureText: true,
                                style: TextStyle(
                                  color: outlineColor,
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Confirm Password",
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Login_screen()));
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
                        service.signUp(nameController.text, lastnameController.text, emailController.text, passwordController.text);
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
