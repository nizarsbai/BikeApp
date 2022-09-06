import 'package:google_maps_flutter/google_maps_flutter.dart';

enum InfoWindowType { position, destination }

class AuthBikeAppInfoWindow {
  final String? name;
  final Duration? time;
  final LatLng? position;
  final InfoWindowType type;

  const AuthBikeAppInfoWindow({this.name, this.time, this.position, required this.type});
}