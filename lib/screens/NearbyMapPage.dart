import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:warm_hearts_flutter/constants/StaticObjects.dart';
import 'package:warm_hearts_flutter/data/post/Adoption.dart';
import 'package:warm_hearts_flutter/data/post/Mating.dart';
import 'package:warm_hearts_flutter/data/post/Missing.dart';
import 'package:warm_hearts_flutter/screens/PostDetailPage.dart';

class NearbyMapPage extends StatefulWidget {
  @override
  _NearbyMapPageState createState() => _NearbyMapPageState();
}

class _NearbyMapPageState extends State<NearbyMapPage> {
  List<Marker> _markers = List();
  GoogleMapController _googleMapController;

  @override
  void initState() {
    super.initState();
    _prepareMap();
    Permission.location.status.then((status) {
      if(status.isDenied){
        Permission.location.request().then((requestStatus){
          if(requestStatus.isGranted){
            _initPosition();
          }
        });
      }
      if(status.isGranted){
        _initPosition();
      }
    });
  }

  void _initPosition() async{
    try {
      var currentPosition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      _googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
          zoom: 14
      )));
    } catch (e){
      Fluttertoast.showToast(msg: 'Daha iyi bir deneyim için lütfen cihaz konumunu açın');
    }
  }

  void _prepareMap() async {
    for (int i = 0; i < StaticObjects.adoptionList.length; i++) {
      Adoption element = StaticObjects.adoptionList[i];
      final iconData = Icons.location_on;
      final pictureRecorder = PictureRecorder();
      final canvas = Canvas(pictureRecorder);
      final textPainter = TextPainter(textDirection: TextDirection.ltr);
      final iconStr = String.fromCharCode(iconData.codePoint);

      textPainter.text = TextSpan(
          text: iconStr,
          style: TextStyle(
            letterSpacing: 0.0,
            fontSize: 110.0,
            fontFamily: iconData.fontFamily,
            color: Color(0xFFfc8803),
          ));
      textPainter.layout();
      textPainter.paint(canvas, Offset(0.0, 0.0));
      final picture = pictureRecorder.endRecording();
      final image = await picture.toImage(110, 110);
      final bytes = await image.toByteData(format: ImageByteFormat.png);

      final bitmapDescriptor = BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
      var marker = Marker(
          markerId: MarkerId('adoption-$i'),
          icon: bitmapDescriptor,
          position: LatLng(element.latitude, element.longitude),
          onTap: () {
            Navigator.of(context).push(PageTransition(child: PostDetailPage(preview: false, postMode: 0, adoption: element), type: PageTransitionType.rightToLeft));
          });
      setState(() {
        _markers.add(marker);
      });
    }

    for (int i = 0; i < StaticObjects.missingList.length; i++) {
      Missing element = StaticObjects.missingList[i];
      final iconData = Icons.location_on;
      final pictureRecorder = PictureRecorder();
      final canvas = Canvas(pictureRecorder);
      final textPainter = TextPainter(textDirection: TextDirection.ltr);
      final iconStr = String.fromCharCode(iconData.codePoint);

      textPainter.text = TextSpan(
          text: iconStr,
          style: TextStyle(
            letterSpacing: 0.0,
            fontSize: 110.0,
            fontFamily: iconData.fontFamily,
            color: Color(0xFFfc4a03)
          ));
      textPainter.layout();
      textPainter.paint(canvas, Offset(0.0, 0.0));
      final picture = pictureRecorder.endRecording();
      final image = await picture.toImage(110, 110);
      final bytes = await image.toByteData(format: ImageByteFormat.png);

      final bitmapDescriptor = BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
      var marker = Marker(
          markerId: MarkerId('missing-$i'),
          icon: bitmapDescriptor,
          position: LatLng(element.latitude, element.longitude),
          onTap: () {
            Navigator.of(context).push(PageTransition(child: PostDetailPage(preview: false, postMode: 1, missing : element), type: PageTransitionType.rightToLeft));
          });
      setState(() {
        _markers.add(marker);
      });
    }

    for (int i = 0; i < StaticObjects.matingList.length; i++) {
      Mating element = StaticObjects.matingList[i];
      final iconData = Icons.location_on;
      final pictureRecorder = PictureRecorder();
      final canvas = Canvas(pictureRecorder);
      final textPainter = TextPainter(textDirection: TextDirection.ltr);
      final iconStr = String.fromCharCode(iconData.codePoint);

      textPainter.text = TextSpan(
          text: iconStr,
          style: TextStyle(
              letterSpacing: 0.0,
              fontSize: 110.0,
              fontFamily: iconData.fontFamily,
              color: Color(0xFFfce703)
          ));
      textPainter.layout();
      textPainter.paint(canvas, Offset(0.0, 0.0));
      final picture = pictureRecorder.endRecording();
      final image = await picture.toImage(110, 110);
      final bytes = await image.toByteData(format: ImageByteFormat.png);

      final bitmapDescriptor = BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
      var marker = Marker(
          markerId: MarkerId('mating-$i'),
          icon: bitmapDescriptor,
          position: LatLng(element.latitude, element.longitude),
          onTap: () {
            Navigator.of(context).push(PageTransition(child: PostDetailPage(preview: false, postMode: 2, mating : element), type: PageTransitionType.rightToLeft));
          });
      setState(() {
        _markers.add(marker);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          child: GoogleMap(
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(target: LatLng(38.73222, 35.48528), zoom: 14),
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _googleMapController = controller;
            },
          ),
        ),
      ),
    );
  }
}
