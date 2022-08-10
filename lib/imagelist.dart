import 'package:flutter/material.dart';
import 'package:imagefs/storage_helpers.dart';

import 'image.dart';
import 'model.dart';

class Fetchimglist extends StatefulWidget {
  const Fetchimglist({Key? key}) : super(key: key);

  @override
  State<Fetchimglist> createState() => _FetchimglistState();
}

class _FetchimglistState extends State<Fetchimglist> {
  late Future<List<FirebaseFile>> ifiles;

  @override
  void initState() {
    super.initState();
    ifiles = UploadImg.fetchImg('files');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Images"),
          centerTitle: true,
          elevation: 0,
        ),
        body: FutureBuilder<List<FirebaseFile>>(
          future: ifiles,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print("Error : ${snapshot.error}");
            } else if (snapshot.hasData) {
              final files = snapshot.data!;
              return ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (context, i) {
                    final file = files[i];
                    return buildFile(context, file);
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Widget buildFile(BuildContext context, FirebaseFile file) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(file.url),
          ),
          title: Text(
            file.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Fullimg(
                  file: file,
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 2,
          indent: 20,
          endIndent: 20,
        )
      ],
    );
  }
}
