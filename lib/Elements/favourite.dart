import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Declaration/article.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'details.dart';

class FavouriteArticlesPage extends StatelessWidget {
  const FavouriteArticlesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Articles'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('favouritenews').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred.'),
            );
          }

          final List<Article> articles = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Article.fromJson(data as Map<String, dynamic>);
          }).toList();

          if (articles.isEmpty) {
            return const Center(
              child: Text('No favourite articles yet.'),
            );
          }

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];

              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (c) {
                          FirebaseFirestore.instance
                              .collection('favouritenews')
                              .doc(article.title)
                              .delete();
                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailView(article: article),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (article?.imageUrl != null &&
                              article.imageUrl.isNotEmpty)
                            Image.network(
                              article.imageUrl,
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            )
                          else
                            const SizedBox.shrink(),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              article?.title ?? 'Unknown title',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              article?.description ??
                                  'No description available',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}