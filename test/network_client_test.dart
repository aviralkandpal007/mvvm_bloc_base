import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_bloc_base/network/network.dart';

void main() {
  group('NetworkClient', () {
    test('resolves relative URLs and merges default headers', () async {
      late http.Request received;
      final client = NetworkClient(
        config: const NetworkConfig(
          baseUrl: 'https://example.test/api/',
          defaultHeaders: {'Accept': 'application/json', 'X-Default': 'yes'},
        ),
        client: MockClient((request) async {
          received = request;
          return http.Response('ok', 200);
        }),
      );

      await client.get('/items', headers: {'X-Request': 'custom'});

      expect(received.url.toString(), 'https://example.test/items');
      expect(received.headers['accept'], 'application/json');
      expect(received.headers['x-default'], 'yes');
      expect(received.headers['x-request'], 'custom');
      client.close();
    });

    test('maps HTTP failures to typed exceptions', () async {
      final client = NetworkClient(
        config: const NetworkConfig(baseUrl: 'https://example.test/'),
        client: MockClient((_) async => http.Response('missing', 404)),
        interceptors: const [ErrorInterceptor()],
      );

      await expectLater(
        client.get('/missing'),
        throwsA(
          isA<NetworkHttpException>()
              .having((error) => error.statusCode, 'statusCode', 404)
              .having((error) => error.body, 'body', 'missing'),
        ),
      );
      client.close();
    });

    test(
      'reports streaming download progress without buffering in client',
      () async {
        final payload = List<int>.generate(512, (index) => index % 256);
        final client = NetworkClient(
          config: const NetworkConfig(baseUrl: 'https://example.test/'),
          client: MockClient((_) async => http.Response.bytes(payload, 200)),
        );
        final chunks = <List<int>>[];
        final progress = <NetworkProgress>[];
        final sink = _RecordingSink(chunks);

        await ProgressClient(client)
            .download('/file', sink, onProgress: progress.add);

        expect(chunks.expand((chunk) => chunk).toList(), payload);
        expect(progress, isNotEmpty);
        expect(progress.last.received, payload.length);
        expect(progress.last.totalReceived, payload.length);
        client.close();
      },
    );

    test('retries safe requests for configured retryable responses', () async {
      var calls = 0;
      final client = NetworkClient(
        config: const NetworkConfig(baseUrl: 'https://example.test/'),
        client: MockClient((_) async {
          calls++;
          return http.Response(
            calls == 1 ? 'retry' : 'ok',
            calls == 1 ? 503 : 200,
          );
        }),
        interceptors: const [ErrorInterceptor(), RetryInterceptor()],
      );

      final result = await client.send(
        NetworkRequest(
          method: 'GET',
          uri: client.resolve('/retry'),
          retryPolicy: const RetryPolicy(
            maxAttempts: 2,
            initialDelay: Duration.zero,
          ),
        ),
      );

      expect(calls, 2);
      expect(result.statusCode, 200);
      client.close();
    });
  });
}

class _RecordingSink implements Sink<List<int>> {
  _RecordingSink(this.chunks);

  final List<List<int>> chunks;

  @override
  void add(List<int> data) => chunks.add(Uint8List.fromList(data));

  @override
  void close() {}
}
