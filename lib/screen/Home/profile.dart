import 'dart:convert';

import 'package:brava/api/api_service.dart';
import 'package:brava/constant.dart';
import 'package:brava/data/course_data.dart';
import 'package:brava/screen/Home/add-course-page/add_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:quickalert/quickalert.dart';

import '../authentication/start_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var user = jsonDecode(sharedPreferences.getString('user')!);
  int courseNumber = 0;
  int rank = 0;
  // getCourseNumberAndTotalStudent() {
  //   for (var element in courseData) {
  //     if (element.authorId == user['_id']) {
  //       courseNumber++;
  //       rank = rank + element.rank;
  //     }
  //   }
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getCourseNumberAndTotalStudent();
  // }

  @override
  Widget build(BuildContext context) {
    String name = "${user['firstname']} ${user['lastname']}";

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
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
                  image: NetworkImage(user['image']),
                ),
              ),
            ),
            const Gap(15),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await sharedPreferences.clear();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Screen1()));
                    },
                    child: const Text('sing ot')),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const Gap(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Courses",
                      style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      courseNumber.toString(),
                      style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Rank",
                      style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      rank.toString(),
                      style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
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
                  "My Courses",
                  style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            // !snapshot.hasData
            //     ? const Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     :
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ListView.builder(
            //     physics: const NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     itemCount: courseData.length,
            //     itemBuilder: ((context, index) {
            //       return courseData[index].authorId == user['_id']
            //           ? Slidable(
            //               direction: Axis.horizontal,
            //               endActionPane: ActionPane(motion: const ScrollMotion(), children: [
            //                 GestureDetector(
            //                   onTap: () {
            //                     QuickAlert.show(
            //                         context: context,
            //                         type: QuickAlertType.warning,
            //                         title: 'Delete Course',
            //                         text: 'Are you sure you want to delete this course?',
            //                         confirmBtnText: 'Delete',
            //                         confirmBtnColor: Colors.red,
            //                         onConfirmBtnTap: () async {
            //                           await ApiService.deleteTheCourse('65da56a27c222049a01fce72');
            //                           courseData.removeAt(index);
            //                           Navigator.pop(context);
            //                           setState(() {});
            //                         },
            //                         cancelBtnText: 'Cancel',
            //                         showCancelBtn: true,
            //                         onCancelBtnTap: () {
            //                           Navigator.pop(context);
            //                         });
            //                   },
            //                   child: Container(
            //                     width: 80,
            //                     height: 100,
            //                     color: Colors.red,
            //                     child: const Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       crossAxisAlignment: CrossAxisAlignment.center,
            //                       children: [
            //                         Icon(
            //                           Icons.delete,
            //                           size: 26,
            //                           color: Colors.white,
            //                         ),
            //                         Gap(5),
            //                         Text(
            //                           'Delete',
            //                           style: TextStyle(color: Colors.white, fontSize: 20),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //                 GestureDetector(
            //                   onTap: () {
            //                     Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMyCourse()));
            //                   },
            //                   child: Container(
            //                     width: 80,
            //                     height: 100,
            //                     color: Theme.of(context).primaryColor,
            //                     child: const Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       crossAxisAlignment: CrossAxisAlignment.center,
            //                       children: [
            //                         Icon(
            //                           Icons.edit,
            //                           size: 26,
            //                           color: Colors.white,
            //                         ),
            //                         Gap(5),
            //                         Text(
            //                           'Edit',
            //                           style: TextStyle(color: Colors.white, fontSize: 20),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ]),
            //               child: Container(
            //                 margin: const EdgeInsets.all(5),
            //                 decoration: BoxDecoration(
            //                   border: Border.all(),
            //                   borderRadius: BorderRadius.circular(25),
            //                 ),
            //                 child: Row(
            //                   children: [
            //                     Expanded(
            //                       flex: 1,
            //                       child: Container(
            //                         width: 100,
            //                         height: 100,
            //                         decoration: const BoxDecoration(
            //                           shape: BoxShape.rectangle,
            //                           // image: DecorationImage(
            //                           //   image: NetworkImage(courseData[index].image),
            //                           //   fit: BoxFit.cover,
            //                           // ),
            //                           borderRadius: BorderRadius.only(
            //                             topLeft: Radius.circular(25),
            //                             bottomLeft: Radius.circular(25),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     const Gap(10),
            //                     Expanded(
            //                       flex: 2,
            //                       child: Column(
            //                         crossAxisAlignment: CrossAxisAlignment.center,
            //                         children: [
            //                           const Gap(5),
            //                           Text(
            //                             courseData[index].courseTitle,
            //                             style: TextStyle(
            //                               fontSize: 18,
            //                               fontWeight: FontWeight.bold,
            //                               color: Theme.of(context).primaryColor,
            //                             ),
            //                           ),
            //                           const Gap(5),
            //                           Row(
            //                             children: [
            //                               Container(
            //                                 width: 90,
            //                                 height: 40,
            //                                 margin: const EdgeInsets.all(5),
            //                                 padding: const EdgeInsets.symmetric(horizontal: 5),
            //                                 decoration: BoxDecoration(
            //                                   borderRadius: BorderRadius.circular(25),
            //                                   color: Theme.of(context).primaryColor,
            //                                 ),
            //                                 child: const Row(
            //                                   children: [
            //                                     Icon(
            //                                       Icons.edit_square,
            //                                       color: Colors.white,
            //                                       size: 22,
            //                                     ),
            //                                     Gap(5),
            //                                     Text(
            //                                       'Edit',
            //                                       style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                               Container(
            //                                 width: 90,
            //                                 height: 40,
            //                                 margin: const EdgeInsets.all(5),
            //                                 padding: const EdgeInsets.symmetric(horizontal: 5),
            //                                 decoration: BoxDecoration(
            //                                   borderRadius: BorderRadius.circular(25),
            //                                   color: Colors.red,
            //                                 ),
            //                                 child: const Row(
            //                                   children: [
            //                                     Icon(
            //                                       Icons.delete,
            //                                       color: Colors.white,
            //                                       size: 22,
            //                                     ),
            //                                     Gap(5),
            //                                     Text(
            //                                       'Delete',
            //                                       style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                             ],
            //                           )
            //                         ],
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //                 // Text(snapshot.data![index]['name']),
            //               ),
            //             )
            //           : const SizedBox();
            //       //
            //     }),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
