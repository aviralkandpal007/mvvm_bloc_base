import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'client/network_client.dart';
import 'core/network_progress.dart';
import 'core/network_response.dart';
import 'errors/network_exception.dart';
import 'core/result.dart';

/// Executes typed API calls and maps transport/parse failures into [Result].
///
/// Each [parse] callback runs with Flutter's `compute` and returns its Dart
/// model directly. Supply a top-level or static callback so it can run in an
/// isolate.
class NetworkExecutor {
  /// Reuses the app's configured [NetworkClient].
  const NetworkExecutor(this._client);

  final NetworkClient _client;

  /// Sends GET and parses its response body into the returned Dart value.
  Future<Result<T, NetworkException>> get<T>(
    String path, {
    required ComputeCallback<String, T> parse,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    void Function(NetworkProgress)? onProgress,
  }) {
    final uri = _client.resolve(path, queryParameters);
    return _execute(
      () => _client.get(
        path,
        queryParameters: queryParameters,
        headers: headers,
        onProgress: onProgress,
      ),
      uri,
      parse,
    );
  }

  /// Sends POST with a JSON-encoded [body] and parses the response.
  Future<Result<T, NetworkException>> post<T>(
    String path, {
    required ComputeCallback<String, T> parse,
    Object? body,
    Map<String, String>? headers,
  }) {
    final uri = _client.resolve(path);
    final encodedBody = body == null ? null : jsonEncode(body);
    return _execute(
      () => _client.post(
        path,
        body: encodedBody,
        headers: {'Content-Type': 'application/json', ...?headers},
      ),
      uri,
      parse,
    );
  }

  /// Sends PUT with a JSON-encoded [body] and parses the response.
  Future<Result<T, NetworkException>> put<T>(
    String path, {
    required ComputeCallback<String, T> parse,
    Object? body,
    Map<String, String>? headers,
  }) {
    final uri = _client.resolve(path);
    final encodedBody = body == null ? null : jsonEncode(body);
    return _execute(
      () => _client.put(
        path,
        body: encodedBody,
        headers: {'Content-Type': 'application/json', ...?headers},
      ),
      uri,
      parse,
    );
  }

  /// Sends DELETE and parses the response body.
  Future<Result<T, NetworkException>> delete<T>(
    String path, {
    required ComputeCallback<String, T> parse,
    Map<String, String>? headers,
  }) {
    final uri = _client.resolve(path);
    return _execute(() => _client.delete(path, headers: headers), uri, parse);
  }

  Future<Result<T, NetworkException>> _execute<T>(
    Future<NetworkResponse> Function() send,
    Uri uri,
    ComputeCallback<String, T> parse,
  ) async {
    try {
      final response = await send();
      final responseBody = response.bodyAsString();
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return Result.error(
          NetworkHttpException(statusCode: response.statusCode),
        );
      }
      final parsed = await compute(parse, responseBody);
      return Result.ok(parsed);
    } on NetworkException catch (error) {
      return Result.error(error);
    } on FormatException {
      return const Result.error(NetworkParseException());
    } on TypeError {
      return const Result.error(NetworkParseException());
    } on Exception catch (error) {
      NetworkException type = mapNetworkException(error, uri);
      return Result.error(type);
    }
  }
}
