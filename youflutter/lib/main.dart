import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youflutter/blocs/favorite_bloc.dart';
import 'package:youflutter/blocs/videos_bloc.dart';
import 'package:youflutter/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Voltar para a versão 1.22 do flutter para conseguir usar as versões anteriores dos packages
    return BlocProvider(
      bloc: VideosBloc(),
      child: BlocProvider(
          bloc: FavoriteBloc(),
          child: MaterialApp(debugShowCheckedModeBanner: false, home: Home())),
    );
  }
}
