import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youflutter/models/video.dart';

/*
""


 */
const API_KEY = "AIzaSyD-0MhXoIweH3W6WyhBy4jVoGV8Yg-q45Q";

class Api {
  String _search;
  String _nextToken;
  Future<List<Video>> search(String search) async {
    _search = search;
    var url = Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10");
    http.Response response = await http.get(url);
    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      _nextToken = decoded["nextPageToken"];
      List<Video> videos = decoded['items'].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();

      return videos;
    } else {
      throw Exception('Failed to load videos');
    }
  }

  Future<List<Video>> nextPage() async {
    var url = Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken");
    http.Response response = await http.get(url);
    return decode(response);
  }
}
