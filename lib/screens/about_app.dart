import 'dart:async';

import 'package:ecommerce_app/data/address.dart';
import 'package:ecommerce_app/data/language_provider.dart';
import 'package:ecommerce_app/model/Address.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AboutAppScreen extends StatelessWidget {
  static const String id = 'aboutapp';
  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.getText('About app')),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('E-commerce App'),
            Text('My address:'),
            Text('address...........'),
            Text('My address on map'),
            Container(
              height: 200,
              child: FutureBuilder(
                future: AddressConnect().getAddress(),
                builder: (ctx, snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  } else {
                    Address address = snapShot.data;
                    Set<Marker> marker = Set<Marker>();
                    marker.add(
                      Marker(
                        markerId: MarkerId('1'),
                        position: LatLng(address.lat, address.lng),
                        infoWindow: InfoWindow(title: 'Mega Store'),
                      ),
                    );
                    return GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(address.lat, address.lng),
                        zoom: 16.0,
                      ),
                      zoomControlsEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      onTap: (_) {
                        showDialog(
                          context: context,
                          builder: (ctx) {
                            return Stack(
                              children: [
                                GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(address.lat, address.lng),
                                    zoom: 16.0,
                                  ),
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    if (_controller == null)
                                      _controller.complete(controller);
                                  },
                                  markers: marker,
                                ),
                                MaterialButton(
                                  child: Icon(
                                    Icons.close,
                                    color: Theme.of(context).selectedRowColor,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Text('By mohamedshasho1@gmail.com'),
          ],
        ),
      ),
    );
  }
}
