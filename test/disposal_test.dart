import 'package:disposal/disposal.dart';
import 'package:test/test.dart';

void main() {

  test('disposable dispose invoked', () {

    int invoked = 0;

    final disposable = Disposable(() {
      invoked += 1;
    });

    expect(invoked, 0);
    disposable.dispose();
    expect(invoked, 1);

  });

  test('disposable empty', () {
    final empty1 = Disposable.empty;
    final empty2 = Disposable.empty;
    expect(empty1, empty2);
  });

  test('disposable addWith', () {

    final List<String> invokes = [];

    final disposable = Disposable(() {
      invokes.add('dispose');
    });
    
    final newDisposable = disposable.addWith(
      beforeDispose: () {
        invokes.add('beforeDispose');
      },
      afterDispose: () {
        invokes.add('afterDispose');
      },
    );

    expect(invokes, []);
    newDisposable.dispose();
    expect(invokes, [
      'beforeDispose',
      'dispose',
      'afterDispose',
    ]);

  });
}
