import 'package:brava/api/api_service.dart';
import 'package:brava/model/courses.dart';
import 'package:brava/model/instructor_model.dart';
import 'package:brava/screen/Home/course_detail.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key, required this.instructor});
  final Instructor instructor;
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(widget.instructor.image),
                ),
              ),
            ),
            const Gap(15),
            Text(
              widget.instructor.fullname,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Gap(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Courses",
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '0',
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Rank",
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '0',
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "User Courses",
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            FutureBuilder(
              future: ApiService.fetchusercourses(widget.instructor.id),
              builder: (context, snapshot) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: snapshot.data == null
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CourseDetail(
                                      courseModel: CourseModel.fromJson(
                                        snapshot.data![index],
                                      ),
                                      authorName: widget.instructor.fullname,
                                      authorImage: widget.instructor.image),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data![index]['backgroundImage']),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Gap(10),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Gap(5),
                                        Text(
                                          "${snapshot.data![index]['name']}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${snapshot.data![index]['description']}",
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
