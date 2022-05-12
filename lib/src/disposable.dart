import 'package:typedef_foundation/typedef_foundation.dart';

class Disposable {
  const Disposable({
    required this.dispose,
  });

  final VoidCallback dispose;
}
