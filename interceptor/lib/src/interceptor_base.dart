abstract class Chain<I, O> {
  factory Chain(I input, List<Interceptor<I, O>> interceptors) {
    return _ChainImpl(input, interceptors);
  }

  I get input;

  O process(I input);
}

abstract class Interceptor<I, O> {
  O intercept(Chain<I, O> chain);
}

class _ChainImpl<I, O> implements Chain<I, O> {
  const _ChainImpl(this._input, this._interceptors, {int index = 0})
      : _index = index;

  final I _input;

  final List<Interceptor<I, O>> _interceptors;

  final int _index;

  @override
  I get input => _input;

  @override
  O process(I data) {
    final next = _ChainImpl(data, _interceptors, index: _index + 1);
    final interceptor = _interceptors[_index];
    return interceptor.intercept(next);
  }


}

class InterceptorImpl<I, O> implements Interceptor<I, O> {
  InterceptorImpl(this.builder);

  final O Function(I input) builder;

  @override
  O intercept(Chain<I, O> chain) {
    return builder(chain.input);
  }
}
