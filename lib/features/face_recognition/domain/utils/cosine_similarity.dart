import 'dart:math';

/// Utility class for mathematical operations on vectors.
class CosineSimilarityCalculator {
  CosineSimilarityCalculator._();

  /// Calculates the cosine similarity between two vectors.
  /// Both vectors must have the same length.
  /// 
  /// Returns a score between -1.0 and 1.0.
  /// 1.0 means exactly the same direction.
  /// 0.0 means orthogonal.
  /// -1.0 means exactly opposite direction.
  static double calculate(List<double> vectorA, List<double> vectorB) {
    if (vectorA.length != vectorB.length) {
      throw ArgumentError('Vectors must have the same length.');
    }

    // 1. Calculate L2 Norm for both vectors
    double normA = 0.0;
    double normB = 0.0;
    for (int i = 0; i < vectorA.length; i++) {
      normA += vectorA[i] * vectorA[i];
      normB += vectorB[i] * vectorB[i];
    }
    
    normA = sqrt(normA);
    normB = sqrt(normB);

    if (normA == 0.0 || normB == 0.0) {
      return 0.0;
    }

    // 2. Normalize the vectors (query_embedding / norm)
    List<double> normalizedA = List.generate(vectorA.length, (i) => vectorA[i] / normA);
    List<double> normalizedB = List.generate(vectorB.length, (i) => vectorB[i] / normB);

    // 3. Dot product of normalized vectors (np.dot)
    double dotProduct = 0.0;
    for (int i = 0; i < normalizedA.length; i++) {
      dotProduct += normalizedA[i] * normalizedB[i];
    }

    return dotProduct;
  }
}
