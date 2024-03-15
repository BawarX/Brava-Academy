import 'package:brava/model/courses.dart';
import 'package:brava/provider/bookmark.dart';
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
                                    'assets/images/course1.png',
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
                                  const Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 15,
                                          backgroundImage: AssetImage(
                                            'assets/images/course1.png',
                                          )),
                                      Gap(10),
                                      //   Text(provider.cards[index].courseTitle),
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
                    );
                  },
                );
        },
      ),
    );
  }
}
