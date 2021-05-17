import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youflutter/models/video.dart';

/*
""
"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"

 */
const API_KEY = "AIzaSyD-0MhXoIweH3W6WyhBy4jVoGV8Yg-q45Q";

class Api {
  search(String search) async {
    var url = Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10");
    http.Response response = await http.get(url);
    decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      List<Video> videos = decoded['items'].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();
      print(videos);
      return videos;
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
