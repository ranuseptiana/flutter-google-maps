import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_maps/map_type_google.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsV2Page extends StatefulWidget {
  const MapsV2Page({super.key});

  @override
  State<MapsV2Page> createState() => _MapsV2PageState();
}

class _MapsV2PageState extends State<MapsV2Page> {
  final Completer<GoogleMapController> _controller = Completer();
  double latitude = -7.3967998536032065;
  double longitude = 112.71468917520309;

  var mapType = MapType.normal;

  Position? devicePosition;
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps V2"),
        actions: [
          PopupMenuButton(
            onSelected: onSelectedMapType,
            itemBuilder: (context) {
              return googleMapTypes
                  .map((typeGoogle) => PopupMenuItem(
                value: typeGoogle.type,
                child: Text(typeGoogle.type.name),
              ))
                  .toList();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildGoogleMap(),
          _buildSearchCard(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Geolocator.requestPermission();
  }

  Widget _buildGoogleMap() {
    return GoogleMap(
      mapType: mapType,
      initialCameraPosition: CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 15,
      ),
      onMapCreated: (controller) => _controller.complete(controller),
      myLocationEnabled: true,
    );
  }

  void onSelectedMapType(Type value) {
    setState(() {
      switch (value) {
        case Type.Normal:
          mapType = MapType.normal;
          break;
        case Type.Hybrid:
          mapType = MapType.hybrid;
          break;
        case Type.Terrain:
          mapType = MapType.terrain;
          break;
        case Type.Satelite:
          mapType = MapType.satellite;
          break;
        default:
      }
    });
  }

  _buildSearchCard() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 8,
                  bottom: 4,
                ),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Masukkan Alamat ...",
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15),
                      suffixIcon: IconButton(
                        onPressed: searchLocation,
                        icon: const Icon(Icons.search),
                      )),
                  onChanged: (value) {
                    address = value;
                  },
                  onSubmitted: (value) {
                    searchLocation();
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  getCurrentPosition().then((value) async {
                    setState(() {
                      devicePosition = value;
                    });
                    GoogleMapController controller = await _controller.future;
                    final cameraPosition = CameraPosition(
                      target: LatLng(latitude, longitude),
                      zoom: 17,
                    );
                    final CameraUpdate cameraUpdate =
                    CameraUpdate.newCameraPosition(cameraPosition);
                    controller.animateCamera(cameraUpdate);
                  });
                },
                child: const Text("Dapatkan Lokasi Saya ini"),
              ),
              devicePosition != null
                  ? Text(
                  "Lokasi Saat ini : ${devicePosition?.latitude}, ${devicePosition?.longitude}")
                  : const Text("Lokasi Tidak Terdeteksi"),
            ],
          ),
        ),
      ),
    );
  }

  Future<Position?> getCurrentPosition() async {
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      position = null;
    }

    return position;
  }

  Future searchLocation() async {
    try {
      await GeocodingPlatform.instance!
          .locationFromAddress(address)
          .then((value) async {
        GoogleMapController controller = await _controller.future;
        LatLng target = LatLng(value[0].latitude, value[0].longitude);
        CameraPosition cameraPosition = CameraPosition(
          target: target,
          zoom: 17,
        );
        CameraUpdate cameraUpdate =
        CameraUpdate.newCameraPosition(cameraPosition);
        controller.animateCamera(cameraUpdate);
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Alamat tidak ditemukan");
    }
  }
}