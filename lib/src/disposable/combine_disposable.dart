
import 'package:meta/meta.dart';

import '../shared/dispose_all.dart';
import 'disposable.dart';

@internal
class CombineDisposable implements Disposable {
  
  CombineDisposable({
    required List<Disposable> children,
    bool reverse = true,
  }): _children = children,
    _reverse = reverse;

  final List<Disposable> _children;
  final bool _reverse;

  @override
  void dispose() {
    disposeAll(_children, _reverse);
  }
}

