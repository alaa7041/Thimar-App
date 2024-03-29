import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/design/app_bar.dart';
import '../../core/logic/helper_methods.dart';
import '../../generated/locale_keys.g.dart';

class AddressView extends StatefulWidget {
  const AddressView({Key? key}) : super(key: key);

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final _controller = Completer<GoogleMapController>();

  Set<Marker> markers = {
    const Marker(
      markerId: MarkerId("1"),
      position: LatLng(31.0191987, 31.3884559),
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
        body: Column(
          children: [
            CustomAppBar(
              text: LocaleKeys.addAddress.tr(),
              onPress: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 450.h,
              child: GoogleMap(
                onTap: (argument) {
                  markers.add(
                    Marker(
                      markerId: const MarkerId("1"),
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
                      circleId: const CircleId("1"),
                      radius: 10000,
                      center: const LatLng(-122.084, 37.4219983),
                      fillColor: Theme.of(context).primaryColor.withOpacity(.2),
                      strokeColor:
                          Theme.of(context).primaryColor.withOpacity(.3))
                },
                mapType: MapType.normal,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(31.0191987, 31.3884559),
                  zoom: 14,
                ),

              ),
            ),
            if (myAddress != null) Text(myAddress!),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const Expanded(
                    child: Text("نوع العنوان",
                        style: TextStyle(
                          color: Color(0xff8B8B8B),
                        )),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 37,
                          child: FilledButton(
                              onPressed: () {}, child: const Text("المنزل")),
                        ),
                        const Spacer(),
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text("العمل"),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'ادخل رقم الجوال',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> goToLocation({required LatLng location}) async {
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
        markerId: const MarkerId("1"),
        position: location,
      ),
    );
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
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

// goToLocation(
  //     location:const LatLng(-122.084,37.4219983)
  // );
  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;

    if (!serviceEnabled) {
      showMessage('Location services are disabled.', type: MessageType.warning);
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
    await goToLocation(
        location: LatLng(myPosition.latitude, myPosition.longitude));
    return myPosition;
  }
}
