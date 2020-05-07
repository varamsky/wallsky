// To parse this JSON data, do
//
//     final pixabayUnits = pixabayUnitsFromJson(jsonString);

import 'dart:convert';

PixabayUnits pixabayUnitsFromJson(String str) => PixabayUnits.fromJson(json.decode(str));

String pixabayUnitsToJson(PixabayUnits data) => json.encode(data.toJson());

class PixabayUnits {
  int total;
  int totalHits;
  List<Hit> hits;

  PixabayUnits({
    this.total,
    this.totalHits,
    this.hits,
  });

  factory PixabayUnits.fromJson(Map<String, dynamic> json) => PixabayUnits(
    total: json["total"],
    totalHits: json["totalHits"],
    hits: List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "totalHits": totalHits,
    "hits": List<dynamic>.from(hits.map((x) => x.toJson())),
  };
}

class Hit {
  int id;
  String pageUrl;
  String type;
  String tags;
  String previewUrl;
  int previewWidth;
  int previewHeight;
  String webformatUrl;
  int webformatWidth;
  int webformatHeight;
  String largeImageUrl;
  int imageWidth;
  int imageHeight;
  int imageSize;
  int views;
  int downloads;
  int favorites;
  int likes;
  int comments;
  int userId;
  String user;
  String userImageUrl;

  Hit({
    this.id,
    this.pageUrl,
    this.type,
    this.tags,
    this.previewUrl,
    this.previewWidth,
    this.previewHeight,
    this.webformatUrl,
    this.webformatWidth,
    this.webformatHeight,
    this.largeImageUrl,
    this.imageWidth,
    this.imageHeight,
    this.imageSize,
    this.views,
    this.downloads,
    this.favorites,
    this.likes,
    this.comments,
    this.userId,
    this.user,
    this.userImageUrl,
  });

  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
    id: json["id"],
    pageUrl: json["pageURL"],
    type: json["type"],
    tags: json["tags"],
    previewUrl: json["previewURL"],
    previewWidth: json["previewWidth"],
    previewHeight: json["previewHeight"],
    webformatUrl: json["webformatURL"],
    webformatWidth: json["webformatWidth"],
    webformatHeight: json["webformatHeight"],
    largeImageUrl: json["largeImageURL"],
    imageWidth: json["imageWidth"],
    imageHeight: json["imageHeight"],
    imageSize: json["imageSize"],
    views: json["views"],
    downloads: json["downloads"],
    favorites: json["favorites"],
    likes: json["likes"],
    comments: json["comments"],
    userId: json["user_id"],
    user: json["user"],
    userImageUrl: json["userImageURL"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pageURL": pageUrl,
    "type": type,
    "tags": tags,
    "previewURL": previewUrl,
    "previewWidth": previewWidth,
    "previewHeight": previewHeight,
    "webformatURL": webformatUrl,
    "webformatWidth": webformatWidth,
    "webformatHeight": webformatHeight,
    "largeImageURL": largeImageUrl,
    "imageWidth": imageWidth,
    "imageHeight": imageHeight,
    "imageSize": imageSize,
    "views": views,
    "downloads": downloads,
    "favorites": favorites,
    "likes": likes,
    "comments": comments,
    "user_id": userId,
    "user": user,
    "userImageURL": userImageUrl,
  };
}
