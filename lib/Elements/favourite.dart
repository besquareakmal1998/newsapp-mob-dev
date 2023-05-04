import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Declaration/article.dart';
import 'home_page.dart';

class FavouriteArticlesPage extends StatefulWidget {
  const FavouriteArticlesPage({Key? key}) : super(key: key);

  @override
  FavouriteArticlesPageState createState() => FavouriteArticlesPageState();
}

class FavouriteArticlesPageState extends State<FavouriteArticlesPage> {
  final CollectionReference favouriteNews =
      FirebaseFirestore.instance.collection("favouritenews");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favourite Articles'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('favouritenews')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Failed to load articles'));
            }

            final data = snapshot.data!;
            final articles = data.docs
                .map((doc) =>
                    Article.fromJson(doc.data() as Map<String, dynamic>))
                .where((article) =>
                    article.description != null &&
                    article.imageUrl != null &&
                    article.title != null &&
                    article.sourceName != null)
                .toList();
            return ListView(
                //children: snapshot.data?.documents.map((document) {
                //Text(document['title']);
                // }),
                );
            // return ListView.builder(
            //   itemCount: articles.length,
            //   itemBuilder: (context, index) {
            //     final article = articles[index];
            //     return ListTile(
            //       title: Text(article?.title ?? ''),
            //       subtitle: Column(
            //         children: [
            //           Text(article?.description ?? ''),
            //           Text(article?.sourceName ?? ''),
            //         ],
            //       ),
            //       leading: Image.network(article?.imageUrl ??
            //           'https://example.com/default-image.png'),
            //     );
            //   },
            // );
          },
        ));
  }
}
