import 'package:disposal/disposal.dart';
import 'package:test/test.dart';

void main() {

  test('disposable dispose invoked', () {

    int _invoked = 0;

    final disposable = Disposable(() {
      _invoked += 1;
    });

    expect(_invoked, 0);
    disposable.dispose();
    expect(_invoked, 1);

  });

  test('disposable empty', () {
    final empty1 = Disposable.empty;
    final empty2 = Disposable.empty;
    expect(empty1, empty2);
  });

  test('disposable addWith', () {

    final List<String> _invokes = [];

    final disposable = Disposable(() {
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
      'afterDispose',
    ]);

  });
}
