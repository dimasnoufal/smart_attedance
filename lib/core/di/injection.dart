import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

/// Global service locator instance.
final getIt = GetIt.instance;

/// Initializes all dependencies via injectable code generation.
/// Must be called before [runApp] in main.dart.
@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
