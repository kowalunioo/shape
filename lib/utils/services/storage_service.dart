import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Storage
{
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadThumbnail(String fileName, String filePath) async
  {
    File file = File(filePath);
    try { await storage.ref('thumbnails/$fileName').putFile(file); } on FirebaseException catch(e) { print(e); }
  }

  Future<String> retriveThumbnail(String fileName) async
  {
    String url = await storage.ref().child('thumbnails/$fileName').getDownloadURL();
    return url;
  }

  Future<void> uploadVideo(String fileName, String filePath) async
  {
    File file = File(filePath);
    try { await storage.ref('videos/$fileName').putFile(file); } on FirebaseException catch(e) { print(e); }
  }
}