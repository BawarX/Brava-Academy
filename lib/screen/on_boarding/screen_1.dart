import 'package:brava/api/data/on_boarding_data.dart';
import 'package:brava/screen/authentication/start_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class OnBoarding_1 extends StatefulWidget {
  const OnBoarding_1({super.key});

  @override
  State<OnBoarding_1> createState() => _OnBoarding_1State();
}

class _OnBoarding_1State extends State<OnBoarding_1> {
  late PageController _pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  if (index >= 0 && index < demo_data.length) {
                    pageIndex = index;
                  }
                });
              },
              itemCount: demo_data.length,
              itemBuilder: (context, index) => OnboardingScreen(
                image: demo_data[index].image,
                title: demo_data[index].title,
                description: demo_data[index].description,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  demo_data.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: dot_indicator(
                      isActive: index == pageIndex,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Gap(100),
          GestureDetector(
            onTap: () {
              setState(() {
                if (pageIndex == demo_data.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InitialPages(),
                    ),
                  );
                }
                _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  pageIndex == 2
                      ? const Text(
                          "Let's Start",
                          style: TextStyle(
                            color: Color.fromARGB(255, 106, 90, 223),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const Text(
                          'Next',
                          style: TextStyle(
                            color: Color.fromARGB(255, 106, 90, 223),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Color.fromARGB(255, 106, 90, 223),
                  ),
                ],
              ),
            ),
          ),
          const Gap(90),
        ],
      ),
    );
  }
}

class dot_indicator extends StatelessWidget {
  const dot_indicator({
    super.key,
    this.isActive = false,
  });
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return isActive
        ? Container(
            width: 30,
            height: 13,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: const BorderRadius.all(Radius.circular(25))),
          )
        : Container(
            width: 13,
            height: 13,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 195, 172, 208),
              shape: BoxShape.circle,
            ),
          );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({
    super.key,
    required this.title,
    required this.image,
    required this.description,
  });
  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          color: const Color.fromARGB(255, 255, 251, 245),
          width: double.infinity,
          child: Center(
            child: Image.asset(image),
          ),
        ),
        const Gap(10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 106, 90, 223),
          ),
        ),
        const Gap(10),
        Text(
          textAlign: TextAlign.center,
          description,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 206, 187, 215)),
        ),
      ],
    );
  }
}
