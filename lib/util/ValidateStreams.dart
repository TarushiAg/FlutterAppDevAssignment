import 'dart:async';

import 'package:rxdart/rxdart.dart';

class ValidateAllStreamsHaveDataAndNoErrors {
  List<bool> errors;

  BehaviorSubject<bool> _controller;

  void listen(List<Stream> streams) {
    _controller = BehaviorSubject<bool>();
    errors = List.generate(streams.length, (_) => true);
    List.generate(streams.length, (int index) {
      return streams[index].listen(
        (data) {
          errors[index] = false;
          _validate();
        },
        onError: (_) {
          errors[index] = true;
          _validate();
        },
      );
    });
  }

  void _validate() {
    bool hasNoErrors =
        (errors.firstWhere((b) => b == true, orElse: () => null) == null);
    _controller.sink.add(hasNoErrors);
  }

  Stream<bool> get status => _controller.stream;

  void dispose() {
    _controller?.close();
  }
}
