import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng? _selectedPoint;
  LatLng? _currentLocation;
  Location location = Location();

  void _showMsg(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  void _goToCurrentLocation() async {
    print("Hello");
    try {
      final bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        final bool requestedService = await location.requestService();
        if (!requestedService) {
          _showMsg("Service is not enabled!");
          return;
        }
      }

      final PermissionStatus permission = await location.hasPermission();
      if (permission == PermissionStatus.denied) {
        final PermissionStatus requestPermission = await location
            .requestPermission();
        if (requestPermission != PermissionStatus.granted &&
            requestPermission != PermissionStatus.grantedLimited) {
          _showMsg("Permission is required.");
          return;
        }}
        final LocationData locationData = await location.getLocation();
        if (locationData.latitude == null && locationData.longitude == null) {
          _showMsg("Invalid latitude and longitude");
          return;
        }

        final LatLng liveLocation = LatLng(
          locationData.latitude!,
          locationData.longitude!,
        );

        setState(() {
          _currentLocation = liveLocation;
        });

        _mapController.move(liveLocation, 15);
      
    print("Hello_successfull");
    } catch (error) {
      _showMsg("Map problem : $error");
    }
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Showing Map')),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: const LatLng(23.0, 90.0),
          onTap: (tapPosition, point) {
            setState(() {
              _selectedPoint = point;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: // "https://api.maptiler.tile.openstreetmap.org/{z}/{x}/{y}.png",
                //  "https://api.maptiler.com/tiles/v3-lite/{z}/{x}/{y}.pbf?key=0x2c1U4qCEAVNNtSCKcT",
                "https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=0x2c1U4qCEAVNNtSCKcT",
            userAgentPackageName: "com.example.map_integration_app1",
          ),
          MarkerLayer(
            markers: [
              if (_selectedPoint != null)
                Marker(
                  height: 40.0,
                  width: 40.0,
                  point: _selectedPoint!,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              if (_currentLocation != null)
                Marker(
                  height: 40.0,
                  width: 40.0,
                  point: _currentLocation!,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.purple,
                    size: 40,
                  ),
                ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToCurrentLocation,
        label: const Text("Get my location"),
        icon: const Icon(Icons.my_location),
      ),
    );
  }
}
