import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youflutter/blocs/favorite_bloc.dart';
import 'package:youflutter/models/video.dart';
import '../api.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  VideoTile(
    this.video,
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: video.id);
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16.0 / 9.0,
                child: Image.network(video.thumb, fit: BoxFit.cover),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                              8,
                              8,
                              8,
                              0,
                            ),
                            child: Text(video.title,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16))),
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                              8,
                              8,
                              8,
                              0,
                            ),
                            child: Text(video.channel,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14))),
                      ],
                    ),
                  ),
                  StreamBuilder<Map<String, Video>>(
                    stream: BlocProvider.of<FavoriteBloc>(context).outFav,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return IconButton(
                            icon: Icon(
                                snapshot.data.containsKey(video.id)
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.white,
                                size: 30),
                            onPressed: () {
                              BlocProvider.of<FavoriteBloc>(context)
                                  .toggleFavorite(video);
                            });
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              )
            ],
          )),
    );
  }
}
