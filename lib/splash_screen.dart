import 'package:csi_flutter_workshop/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAnimate = true;
  bool isClicked = false;

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        setState(() {
          isAnimate = false;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff3a4f7a),
        body: Stack(
          children: [
            AnimatedPositioned(
              top: 140,
              left: isAnimate ? -100 : 120,
              right: 90,
              duration: const Duration(seconds: 2),
              child: Image.asset("assets/sun.png", height: 100, width: 100),
            ),
            AnimatedPositioned(
              top: 100,
              left: 70,
              right: isAnimate ? -100 : 70,
              duration: const Duration(seconds: 2),
              child: Image.asset("assets/cloud.png", height: 250, width: 250),
            ),
            Positioned(
              top: 180,
              left: 70,
              right: 60,
              child: AnimatedOpacity(
                opacity: isAnimate ? 0 : 1,
                duration: const Duration(seconds: 4),
                child: Transform.rotate(
                    angle: 0.8,
                    child: Image.asset("assets/light.png",
                        height: 250, width: 250)),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const Text(
                    "WEATHER",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Forecasts",
                    style: TextStyle(
                        color: Colors.amber,
                        letterSpacing: 2,
                        fontSize: 50,
                        fontWeight: FontWeight.w300),
                  ),
                  const Text(
                    "Lorem Ipsum has the industry's standard \nwhen make a type specimen book.\nalso the leap into electronic typesetting.",
                    style: TextStyle(
                        // height: 1.3,
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.1,
                        wordSpacing: 1.1),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isClicked = true;
                      });

                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      });
                    },
                    child: AnimatedContainer(
                      height: 50,
                      width: isClicked ? 150 : 250,
                      curve: Curves.bounceInOut,
                      duration: const Duration(seconds: 2),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                          child: Text("Get Started",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
