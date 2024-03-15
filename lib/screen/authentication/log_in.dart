import 'package:brava/api/api_service.dart';
import 'package:brava/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({super.key});

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  bool isVisisble = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ApiService service = ApiService();
  late SharedPreferences localStorage;

  // Future checkLogin() async {
  //   if (emailController.text == email && passwordController.text == password) {

  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Color outlineColor = Theme.of(context).primaryColor;
    Color fillColor = Colors.white;
    Color textColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: outlineColor,
        title: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(40),
            SvgPicture.asset(
              'assets/svg/login.svg',
              width: 100,
              height: 150,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const Gap(90),
                  const Gap(30),
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
                              child: TextFormField(
                                controller: emailController,
                                style: TextStyle(
                                  color: outlineColor,
                                  fontSize: 18,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter some text';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    color: outlineColor,
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
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: !isVisisble,
                                style: TextStyle(
                                  color: outlineColor,
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    color: outlineColor,
                                    fontSize: 18,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisisble = !isVisisble;
                                      });
                                    },
                                    icon: Icon(isVisisble ? Icons.visibility : Icons.visibility_off),
                                    color: outlineColor,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  } else if (value.length < 8) {
                                    return 'Password must be at least 8 characters';
                                  }
                                  return null; // Return null if validation passes
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forget Password?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: outlineColor,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(25),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        service.login(email: emailController.text, password: passwordController.text, context: context);
                      } else {}
                    },
                    child: Container(
                      height: 45,
                      width: 308,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: outlineColor),
                      ),
                      child: const Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(30),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                          child: Divider(
                            color: Theme.of(context).primaryColor,
                            height: 36,
                          ),
                        ),
                      ),
                      Text(
                        "Or with",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                          child: Divider(
                            color: Theme.of(context).primaryColor,
                            height: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  GestureDetector(
                    onTap: () {
                      print("white is missing");
                    },
                    child: SizedBox(
                      width: 60,
                      height: 50,
                      child: Container(
                        child: Image.network('http://pngimg.com/uploads/google/google_PNG19635.png', fit: BoxFit.cover),
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
