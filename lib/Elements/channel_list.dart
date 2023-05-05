import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/Cubit/cubit_cahnnellist.dart';
import 'package:newsapp/key.dart';
import 'package:newsapp/Elements/articles_screen.dart';
import 'package:newsapp/string_extension.dart';

class NewsChannelsScreen extends StatelessWidget {
  const NewsChannelsScreen({Key? key}) : super(key: key);

  Future<List<String>> getNewsChannels() async {
    String channelWeblink = "$url/sources?country=$country&apiKey=$apiKey";
    final response = await http.get(Uri.parse(channelWeblink));
    if (response.statusCode == 200) {
      final sourcesJson = json.decode(response.body)['sources'];
      return sourcesJson
          .map<String>((source) => source['id'] as String)
          .toList();
    } else {
      throw Exception('Failed to load news channels');
    }
  }

  void navigateToArticles(
      BuildContext context, String channelName, String channelId) {
    String formattedChannelName = channelId.replaceAll('-', ' ').capitalize();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticlesScreen(
          channelName: formattedChannelName,
          channelId: channelId,
          description: '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of News Channels'),
      ),
      body: BlocBuilder<CubitChannelList, ChannelState>(
        builder: (context, channels) {
          if (channels is ChannelStateLoading) {
            return const Text("");
          } else if (channels is ChannelStateLoaded) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: FutureBuilder<List<String>>(
                future: getNewsChannels(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.hasData) {
                    final channels = snapshot.data!;
                    return GridView.count(
                      crossAxisCount: 3, // set the number of columns to 3
                      children: List.generate(channels.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            navigateToArticles(
                                context, channels[index], channels[index]);
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius: 28.0,
                                  backgroundImage: NetworkImage(
                                    getChannelImageUrl(channels[index]),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                channels[index].replaceAll('-', ' ').capitalize(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            );
          } else {
            return const Text("data");
          }
        },
      ),
    );
  }
}

String getChannelImageUrl(String channelId) {
  return 'https://logo.clearbit.com/${channelId.replaceAll('-', '').toLowerCase()}.com';
}
