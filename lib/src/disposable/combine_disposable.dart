
import 'package:meta/meta.dart';

import 'disposable.dart';

@internal
class CombineDisposable implements Disposable {
  
  CombineDisposable({
    required List<Disposable> children,
    bool reverse = true,
  }): _children = reverse
        ? children.reversed
        : children;

  final Iterable<Disposable> _children;

  @override
  void dispose() {
    for (final child in _children) {
      child.dispose();
    }  
  }
}

