import 'package:coffee_test/data_providers/auth_data_provider.dart';
import 'package:coffee_test/data_providers/http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements HttpClient {}

main() {
  group('DataProvider', () {
    group('SignInWithPasswordUsername', () {
      test('should return true with correct username and password', () async {
        // arrange
        final HttpClient mockHttpClient = MockHttpClient();
        final AuthDataProvider authDataProvider = AuthDataProvider(
          http: mockHttpClient,
        );
        const String password = 'password';
        const String email = 'username';

        when(mockHttpClient.post('', '')).thenAnswer(
          (realInvocation) => Future.value(
            http.Response('success', 200),
          ),
        );

        // act
        final bool res =
            await authDataProvider.signInWithEmailAndPassword(email, password);

        // assert
        expect(res, true);
      });
    });

    group('signOut', () {
      test('should return true with log out', () async {
        // arrange
        final HttpClient mockHttpClient = MockHttpClient();
        final AuthDataProvider authDataProvider = AuthDataProvider(
          http: mockHttpClient,
        );

        when(mockHttpClient.get('')).thenAnswer(
          (realInvocation) => Future.value(
            http.Response('success', 200),
          ),
        );

        // act
        final bool res = await authDataProvider.signOut();

        // assert
        expect(res, true);
      });
    });
  });
}
