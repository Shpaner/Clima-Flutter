import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_icons/weather_icons.dart';

class FutureHourColumn extends StatelessWidget {
  FutureHourColumn(
      {@required this.temperature, @required this.hour, @required this.icon});

  final int temperature;
  final String hour;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
      child: Column(
        children: [
          Text(
            hour,
            style: kHourForecast,
          ),
          BoxedIcon(
            icon,
            size: 23.0,
          ),
          Text(
            '${temperature.toString()}°',
            style: kHourForecast,
          ),
        ],
      ),
    );
  }
}
