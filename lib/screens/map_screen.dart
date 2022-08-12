import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


const LatLng SOURCE_LOCATION = LatLng(33.599192545109936, -7.664233691337921);
const LatLng DEST_LOCATION = LatLng(33.56806300637081, -7.628466552353953);

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}



// Future<LocationData?> _currentLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;
 
//     Location location = new Location();
 
//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return null;
//       }
//     }
 
//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return null;
//       }
//     }
//     return await location.getLocation();
//   }



class _MapScreenState extends State<MapScreen> {
  Set<Polyline> _polylines = Set<Polyline>();
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
    Marker firstMarker=Marker(
            markerId: MarkerId('Station Maarif'),
            position: LatLng(33.56806300637081, -7.628466552353953),
            infoWindow: const InfoWindow(title: 'Station Maarif'),
            icon: 
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          );
    Marker secondMarker=Marker(
            markerId: MarkerId('Station Mosquée Hassan-II'),
            position: LatLng(33.60950735526005, -7.633051170093907),
            infoWindow: const InfoWindow(title: 'Station Mosquée Hassan-II'),
            icon: 
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          );
          Marker thirdMarker=Marker(
            markerId: MarkerId('Station Place des Nations Unies'),
            position: LatLng(33.595194912570044, -7.618696588039488),
            infoWindow: const InfoWindow(title: 'Station Place des Nations Unies'),
            icon: 
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          );
          Marker forthMarker=Marker(
            markerId: MarkerId('Station Morocco Mall'),
            position: LatLng(33.57691956355926, -7.707088013896289),
            infoWindow: const InfoWindow(title: 'Station Morocco Mall'),
            icon: 
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          );
          Marker fifthMarker=Marker(
            markerId: MarkerId('Station Anfa Place'),
            position: LatLng(33.599192545109936, -7.664233691337921),
            infoWindow: const InfoWindow(title: 'Station Anfa Place'),
            icon: 
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
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

void setInitialLocation() {
    currentLocation = LatLng(
      SOURCE_LOCATION.latitude,
      SOURCE_LOCATION.longitude
    );

    destinationLocation = LatLng(
      DEST_LOCATION.latitude,
      DEST_LOCATION.longitude
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
        currentLocation.latitude,
        currentLocation.longitude
      ),
      PointLatLng(
        destinationLocation.latitude,
        destinationLocation.longitude
      )
    );

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(
          Polyline(
            width: 10,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF08A5CB),
            points: polylineCoordinates
          )
        );
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
  
