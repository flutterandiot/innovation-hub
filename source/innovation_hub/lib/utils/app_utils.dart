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

  ///Get the greeting message from time of day
  ///
  /// = Good morning
  /// 12 AM to 11 AM
//(12 to 11) in 24 hour format

  /// = Good afternoon
  ///12PM to 4:59PM
  ///(24 to 16:59) in 24 hour format
  ///
  /// = Good evening
  /// 5PM to 7:59PM
  /// (17 to 19:59) in 24 hour format
  ///
  /// = Good night
  /// 8PM to 11:59 PM
  /// (20 to 22:59) in 24 hour format
  ///
  static String getGreetingMessage() {
    final hour = DateTime.now().hour; // always return hour in 24 hour format, [0..23]
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour <= 16) {
      return "Good Afternoon";
    } else if (hour > 16 && hour < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
}
