import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BookMark extends StatelessWidget {
  const BookMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
            )),
        title: const Text(
          "Course Detail",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return const course_bookmarked();
          },
        ),
      ),
    );
  }
}

class course_bookmarked extends StatelessWidget {
  const course_bookmarked({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(
              color: Theme.of(context).primaryColor,
            )),
        child: Row(
          children: [
            const Gap(10),
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: SizedBox(
                width: 150,
                child: Image.asset(
                  "assets/images/course1.png",
                ),
              ),
            ),
            const Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Web Development",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage('assets/images/guy1.png'),
                    ),
                    Gap(10),
                    Text("Zhyar Abubakr"),
                  ],
                ),
                LinearPercentIndicator(
                  width: 190.0,
                  lineHeight: 11.0,
                  percent: 0.5,
                  backgroundColor: Colors.grey,
                  progressColor: Theme.of(context).primaryColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
