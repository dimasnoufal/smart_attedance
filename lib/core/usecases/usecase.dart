import 'package:dartz/dartz.dart';
import 'package:smart_attedance/core/error/failures.dart';

/// Abstract base class for all use cases.
/// [Type] is the return type, [Params] is the input parameter type.
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Use when a use case requires no parameters.
class NoParams {
  const NoParams();
}
