import 'dart:async';

mixin Validators {
  //---- length validation
  var lengthValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (str, sink) {
    if (str.length >= 3 && str.length <= 11) {
      sink.add(str);
    } else {
      sink.addError('Should be more than 3 char and less than 11 char long');
    }
  });
}
