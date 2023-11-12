import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../core/logic/helper_methods.dart';

class AddressView extends StatefulWidget {
  const AddressView({Key? key}) : super(key: key);

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final _controller = Completer<GoogleMapController>();

  Set<Marker> markers = {
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(31.0191987,31.3884559),
    ),
  };
  @override
  void initState() {
    super.initState();
    _determinePosition();
  }
  String? myAddress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(
            height: 32.h,
            width: 32.w,
            padding: EdgeInsetsDirectional.only(start: 8),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).primaryColor,
              ),
            ),
            margin: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.r),
                color: Theme.of(context).primaryColor.withOpacity(.13)),
          ),
          title: Center(
            child: Text(
              "اضافة عنوان",
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 450.h,
              child: GoogleMap(
                onTap: (argument) {
                  markers.add(
                    Marker(
                      markerId: MarkerId("1"),
                      position: LatLng(argument.latitude, argument.longitude),
                    ),
                  );
                  setState(() {});
                  print(argument.latitude);
                  print(argument.longitude);
                },
                markers: markers,
                circles: {
                  Circle(
                      circleId: CircleId("1"),
                      radius: 10000,
                      center: LatLng(-122.084,37.4219983),
                      fillColor: Theme.of(context).primaryColor.withOpacity(.2),
                      strokeColor:
                          Theme.of(context).primaryColor.withOpacity(.3))
                },
                mapType: MapType.terrain,
                initialCameraPosition: CameraPosition(
                  target: LatLng(-122.084,37.4219983),
                  zoom: 14,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            if(myAddress!=null)
              Text(myAddress!),
            SizedBox(height: 20.h,),
            FloatingActionButton(
              onPressed: () async {
                goToLocation(
                    location:LatLng(-122.084,37.4219983)
                );
              },
              child: Icon(Icons.location_on_sharp),
            )
          ],
        ),
      ),
    );
  }

  Future<void> goToLocation({required LatLng location})async{
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 12,
        ),
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId("1"),
        position: location,
      ),
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(location
        .latitude,location.longitude);
    var element = placemarks.first;
      print(element.name);
      print(element.country);
      print(element.subLocality);
      print(element.locality);
      print(element.street);
      print("*****************************");
      myAddress = "${element.name} / ${element.country} / ${element.street}";
    setState(() {});
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled =  await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;

    if (!serviceEnabled) {
      showMessage('Location services are disabled.',type: MessageType.warning);
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var myPosition = await Geolocator.getCurrentPosition();
    print("******************************************");
    print(myPosition.longitude);
    print(myPosition.latitude);
    await goToLocation(location: LatLng(myPosition.latitude, myPosition
        .longitude));
    return myPosition;
  }
}

