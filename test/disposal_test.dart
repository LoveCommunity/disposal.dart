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

  test('single assignment disposable assign then dispose', () {

    int invoked = 0;

    final disposable = Disposable(() {
      invoked += 1;
    });

    final singleAssignmentDisposable = SingleAssignmentDisposable();

    singleAssignmentDisposable.assignDisposable(disposable);
    expect(invoked, 0);

    singleAssignmentDisposable.dispose();
    expect(invoked, 1);
  });

  test('single assignment disposable dispose then assign', () {

    int invoked = 0;

    final disposable = Disposable(() {
      invoked += 1;
    });

    final singleAssignmentDisposable = SingleAssignmentDisposable();

    singleAssignmentDisposable.dispose();
    expect(invoked, 0);

    singleAssignmentDisposable.assignDisposable(disposable);
    expect(invoked, 1);
  });

  test('single assignment disposable reassign throws', () {

    final disposable1 = Disposable(() {});
    final disposable2 = Disposable(() {});

    final singleAssignmentDisposable = SingleAssignmentDisposable();

    singleAssignmentDisposable.assignDisposable(disposable1);

    expect(
      () {
        singleAssignmentDisposable.assignDisposable(disposable2);
      },
      throwsA(
        isA<StateError>()
          .having(
            (error) => error.toString(),
            'description',
            contains('disposable has been assigned before and can be assigned only one time!')
          )
      ),
    );
  });

  test('single assignment disposable dispose multiple times', () {

    int invoked = 0;

    final disposable = Disposable(() {
      invoked += 1;
    });

    final singleAssignmentDisposable = SingleAssignmentDisposable();
    
    singleAssignmentDisposable.assignDisposable(disposable);

    expect(invoked, 0);
    singleAssignmentDisposable.dispose();
    expect(invoked, 1);
    singleAssignmentDisposable.dispose();
    expect(invoked, 1);
  });

  test('composite disposable default order', () {
    
    final List<String> invokes = [];

    final disposable1 = Disposable(() {
      invokes.add('dispose1');
    });

    final disposable2 = Disposable(() {
      invokes.add('dispose2');
    });

    final compositeDisposable = CompositeDisposable()
      ..addDisposables([
        disposable1,
        disposable2,
      ]);

    expect(invokes, []);
    compositeDisposable.dispose();
    expect(invokes, [
      'dispose2',
      'dispose1',
    ]);

  });

  test('composite disposable descending order', () {
    
    final List<String> invokes = [];

    final disposable1 = Disposable(() {
      invokes.add('dispose1');
    });

    final disposable2 = Disposable(() {
      invokes.add('dispose2');
    });

    final compositeDisposable = CompositeDisposable(
      reverseDispose: true,
    )..addDisposables([
      disposable1,
      disposable2,
    ]);

    expect(invokes, []);
    compositeDisposable.dispose();
    expect(invokes, [
      'dispose2',
      'dispose1',
    ]);

  });

  test('composite disposable ascending order', () {
    
    final List<String> invokes = [];

    final disposable1 = Disposable(() {
      invokes.add('dispose1');
    });

    final disposable2 = Disposable(() {
      invokes.add('dispose2');
    });

    final compositeDisposable = CompositeDisposable(
      reverseDispose: false,
    )..addDisposables([
      disposable1,
      disposable2,
    ]);

    expect(invokes, []);
    compositeDisposable.dispose();
    expect(invokes, [
      'dispose1',
      'dispose2',
    ]);

  });

  test('composite disposable addDisposables after disposed', () {

    final List<String> invokes = [];

    final disposable1 = Disposable(() {
      invokes.add('dispose1');
    });

    final disposable2 = Disposable(() {
      invokes.add('dispose2');
    });

    final compositeDisposable = CompositeDisposable()
      ..dispose();

    expect(invokes, []);
    compositeDisposable.addDisposables([
      disposable1,
      disposable2,
    ]);
    expect(invokes, [
      'dispose2',
      'dispose1',
    ]);
  });

  test('composite disposable addDisposable after disposed', () {
    
    int invokes = 0;

    final disposable = Disposable(() {
      invokes += 1;
    });

    final compositeDisposable = CompositeDisposable()
      ..dispose();
    
    expect(invokes, 0);
    compositeDisposable.addDisposable(disposable);
    expect(invokes, 1);

  });

  test('composite disposable dispose multiple times', () {
    
    int invokes = 0;

    final disposable = Disposable(() {
      invokes += 1;
    });

    final compositeDisposable = CompositeDisposable()
      ..addDisposable(disposable);

    expect(invokes, 0);
    compositeDisposable.dispose();
    expect(invokes, 1);
    compositeDisposable.dispose();
    expect(invokes, 1);

  });

}



