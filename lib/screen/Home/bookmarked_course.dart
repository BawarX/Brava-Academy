import 'dart:convert';

import 'package:brava/constant.dart';
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
  List<CourseModel> bookmark = [];
  void getData() {
    print('hi2===================================');
    List<String>? cardsListString = sharedPreferences.getStringList('bookmark');
    print('hi3===================================');
    if (cardsListString != null) {
      // bookmark =
      cardsListString.map((e) {
        print(e);
        return CourseModel.fromJsonforsharedpref(
          jsonDecode(e),
        );
      }).toList();
      print('hi4===================================');
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
    print('hi=========================');
  }

  @override
  Widget build(BuildContext context) {
    print(bookmark);
    final bookmarkProvider =
        Provider.of<BookmarkProvider>(context, listen: false);
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
          "Watch Later",
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
                        'assets/svg/noitem.svg',
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
                    CourseModel courseModel = provider.cards[index];
                    return Dismissible(
                      key: ValueKey<CourseModel>(courseModel),
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
                      child: Padding(
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
                                  width: 155,
                                  height: 100,
                                  child: Image.network(
                                    provider.cards[index].image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const Gap(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    provider.cards[index].courseTitle,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundImage: NetworkImage(
                                            provider.cards[index].image),
                                      ),
                                      const Gap(10),
                                      Text(provider.cards[index].authorName),
                                    ],
                                  ),
                                  LinearPercentIndicator(
                                    width: 190.0,
                                    lineHeight: 11.0,
                                    percent: 0.5,
                                    backgroundColor: Colors.grey,
                                    progressColor:
                                        Theme.of(context).primaryColor,
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
