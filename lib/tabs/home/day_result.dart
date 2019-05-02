import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

class DayResult extends Event{
  final DateTime date;
  final Widget _icon;

  DayResult(this.date, this._icon);

  @override
  bool operator ==(other) {
    return this.date == other.date &&
        this._icon == other._icon;
  }
}