import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Elements/cubit_cahnnellist.dart';
import 'Elements/cubit_articles_screen.dart';
import 'package:newsapp/Elements/master.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter News',
    home: BlocProvider(
        create: (context) => CubitChannelList(), child: const MyHomePage()),
  ));
}
