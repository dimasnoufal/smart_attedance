// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:smart_attedance/core/services/attendance_service.dart'
    as _i1020;
import 'package:smart_attedance/core/services/auth_local_storage_service.dart'
    as _i555;
import 'package:smart_attedance/core/services/auth_service.dart' as _i605;
import 'package:smart_attedance/core/services/kiosk_service.dart' as _i1021;
import 'package:smart_attedance/core/services/location_service.dart' as _i49;
import 'package:smart_attedance/core/services/wakelock_service.dart' as _i1010;
import 'package:smart_attedance/features/face_detection/data/repositories/face_detection_repository_impl.dart'
    as _i449;
import 'package:smart_attedance/features/face_detection/data/services/camera_service.dart'
    as _i60;
import 'package:smart_attedance/features/face_detection/data/services/face_detector_service.dart'
    as _i477;
import 'package:smart_attedance/features/face_detection/domain/repositories/face_detection_repository.dart'
    as _i249;
import 'package:smart_attedance/features/face_detection/domain/usecases/capture_frame_usecase.dart'
    as _i333;
import 'package:smart_attedance/features/face_detection/domain/usecases/detect_faces_usecase.dart'
    as _i337;
import 'package:smart_attedance/features/face_detection/domain/usecases/validate_face_usecase.dart'
    as _i446;
import 'package:smart_attedance/features/face_detection/domain/usecases/verify_liveness_usecase.dart'
    as _i705;
import 'package:smart_attedance/features/face_detection/presentation/bloc/face_detection_bloc.dart'
    as _i807;
import 'package:smart_attedance/features/face_detection_rounded_box/data/services/anti_spoofing_service.dart'
    as _i913;
import 'package:smart_attedance/features/face_detection_rounded_box/data/services/inference_isolate.dart'
    as _i1062;
import 'package:smart_attedance/features/face_detection_rounded_box/domain/usecases/verify_passive_liveness_usecase.dart'
    as _i181;
import 'package:smart_attedance/features/face_detection_rounded_box/presentation/bloc/gate_detection_bloc.dart'
    as _i633;
import 'package:smart_attedance/features/face_recognition/data/repositories/embedding_sync_repository_impl.dart'
    as _i166;
import 'package:smart_attedance/features/face_recognition/data/repositories/face_recognition_repository_impl.dart'
    as _i237;
import 'package:smart_attedance/features/face_recognition/data/services/face_service.dart'
    as _i654;
import 'package:smart_attedance/features/face_recognition/data/services/local_database_service.dart'
    as _i272;
import 'package:smart_attedance/features/face_recognition/data/services/sync_api_client.dart'
    as _i376;
import 'package:smart_attedance/features/face_recognition/data/services/tflite_recognizer_service.dart'
    as _i646;
import 'package:smart_attedance/features/face_recognition/domain/repositories/embedding_sync_repository.dart'
    as _i820;
import 'package:smart_attedance/features/face_recognition/domain/repositories/face_recognition_repository.dart'
    as _i808;
import 'package:smart_attedance/features/face_recognition/domain/usecases/extract_embedding_usecase.dart'
    as _i578;
import 'package:smart_attedance/features/face_recognition/domain/usecases/match_face_usecase.dart'
    as _i184;
import 'package:smart_attedance/features/face_recognition/domain/usecases/sync_embeddings_usecase.dart'
    as _i412;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i555.AuthLocalStorageService>(
      () => _i555.AuthLocalStorageService(),
    );
    gh.lazySingleton<_i605.AuthService>(() => _i605.AuthService());
    gh.lazySingleton<_i1021.KioskService>(() => _i1021.KioskService());
    gh.lazySingleton<_i49.LocationService>(() => _i49.LocationService());
    gh.lazySingleton<_i1010.WakelockService>(() => _i1010.WakelockService());
    gh.lazySingleton<_i60.CameraService>(() => _i60.CameraService());
    gh.lazySingleton<_i477.FaceDetectorService>(
      () => _i477.FaceDetectorService(),
    );
    gh.lazySingleton<_i446.ValidateFaceUseCase>(
      () => _i446.ValidateFaceUseCase(),
    );
    gh.lazySingleton<_i705.VerifyLivenessUseCase>(
      () => _i705.VerifyLivenessUseCase(),
    );
    gh.lazySingleton<_i913.AntiSpoofingService>(
      () => _i913.AntiSpoofingService(),
    );
    gh.lazySingleton<_i1062.InferenceIsolateService>(
      () => _i1062.InferenceIsolateService(),
    );
    gh.lazySingleton<_i654.FaceService>(() => _i654.FaceService());
    gh.lazySingleton<_i272.LocalDatabaseService>(
      () => _i272.LocalDatabaseService(),
    );
    gh.lazySingleton<_i376.SyncApiClient>(() => _i376.SyncApiClient());
    gh.lazySingleton<_i646.TFLiteRecognizerService>(
      () => _i646.TFLiteRecognizerService(),
    );
    gh.lazySingleton<_i820.EmbeddingSyncRepository>(
      () => _i166.EmbeddingSyncRepositoryImpl(
        gh<_i376.SyncApiClient>(),
        gh<_i272.LocalDatabaseService>(),
      ),
    );
    gh.lazySingleton<_i808.FaceRecognitionRepository>(
      () => _i237.FaceRecognitionRepositoryImpl(
        gh<_i646.TFLiteRecognizerService>(),
        gh<_i272.LocalDatabaseService>(),
      ),
    );
    gh.lazySingleton<_i1020.AttendanceService>(
      () => _i1020.AttendanceService(gh<_i555.AuthLocalStorageService>()),
    );
    gh.lazySingleton<_i412.SyncEmbeddingsUseCase>(
      () => _i412.SyncEmbeddingsUseCase(gh<_i820.EmbeddingSyncRepository>()),
    );
    gh.lazySingleton<_i181.VerifyPassiveLivenessUseCase>(
      () => _i181.VerifyPassiveLivenessUseCase(gh<_i913.AntiSpoofingService>()),
    );
    gh.lazySingleton<_i249.FaceDetectionRepository>(
      () => _i449.FaceDetectionRepositoryImpl(
        gh<_i60.CameraService>(),
        gh<_i477.FaceDetectorService>(),
      ),
    );
    gh.lazySingleton<_i578.ExtractEmbeddingUseCase>(
      () =>
          _i578.ExtractEmbeddingUseCase(gh<_i808.FaceRecognitionRepository>()),
    );
    gh.lazySingleton<_i184.MatchFaceUseCase>(
      () => _i184.MatchFaceUseCase(gh<_i808.FaceRecognitionRepository>()),
    );
    gh.lazySingleton<_i333.CaptureFrameUseCase>(
      () => _i333.CaptureFrameUseCase(gh<_i249.FaceDetectionRepository>()),
    );
    gh.lazySingleton<_i337.DetectFacesUseCase>(
      () => _i337.DetectFacesUseCase(gh<_i249.FaceDetectionRepository>()),
    );
    gh.factory<_i633.GateDetectionBloc>(
      () => _i633.GateDetectionBloc(
        gh<_i60.CameraService>(),
        gh<_i477.FaceDetectorService>(),
        gh<_i337.DetectFacesUseCase>(),
        gh<_i1062.InferenceIsolateService>(),
        gh<_i808.FaceRecognitionRepository>(),
        gh<_i1020.AttendanceService>(),
        gh<_i49.LocationService>(),
      ),
    );
    gh.factory<_i807.FaceDetectionBloc>(
      () => _i807.FaceDetectionBloc(
        gh<_i60.CameraService>(),
        gh<_i477.FaceDetectorService>(),
        gh<_i337.DetectFacesUseCase>(),
        gh<_i446.ValidateFaceUseCase>(),
        gh<_i705.VerifyLivenessUseCase>(),
        gh<_i333.CaptureFrameUseCase>(),
        gh<_i578.ExtractEmbeddingUseCase>(),
        gh<_i184.MatchFaceUseCase>(),
      ),
    );
    return this;
  }
}
