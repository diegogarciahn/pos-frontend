import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constans.dart';

Future descargarFacturaOriginal(
    BuildContext context, String numeroFactura, int tipo, int tiempo) async {
      print('descargardactura?numerofactura=$numeroFactura&tipo=$tipo&tiempo=$tiempo');
  await launchUrl(
      Uri.parse(API_URL + 'descargardactura?numerofactura=$numeroFactura&tipo=$tipo&tiempo=$tiempo'));
}
