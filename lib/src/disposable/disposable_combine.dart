
import 'package:meta/meta.dart';

import '../shared/dispose_all.dart';
import 'disposable.dart';

@internal
class DisposableCombine implements Disposable {
  
  DisposableCombine({
    required List<Disposable> disposables,
    bool reverse = true,
  }): _disposables = disposables,
    _reverse = reverse;

  final List<Disposable> _disposables;
  final bool _reverse;

  @override
  void dispose() {
    disposeAll(_disposables, _reverse);
  }
}

