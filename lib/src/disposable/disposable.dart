
import 'package:typedef_foundation/typedef_foundation.dart';
import 'disposable_function.dart';
import 'empty_disposable.dart';

abstract class Disposable {

  void dispose();

  const factory Disposable(
    VoidCallback dispose
  ) = DisposableFunction;

  static const Disposable empty = EmptyDisposable();
}
