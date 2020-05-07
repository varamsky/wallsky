// To parse this JSON data, do
//
//     final pexelsUnits = pexelsUnitsFromJson(jsonString);

import 'dart:convert';

PexelsUnits pexelsUnitsFromJson(String str) => PexelsUnits.fromJson(json.decode(str));

String pexelsUnitsToJson(PexelsUnits data) => json.encode(data.toJson());

class PexelsUnits {
  int totalResults;
  int page;
  int perPage;
  List<Photo> photos;
  String nextPage;

  PexelsUnits({
    this.totalResults,
    this.page,
    this.perPage,
    this.photos,
    this.nextPage,
  });

  factory PexelsUnits.fromJson(Map<String, dynamic> json) => PexelsUnits(
    totalResults: json["total_results"],
    page: json["page"],
    perPage: json["per_page"],
    photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    nextPage: json["next_page"],
  );

  Map<String, dynamic> toJson() => {
    "total_results": totalResults,
    "page": page,
    "per_page": perPage,
    "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    "next_page": nextPage,
  };
}

class Photo {
  int id;
  int width;
  int height;
  String url;
  String photographer;
  String photographerUrl;
  int photographerId;
  Src src;
  bool liked;

  Photo({
    this.id,
    this.width,
    this.height,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.src,
    this.liked,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    id: json["id"],
    width: json["width"],
    height: json["height"],
    url: json["url"],
    photographer: json["photographer"],
    photographerUrl: json["photographer_url"],
    photographerId: json["photographer_id"],
    src: Src.fromJson(json["src"]),
    liked: json["liked"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "width": width,
    "height": height,
    "url": url,
    "photographer": photographer,
    "photographer_url": photographerUrl,
    "photographer_id": photographerId,
    "src": src.toJson(),
    "liked": liked,
  };
}

class Src {
  String original;
  String large2X;
  String large;
  String medium;
  String small;
  String portrait;
  String landscape;
  String tiny;

  Src({
    this.original,
    this.large2X,
    this.large,
    this.medium,
    this.small,
    this.portrait,
    this.landscape,
    this.tiny,
  });

  factory Src.fromJson(Map<String, dynamic> json) => Src(
    original: json["original"],
    large2X: json["large2x"],
    large: json["large"],
    medium: json["medium"],
    small: json["small"],
    portrait: json["portrait"],
    landscape: json["landscape"],
    tiny: json["tiny"],
  );

  Map<String, dynamic> toJson() => {
    "original": original,
    "large2x": large2X,
    "large": large,
    "medium": medium,
    "small": small,
    "portrait": portrait,
    "landscape": landscape,
    "tiny": tiny,
  };
}
