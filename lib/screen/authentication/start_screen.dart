import 'package:brava/screen/authentication/log_in.dart';
import 'package:brava/screen/authentication/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          SvgPicture.asset(
            'assets/svg/choose.svg',
            width: 100,
            height: 200,
          ),
          Stack(
            children: [
              SvgPicture.asset(
                'assets/svg/curve.svg',
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                height: 553,
              ),
              Column(
                children: [
                  const Gap(160),
                  const SizedBox(
                    width: 350,
                    child: Text(
                      "Lets' get start growing your skills",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Gap(25),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login_screen()));
                    },
                    child: Container(
                      height: 55,
                      width: 308,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(25),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp_screen()));
                    },
                    child: Container(
                      height: 55,
                      width: 308,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 20.0),
                          child: const Divider(
                            color: Colors.white,
                            height: 36,
                          ),
                        ),
                      ),
                      const Text(
                        "Or with",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 10.0),
                          child: const Divider(
                            color: Colors.white,
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
                        child: Image.network(
                            'http://pngimg.com/uploads/google/google_PNG19635.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
