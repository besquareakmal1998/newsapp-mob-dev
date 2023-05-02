import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newsapp/key.dart';
import 'package:newsapp/string_extension.dart';

class CubitChannelList extends Cubit<ChannelState> {
  CubitChannelList() : super(ChannelStateLoading()) {
    getNewsChannels();
  }

  Future<void> getNewsChannels() async {
    try {
      String channelWeblink = "$url/sources?country=$country&apiKey=$apiKey";
      final response = await http.get(Uri.parse(channelWeblink));
      if (response.statusCode == 200) {
        final sourcesJson = json.decode(response.body)['sources'];
        final channels = sourcesJson
            .map<String>((source) => source['id'] as String)
            .toList();
        emit(ChannelStateLoaded(channels));
      } else {
        emit(ChannelStateError());
      }
    } catch (e) {
      emit(ChannelStateError());
    }
  }
}

class ChannelStateInitial extends ChannelState {}

class ChannelStateLoading extends ChannelState {}

class ChannelStateLoaded extends ChannelState {
  final List<String> channels;

  ChannelStateLoaded(this.channels);

  List<String> get getChannels => channels;
}

class ChannelStateError extends ChannelState {}

abstract class ChannelState {}
