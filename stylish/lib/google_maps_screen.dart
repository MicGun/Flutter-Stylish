import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:stylish/location_service.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({super.key});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  double? lat, long;
  double? searchedLat, searchedLong;
  String? country, adminArea;
  String? searchAddress;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  CameraPosition _getMinePosition(double lat, double long) {
    return CameraPosition(
      target: LatLng(lat, long),
      zoom: 19.151926040649414,
      bearing: 0.0,
    );
  }

  Set<Marker> _getMineMarker(double lat, double long) {
    Marker marker = Marker(
      markerId: const MarkerId('oxdkaldk'),
      position: LatLng(lat, long),
    );
    Set<Marker> value = <Marker>{};
    value.add(marker);
    return value;
  }

  static Set<Marker> _marker() {
    Marker marker = const Marker(
      markerId: MarkerId('oxdkaldk'),
      position: LatLng(37.42796133580664, -122.085749655962),
    );
    Set<Marker> value = Set<Marker>();
    value.add(marker);
    return value;
  }

  void getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();

    if (locationData != null) {
      setState(() {
        lat = locationData.latitude;
        long = locationData.longitude;
      });
    }
  }

  void getSearchLocation(String address) async {
    final service = LocationService();
    final location = await service.getSearchedLocation(address);

    setState(() {
      searchedLat = location?.latitude;
      searchedLong = location?.longitude;
    });

    if (searchedLat != null || searchedLong != null) {
      GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(searchedLat!, searchedLong!), zoom: 18)));
    }
  }

  void clearSearchData() async {
    searchAddress = null;
    searchedLat = null;
    searchedLong = null;

    if (lat != null || long != null) {
      GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat!, long!), zoom: 18)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (lat == null || long == null)
          ? const Text('Loading...')
          : Stack(children: [
              GoogleMap(
                scrollGesturesEnabled: true,
                rotateGesturesEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                minMaxZoomPreference: const MinMaxZoomPreference(5.0, 20.0),
                markers: (searchedLat == null || searchedLong == null)
                    ? <Marker>{}
                    : _getMineMarker(searchedLat!, searchedLong!),
                mapType: MapType.normal,
                initialCameraPosition: _getMinePosition(lat!, long!),
                onMapCreated: (GoogleMapController controller) async {
                  _controller.complete(controller);
                },
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      getSearchLocation(value);
                    },
                    controller: _searchController,
                    onChanged: (text) {
                      setState(() {
                        searchAddress = text;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.room),
                      suffixIcon:
                          (searchAddress == null || searchAddress!.isEmpty)
                              ? null
                              : InkWell(
                                  onTap: () {
                                    _searchController.clear();
                                    clearSearchData();
                                  },
                                  child: const Icon(Icons.clear),
                                ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      hintText: 'Input Address here',
                    ),
                  ))
            ]),
    );
  }

  TextEditingController _searchController = TextEditingController();
}
