// To parse this JSON data, do
//
//     final unSplashUnits = unSplashUnitsFromJson(jsonString);

import 'dart:convert';

UnSplashUnits unSplashUnitsFromJson(String str) => UnSplashUnits.fromJson(json.decode(str));

String unSplashUnitsToJson(UnSplashUnits data) => json.encode(data.toJson());

class UnSplashUnits {
  int total;
  int totalPages;
  List<Result> results;

  UnSplashUnits({
    this.total,
    this.totalPages,
    this.results,
  });

  factory UnSplashUnits.fromJson(Map<String, dynamic> json) => UnSplashUnits(
    total: json["total"],
    totalPages: json["total_pages"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "total_pages": totalPages,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime promotedAt;
  int width;
  int height;
  String color;
  String description;
  String altDescription;
  Urls urls;
  ResultLinks links;
  List<dynamic> categories;
  int likes;
  bool likedByUser;
  List<dynamic> currentUserCollections;
  User user;
  List<Tag> tags;

  Result({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.description,
    this.altDescription,
    this.urls,
    this.links,
    this.categories,
    this.likes,
    this.likedByUser,
    this.currentUserCollections,
    this.user,
    this.tags,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    promotedAt: json["promoted_at"] == null ? null : DateTime.parse(json["promoted_at"]),
    width: json["width"],
    height: json["height"],
    color: json["color"],
    description: json["description"] == null ? null : json["description"],
    altDescription: json["alt_description"],
    urls: Urls.fromJson(json["urls"]),
    links: ResultLinks.fromJson(json["links"]),
    categories: List<dynamic>.from(json["categories"].map((x) => x)),
    likes: json["likes"],
    likedByUser: json["liked_by_user"],
    currentUserCollections: List<dynamic>.from(json["current_user_collections"].map((x) => x)),
    user: User.fromJson(json["user"]),
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "promoted_at": promotedAt == null ? null : promotedAt.toIso8601String(),
    "width": width,
    "height": height,
    "color": color,
    "description": description == null ? null : description,
    "alt_description": altDescription,
    "urls": urls.toJson(),
    "links": links.toJson(),
    "categories": List<dynamic>.from(categories.map((x) => x)),
    "likes": likes,
    "liked_by_user": likedByUser,
    "current_user_collections": List<dynamic>.from(currentUserCollections.map((x) => x)),
    "user": user.toJson(),
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
  };
}

class ResultLinks {
  String self;
  String html;
  String download;
  String downloadLocation;

  ResultLinks({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  factory ResultLinks.fromJson(Map<String, dynamic> json) => ResultLinks(
    self: json["self"],
    html: json["html"],
    download: json["download"],
    downloadLocation: json["download_location"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "download": download,
    "download_location": downloadLocation,
  };
}

class Tag {
  Type type;
  String title;
  Source source;

  Tag({
    this.type,
    this.title,
    this.source,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    type: typeValues.map[json["type"]],
    title: json["title"],
    source: json["source"] == null ? null : Source.fromJson(json["source"]),
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "title": title,
    "source": source == null ? null : source.toJson(),
  };
}

class Source {
  Ancestry ancestry;
  String title;
  String subtitle;
  String description;
  String metaTitle;
  String metaDescription;
  CoverPhoto coverPhoto;

  Source({
    this.ancestry,
    this.title,
    this.subtitle,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.coverPhoto,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    ancestry: Ancestry.fromJson(json["ancestry"]),
    title: json["title"],
    subtitle: json["subtitle"],
    description: json["description"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    coverPhoto: CoverPhoto.fromJson(json["cover_photo"]),
  );

  Map<String, dynamic> toJson() => {
    "ancestry": ancestry.toJson(),
    "title": title,
    "subtitle": subtitle,
    "description": description,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "cover_photo": coverPhoto.toJson(),
  };
}

class Ancestry {
  Category type;
  Category category;
  Category subcategory;

  Ancestry({
    this.type,
    this.category,
    this.subcategory,
  });

  factory Ancestry.fromJson(Map<String, dynamic> json) => Ancestry(
    type: Category.fromJson(json["type"]),
    category: Category.fromJson(json["category"]),
    subcategory: json["subcategory"] == null ? null : Category.fromJson(json["subcategory"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type.toJson(),
    "category": category.toJson(),
    "subcategory": subcategory == null ? null : subcategory.toJson(),
  };
}

class Category {
  String slug;
  String prettySlug;

  Category({
    this.slug,
    this.prettySlug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    slug: 'slug'/*json['slug']*/,//hardcoded because the api sometimes returns null and crashes the app
    prettySlug: 'pretty_slug'/*json['pretty_slug']*/,//hardcoded because the api sometimes returns null and crashes the app
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "pretty_slug": prettySlug,
  };
}

class CoverPhoto {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime promotedAt;
  int width;
  int height;
  String color;
  String description;
  String altDescription;
  Urls urls;
  ResultLinks links;
  List<dynamic> categories;
  int likes;
  bool likedByUser;
  List<dynamic> currentUserCollections;
  User user;

  CoverPhoto({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.description,
    this.altDescription,
    this.urls,
    this.links,
    this.categories,
    this.likes,
    this.likedByUser,
    this.currentUserCollections,
    this.user,
  });

  factory CoverPhoto.fromJson(Map<String, dynamic> json) => CoverPhoto(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    promotedAt: json["promoted_at"] == null ? null : DateTime.parse(json["promoted_at"]),
    width: json["width"],
    height: json["height"],
    color: json["color"],
    description: json["description"],
    altDescription: json["alt_description"] == null ? null : json["alt_description"],
    urls: Urls.fromJson(json["urls"]),
    links: ResultLinks.fromJson(json["links"]),
    categories: List<dynamic>.from(json["categories"].map((x) => x)),
    likes: json["likes"],
    likedByUser: json["liked_by_user"],
    currentUserCollections: List<dynamic>.from(json["current_user_collections"].map((x) => x)),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "promoted_at": promotedAt == null ? null : promotedAt.toIso8601String(),
    "width": width,
    "height": height,
    "color": color,
    "description": description,
    "alt_description": altDescription == null ? null : altDescription,
    "urls": urls.toJson(),
    "links": links.toJson(),
    "categories": List<dynamic>.from(categories.map((x) => x)),
    "likes": likes,
    "liked_by_user": likedByUser,
    "current_user_collections": List<dynamic>.from(currentUserCollections.map((x) => x)),
    "user": user.toJson(),
  };
}

class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
    raw: json["raw"],
    full: json["full"],
    regular: json["regular"],
    small: json["small"],
    thumb: json["thumb"],
  );

  Map<String, dynamic> toJson() => {
    "raw": raw,
    "full": full,
    "regular": regular,
    "small": small,
    "thumb": thumb,
  };
}

class User {
  String id;
  DateTime updatedAt;
  String username;
  String name;
  String firstName;
  String lastName;
  String twitterUsername;
  String portfolioUrl;
  String bio;
  String location;
  UserLinks links;
  ProfileImage profileImage;
  String instagramUsername;
  int totalCollections;
  int totalLikes;
  int totalPhotos;
  bool acceptedTos;

  User({
    this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.links,
    this.profileImage,
    this.instagramUsername,
    this.totalCollections,
    this.totalLikes,
    this.totalPhotos,
    this.acceptedTos,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    username: json["username"],
    name: json["name"],
    firstName: json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    twitterUsername: json["twitter_username"] == null ? null : json["twitter_username"],
    portfolioUrl: json["portfolio_url"] == null ? null : json["portfolio_url"],
    bio: json["bio"] == null ? null : json["bio"],
    location: json["location"] == null ? null : json["location"],
    links: UserLinks.fromJson(json["links"]),
    profileImage: ProfileImage.fromJson(json["profile_image"]),
    instagramUsername: json["instagram_username"] == null ? null : json["instagram_username"],
    totalCollections: json["total_collections"],
    totalLikes: json["total_likes"],
    totalPhotos: json["total_photos"],
    acceptedTos: json["accepted_tos"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "updated_at": updatedAt.toIso8601String(),
    "username": username,
    "name": name,
    "first_name": firstName,
    "last_name": lastName == null ? null : lastName,
    "twitter_username": twitterUsername == null ? null : twitterUsername,
    "portfolio_url": portfolioUrl == null ? null : portfolioUrl,
    "bio": bio == null ? null : bio,
    "location": location == null ? null : location,
    "links": links.toJson(),
    "profile_image": profileImage.toJson(),
    "instagram_username": instagramUsername == null ? null : instagramUsername,
    "total_collections": totalCollections,
    "total_likes": totalLikes,
    "total_photos": totalPhotos,
    "accepted_tos": acceptedTos,
  };
}

class UserLinks {
  String self;
  String html;
  String photos;
  String likes;
  String portfolio;
  String following;
  String followers;

  UserLinks({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
    this.following,
    this.followers,
  });

  factory UserLinks.fromJson(Map<String, dynamic> json) => UserLinks(
    self: json["self"],
    html: json["html"],
    photos: json["photos"],
    likes: json["likes"],
    portfolio: json["portfolio"],
    following: json["following"],
    followers: json["followers"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "photos": photos,
    "likes": likes,
    "portfolio": portfolio,
    "following": following,
    "followers": followers,
  };
}

class ProfileImage {
  String small;
  String medium;
  String large;

  ProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
    small: json["small"],
    medium: json["medium"],
    large: json["large"],
  );

  Map<String, dynamic> toJson() => {
    "small": small,
    "medium": medium,
    "large": large,
  };
}

enum Type { SEARCH, LANDING_PAGE }

final typeValues = EnumValues({
  "landing_page": Type.LANDING_PAGE,
  "search": Type.SEARCH
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
