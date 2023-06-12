import 'package:flutter/material.dart';

import '../models/walpaper_models.dart';
import '../views/image_views.dart';

Widget BrandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text("Walpaper",
          style: TextStyle(color: Colors.black87, fontFamily: 'Overpass')),
      Text("Hub", style: TextStyle(color: Colors.blue, fontFamily: 'Overpass')),
    ],
  );
}

Widget WallpapersList(
    {List<WalpaperModels>? wallpapers, BuildContext? context}) {
  return Container(
    child: GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.vertical,
      physics: PageScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      children: wallpapers!.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context!,
                    MaterialPageRoute(
                        builder: (context) => ImageView(
                              imgUrl: wallpaper.src?.portrait,
                            )));
              },
              child: Hero(
                tag: wallpaper.src!.portrait!,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      wallpaper.src!.portrait!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )),
        );
      }).toList(),
    ),
  );
}
