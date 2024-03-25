import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadVideo(String videoUrl, String courseName) async {
    Reference ref = _storage.ref().child('courses').child(courseName).child("Image1.mp4");
    await ref.putFile(File(videoUrl));
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  // Future<void> saveVideoData(String videoDownloadUrl) async {
  //   await _firestore.collection('videos').add(
  //     {
  //       'url': videoDownloadUrl,
  //       'timeStamp': FieldValue.serverTimestamp(),
  //       'name': 'User Video',
  //     },
  //   );
  // }
}
