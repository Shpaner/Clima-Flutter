import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Nunito Light',
  fontSize: 90.0,
);

const kCityNameTextStyle = TextStyle(
  fontFamily: 'Nunito Light',
  fontSize: 50.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 27.0,
  fontFamily: 'Nunito Light',
  fontWeight: FontWeight.bold,
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
  fontWeight: FontWeight.bold,
);

const kWeekDayRowTextStyle = TextStyle(
  fontFamily: 'Nunito Light',
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

const kWeekDayMinRowTextStyle = TextStyle(
  fontFamily: 'Nunito Light',
  fontSize: 22.0,
  color: Colors.grey,
  fontWeight: FontWeight.bold,
);

const kCoordsTextStyle = TextStyle(
  fontFamily: 'Nunito Light',
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);

const kConditionPercentage = TextStyle(
  fontFamily: 'Nunito Light',
  fontSize: 15.0,
  color: Colors.blue,
  fontWeight: FontWeight.bold,
);

const kHourForecast = TextStyle(
  fontFamily: 'Nunito Light',
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);

Map<int, String> weekDaysMap = {
  1: 'Monday',
  2: 'Tuesday',
  3: 'Wednesday',
  4: 'Thursday',
  5: 'Friday',
  6: 'Saturday',
  7: 'Sunday',
};
