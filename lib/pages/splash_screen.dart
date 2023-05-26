import 'package:flutter/material.dart';
// import 'fetch.dart' as fetch;
import 'home.dart' as home;
import 'thumbnail.dart' as thumbnail;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NextScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://play-lh.googleusercontent.com/53M-KrDLmYQCPafCOQvE6AnV32RpfE4oZ4Z_emnQSLuBAoWKrZgNj_w8gkPdyX6BAQ=w240-h480-rw',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://play-lh.googleusercontent.com/53M-KrDLmYQCPafCOQvE6AnV32RpfE4oZ4Z_emnQSLuBAoWKrZgNj_w8gkPdyX6BAQ=w240-h480-rw',
              width: 200,
              height: 200,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Welcome to the Shorts App!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              // fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => thumbnail.ThumbnailPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(82, 24, 122, 1),
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Start Using It',
              style: TextStyle(
                  // fontSize: 20,
                  // fontWeight: FontWeight.bold,
                  // fontStyle: FontStyle.italic,
                  ),
            ),
          )
        ],
      )),
    );
  }
}
