import 'package:freezed_annotation/freezed_annotation.dart';
import '../errors/failures.dart';
part 'api_result.freezed.dart';
@freezed
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = _Success<T>;
  const factory ApiResult.error(Failure failure) = _Error<T>;
}
