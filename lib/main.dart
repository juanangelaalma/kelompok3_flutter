import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

void main() {
  runApp(LearnExtractWidget());
}

class LearnExtractWidget extends StatelessWidget {
  LearnExtractWidget({super.key});

  var faker = new Faker();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Extract Widget"),
        ),
        body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ChatItem(
              imageUrl: "https://picsum.photos/id/${index}/200/200",
              title: faker.person.name(),
              subtitle: faker.lorem.sentence(),
            );
          }
        )
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  ChatItem({
    required this.imageUrl,
    required this.title,
    required this.subtitle
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      subtitle: Text(
        this.subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Text("10:02 AM"),
    );
  }
}