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
}
