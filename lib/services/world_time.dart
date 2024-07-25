import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location;
  late String time;
  late String flag;
  late String url;
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
      await get(Uri.http('worldtimeapi.org', '/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offsetHour = data['utc_offset'].substring(1, 3);
      String offsetMinutes = data['utc_offset'].substring(4, 6);
      int offset = int.parse(offsetHour) * 60 + int.parse(offsetMinutes);
      DateTime now = DateTime.parse(datetime);
      now = data['utc_offset'].contains('+') ? now.add(Duration(minutes: offset)) : now.subtract(Duration(minutes: offset));

      isDayTime = now.hour > 6 && now.hour < 20 ? true:false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      time = 'Could not get time';
    }
  }
}