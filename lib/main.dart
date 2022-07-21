import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_mapas/src/views/flull_screen_map.dart';

Future main() async {

  // To load the .env file contents into dotenv.
  // NOTE: fileName defaults to .env and can be omitted in this case.
  // Ensure that the filename corresponds to the path in step 1 and 2.
  await dotenv.load(fileName: ".env");
  
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App', 
      initialRoute: 'home',
      routes: {
        'home'   : ( _ ) => const FullScreenMap(), 
      },
    );
  }
}