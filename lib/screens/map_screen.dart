import 'dart:async';
import 'package:auth_bikeapp/screens/reservation/station_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/next_screen.dart';


const LatLng source_location = LatLng(33.599192545109936, -7.664233691337921);
const LatLng dest_location = LatLng(33.56806300637081, -7.628466552353953);

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen> {
  final Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  LatLng currentLocation=const LatLng(33.599192545109936, -7.664233691337921);
  LatLng destinationLocation=const LatLng(33.56806300637081, -7.628466552353953);
  //add multiple markers on the map
  late GoogleMapController googleMapController;
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];

  @override
  void initState() {
    intilize();
    super.initState();
    polylinePoints = PolylinePoints();

  }
  
  intilize() {
     Marker firstMarker = Marker(
      markerId: const MarkerId('Station Maarif'),
      position: const LatLng(33.56806300637081, -7.628466552353953),
      infoWindow: const InfoWindow(title: 'Station Maarif'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );
    Marker secondMarker = Marker(
      markerId: const MarkerId('Station Mosquée Hassan-II'),
      position: const LatLng(33.60950735526005, -7.633051170093907),
      infoWindow: const InfoWindow(title: 'Station Mosquée Hassan-II'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );
    Marker thirdMarker = Marker(
      markerId: const MarkerId('Station Place des Nations Unies'),
      position: const LatLng(33.595194912570044, -7.618696588039488),
      infoWindow: const InfoWindow(title: 'Station Place des Nations Unies'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      onTap: () => nextScreen(context, StationScreen()),
    );
    Marker forthMarker = Marker(
      markerId: const MarkerId('Station Morocco Mall'),
      position: const LatLng(33.57691956355926, -7.707088013896289),
      infoWindow: const InfoWindow(title: 'Station Morocco Mall'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );
    Marker fifthMarker = Marker(
      markerId: const MarkerId('Station Anfa Place'),
      position: const LatLng(33.599192545109936, -7.664233691337921),
      infoWindow: const InfoWindow(title: 'Station Anfa Place'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );
    markers.add(firstMarker);
    markers.add(secondMarker);
    markers.add(thirdMarker);
    markers.add(forthMarker);
    markers.add(fifthMarker);


      // _polylines.add(
      //   Polyline(polylineId: PolylineId('1'),
      //   points : polylineCoordinates
      // ),
      // );
      setState(() {
        _polylines.add(
          Polyline(
            width: 10,
            polylineId: const PolylineId('polyLine'),
            color: const Color(0xFF08A5CB),
            points: polylineCoordinates
          )
        );
      });

      
  }


static const _initialCameraPosition = CameraPosition(
  target: LatLng(33.53985139628253, -7.658792714030167),
  zoom: 11.5,
);


void setInitialLocation() {
    currentLocation = LatLng(
      source_location.latitude,
      source_location.longitude
    );

    destinationLocation = LatLng(
      dest_location.latitude,
      dest_location.longitude
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GoogleMap(
        
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        compassEnabled: false,
        tiltGesturesEnabled: false,
        polylines: _polylines,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          //_controller.complete(controller);
          googleMapController = controller;
          setPolylines();

        },

        markers: markers.map((e) => e).toSet(),
        /*
        markers: {
          if(_origin != null) _origin,
          if(_destination != null) _destination
        },

        onLongPress: _addMarker,
        */
      ),
     
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePosition();

          googleMapController
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));


          markers.clear();

          markers.add(Marker(markerId: const MarkerId('Votre Position'),position: LatLng(position.latitude, position.longitude)));

          

        //   setState(() {
        //      _polylines.add(
        //     Polyline(
        //     width: 10,
        //     polylineId: PolylineId('polyLine'),
        //     color: Color(0xFF08A5CB),
        //     points: polylineCoordinates
        //   )
        // );
        //   });
          }, 
          label:const Text("Ma Position"),
          icon: const Icon(Icons.location_history),
    ),
    
    );
  }
  
  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "<AIzaSyDGIlvQGO-4WnHB_t7FgHG5atjI0WiyqxA>",
      PointLatLng(
        source_location.latitude,
        source_location.longitude
      ),
      PointLatLng(
        dest_location.latitude,
        dest_location.longitude
      )
    );

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      
    }
    }
    

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      return Future.error('Services de localisation sont désactivés');
    }

    permission = await Geolocator.requestPermission();

    if(permission == LocationPermission.denied){
      return Future.error('Autorisation de Localisation est désactivé');
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;

    
  }

}
  
