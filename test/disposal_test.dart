import 'package:disposal/disposal.dart';
import 'package:test/test.dart';

void main() {

  test('disposable dispose invoked', () async {
    
    int _invoked = 0;
    final disposable = Disposable(dispose: () {
      _invoked += 1;
    });
    
    expect(_invoked, 0);
    disposable.dispose();
    expect(_invoked, 1);
  });

  test('disposable empty', () async {
    final emptyDisposable1 = Disposable.empty();
    final emptyDisposable2 = Disposable.empty();
    expect(emptyDisposable1, emptyDisposable2);
  });

  test('disposable addBeforeDispose', () async {
    final List<String> _invokes = [];

    final disposable = Disposable(dispose: () {
      _invokes.add('dispose');
    });

    final newDisposable = disposable.addBeforeDispose(() {
      _invokes.add('beforeDispose');
    });
    
    expect(_invokes, []);
    newDisposable.dispose();
    expect(_invokes, [
      'beforeDispose',
      'dispose'
    ]);
  });

  test('disposable addAfterDispose', () async {
    final List<String> _invokes = [];

    final disposable = Disposable(dispose: () {
      _invokes.add('dispose');
    });

    final newDisposable = disposable.addAfterDispose(() {
      _invokes.add('afterDispose');
    });

    expect(_invokes, []);
    newDisposable.dispose();
    expect(_invokes, [
      'dispose',
      'afterDispose'
    ]);
  });

  test('disposable addWith', () async {
    final List<String> _invokes = [];

    final disposable = Disposable(dispose: () {
      _invokes.add('dispose');
    });

    final newDisposable = disposable.addWith(
      beforeDispose: () {
        _invokes.add('beforeDispose');
      },
      afterDispose: () {
        _invokes.add('afterDispose');
      },
    );
    
    expect(_invokes, []);
    newDisposable.dispose();
    expect(_invokes, [
      'beforeDispose',
      'dispose',
      'afterDispose'
    ]);
  });
}
