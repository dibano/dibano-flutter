import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:dibano/ui/widgets/components/custom_alert_dialog.dart';



class FieldMap extends StatefulWidget {
  final String geoAdminLayer;
  const FieldMap({Key? key, required this.geoAdminLayer}) : super(key: key);

  @override
  _FieldMapState createState() => _FieldMapState();
}

class _FieldMapState extends State<FieldMap> {
  final MapController _mapController = MapController();
  bool _failedLoad = false;
  double? _longitude;
  double? _latitude;
  double? _flaeche_ha;

  @override
  void initState() {
    super.initState();
  }

  
  Future<void> _onTap(LatLng tapPoint) async {
    _longitude = tapPoint.longitude;
    _latitude = tapPoint.latitude;
    String geometry = '${_longitude},${_latitude}';
    const pixelBuffer = 0.1;
    String mapWithBuffer ='${tapPoint.longitude - pixelBuffer},${tapPoint.latitude - pixelBuffer},${tapPoint.longitude + pixelBuffer},${tapPoint.latitude + pixelBuffer}';
    final identifyParams = {
      'geometry': geometry,
      'geometryType': 'esriGeometryPoint',
      'layers': 'all:${widget.geoAdminLayer}',
      'tolerance': '5',
      'mapExtent': mapWithBuffer,
      'imageDisplay': '800,600,96',
      'sr': '4326',
      'returnGeometry': 'false',
      'lang': 'de'
    };

    final urlIdentify =  Uri.https("api3.geo.admin.ch", "/rest/services/api/MapServer/identify", identifyParams);
    debugPrint("Sende Identify-Anfrage: $urlIdentify");

    try {
      final responseIdentify = await http.get(urlIdentify);
      if (responseIdentify.statusCode == 200) {
        final dataIdentify = json.decode(responseIdentify.body);
        if (dataIdentify['results'] != null && (dataIdentify['results'] as List).isNotEmpty) {
          final feature = dataIdentify['results'][0];
          final featureId = feature['id'].toString();
          final findParams = {
            'layer': widget.geoAdminLayer,
            'searchText': featureId,
            'searchField': 'id',
            'contains': 'false',
            'f': 'json',
          };
          final urlFind = Uri.https("api3.geo.admin.ch", "/rest/services/api/MapServer/find", findParams);
          debugPrint("Sende Identify-Anfrage: $urlFind");
          final responseFind = await http.get(urlFind);
          if (responseFind.statusCode == 200) {
            final dataFind = json.decode(responseFind.body);
            if (dataFind['results'] != null && (dataFind['results'] as List).isNotEmpty) {
              final foundData = dataFind['results'][0] as Map<String, dynamic>;
              final attributes = foundData['attributes'] ?? {};
              final flaeche_m2 = attributes['flaeche_m2'];
              _flaeche_ha = (flaeche_m2/10000);
              Navigator.pop(context, {
                'longitude': _longitude,
                'latitude': _latitude,
                'flaecheHa': _flaeche_ha,
              });
            }else{
              _failedLoad = true;
            }
          }else{
          _failedLoad = true;
        }
        }else{
          _failedLoad = true;
        }
      }else{
        _failedLoad = true;
      }

    }catch(e){
      _failedLoad = true;
    }
    if(_failedLoad){
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            alertText:"Beim Laden des Feldes ist ein Fehler aufgetreten, versuchen Sie es später noch einmal oder geben Sie es manuell ein.",
            alertType: AlertType.error,
          );
        },
      );
    }
    _failedLoad = false;
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Map Example"),
        ),
        body: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: LatLng(47.000, 8.6033),
            initialZoom: 15.0,
            onTap: (tapPosition, latlng) => _onTap(latlng),
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            ),
          ],
        ),
      );
    }
  }

