import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
static const _initialCameraPosition = CameraPosition(
  target: LatLng(33.53985139628253, -7.658792714030167),
  zoom: 11.5,
);


late final GoogleMapController _googleMapController;
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

 @override
 void dispose() {
  _googleMapController.dispose();
  super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController=controller,
        markers: {
          if(_origin != null) _origin,
          if(_destination != null) _destination
        },
        onLongPress: _addMarker,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _addMarker(LatLng pos) {
    if(_origin==null || (_origin != null && _destination != null)) {
        setState(() {
          _origin = Marker(
            markerId: const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Origin'),
            icon: 
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            position: pos,
          );
          //Reset Destination
          late final _destination=null;
        });
    } else {
        // Origin is already set
        // Set destination
        setState(() {
          _destination=Marker(
          markerId: const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: pos,
            );
        });
    }
  }
}