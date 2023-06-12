import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_walpaper_app/data/data.dart';
import 'package:flutter_walpaper_app/models/walpaper_models.dart';
import 'package:flutter_walpaper_app/models/categorie.dart';
import 'package:flutter_walpaper_app/views/categorie.dart';
import 'package:flutter_walpaper_app/views/search.dart';
import 'package:flutter_walpaper_app/widget/widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = [];
  List<WalpaperModels> walpaper = [];
  TextEditingController searchController = new TextEditingController();
  getTrendingWalpapers() async {
    String url = "https://api.pexels.com/v1/curated";
    Uri uri = Uri.parse(url);
    var response = await http.get(uri, headers: {"Authorization": ApiKey});

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    List<dynamic> photos = jsonData["photos"];
    photos.forEach((element) {
      //print("$element \n\n");
      WalpaperModels walpaperModels = new WalpaperModels();
      walpaperModels = WalpaperModels.fromMap(element);
      walpaper.add(walpaperModels);
    });

    setState(() {});
  }

  @override
  void initState() {
    getTrendingWalpapers();
    categories = getCategori()!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: "search walpapers",
                            border: InputBorder.none),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Search(
                                        searchQuery: searchController.text,
                                      )));
                        },
                        child: Icon(Icons.search))
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return CategoriTile(
                        imgURl: categories[index].imgUrl,
                        categorieName: categories[index].categorieName,
                      );
                    }),
              ),
              SizedBox(
                height: 16,
              ),
              WallpapersList(
                wallpapers: walpaper,
                context: context,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriTile extends StatelessWidget {
  final String? imgURl, categorieName;
  CategoriTile({this.categorieName, this.imgURl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Categorie(
                CategorieName: categorieName!.toLowerCase(),
              ),
            ));
      },
      child: Container(
          margin: EdgeInsets.only(right: 4),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      imgURl!,
                      width: 100,
                      height: 50,
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(16)),
                  height: 50,
                  width: 100,
                  alignment: Alignment.center,
                  child: Text(
                    categorieName!,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ))
            ],
          )),
    );
  }
}
