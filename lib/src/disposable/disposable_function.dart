import 'package:meta/meta.dart';
import 'package:typedef_foundation/typedef_foundation.dart';

import 'disposable.dart';

@internal
class DisposableFunction implements Disposable {
  
  const DisposableFunction(
    VoidCallback dispose
  ): _dispose = dispose;

  final VoidCallback _dispose;

  @override
  void dispose() {
    _dispose();
  }
}
