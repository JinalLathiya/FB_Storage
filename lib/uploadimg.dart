import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:imagefs/storage_helpers.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final UploadImg uploadImg = UploadImg();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload & fetch Image"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Upload File"),
              onPressed: () {
                selectFile();
              },
            ),
            ElevatedButton(
              child: const Text("Fetch File"),
              onPressed: () {
                Navigator.of(context).pushNamed('Fetchimglist');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No Files Selected"),
        ),
      );
      return null;
    }

    final path = result.files.single.path!;
    final filename = result.files.single.name;

    uploadImg.uploadFile(path, filename).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Uploaded"),
        ),
      );
    });
  }
}
