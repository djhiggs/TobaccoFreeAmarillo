import 'package:flutter/material.dart';

class DayResult {
  final DateTime date;
  final Widget icon;

  DayResult(this.date, this.icon);

  @override
  bool operator ==(other) {
    return this.date == other.date &&
        this.icon == other.icon;
  }
}