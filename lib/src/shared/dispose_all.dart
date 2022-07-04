import 'package:meta/meta.dart';
import '../disposable/disposable.dart';

@internal
void disposeAll(List<Disposable> disposables, bool reverse) {
  final _disposables = reverse ? disposables.reversed : disposables;
  for (final disposable in _disposables) {
    disposable.dispose();
  }
}
