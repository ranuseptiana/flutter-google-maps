import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_maps/data_dummy.dart';
import 'package:flutter_google_maps/map_type_google.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsV1Page extends StatefulWidget {
  const MapsV1Page({super.key});

  @override
  State<MapsV1Page> createState() => _MapsV1PageState();
}

class _MapsV1PageState extends State<MapsV1Page> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  double latitude = -7.3967998536032065;
  double longitude = 112.71468917520309;

  var mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Google Maps V1'),
          actions: [
            PopupMenuButton(
              onSelected: onSelectedMapType,
              itemBuilder: (context) {
                return googleMapTypes.map((typeGoogle) {
                  return PopupMenuItem(
                    value: typeGoogle.type,
                    child: Text(typeGoogle.type.name),
                  );
                }).toList();
              },
            )
          ]
      ),
      body: Stack(
        children: [
          _buildGoogleMaps(),
          _buildDetailCard(),
        ],
      ),
    );
  }

  Widget _buildGoogleMaps() {
    return GoogleMap(
      mapType: mapType,
      initialCameraPosition: CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 14,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: markers,
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

  Widget _buildDetailCard() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(
              width: 10,
            ),
            _displayPlaceCard(
                "https://lh5.googleusercontent.com/p/AF1QipOG15wa989Pk6CyaOADA6-BEj5RwlXLbbXg3m_j=w408-h544-k-no",
                "Kantor Desa Keboan Anom",
                -7.3941667486510045, 112.71406274290466),
            const SizedBox(
              width: 10,
            ),
            _displayPlaceCard(
                "https://lh5.googleusercontent.com/p/AF1QipNpwhjRET2O140jhS27AbV-2oVPC3N3xbzm41MU=w408-h306-k-no",
                "SDN Keboan Anom",
                -7.393384736054036, 112.71529655906696),
            const SizedBox(
              width: 10,
            ),
            _displayPlaceCard(
                "https://lh5.googleusercontent.com/p/AF1QipNX88OqlR81ukUShDo3rTLJP9PwUDX7yXWm5bC5=w425-h240-k-no",
                "McDonald's Puri Jaya",
                -7.395237729311119, 112.72804653268592),
            const SizedBox(
              width: 10,
            ),
            _displayPlaceCard(
                "https://lh5.googleusercontent.com/p/AF1QipN-uw3nR95s7zGNFWuXN5zX1W-tSoKUFz1SF9M=w408-h544-k-no",
                "Stasiun Kereta Api Gedangan",
                -7.3891518407541605, 112.72834694008702),
            const SizedBox(
              width: 10,
            ),
            _displayPlaceCard(
                "https://lh5.googleusercontent.com/p/AF1QipMWfVwWM3Lxt1aN05yRogxBoQHWztHktGfg-rt_=w408-h408-k-no",
                "RSIA Metro Hospitals Sidoarjo",
                -7.4004227191683105, 112.7270948052217),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }

  _displayPlaceCard(String imageUrl, String name, double lat, double lgn) {
    return GestureDetector(
      onTap: () {
        _onClickPlaceCard(lat, lgn);
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        height: 90,
        margin: const EdgeInsets.only(bottom: 30),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          elevation: 10,
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical:10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "4.9",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          children: stars(),
                        )
                      ],
                    ),
                    const Text(
                      "Indonesia \u00B7 Gedangan",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Expanded(
                        child: Text(
                            "Closed \u00B7 Open 07:00 Pagi",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            )
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> stars() {
    List<Widget> list1 = [];
    for (var i = 0; i < 5; i++) {
      list1.add(
        const Icon(
          Icons.star,
          color: Colors.orange,
          size: 15,
        ),
      );
    }
    return list1;
  }

  void _onClickPlaceCard(double lat, double lgn) async {
    setState(() {
      latitude = lat;
      longitude = lgn;
    });

    GoogleMapController controller = await _controller.future;
    final cameraPosition = CameraPosition(
        target: LatLng(latitude, longitude),
      zoom: 17,
      bearing: 192,
      tilt: 55,
    );
    final cameraUpdate = CameraUpdate.newCameraPosition(cameraPosition,);
    controller.animateCamera(cameraUpdate);
  }
}