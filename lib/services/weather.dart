import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

const kApiKey = '176012983da7f6c7d9dafd92b9e837ba';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/';

class WeatherModel {
  Future<dynamic> getWeekForecast(double latitude, double longitude) async {
    var url =
        '${openWeatherMapURL}onecall?lat=$latitude&lon=$longitude&appid=$kApiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    var url =
        '${openWeatherMapURL}weather?q=$cityName&appid=$kApiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '${openWeatherMapURL}weather?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric');
    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getMessage(int condition) {
    if (condition < 300) {
      return 'thunderstorm';
    } else if (condition < 400) {
      return 'drizzle';
    } else if (condition < 600) {
      return 'rainy';
    } else if (condition < 700) {
      return 'snowy';
    } else if (condition < 800) {
      return 'foggy';
    } else if (condition == 800) {
      return 'sunny️';
    } else if (condition <= 804) {
      return 'cloudy';
    } else {
      return '';
    }
  }

  String getBackgroundImage(int condition) {
    if (condition < 300) {
      return 'images/thunderstorm_background.jpeg';
    } else if (condition < 400) {
      return 'images/drizzle_background.jpeg';
    } else if (condition < 600) {
      return 'images/rain_background2.jpg';
    } else if (condition < 700) {
      return 'images/snow_background3.jpeg';
    } else if (condition < 800) {
      return 'images/fog_background.jpeg';
    } else if (condition == 800) {
      return 'images/sunny_background.jpeg';
    } else if (condition <= 804) {
      return 'images/cloudy_background.jpeg';
    } else {
      return 'images/location_background.jpg‍';
    }
  }

  IconData getConditionIcon(int condition) {
    if (condition < 300) {
      return WeatherIcons.thunderstorm;
    } else if (condition < 400) {
      return WeatherIcons.raindrop;
    } else if (condition < 600) {
      return WeatherIcons.rain;
    } else if (condition < 700) {
      return WeatherIcons.snow;
    } else if (condition < 800) {
      return WeatherIcons.fog;
    } else if (condition == 800) {
      return WeatherIcons.day_sunny;
    } else if (condition <= 804) {
      return WeatherIcons.cloudy;
    } else {
      return WeatherIcons.day_rain_wind;
    }
  }
}

// String getWeatherIcon(int condition) {
//   if (condition < 300) {
//     return '🌩';
//   } else if (condition < 400) {
//     return '🌧';
//   } else if (condition < 600) {
//     return '☔️';
//   } else if (condition < 700) {
//     return '☃️';
//   } else if (condition < 800) {
//     return '🌫';
//   } else if (condition == 800) {
//     return '☀️';
//   } else if (condition <= 804) {
//     return '☁️';
//   } else {
//     return '🤷‍';
//   }
// }
//
// String getMessage(int temp) {
//   if (temp > 25) {
//     return 'It\'s 🍦 time';
//   } else if (temp > 20) {
//     return 'Time for shorts and 👕';
//   } else if (temp < 10) {
//     return 'You\'ll need 🧣 and 🧤';
//   } else {
//     return 'Bring a 🧥 just in case';
//   }
// }
