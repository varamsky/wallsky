import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:wallsky/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class ImageScreen extends StatefulWidget {
  final dynamic curPhoto;
  final int currSource;

  ImageScreen({this.currSource, this.curPhoto});

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen>
    with SingleTickerProviderStateMixin {
  double _containerHeight = 115.0, _containerWidth;
  bool showInfo = false, isLongPress = false;

  Icon sizeChangeIcon = Icon(
    Icons.fullscreen_exit,
    color: Colors.white,
  );
  BoxFit imageFit = BoxFit.cover;
  bool isFitCover = true;

  @override
  Widget build(BuildContext context) {
    _containerWidth = MediaQuery.of(context).size.width / 1.5;
    var artistImage, artistName, artistProfile;
    if (widget.currSource == 0) {
      artistImage = widget.curPhoto.photographerUrl;
      artistName = widget.curPhoto.photographer;
      artistProfile = widget.curPhoto.photographerUrl.split('@')[1];
    } else if (widget.currSource == 1) {
      artistImage = widget.curPhoto.user.profileImage.medium;
      artistName = widget.curPhoto.user.name;
      artistProfile = widget.curPhoto.user.username;
    } else if (widget.currSource == 2) {
      artistImage = widget.curPhoto.userImageUrl;
      artistName = widget.curPhoto.user;
      artistProfile = widget.curPhoto.user;
    }

    String largeImage, smallImage;

    if (widget.currSource == 0) {
      largeImage = widget.curPhoto.src.original;
      smallImage = widget.curPhoto.src.small;
    } else if (widget.currSource == 1) {
      largeImage = widget.curPhoto.urls.full;
      smallImage = widget.curPhoto.urls.small;
    } else if (widget.currSource == 2) {
      largeImage = widget.curPhoto.largeImageUrl;
      smallImage = widget.curPhoto.previewUrl;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarOpacity: (isLongPress) ? 0.0 : 1.0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  (isLongPress)
                      ? Colors.transparent
                      : Colors.black.withOpacity(0.8),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          actions: [
            IconButton(
              icon: sizeChangeIcon,
              onPressed: () {
                setState(() {
                  isFitCover = !isFitCover;
                  imageFit = (isFitCover) ? BoxFit.cover : BoxFit.contain;
                  sizeChangeIcon = (isFitCover)
                      ? Icon(
                          Icons.fullscreen_exit,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                        );
                  print('icon Pressed');
                });
              },
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            GestureDetector(
              onLongPressStart: (value) {
                setState(() {
                  isLongPress = true;
                });
              },
              onLongPressEnd: (value) {
                setState(() {
                  isLongPress = false;
                });
              },
              child: Image.network(
                largeImage,
                //curPhoto.src.large,
                //curPhoto.src.portrait,
                //curPhoto.src.large2X,
                //curPhoto.src.medium,
                //curPhoto.src.tiny,
                //curPhoto.src.small,
                //curPhoto.src.landscape,

                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: new NetworkImage(smallImage),
                          fit: BoxFit.cover),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ' Try Long Press ',
                              style: TextStyle(
                                fontSize: 20.0, color: Colors.white,
                                backgroundColor: Colors.black45,
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2.0,
                              backgroundColor: Colors.black45,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                fit: imageFit,
                alignment: Alignment.center,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: buildPhotoActions(context, artistImage, artistName,
                    artistProfile, largeImage),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPhotoActions(BuildContext context, artistImage, artistName,
      artistProfile, largeImage) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      transform: Matrix4.translationValues(
          0, (isLongPress) ? (_containerHeight + 150.0) : 0, 0),
      decoration: BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: Colors.black,
            blurRadius: 10.0,
          ),
        ],
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(10.0),
      width: _containerWidth,
      height: _containerHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 40.0,
                height: 40.0,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: CachedNetworkImage(
                      imageUrl: artistImage,
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error_outline),
                    )),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              // NOT used CircleAvatar because CachedNetworkImage doesn't  work with it
              SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      artistName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '@$artistProfile',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: (showInfo) ? extraInfo() : Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.info,
                ),
                tooltip: 'Details',
                onPressed: () {
                  setState(() {
                    showInfo = !showInfo;
                    print('before _height : $_containerHeight');
                    (showInfo)
                        ? _containerHeight += 150.0
                        : _containerHeight -= 150.0;
                    print('after _height : $_containerHeight');
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.file_download),
                tooltip: 'Download',
                onPressed: () => handleDownload(largeImage),
              ),
              IconButton(
                icon: Icon(Icons.format_paint),
                tooltip: 'Apply',
                onPressed: () => handleApply(largeImage, context),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget extraInfo() {
    String pageUrl, photographerUrl;
    if (widget.currSource == 0) {
      pageUrl = widget.curPhoto.url;
      photographerUrl = widget.curPhoto.photographerUrl;
    } else if (widget.currSource == 1) {
      pageUrl = widget.curPhoto.links.html;
      photographerUrl = widget.curPhoto.user.links.html;
    } else if (widget.currSource == 2) {
      pageUrl = widget.curPhoto.pageUrl;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Image id : ${widget.curPhoto.id}'),
            SizedBox(
              height: 2.0,
            ),
            RichText(
              text: new TextSpan(
                children: [
                  new TextSpan(
                    text: 'Page url : ',
                    style: new TextStyle(color: Colors.black),
                  ),
                  new TextSpan(
                    text: pageUrl,
                    style: new TextStyle(color: Colors.blue),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        launch(pageUrl);
                      },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            (widget.currSource != 2)
                ? RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text: 'Photographer url : ',
                          style: new TextStyle(color: Colors.black),
                        ),
                        new TextSpan(
                          text: photographerUrl,
                          style: new TextStyle(color: Colors.blue),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              launch(photographerUrl);
                            },
                        ),
                      ],
                    ),
                  )
                : Container(),
            //Text('page url "links"{"html" : https://unsplash.com/photos/oyBxvFU3SJI'),
            //Text('photographer url "user"{"links"{"html" : https://unsplash.com/@yuli_superson'),
          ],
        ),
      ),
    );
  }

  handleDownload(String image) async {
    var localFileLocation;
    try {
      // Saved with this method.
      String imageName;
      if (widget.currSource == 0)
        imageName = 'pexels_${widget.curPhoto.id}.jpg';
      else if (widget.currSource == 1)
        imageName = 'unsplash_${widget.curPhoto.id}.jpg';
      else if (widget.currSource == 2)
        imageName = 'pixabay_${widget.curPhoto.id}.jpg';

      print('image url :: $image');

      localFileLocation = AndroidDestinationType.custom(
        directory: appName,
      )..subDirectory(imageName);

      var imageId = await ImageDownloader.downloadImage(
        image,
        destination: localFileLocation,
      ).then((value) {
        print('ImageDownloader :: DONE');

        Fluttertoast.showToast(
          msg: "Image Downloaded",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      });
      print('ImageDownloader :: $imageId ::  ${imageId.toString()}');
    } on PlatformException catch (error) {
      print(error);
    }
  }

  Future<Null> handleApply(String image, BuildContext context) async {
    String result;
    var file;

    try {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text('Set As'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                      title: Text('Home Screen Wallpaper'),
                      onTap: () async {
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                          msg: "Setting Home Screen Wallpaper ... ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                        file = await DefaultCacheManager().getSingleFile(image);
                        result = await WallpaperManager.setWallpaperFromFile(
                                file.path, WallpaperManager.HOME_SCREEN)
                            .then((value) {
                          Fluttertoast.showToast(
                            msg: "Home Screen Wallpaper Set",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                          print('WallpaperManager value :: $value');
                          return value;
                        });
                      }),
                  ListTile(
                      title: Text('Lock Screen Wallpaper'),
                      onTap: () async {
                        Fluttertoast.showToast(
                          msg: "Setting Lock Screen Wallpaper ... ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                        file = await DefaultCacheManager().getSingleFile(image);
                        result = await WallpaperManager.setWallpaperFromFile(
                                file.path, WallpaperManager.LOCK_SCREEN)
                            .then((value) {
                          Fluttertoast.showToast(
                            msg: "Lock Screen Wallpaper Set",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                          print('WallpaperManager value :: $value');
                          return value;
                        });
                      }),
                ],
              ),
            );
          });

      print('RESULT :: $result');
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
  }
}
