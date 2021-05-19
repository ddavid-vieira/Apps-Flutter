import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youflutter/api.dart';
import 'package:youflutter/blocs/favorite_bloc.dart';
import 'package:youflutter/models/video.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text('Favoritos'),
        backgroundColor: Colors.black87,
      ),
      body: StreamBuilder<Map<String, Video>>(
        initialData: {},
        stream: bloc.outFav,
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((e) {
              return InkWell(
                onTap: () {
                  FlutterYoutube.playYoutubeVideoById(
                      apiKey: API_KEY, videoId: e.id);
                },
                onLongPress: () {
                  bloc.toggleFavorite(e);
                },
                child: Row(
                  children: [
                    Container(
                        width: 100, height: 50, child: Image.network(e.thumb)),
                    Expanded(
                      child: Text(
                        e.title,
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
