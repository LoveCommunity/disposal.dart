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

  test('disposable combine default order', () {

    final List<String> invokes = [];

    final disposable1 = Disposable(() {
      invokes.add('dispose1');
    });
    
    final disposable2 = Disposable(() {
      invokes.add('dispose2');
    });
    
    final newDisposable = Disposable.combine(
      children: [
        disposable1,
        disposable2,
      ],
    );

    expect(invokes, []);
    newDisposable.dispose();
    expect(invokes, [
      'dispose2',
      'dispose1',
    ]);

  });

  test('disposable combine descending order', () {

    final List<String> invokes = [];

    final disposable1 = Disposable(() {
      invokes.add('dispose1');
    });
    
    final disposable2 = Disposable(() {
      invokes.add('dispose2');
    });
    
    final newDisposable = Disposable.combine(
      reverse: true,
      children: [
        disposable1,
        disposable2,
      ],
    );

    expect(invokes, []);
    newDisposable.dispose();
    expect(invokes, [
      'dispose2',
      'dispose1',
    ]);

  });

  test('disposable combine ascending order', () {

    final List<String> invokes = [];
    
    final disposable1 = Disposable(() {
      invokes.add('dispose1');
    });
    
    final disposable2 = Disposable(() {
      invokes.add('dispose2');
    });

    final newDisposable = Disposable.combine(
      reverse: false,
      children: [
        disposable1,
        disposable2,
      ],
    );

    expect(invokes, []);
    newDisposable.dispose();
    expect(invokes, [
      'dispose1',
      'dispose2',
    ]);

  });
}



