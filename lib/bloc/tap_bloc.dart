import 'dart:async';

class TapBloc {
  static TapBloc? _instance;

  final _tapStreamController = StreamController<void>.broadcast();

  Stream<void> get tapStream => _tapStreamController.stream;

  StreamSink<void> get tapStreamSink => _tapStreamController.sink;

  static TapBloc getInstance() {
    if(_instance == null) {
      _instance = TapBloc();
    }
    return _instance!;
  }
}