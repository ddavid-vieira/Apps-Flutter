import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youflutter/blocs/favorite_bloc.dart';
import 'package:youflutter/blocs/videos_bloc.dart';
import 'package:youflutter/delegates/data_search.dart';
import 'package:youflutter/models/video.dart';
import 'package:youflutter/screens/favorites.dart';
import 'package:youflutter/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Container(
            height: 25,
            child: Row(
              children: [
                Image.asset('images/youlogo.png'),
                SizedBox(width: 10),
                Text('YouFlutter',
                    style: TextStyle(color: Colors.white, fontSize: 16))
              ],
            ),
          ),
          backgroundColor: Colors.black87,
          actions: [
            Align(
              alignment: Alignment.center,
              child: StreamBuilder<Map<String, Video>>(
                  stream: BlocProvider.of<FavoriteBloc>(context).outFav,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text("${snapshot.data.length}");
                    } else {
                      return Container();
                    }
                  }),
            ),
            IconButton(
                icon: Icon(Icons.star),
                onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Favorite()))
                    }),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  String result = await showSearch(
                      context: context, delegate: DataSearch());
                  if (result != null) {
                    BlocProvider.of<VideosBloc>(context).inSearch.add(result);
                  }
                })
          ],
        ),
        backgroundColor: Colors.black,
        body: StreamBuilder(
            initialData: [],
            stream: BlocProvider.of<VideosBloc>(context).outVideos,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      if (index < snapshot.data.length) {
                        return VideoTile(snapshot.data[index]);
                      } else if (index > 1) {
                        BlocProvider.of<VideosBloc>(context).inSearch.add(null);
                        return Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red)));
                      } else {
                        return Container();
                      }
                    });
              } else {
                return Container();
              }
            }));
  }
}
