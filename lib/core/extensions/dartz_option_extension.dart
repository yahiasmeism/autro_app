import 'package:dartz/dartz.dart';

extension DartzOptionX<T> on Option<T> {
  // You must check if the option is some then call this
  // otherwise it will throw an exception
  T getSome() {
    late T t;
    fold(() => null, (a) => t = a);
    return t;
  }
}
