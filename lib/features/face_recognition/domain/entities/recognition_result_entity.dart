import 'package:freezed_annotation/freezed_annotation.dart';

part 'recognition_result_entity.freezed.dart';

@freezed
abstract class RecognitionResultEntity with _$RecognitionResultEntity {
  /// The face was successfully recognized and matched with a user.
  const factory RecognitionResultEntity.recognized({
    required String userId,
    @Default('') String name,
    required double similarityScore,
  }) = RecognizedFace;

  /// The face was processed but did not match any user above the threshold.
  const factory RecognitionResultEntity.unrecognized({
    required double highestSimilarityScore,
  }) = UnrecognizedFace;
}
