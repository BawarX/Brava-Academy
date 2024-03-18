import 'package:brava/model/courses.dart';
import 'package:brava/provider/bookmark.dart';
import 'package:brava/screen/Home/course_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:gap/gap.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class BookMark extends StatefulWidget {
  const BookMark({super.key});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Course Detail",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<BookmarkProvider>(
        builder: (context, provider, child) {
          return provider.cards.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/no_data.svg',
                        width: 150,
                        height: 250,
                      ),
                      const Text(
                        "Nothing Bookmakred",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: provider.cards.length,
                  itemBuilder: (context, index) {
                    Course courseModel = provider.cards[index];
                    return Dismissible(
                      onDismissed: (direction) {
                        bookmarkProvider.removeItem(courseModel);
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      key: ValueKey<Course>(courseModel),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail(course: courseModel)));
                          },
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
                                    child: Image.network(
                                      provider.cards[index].backgroundImage,
                                      width: 150,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      courseModel.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          provider.cards[index].description,
                                        )
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
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
