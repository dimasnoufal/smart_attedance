import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';
import 'dart:developer' as dev;

/// Holds the device location info captured once at app start.
class DeviceLocation {
  final double latitude;
  final double longitude;
  final String addressDetail;

  const DeviceLocation({
    required this.latitude,
    required this.longitude,
    required this.addressDetail,
  });

  @override
  String toString() =>
      'DeviceLocation(lat: $latitude, lng: $longitude, address: $addressDetail)';
}

/// Service to fetch device location once on app start.
/// Caches the result so it only hits GPS once.
@lazySingleton
class LocationService {
  DeviceLocation? _cachedLocation;

  /// Returns the cached location or fetches a fresh one.
  DeviceLocation? get currentLocation => _cachedLocation;

  /// Whether location has been successfully fetched.
  bool get hasLocation => _cachedLocation != null;

  /// Requests location permission and fetches the current position.
  /// Should be called once when the app starts.
  Future<DeviceLocation?> fetchLocation() async {
    if (_cachedLocation != null) return _cachedLocation;

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        dev.log('Location services are disabled', name: 'LocationService');
        return null;
      }

      // Check and request permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          dev.log('Location permission denied', name: 'LocationService');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        dev.log('Location permission permanently denied', name: 'LocationService');
        return null;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      // Reverse geocode to get address
      String addressDetail = '${position.latitude}, ${position.longitude}';
      try {
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          final parts = <String>[
            if (place.subLocality?.isNotEmpty == true) place.subLocality!,
            if (place.locality?.isNotEmpty == true) place.locality!,
            if (place.subAdministrativeArea?.isNotEmpty == true)
              place.subAdministrativeArea!,
          ];
          if (parts.isNotEmpty) {
            addressDetail = parts.join(', ');
          }
        }
      } catch (e) {
        dev.log('Geocoding failed: $e', name: 'LocationService');
        // Use coordinates as fallback — already set above
      }

      _cachedLocation = DeviceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        addressDetail: addressDetail,
      );

      dev.log('Location fetched: $_cachedLocation', name: 'LocationService');
      return _cachedLocation;
    } catch (e) {
      dev.log('Failed to get location: $e', error: e, name: 'LocationService');
      return null;
    }
  }
}
