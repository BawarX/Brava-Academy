import 'package:brava/provider/bookmark.dart';
import 'package:flutter/material.dart';

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
              ? const Text("data is emppty")
              : ListView.builder(
                  itemCount: provider.cards.length,
                  itemBuilder: (context, index) {
                    return Container(
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
                                provider.cards[index].image,
                              ),
                            ),
                          ),
                          const Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    backgroundImage: AssetImage(provider.cards[index].image),
                                  ),
                                  const Gap(10),
                                  Text(provider.cards[index].courseTitle),
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
                    );
                  },
                );
        },
      ),
    );
  }
}
