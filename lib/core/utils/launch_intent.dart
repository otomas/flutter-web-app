import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'general_data.dart';

Future<void> callPhone(String? phoneNumber) async {
  if (phoneNumber != null) {
    final url = 'tel:${phoneNumber.replaceAll(' ', '')}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrlString(url);
    } else {
      throw ArgumentError('Could not launch call phone $url');
    }
  }
}

Future<void> sendSms(String? phoneNumber) async {
  if (phoneNumber != null) {
    final url = 'sms:${phoneNumber.replaceAll(' ', '')}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrlString(url);
    } else {
      throw ArgumentError('Could not launch sms phone $url');
    }
  }
}

Future<void> sendMail(String? mailAddress) async {
  if (mailAddress != null) {
    final url = 'mailto:${mailAddress.replaceAll(' ', '')}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrlString(url);
    } else {
      throw ArgumentError('Could not launch mail $url');
    }
  }
}

Future<bool> addToCalendar({
  required String title,
  required String description,
  required DateTime startDate,
  required DateTime endDate,
  String? location,
  String? email,
}) async {
  final serverTime = GeneralData.getInstance().serverTime;
  var start = DateTime(serverTime.year, startDate.month, startDate.day);
  var end = DateTime(serverTime.year, startDate.month, startDate.day);
  if (start.isBefore(serverTime)) {
    start = DateTime(serverTime.year + 1, startDate.month, startDate.day, startDate.hour, startDate.minute);
    end = DateTime(serverTime.year + 1, startDate.month, startDate.day, startDate.hour, startDate.minute);
  }
  final event = Event(
    title: title,
    description: description,
    location: location,
    startDate: start,
    endDate: end,
    allDay: true,
    androidParams: AndroidParams(emailInvites: email == null ? [] : [email]),
  );
  return Add2Calendar.addEvent2Cal(event);
}

Future<void> launchUrl(String? url, {LaunchMode? mode}) async {
  if (url != null) {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrlString(url);
    } else {
      throw ArgumentError('Could not launch $url');
    }
  }
}

Future<void> openMaps(num? lat, num? long) async {
  if (lat != null && long != null) {
    final latitude = lat.toDouble();
    final longitude = long.toDouble();
    await MapsLauncher.launchCoordinates(latitude, longitude);
  }
}
