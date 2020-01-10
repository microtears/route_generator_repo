import 'package:interceptor/interceptor.dart';
import 'package:test/test.dart';

String interceptWith<T>(Chain<String, String> chain) {
  var input = chain.input + '/' + T.toString();
  var data = chain.process(input);
  return data;
}

class SimpleInterceptor1 implements Interceptor<String, String> {
  @override
  String intercept(Chain<String, String> chain) =>
      interceptWith<SimpleInterceptor1>(chain);
}

class SimpleInterceptor2 implements Interceptor<String, String> {
  @override
  String intercept(Chain<String, String> chain) =>
      interceptWith<SimpleInterceptor2>(chain);
}

class SimpleInterceptor3 implements Interceptor<String, String> {
  @override
  String intercept(Chain<String, String> chain) =>
      interceptWith<SimpleInterceptor3>(chain);
}

class ErrorInterceptor implements Interceptor<String, String> {
  @override
  String intercept(Chain<String, String> chain) {
    // Only test. Do not call process function twice.
    chain.process(chain.input);
    return chain.process(chain.input);
  }
}

void main() {
  group('A group of tests', () {
    List<Interceptor<String, String>> interceptors;
    Chain<String, String> chain;

    setUp(() {
      interceptors = <Interceptor<String, String>>[
        SimpleInterceptor1(),
        SimpleInterceptor2(),
        SimpleInterceptor3(),
      ];
    });

    test('Test process function', () {
      chain = Chain<String, String>(
        'string',
        interceptors..add(ErrorInterceptor()),
        (e) => e,
      );
      expect(() => chain.process(chain.input), throwsStateError);
    });

    test('Test process function', () {
      chain = Chain<String, String>(
        'string',
        interceptors,
        (e) => e,
      );
      expect(
        chain.process(chain.input),
        'string/SimpleInterceptor1/SimpleInterceptor2/SimpleInterceptor3',
      );
    });
  });
}
