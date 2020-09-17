import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:warm_hearts_flutter/data/CallManager.dart';

class ImageDetailScreen extends StatefulWidget {
  final bool preview;
  final List<File> fileImages;
  final List<String> urlImages;
  final int offSet;

  ImageDetailScreen({this.fileImages, this.urlImages, this.offSet, this.preview = false});

  @override
  _ImageDetailScreenState createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  CallManager _callManager = CallManager();
  PageController _controller;
  int currentPage;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.offSet);
    currentPage = widget.offSet;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: SweepGradient(
            colors: [
              Color(0xFFfc9842),
              Color(0xFFfe5f75),
            ],
            center: AlignmentDirectional(1, -1),
            startAngle: 0,
            endAngle: 2.2,
            stops: [0.74, 1],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(width: double.infinity),
                  Expanded(
                    flex: MediaQuery.of(context).size.height.toInt() - 40,
                    child: PhotoViewGallery.builder(
                      scrollPhysics: BouncingScrollPhysics(),
                      builder: (BuildContext context, int index) {
                        return PhotoViewGalleryPageOptions(
                            imageProvider: widget.preview ? FileImage(widget.fileImages[index]) :
                            NetworkImage(_callManager.getImageUrl(widget.urlImages[index])),
                            initialScale: PhotoViewComputedScale.contained * 0.8,
                            minScale: PhotoViewComputedScale.contained * 0.6,
                            maxScale: PhotoViewComputedScale.contained * 5,
                            filterQuality: FilterQuality.high,
                            );
                      },
                      itemCount: widget.preview ? widget.fileImages.length : widget.urlImages.length,
                      loadingBuilder: (context, event){
                        return  SpinKitFadingCircle(
                          color: Color(0xff0367BD),
                        );
                      },
                      backgroundDecoration: BoxDecoration(
                        color: Colors.transparent
                      ),
                      pageController: _controller,
                      onPageChanged: (index){
                        setState(() {
                          currentPage = index;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Platform.isIOS ? Icon(Icons.arrow_back_ios,  color: Colors.white,) : Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _getCarouselChips(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  List<Widget> _getCarouselChips() {
    List<Widget> _chips = List();
    for (int i = 0; i < (widget.preview ? widget.fileImages.length : widget.urlImages.length); i++) {
      _chips.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: i == currentPage ? 24 : 12,
          height: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: i == currentPage ? Colors.green : Colors.white,
          ),
        ),
      ));
    }
    return _chips;
  }
}
