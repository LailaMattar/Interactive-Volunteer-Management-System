import 'package:flutter/material.dart';
import 'package:takatof/management/presentation/component/post_item.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context , int index){
              return PostItem();
            }),
      ),
    );
  }
}
