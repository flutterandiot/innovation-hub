// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getting message', () {
    var hour = DateTime.now().hour;

    if (hour <= 12) {
      print('Good Morning');
    } else if ((hour > 12) && (hour <= 16)) {
      print('Good Afternoon');
    } else if ((hour > 16) && (hour < 20)) {
      print('Good Evening');
    } else {
      print('Good Night');
    }
  });

  test('AM-PM', () {
    TimeOfDay day = TimeOfDay.now();
    switch (day.period) {
      case DayPeriod.am:
        print('its morning');
        break;
      case DayPeriod.pm:
        print('its evening/night');
    }
  });
}
