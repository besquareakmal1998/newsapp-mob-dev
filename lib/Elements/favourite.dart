import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Declaration/article.dart';

class FavouriteArticlesPage extends StatelessWidget {
  const FavouriteArticlesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Articles'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('favouritenews').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<Article> articles = snapshot.data!.docs
              .map(
                  (doc) => Article.fromJson(doc.data() as Map<String, dynamic>))
              .toList();

          if (articles.isEmpty) {
            return const Center(
              child: Text('No favourite articles yet.'),
            );
          }

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return ListTile(
                title: Text(article.title),
                subtitle: Text(article.description),
                leading: Image.network(
                  article.imageUrl,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
