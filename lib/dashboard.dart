import 'package:airportapp/HTTP/requets.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff202020),
      appBar: AppBar(
        backgroundColor: Color(0xff202020),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: StreamBuilder(
                stream: soundStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator(
                      color: Colors.green,
                    );
                  } else {
                    return Text(
                      "${listSound.last.SoundData.toString()}dB",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 64,
                          fontWeight: FontWeight.bold),
                    );
                  }
                },
              ),
            ),
            Container(
                child: StreamBuilder(
              stream: soundStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator(
                    color: Colors.green,
                  );
                } else {
                  return LineGraph(
                    features: [
                      Feature(
                        title: "Plane",
                        color: Colors.blue,
                        data: [
                          (listSound[listSound.length - 1].SoundData / 100),
                          (listSound[listSound.length - 2].SoundData / 100),
                          (listSound[listSound.length - 3].SoundData / 100),
                          (listSound[listSound.length - 4].SoundData / 100),
                          (listSound[listSound.length - 5].SoundData / 100),
                          (listSound[listSound.length - 6].SoundData / 100),
                        ],
                      ),
                    ],
                    size: Size(380, 400),
                    labelX: [
                      '.',
                      '.',
                      '.',
                      '.',
                      '.',
                      '.',
                    ],
                    labelY: ['20%', '40%', '60%', '80%', '100%'],
                    showDescription: true,
                    graphColor: Colors.white30,
                    graphOpacity: 0.2,
                    verticalFeatureDirection: true,
                    descriptionHeight: 130,
                  );
                }
              },
            )),
            Container(
              height: 64,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  lightControl();
                  getLevels();
                },
                child: Text("Activate Runway Lights"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
