import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map data = {};

  void getData(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=57fa9e4b78664067f293d97602aa3d74"),
    );

    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
      });

      print(data["name"]);
    }
  }

  @override
  void initState() {
    getData(19.0, 72.87);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double temp = data.isNotEmpty ? data["main"]["temp"] - 273 : 0;
    final double maxtemp = data.isNotEmpty ? data["main"]["temp_max"] - 273 : 0;
    final String day = DateFormat('EEEE').format(DateTime.now());
    String formatDate(DateTime date) => DateFormat("MMMM d").format(date);
    final String date = formatDate(DateTime.now());
    return Scaffold(
        backgroundColor: Color(0xff3a4f7a),
        body: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: data.isNotEmpty
                ? Column(children: [
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.slider_horizontal_3,
                          size: 26,
                          color: Colors.white,
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        const Icon(
                          CupertinoIcons.location_solid,
                          size: 26,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${data["name"]}, ${data["sys"]["country"]}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          temp.toStringAsFixed(0),
                          style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 100,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w400),
                        ),
                        const Text(
                          "°",
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 70,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Text(
                      "${day}, ${date}",
                      style: const TextStyle(
                          height: 1.3,
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 1.1,
                          wordSpacing: 1.1),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "max temperature: ${maxtemp.toStringAsFixed(0)}°C",
                      style: const TextStyle(
                          height: 1.3,
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 1.1,
                          wordSpacing: 1.1),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 180,
                            width: 150,
                            padding: const EdgeInsets.only(bottom: 18),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/cloud.png",
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    data["weather"][0]["main"],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    data["weather"][0]["description"],
                                    style: const TextStyle(
                                      color: Colors.amber,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ]),
                          ),
                          Container(
                            height: 180,
                            width: 150,
                            padding: const EdgeInsets.only(bottom: 18),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Transform.rotate(
                                    angle: 0.8,
                                    child: Image.asset(
                                      "assets/light.png",
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const Text(
                                    "pressure",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    data["main"]["pressure"].toString(),
                                    style: const TextStyle(
                                      color: Colors.amber,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ]),
                          ),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 180,
                            width: 150,
                            padding: const EdgeInsets.only(bottom: 18),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/sun.png",
                                    height: 100,
                                    width: 60,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    "Humidity",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    data["main"]["humidity"].toString(),
                                    style: const TextStyle(
                                      color: Colors.amber,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ]),
                          ),
                          Container(
                            height: 180,
                            width: 150,
                            padding: const EdgeInsets.only(bottom: 18),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/wind.png",
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    "Wind Speed",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    data["wind"]["speed"].toString(),
                                    style: const TextStyle(
                                      color: Colors.amber,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ]),
                          ),
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                  ])
                : Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  )));
  }
}
