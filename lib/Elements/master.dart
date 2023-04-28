import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapp/Elements/channel_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter News"),
      ),
      body: FutureBuilder<List<String>>(
        future: getNewsChannels(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData) {
            final channels = snapshot.data!;
            return ListView.builder(
              itemCount: channels.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(channels[index]),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
