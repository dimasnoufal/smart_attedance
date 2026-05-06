import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:developer' as dev;
import 'package:smart_attedance/app.dart';
import 'package:smart_attedance/core/di/injection.dart';
import 'package:smart_attedance/core/usecases/usecase.dart';
import 'package:smart_attedance/core/services/location_service.dart';
import 'package:smart_attedance/features/face_recognition/domain/usecases/sync_embeddings_usecase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize dependency injection
  await configureDependencies();

  // Fetch device location once at startup for attendance API
  getIt<LocationService>().fetchLocation().then((loc) {
    if (loc != null) {
      dev.log('Location fetched at startup: $loc', name: 'AppStart');
    } else {
      dev.log('Failed to fetch location at startup', name: 'AppStart');
    }
  });

  // Trigger background sync for face embeddings
  // We don't await this so it doesn't block the UI from rendering the first frame
  final syncUseCase = getIt<SyncEmbeddingsUseCase>();
  syncUseCase(const NoParams()).then((result) {
    result.fold(
      (failure) =>
          dev.log('Initial sync failed: ${failure.message}', name: 'AppSync'),
      (records) => dev.log(
        'Initial sync success: $records records processed',
        name: 'AppSync',
      ),
    );
  });

  runApp(const App());
}
