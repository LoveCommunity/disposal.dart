
import 'package:meta/meta.dart';

import 'disposable.dart';

@internal
class EmptyDisposable implements Disposable {

  const EmptyDisposable();

  @override
  void dispose() {
    
  }
}

