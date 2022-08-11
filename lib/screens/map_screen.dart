import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //add multiple markers on the map
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];

  @override
  void initState() {
    intilize();
    super.initState();
  }
  
  intilize() {
    Marker firstMarker=Marker(
            markerId: MarkerId('Station Maarif'),
            position: LatLng(33.56806300637081, -7.628466552353953),
            infoWindow: const InfoWindow(title: 'Station Maarif'),
            icon: 
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          );
    Marker secondMarker=Marker(
            markerId: MarkerId('Station Mosquée Hassan-II'),
            position: LatLng(33.60950735526005, -7.633051170093907),
            infoWindow: const InfoWindow(title: 'Station Mosquée Hassan-II'),
            icon: 
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          );
          Marker thirdMarker=Marker(
            markerId: MarkerId('Station Place des Nations Unies'),
            position: LatLng(33.595194912570044, -7.618696588039488),
            infoWindow: const InfoWindow(title: 'Station Place des Nations Unies'),
            icon: 
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          );
          Marker forthMarker=Marker(
            markerId: MarkerId('Station Morocco Mall'),
            position: LatLng(33.57691956355926, -7.707088013896289),
            infoWindow: const InfoWindow(title: 'Station Morocco Mall'),
            icon: 
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          );
          Marker fifthMarker=Marker(
            markerId: MarkerId('Station Anfa Place'),
            position: LatLng(33.599192545109936, -7.664233691337921),
            infoWindow: const InfoWindow(title: 'Station Anfa Place'),
            icon: 
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          );
      markers.add(firstMarker);
      markers.add(secondMarker);
      markers.add(thirdMarker);
      markers.add(forthMarker);
      markers.add(fifthMarker);
      setState(() {
        
      });
  }


static const _initialCameraPosition = CameraPosition(
  target: LatLng(33.53985139628253, -7.658792714030167),
  zoom: 11.5,
);


//late final GoogleMapController _googleMapController;
/*
Marker _origin=Marker(
            markerId: const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Origin'),
            icon: 
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          );
Marker _destination=Marker(
          markerId: const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            );
            */

//  @override
//  void dispose() {
//   _googleMapController.dispose();
//   super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
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
      /*
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
      */
    );
  }

  // void _addMarker(LatLng pos) {
  //   if(_origin==null || (_origin != null && _destination != null)) {
  //       setState(() {
  //         _origin = Marker(
  //           markerId: const MarkerId('origin'),
  //           infoWindow: const InfoWindow(title: 'Origin'),
  //           icon: 
  //                 BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //           position: pos,
  //         );
  //         //Reset Destination
  //       late final _destination=null;
  //       });
  //   } else {
  //       // Origin is already set
  //       // Set destination
  //       setState(() {
  //         _destination=Marker(
  //         markerId: const MarkerId('destination'),
  //           infoWindow: const InfoWindow(title: 'Destination'),
  //           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //           position: pos,
  //           );
  //       });
  //   }
  //}
}