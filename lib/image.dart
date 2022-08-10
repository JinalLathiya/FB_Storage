import 'package:flutter/material.dart';
import 'package:imagefs/model.dart';

class Fullimg extends StatelessWidget {
  final FirebaseFile file;

  const Fullimg({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
        centerTitle: true,
        elevation: 0,
      ),
      body: Image.network(
        file.url,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
