import 'package:typedef_foundation/typedef_foundation.dart';

class Disposable {
  const Disposable({
    required this.dispose,
  });
  
  final VoidCallback dispose;
  factory Disposable.empty() => const Disposable(dispose: _empty);
}

void _empty() {}

extension DisposableX on Disposable {

  Disposable addWith({
    VoidCallback? beforeDispose,
    VoidCallback? afterDispose,
  }) {
    return addBeforeDispose(beforeDispose)
      .addAfterDispose(afterDispose);
  }
  
  Disposable addBeforeDispose(VoidCallback? beforeDispose) {
    if (beforeDispose == null) return this;
    return Disposable(dispose: () {
      beforeDispose();
      dispose();
    });
  }

  Disposable addAfterDispose(VoidCallback? afterDispose) {
    if (afterDispose == null) return this;
    return Disposable(dispose: () {
      dispose();
      afterDispose();
    });
  }
}
