import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Elements/details.dart';
import '../Cubit/cubit_articles_screen.dart';

class ArticlesScreen extends StatelessWidget {
  final String channelId;
  final String channelName;
  final String description;
  const ArticlesScreen({
    Key? key,
    required this.channelId,
    required this.channelName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CubitArticlesScreen>(
        create: (context) => CubitArticlesScreen(channelId),
        child: Scaffold(
          appBar: AppBar(
            title: Text(channelName),
          ),
          body: BlocBuilder<CubitArticlesScreen, ArticleScreenState>(
            builder: (BuildContext context, ArticleScreenState state) {
              if (state is ArticleScreenStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ArticleScreenStateLoaded) {
                final articles = state.getChannels;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  NetworkImage(getChannelImageUrl(channelId)),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              channelName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: articles[index].urlToImage != null
                                ? SizedBox(
                                    width: 150,
                                    height: 130,
                                    child: Image.network(
                                      articles[index].urlToImage,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(Icons.article),
                            title: Text(
                              articles[index].title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  articles[index].publishedAt.substring(0, 10),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  articles[index].publishedAt.substring(11, 16),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailView(
                                    article: articles[index],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is ArticleScreenStateError) {
                return const Center(
                  child: Text('Failed to load articles'),
                );
              } else {
                return const Center(
                  child: Text('Unknown Error!'),
                );
              }
            },
          ),
        ));
  }
}

String getChannelImageUrl(String channelId) {
  return 'https://logo.clearbit.com/${channelId.replaceAll('-', '').toLowerCase()}.com';
}
