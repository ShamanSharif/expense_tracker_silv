import 'package:intl/intl.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  DateTime getDateFormatted() {
    return DateFormat("dd/MM/yy").parse(this);
  }
}

extension PresentInString on DateTime {
  String showDateFormatted() {
    return DateFormat("dd/MM/yy").format(this);
  }
}
