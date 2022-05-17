
import 'package:meta/meta.dart';

import 'package:typedef_foundation/typedef_foundation.dart';

import 'disposable.dart';

@internal
class AddWithDisposable implements Disposable {
  
  AddWithDisposable({
    required VoidCallback? beforeDispose,
    required VoidCallback? afterDispose,
    required Disposable child,
  }) {
    if (beforeDispose != null && afterDispose != null) {
      _proxy = _AddBeforeAndAfterDispose(
        beforeDispose: beforeDispose,
        afterDispose: afterDispose,
        child: child,
      );
    } else if (beforeDispose != null) {
      _proxy = _AddBeforeDispose(
        beforeDispose: beforeDispose,
        child: child,
      );
    } else if (afterDispose != null) {
      _proxy = _AddAfterDispose(
        afterDispose: afterDispose,
        child: child,
      );
    } else {
      _proxy = child;
    }
  }

  late final Disposable _proxy;

  @override
  void dispose() {
    _proxy.dispose();
  }
}

class _AddBeforeAndAfterDispose implements Disposable {

  _AddBeforeAndAfterDispose({
    required VoidCallback beforeDispose,
    required VoidCallback afterDispose,
    required Disposable child,
  }): _beforeDispose = beforeDispose,
    _afterDispose = afterDispose,
    _child = child;

  final VoidCallback _beforeDispose;
  final VoidCallback _afterDispose;
  final Disposable _child;
  
  @override
  void dispose() {
    _beforeDispose();
    _child.dispose();
    _afterDispose();
  }
}

class _AddBeforeDispose implements Disposable {

  _AddBeforeDispose({
    required VoidCallback beforeDispose,
    required Disposable child,
  }): _beforeDispose = beforeDispose,
    _child = child;

  final VoidCallback _beforeDispose;
  final Disposable _child;

  @override
  void dispose() {
    _beforeDispose();
    _child.dispose();
  }
}

class _AddAfterDispose implements Disposable {

  _AddAfterDispose({
    required VoidCallback afterDispose,
    required Disposable child,
  }): _afterDispose = afterDispose,
    _child = child;
  
  final VoidCallback _afterDispose;
  final Disposable _child;
  
  @override
  void dispose() {
    _child.dispose();
    _afterDispose();
  }
}



