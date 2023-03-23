import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AppUtilities {
  AppUtilities._();

  /// Get Timestamp from now
  /// @return: timestamp in epoch, seconds
  static String getTimeStampFromNow() {
    return (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
  }

  ///Get time from [epochTime] in seconds
  ///@return: A String of Date time
  static String getTimeFromEpoch(int? epochTime) {
    if (epochTime == null) return '';
    return DateTime.fromMillisecondsSinceEpoch(epochTime * 1000).toString();
  }

  /// Formate [dateTime] in String to a formatted pattern
  /// pattern: 'E, dd MMM yyyy' => e.g: Wed, 20 Mar 2023
  ///
  /// @return: a formated string
  static String getDateTimeFormatted(String dateTime) {
    return DateFormat('E, dd MMM yyyy').format(DateTime.parse(dateTime));
  }

  /// Get a uid from UniqueKey(), remove the #, [, ]
  /// return the uid
  static String getUid() {
    return UniqueKey().toString().replaceAll('#', '').replaceAll('[', '').replaceAll(']', '');
  }
}
