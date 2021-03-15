import 'package:clima/components/future_hour_column.dart';
import 'package:clima/components/future_week_day_row.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:weather_icons/weather_icons.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({@required this.locationWeather, @required this.weekForecast});

  final locationWeather;
  final weekForecast;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  //current weather
  int temperature;
  String backgroundImage;
  String cityName;
  String message;
  String latitude;
  String longitude;

  //week forecast
  var weekDays = List<String>.filled(24, '');
  var conditionIcons = List<IconData>.filled(24, WeatherIcons.sunrise);
  var weekTemperatures = List<int>.filled(24, 0);
  var minTemperatures = List<int>.filled(24, 0);
  var descriptions = List<String>.filled(24, '');

  //hour forecast
  var hours = List<String>.filled(24, '');
  var hourTemperatures = List<int>.filled(24, 0);
  var hourConditionIcons = List<IconData>.filled(24, WeatherIcons.sunrise);

  @override
  void initState() {
    updateUI(widget.locationWeather);
    updateWeekForecastUI(widget.weekForecast);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        backgroundImage = 'images/location_background.jpg';
        message = 'Unable to get weather data';
        cityName = '';
        return;
      }
      temperature = weatherData['main']['temp'].toInt();

      var condition = weatherData['weather'][0]['id'];
      message = weather.getMessage(condition);
      backgroundImage = weather.getBackgroundImage(condition);
      cityName = weatherData['name'];
      longitude = weatherData['coord']['lon'].toString();
      latitude = weatherData['coord']['lat'].toString();
    });
  }

  void updateWeekForecastUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        return;
      }

      // hourly forecast
      for (var i = 0; i < 24; i++) {
        var hour = weatherData['hourly'][i]['dt'].toInt();
        int hourTemperature = weatherData['hourly'][i]['temp'].toInt();
        var hCondition = weatherData['hourly'][i]['weather'][0]['id'];

        var time =
            DateTime.fromMillisecondsSinceEpoch(hour * 1000, isUtc: false)
                .hour
                .toString();
        var hCondIcon = WeatherModel().getConditionIcon(hCondition);

        setState(() {
          hours[i] = time;
          hourTemperatures[i] = hourTemperature;
          hourConditionIcons[i] = hCondIcon;
        });
      }

      // weekly forecast
      for (var i = 1; i < 8; i++) {
        int dt = weatherData['daily'][i]['dt'].toInt();
        int temp = weatherData['daily'][i]['temp']['day'].toInt();
        int minTemp = weatherData['daily'][i]['temp']['min'].toInt();
        int condition = weatherData['daily'][i]['weather'][0]['id'];
        String description =
            weatherData['daily'][i]['weather'][0]['description'];

        var day = DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: false)
            .weekday;
        var condIcon = WeatherModel().getConditionIcon(condition);

        setState(() {
          // week
          weekDays[i - 1] = weekDaysMap[day];
          weekTemperatures[i - 1] = temp;
          minTemperatures[i - 1] = minTemp;
          conditionIcons[i - 1] = condIcon;
          descriptions[i - 1] = description;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('$backgroundImage'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);

                      var weekForecast = await weather.getWeekForecast(
                          double.parse(latitude), double.parse(longitude));
                      updateWeekForecastUI(weekForecast);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);

                        var weekForecast = await weather.getWeekForecast(
                            double.parse(latitude), double.parse(longitude));
                        updateWeekForecastUI(weekForecast);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$cityName',
                          style: kCityNameTextStyle,
                        ),
                        Text(
                          '$longitude°N  $latitude°E',
                          style: kCoordsTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          '$temperature°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          '$message',
                          style: kButtonTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Divider(
                    thickness: 1.0,
                    color: Colors.white30,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var i = 0; i < 24; i++)
                          FutureHourColumn(
                            temperature: hourTemperatures[i],
                            hour: hours[i],
                            icon: hourConditionIcons[i],
                          ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: Colors.white30,
                  ),
                  for (var i = 0; i < 7; i++)
                    FutureWeekDayRow(
                      weekDay: weekDays[i],
                      icon: conditionIcons[i],
                      temperature: weekTemperatures[i].toString(),
                      minTemperature: minTemperatures[i].toString(),
                      description: descriptions[i],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
