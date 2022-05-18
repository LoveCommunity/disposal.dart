
import '../disposable/disposable.dart';


class SingleAssignmentDisposable implements Disposable {

  bool _disposed = false;
  Disposable? _disposable;

  void assignDisposable(Disposable disposable) {
    if (_disposable != null) {
      throw StateError('disposable has been assigned before and can be assigned only one time!');
    }
    _disposable = disposable;
    if (_disposed) {
      disposable.dispose();
    }
  }

  @override
  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _disposable?.dispose();
  }
}
