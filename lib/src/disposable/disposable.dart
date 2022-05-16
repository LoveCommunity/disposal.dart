
import 'package:typedef_foundation/typedef_foundation.dart';
import 'disposable_function.dart';

abstract class Disposable {

  void dispose();

  const factory Disposable(
    VoidCallback dispose
  ) = DisposableFunction;
}
