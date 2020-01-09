import 'package:interceptor/interceptor.dart';

void main() {
  var interceptors = <Interceptor<String,String>>[
    SimpleInterceptor1(),
    SimpleInterceptor2(),
    SimpleInterceptor3(),
    InterceptorImpl((e) => e),
  ];
  var chain = Chain<String, String>('string', interceptors);

  var data = chain.process(chain.input);

  print(data);
}

String interceptWith<T>(Chain<String, String> chain) {
  print('intercept with $T: ${chain.input}');
  var data = chain.process(chain.input);
  print('process with $T: $data');
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
