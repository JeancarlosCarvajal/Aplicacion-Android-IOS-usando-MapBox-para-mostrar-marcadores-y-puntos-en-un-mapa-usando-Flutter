import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {
   
  const FullScreenMap({Key? key}) : super(key: key);

  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {

    MapboxMapController? mapController;

    _onMapCreated(MapboxMapController controller) {
      mapController = controller;
    }
 

    final LatLng center = LatLng(10.1923226, -64.6841399);

    // estilo creado personalizado en https://studio.mapbox.com/.. lo copie desde Style URL
    var selectedStyle = 'mapbox://styles/jcc9638/cl5twvcjk001w15payzt6ao7v';
    final oscuroStyle = 'mapbox://styles/jcc9638/cl5twvcjk001w15payzt6ao7v';
    final streetStyle = 'mapbox://styles/jcc9638/cl5twyqdy000t14tdw50rj51f';

  final apiMapBox = dotenv.env['MAPBOX_TOKEN_STYLES']; // MAPBOX_TOKEN_STYLES   MAPBOX_TOKEN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 600,
        child: MapboxMap(
          styleString: selectedStyle,
          // TODO sin este token accessToken la aplicacion REBIENTA OJO
          accessToken: apiMapBox,
          onMapCreated: _onMapCreated,
          initialCameraPosition: 
            CameraPosition(
              target: center,
              zoom: 13
            ),
          // onStyleLoadedCallback: _onStyleLoadedCallback,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(  
        mainAxisSize: MainAxisSize.max,        
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            // backgroundColor: Colors.green,
            child: const Icon(Icons.zoom_in),
            onPressed: () {
              mapController?.animateCamera(CameraUpdate.zoomIn());
              setState(() { 
                print('Haciendo Zoom in');
              });
            },
          ),
          FloatingActionButton(
            // backgroundColor: Colors.green,
            child: const Icon(Icons.zoom_out),
            onPressed: () {
              mapController?.animateCamera(CameraUpdate.zoomOut());
              setState(() { 
                print('Haciendo Zoom out');
              });
            },
          ),
          FloatingActionButton(
            // backgroundColor: Colors.green,
            child: const Icon(Icons.emoji_symbols_sharp),
            onPressed: () {
              mapController?.addSymbol(SymbolOptions(
                zIndex: 3,
                geometry: center,
                iconSize: 3,
                iconImage: 'fast-food-15',
                iconColor: '#f10404',
                textField: 'Montana Creada',
                textColor: '#f10404',
                fontNames: ['DIN Offc Pro Bold', 'Arial Unicode MS Regular'],               
              ));
              setState(() {
                print('Haciendo Pin');
              });
            },
          ),
          const Text('Test', style: TextStyle(fontFamily: 'Pixel', fontWeight: FontWeight.bold),),
          FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(Icons.layers),
            onPressed: () {
              selectedStyle == oscuroStyle
                ? selectedStyle = streetStyle
                : selectedStyle = oscuroStyle;
              setState(() { 
                print(selectedStyle);
              });
            },
          ),
        ],
      ),
    ); 
  }
} 