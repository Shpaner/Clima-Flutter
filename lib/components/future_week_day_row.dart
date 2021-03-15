import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class FutureWeekDayRow extends StatelessWidget {
  FutureWeekDayRow(
      {@required this.weekDay,
      @required this.icon,
      @required this.temperature,
      @required this.minTemperature,
      @required this.description});

  final String weekDay;
  final IconData icon;
  final String temperature;
  final String minTemperature;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 120.0,
            padding: EdgeInsets.all(0.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                weekDay,
                style: kWeekDayRowTextStyle,
              ),
            ),
          ),
          Container(
            width: 105.0,
            child: Row(
              children: [
                Container(
                  width: 40.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: BoxedIcon(
                      icon,
                      size: 23.0,
                    ),
                  ),
                ),
                Container(
                  width: 65.0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      description,
                      style: kConditionPercentage,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40.0,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$temperature°',
                      style: kWeekDayRowTextStyle,
                    ),
                  ),
                ),
                Container(
                  width: 40.0,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$minTemperature°',
                      style: kWeekDayMinRowTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
