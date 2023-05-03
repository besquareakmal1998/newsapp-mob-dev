import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final String apiUrl =
      'https://newsapi.org/v2/top-headlines?language=en&apiKey=$apikey';

  late final String apikey = 'e9041acfdfd94aef9a4713586aec923f';

  List<Article> _articles = [];
  bool _loading = true;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchArticles(String query) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl&q=$query'));
      final jsonData = json.decode(response.body)['articles'] as List;
      setState(() {
        _articles =
            jsonData.map((article) => Article.fromJson(article)).toList();
        _loading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Articles'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search articles',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchArticles(_searchController.text);
                  },
                ),
              ),
              onSubmitted: (String query) {
                // add this function for onSubmitted
                _searchArticles(query);
              },
            ),
          ),
          _articles.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Showing tags related to ${_searchController.text}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              : Container(),
          Expanded(
            // child: _loading ? const Center(
            //   child: CircularProgressIndicator(),
            // )
            //     :
            child: ListView.builder(
              itemCount: _articles.length,
              itemBuilder: (BuildContext context, int index) {
                final article = _articles[index];
                return Card(
                  margin: const EdgeInsets.all(13),
                  child: Column(
                    children: [
                      Image.network(article.imageUrl),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'By ${article.author}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
