import 'dart:convert';
import 'dart:io';

import 'package:airportapp/models/data.dart';

HttpClient client = HttpClient();

///
///Method Name: LightControl
///Description: This method sends an HTTP get request
///to the control page that activates the strobing lights
///
Future lightControl() async {
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  HttpClientRequest request =
      await client.getUrl(Uri.parse("http://192.168.86.177:5000/control"));
  HttpClientResponse result = await request.close();
}

List<Sound> listSound = [];

///
///Method Name: getLevels
///Description: This method sends an HTTP get request
///to the Flask API that receives a Json Object decodes
///the json and stores the items within a class Sound
///and adds it to a list
///
Future<List<Sound>> getLevels() async {
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  HttpClientRequest request =
      await client.getUrl(Uri.parse("http://192.168.86.177:5000"));
  HttpClientResponse result = await request.close();
  if (result.statusCode == 200) {
    List<dynamic> jsonData =
        jsonDecode(await result.transform(utf8.decoder).join());
    if (listSound.isNotEmpty) {
      listSound.clear();
    }
    for (var i in jsonData) {
      listSound.add(
        new Sound(
          i['ID'],
          i['SoundData'],
        ),
      );
    }
  }
  print(listSound.length);
  return listSound;
}

///
///Method Name: soundStream
///Description: This method is a stream that every 5 seconds will call the
///get levels to get the most recent dB sound level for the total and graph
///
Stream<List<Sound>> soundStream() =>
    Stream.periodic(Duration(seconds: 5)).asyncMap((event) => getLevels());
