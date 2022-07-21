
import 'package:meta/meta.dart';

import 'package:typedef_foundation/typedef_foundation.dart';

import 'disposable.dart';

@internal
class AddWithDisposable implements Disposable {
  
  AddWithDisposable({
    required VoidCallback? beforeDispose,
    required VoidCallback? afterDispose,
    required Disposable disposable,
  }) {
    if (beforeDispose != null && afterDispose != null) {
      _proxy = _AddBeforeAndAfterDispose(
        beforeDispose: beforeDispose,
        afterDispose: afterDispose,
        disposable: disposable,
      );
    } else if (beforeDispose != null) {
      _proxy = _AddBeforeDispose(
        beforeDispose: beforeDispose,
        disposable: disposable,
      );
    } else if (afterDispose != null) {
      _proxy = _AddAfterDispose(
        afterDispose: afterDispose,
        disposable: disposable,
      );
    } else {
      _proxy = disposable;
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
    required Disposable disposable,
  }): _beforeDispose = beforeDispose,
    _afterDispose = afterDispose,
    _disposable = disposable;

  final VoidCallback _beforeDispose;
  final VoidCallback _afterDispose;
  final Disposable _disposable;
  
  @override
  void dispose() {
    _beforeDispose();
    _disposable.dispose();
    _afterDispose();
  }
}

class _AddBeforeDispose implements Disposable {

  _AddBeforeDispose({
    required VoidCallback beforeDispose,
    required Disposable disposable,
  }): _beforeDispose = beforeDispose,
    _disposable = disposable;

  final VoidCallback _beforeDispose;
  final Disposable _disposable;

  @override
  void dispose() {
    _beforeDispose();
    _disposable.dispose();
  }
}

class _AddAfterDispose implements Disposable {

  _AddAfterDispose({
    required VoidCallback afterDispose,
    required Disposable disposable,
  }): _afterDispose = afterDispose,
    _disposable = disposable;
  
  final VoidCallback _afterDispose;
  final Disposable _disposable;
  
  @override
  void dispose() {
    _disposable.dispose();
    _afterDispose();
  }
}



