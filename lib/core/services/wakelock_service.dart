import 'dart:developer' as dev;

import 'package:injectable/injectable.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// Service that manages the device screen wake lock.
///
/// Prevents the screen from turning off while the attendance gate
/// is active. Should be disabled when returning to the login page
/// to conserve battery.
///
/// Usage:
/// ```dart
/// final wakelock = getIt<WakelockService>();
/// await wakelock.enable();   // Screen stays on
/// await wakelock.disable();  // Screen can sleep again
/// ```
@lazySingleton
class WakelockService {
  static const _tag = 'WakelockService';

  /// Enables the screen wake lock, preventing the display from sleeping.
  ///
  /// Safe to call multiple times — subsequent calls are no-ops if
  /// the wake lock is already enabled.
  Future<void> enable() async {
    try {
      await WakelockPlus.enable();
      dev.log('Wake lock ENABLED — screen will stay on', name: _tag);
    } catch (e) {
      dev.log('Failed to enable wake lock: $e', name: _tag);
    }
  }

  /// Disables the screen wake lock, allowing the display to sleep normally.
  Future<void> disable() async {
    try {
      await WakelockPlus.disable();
      dev.log('Wake lock DISABLED — screen can sleep', name: _tag);
    } catch (e) {
      dev.log('Failed to disable wake lock: $e', name: _tag);
    }
  }

  /// Returns `true` if the wake lock is currently active.
  Future<bool> get isEnabled async {
    try {
      return await WakelockPlus.enabled;
    } catch (e) {
      dev.log('Failed to check wake lock status: $e', name: _tag);
      return false;
    }
  }
}
