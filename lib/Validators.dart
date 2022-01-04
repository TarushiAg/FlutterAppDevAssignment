import 'dart:async';

mixin Validators {

  //---- Password validation
  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.trim().length >= 3) {
          sink.add(password);
        } else {
          sink.addError('Your password should be more then 3 char long');
        }
      });
}
