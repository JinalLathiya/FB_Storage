import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

import 'model.dart';

class UploadImg {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filepath, String filename) async {
    File file = File(filepath);

    try {
      await storage.ref('test/$filename').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e.message);
    }
  }

  static Future<List<String>> DownloadLinks(List<Reference> refs) =>
      Future.wait(
        refs
            .map(
              (ref) => ref.getDownloadURL(),
            )
            .toList(),
      );

  static Future<List<FirebaseFile>> fetchImg(String path) async {
    final ref = firebase_storage.FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();
    final urls = await DownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url : url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }
}
