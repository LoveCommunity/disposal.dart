import '../disposable/disposable.dart';
import '../shared/dispose_all.dart';

class CompositeDisposable implements Disposable {

  CompositeDisposable({
    bool reverseDispose = true,
  }): _reverseDispose = reverseDispose;

  final bool _reverseDispose;
  bool _disposed = false;
  final List<Disposable> _disposables = [];

  void addDisposable(Disposable disposable) {
    if (_disposed) {
      disposable.dispose();
      return;
    }
    _disposables.add(disposable);
  }

  void addDisposables(List<Disposable> disposables) {
    if (_disposed) {
      _disposeAll(disposables);
      return;
    }
    _disposables.addAll(disposables);
  }

  void _disposeAll(List<Disposable> disposables) {
    disposeAll(disposables, _reverseDispose);
  }

  @override
  void dispose() {
    if (_disposed) {
      return;
    }
    _disposed = true;
    _disposeAll(_disposables);
    _disposables.clear();
  }
}
