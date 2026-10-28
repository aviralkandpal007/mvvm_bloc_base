/// A result that contains either a successful value or a typed error.
///
/// This follows Flutter's documented Result pattern. It is an application
/// utility rather than a type provided by the Dart SDK.
sealed class Result<T, E> {
  const Result();

  /// Creates a successful result containing [value].
  const factory Result.ok(T value) = Ok<T, E>;

  /// Creates an error result containing [error].
  const factory Result.error(E error) = Error<T, E>;
}

/// Successful [Result] containing [value].
final class Ok<T, E> extends Result<T, E> {
  /// Creates a successful result.
  const Ok(this.value);

  /// The successful value.
  final T value;

  @override
  String toString() => 'Result<$T, $E>.ok($value)';
}

/// Failed [Result] containing [error].
final class Error<T, E> extends Result<T, E> {
  /// Creates an error result.
  const Error(this.error);

  /// The error describing the failure.
  final E error;

  @override
  String toString() => 'Result<$T, $E>.error($error)';
}
