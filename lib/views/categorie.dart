import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/data.dart';
import '../models/walpaper_models.dart';
import '../widget/widget.dart';

class Categorie extends StatefulWidget {
  final String? CategorieName;
  Categorie({this.CategorieName});

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<WalpaperModels> wallpapers = [];
  @override
  void initState() {
    getSearchWallpapers(widget.CategorieName!);
    super.initState();
  }

  getSearchWallpapers(String search) async {
    String url = "https://api.pexels.com/v1/search?query=$search";
    Uri uri = Uri.parse(url);
    var response = await http.get(uri, headers: {"Authorization": ApiKey});

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    List<dynamic> photos = jsonData["photos"];
    photos.forEach((element) {
      WalpaperModels wallpaperModel = WalpaperModels.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: BrandName(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              WallpapersList(
                wallpapers: wallpapers,
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
