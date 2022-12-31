import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_app/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation? initialLocation;
  final bool isReadOnly;
  const MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: 37.419857, longitude: -122.078827),
    this.isReadOnly = false,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione...'),
        actions: [
          if (!widget.isReadOnly)
            IconButton(
              onPressed: _pickedPosition == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedPosition);
                    },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation!.latitude!,
            widget.initialLocation!.longitude!,
          ),
          zoom: 19.151926040649414,
        ),
        onTap: widget.isReadOnly ? null : _selectPosition,
        markers: (_pickedPosition == null && !widget.isReadOnly)
            ? <Marker>{}
            : {
                Marker(
                  markerId: const MarkerId('p1'),
                  position:
                      _pickedPosition ?? widget.initialLocation!.toLatLng(),
                )
              },
      ),
    );
  }
}
