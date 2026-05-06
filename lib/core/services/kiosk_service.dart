import 'dart:developer' as dev;
import 'dart:io' show Platform;

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

/// Service that manages Android Kiosk Mode (Lock Task Mode).
///
/// When kiosk mode is active, the user cannot leave the app using
/// Home, Back, or Recents buttons. This requires the app to be
/// registered as a Device Owner on the Android device.
///
/// **Platform support:**
/// - Android: Full Lock Task Mode via DevicePolicyManager
/// - iOS: No-op (use iOS Guided Access instead)
///
/// **Setup (one-time per device):**
/// ```bash
/// adb shell dpm set-device-owner com.example.smart_attedance/.KioskDeviceAdminReceiver
/// ```
@lazySingleton
class KioskService {
  static const _tag = 'KioskService';
  static const _channel = MethodChannel('com.example.smart_attedance/kiosk');

  bool _isKioskActive = false;

  /// Whether kiosk mode is currently active.
  bool get isKioskActive => _isKioskActive;

  /// Starts Android Lock Task Mode (kiosk mode).
  ///
  /// The app will be pinned to the screen, preventing the user
  /// from navigating away using system buttons.
  ///
  /// Returns `true` if kiosk mode was successfully started.
  /// On non-Android platforms, returns `false` silently.
  Future<bool> startKioskMode() async {
    if (!Platform.isAndroid) {
      dev.log('Kiosk mode is only supported on Android', name: _tag);
      return false;
    }

    if (_isKioskActive) {
      dev.log('Kiosk mode is already active', name: _tag);
      return true;
    }

    try {
      final result = await _channel.invokeMethod<bool>('startLockTask');
      _isKioskActive = result ?? false;

      if (_isKioskActive) {
        dev.log('Kiosk mode STARTED — app is now locked', name: _tag);
      } else {
        dev.log(
          'Kiosk mode could not start — is the app set as Device Owner?',
          name: _tag,
        );
      }

      return _isKioskActive;
    } on PlatformException catch (e) {
      dev.log('Failed to start kiosk mode: ${e.message}', name: _tag);
      return false;
    } catch (e) {
      dev.log('Unexpected error starting kiosk mode: $e', name: _tag);
      return false;
    }
  }

  /// Stops Android Lock Task Mode.
  ///
  /// The user will be able to navigate away from the app again.
  /// Call this before logging out or navigating to the login page.
  ///
  /// Returns `true` if kiosk mode was successfully stopped.
  Future<bool> stopKioskMode() async {
    if (!Platform.isAndroid) {
      return false;
    }

    if (!_isKioskActive) {
      dev.log('Kiosk mode is not active — nothing to stop', name: _tag);
      return true;
    }

    try {
      final result = await _channel.invokeMethod<bool>('stopLockTask');
      final stopped = result ?? false;

      if (stopped) {
        _isKioskActive = false;
        dev.log('Kiosk mode STOPPED — app is now unlocked', name: _tag);
      } else {
        dev.log('Failed to stop kiosk mode', name: _tag);
      }

      return stopped;
    } on PlatformException catch (e) {
      dev.log('Failed to stop kiosk mode: ${e.message}', name: _tag);
      return false;
    } catch (e) {
      dev.log('Unexpected error stopping kiosk mode: $e', name: _tag);
      return false;
    }
  }

  /// Queries the native side for the current lock task state.
  ///
  /// This is useful to sync state after app restart or when
  /// the state might be out of sync with the native side.
  Future<bool> syncKioskState() async {
    if (!Platform.isAndroid) return false;

    try {
      final result = await _channel.invokeMethod<bool>('isInLockTaskMode');
      _isKioskActive = result ?? false;
      dev.log('Kiosk state synced: active=$_isKioskActive', name: _tag);
      return _isKioskActive;
    } on PlatformException catch (e) {
      dev.log('Failed to sync kiosk state: ${e.message}', name: _tag);
      return false;
    }
  }
}
