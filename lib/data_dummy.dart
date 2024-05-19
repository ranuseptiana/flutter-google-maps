import 'package:google_maps_flutter/google_maps_flutter.dart';

Set<Marker> markers = {
  Marker(
      markerId: const MarkerId("Kantor Desa Keboan Anom"),
      position: const LatLng(-7.394117752832961, 112.71407055148345),
      infoWindow: const InfoWindow(title: "Kantor Desa"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
  Marker(
      markerId: const MarkerId("SDN Keboan Anom"),
      position: const LatLng(-7.393441603192072, 112.71535200086306),
      infoWindow: const InfoWindow(title: "Sekolah Dasar"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
  Marker(
      markerId: const MarkerId("McDonald's Puri Jaya"),
      position: const LatLng(-7.394810166896118, 112.72814189328416),
      infoWindow: const InfoWindow(title: "Restoran Cepat Saji"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
  Marker(
      markerId: const MarkerId("Stasiun Kereta Api Gedangan"),
      position: const LatLng(-7.388941024761289, 112.72832233007254),
      infoWindow: const InfoWindow(title: "Stasiun Kereta Api"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
  Marker(
      markerId: const MarkerId("RSIA Metro Hospitals Sidoarjo"),
      position: const LatLng(-7.400571870666733, 112.72687883569881),
      infoWindow: const InfoWindow(title: "Rumah Sakit Ibu Anak"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed))
};