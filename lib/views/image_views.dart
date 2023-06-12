import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageView extends StatefulWidget {
  final String? imgUrl;
  ImageView({this.imgUrl});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Hero(
        tag: widget.imgUrl!,
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.imgUrl!,
              fit: BoxFit.cover,
            )),
      ),
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                _save();
              },
              child: Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff1C1B1B).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24, width: 1),
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                          colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Set Walpaper",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.none),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Image will be saved in galery",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.none),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Cancel",
              style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      )
    ]);
  }

  _save() async {
    var response = await Dio().get(widget.imgUrl!,
        options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }
}
