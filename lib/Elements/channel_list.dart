// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:newsapp/Elements/master.dart';

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text("Flutter News"),
//     ),
//     body: FutureBuilder<List<Channel>>(
//       future: getNewsChannels(),
//       builder: (BuildContext context, AsyncSnapshot<List<Channel>> snapshot) {
//         if (snapshot.hasData) {
//           final channels = snapshot.data!;
//           print(channels); // print the list of channels
//           return ListView.builder(
//             itemCount: channels.length,
//             itemBuilder: (BuildContext context, int index) {
//               return ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(channels[index].imageUrl),
//                 ),
//                 title: Text(channels[index].name),
//               );
//             },
//           );
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Text("${snapshot.error}"),
//           );
//         }
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     ),
//   );
// }

// Future<List<Channel>> getNewsChannels(
//     {String country = 'us', int pageSize = 10}) async {
//   final response = await http.get(Uri.parse(
//       weblink));
//   if (response.statusCode == 200) {
//     final sourcesJson = json.decode(response.body)['sources'];
//     return sourcesJson
//         .map<Channel>((source) => Channel.fromJson(source))
//         .toList();
//   } else {
//     throw Exception('Failed to load news channels');
//   }
// }

// class Channel {
//   final String name;
//   final String description;
//   final String url;
//   final String category;
//   final String imageUrl;

//   Channel({
//     required this.name,
//     required this.description,
//     required this.url,
//     required this.category,
//     required this.imageUrl,
//   });

//   factory Channel.fromJson(Map<String, dynamic> json) {
//     return Channel(
//       name: json['name'],
//       description: json['description'],
//       url: json['url'],
//       category: json['category'],
//       imageUrl: json['urlsToLogos']['small'],
//     );
//   }
// }

import 'dart:convert';

import 'package:newsapp/key.dart';
import 'package:http/http.dart' as http;

Future<List<String>> getNewsChannels() async {
  String channel_weblink = "$url/sources?apiKey=$apiKey";
  final response = await http.get(Uri.parse(channel_weblink));
  if (response.statusCode == 200) {
    final sourcesJson = json.decode(response.body)['sources'];
    return sourcesJson
        .map<String>((source) => source['name'] as String)
        .toList();
  } else {
    throw Exception('Failed to load news channels');
  }
}