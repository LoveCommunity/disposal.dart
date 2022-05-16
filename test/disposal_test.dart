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
}
