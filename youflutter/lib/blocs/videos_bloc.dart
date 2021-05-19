import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youflutter/api.dart';
import 'package:youflutter/models/video.dart';

class VideosBloc implements BlocBase {
  Api api;
  List<Video> videos;
  final StreamController _videosController =
      new StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;
  final StreamController _searchController = new StreamController<String>();
  Sink get inSearch => _searchController.sink;
  VideosBloc() {
    api = Api();
    _searchController.stream.listen(_search);
  }
  void _search(String search) async {
    search != null
        ? videos = await api.search(search)
        : videos += await api.nextPage();
    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }
}
