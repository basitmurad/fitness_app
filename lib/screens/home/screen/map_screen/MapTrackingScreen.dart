// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
//
// class MapTrackingScreen extends StatefulWidget {
//   const MapTrackingScreen({super.key});
//
//   @override
//   State<MapTrackingScreen> createState() => _MapTrackingScreenState();
// }
//
// class _MapTrackingScreenState extends State<MapTrackingScreen> {
//   static const LatLng _defaultPosition = LatLng(37.7749, -122.4194); // Default location: San Francisco
//   late GoogleMapController _mapController;
//   LatLng _currentPosition = _defaultPosition;
//   final Set<Marker> _markers = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//     _listenToLocationChanges();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enable location services')),
//       );
//       return;
//     }
//
//     // Check for permissions
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Location permission denied')),
//         );
//         return;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Location permission permanently denied')),
//       );
//       return;
//     }
//
//     // Get the current position
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     _updateMapPosition(position);
//   }
//
//   void _listenToLocationChanges() {
//     Geolocator.getPositionStream(locationSettings: const LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 10, // Update only if the device moves by 10 meters
//     )).listen((Position position) {
//       _updateMapPosition(position);
//     });
//   }
//
//   void _updateMapPosition(Position position) {
//     setState(() {
//       _currentPosition = LatLng(position.latitude, position.longitude);
//       _markers.clear();
//       _markers.add(
//         Marker(
//           markerId: const MarkerId('currentLocation'),
//           position: _currentPosition,
//           infoWindow: const InfoWindow(title: 'You are here'),
//         ),
//       );
//       _mapController.animateCamera(
//         CameraUpdate.newLatLngZoom(_currentPosition, 14),
//       );
//     });
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map Tracking'),
//         backgroundColor: Colors.blue,
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _defaultPosition,
//           zoom: 12.0,
//         ),
//         markers: _markers,
//         myLocationEnabled: true,
//         myLocationButtonEnabled: true,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapTrackingScreen extends StatefulWidget {
  const MapTrackingScreen({super.key});

  @override
  State<MapTrackingScreen> createState() => _MapTrackingScreenState();
}

class _MapTrackingScreenState extends State<MapTrackingScreen> {
  static const LatLng _defaultPosition = LatLng(37.7749, -122.4194); // Default location: San Francisco
  static const LatLng _konmodasPosition = LatLng(37.7749, -122.4194); // Replace with actual Konmodas coordinates
  late GoogleMapController _mapController;
  LatLng _currentPosition = _defaultPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _listenToLocationChanges();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enable location services')),
      );
      return;
    }

    // Check for permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission permanently denied')),
      );
      return;
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _updateMapPosition(position);
  }

  void _listenToLocationChanges() {
    Geolocator.getPositionStream(locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update only if the device moves by 10 meters
    )).listen((Position position) {
      _updateMapPosition(position);
    });
  }

  void _updateMapPosition(Position position) {
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: _currentPosition,
          infoWindow: const InfoWindow(title: 'You are here'),
        ),
      );
      _markers.add(
        Marker(
          markerId: const MarkerId('konmodas'),
          position: _konmodasPosition,
          infoWindow: const InfoWindow(title: 'Konmodas'),
        ),
      );

      // Draw a polyline from the current location to Konmodas
      _polylines.clear();
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: [_currentPosition, _konmodasPosition],
          color: Colors.blue,
          width: 5,
        ),
      );

      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition, 14),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Tracking'),
        backgroundColor: Colors.blue,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _defaultPosition,
          zoom: 12.0,
        ),
        markers: _markers,
        polylines: _polylines,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
