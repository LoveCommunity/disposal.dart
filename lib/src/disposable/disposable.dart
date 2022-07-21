
import 'package:typedef_foundation/typedef_foundation.dart';
import 'disposable_function.dart';
import 'empty_disposable.dart';
import 'add_with_disposable.dart';
import 'disposable_combine.dart';

abstract class Disposable {

  void dispose();

  const factory Disposable(
    VoidCallback dispose
  ) = DisposableFunction;

  static const Disposable empty = EmptyDisposable();

  factory Disposable.combine({
    required List<Disposable> disposables,
    bool reverse,
  }) = DisposableCombine;
}

extension DisposableX on Disposable {

  Disposable addWith({
    VoidCallback? beforeDispose,
    VoidCallback? afterDispose,
  }) {
    return AddWithDisposable(
      beforeDispose: beforeDispose,
      afterDispose: afterDispose,
      child: this,
    );
  }
}
