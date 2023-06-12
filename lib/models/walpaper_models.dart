class WalpaperModels {
  String? photogtrapher;
  int? photogtrapher_id;
  String? photogtrapher_url;
  SrcModel? src;

  WalpaperModels(
      {this.photogtrapher,
      this.photogtrapher_id,
      this.photogtrapher_url,
      this.src});

  factory WalpaperModels.fromMap(Map<String, dynamic> jsonData) {
    return WalpaperModels(
      src: SrcModel.fromMap(jsonData['src']),
      photogtrapher: jsonData['photographer'],
      photogtrapher_id: jsonData['photographer_id'],
      photogtrapher_url: jsonData['photographer_url'],
    );
  }
}

class SrcModel {
  String? original;
  String? small;
  String? portrait;

  SrcModel({this.original, this.portrait, this.small});
  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      original: jsonData['original'],
      small: jsonData['small'],
      portrait: jsonData['portrait'],
    );
  }
}
