import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_walpaper_app/widget/widget.dart';
import 'package:http/http.dart' as http;

import '../data/data.dart';
import '../models/walpaper_models.dart';

class Search extends StatefulWidget {
  final String? searchQuery;
  Search({this.searchQuery});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<WalpaperModels> wallpapers = [];

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
  void initState() {
    super.initState();
    getSearchWallpapers(widget.searchQuery!);
    searchController.text = widget.searchQuery!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: BrandName(),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFf5f8fd),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: "Search wallpapers",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            String query = searchController.text;
                            getSearchWallpapers(query);
                          },
                          child: Icon(Icons.search),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  WallpapersList(
                    wallpapers: wallpapers,
                    context: context,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
