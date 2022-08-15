import 'package:flutter/material.dart';
import 'package:soft_frontend/models/facturaBuscada.model.dart';

import '../../mostrarUnaFactura/mostrarunafactura.screen.dart';

Container facturaItemListMobile(FacturaBuscada factura, context) {
  Size size = MediaQuery.of(context).size;
  return Container(
      padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.assignment_outlined, color: Colors.blue),
              SizedBox(
                width: size.width * 0.01,
              ),
              Expanded(
                child: SelectableText(factura.numeroFactura,
                    style: TextStyle(
                        color: Color.fromARGB(255, 3, 49, 87),
                        fontWeight: FontWeight.bold)),
              ),
              Icon(Icons.calendar_today_outlined, color: Colors.blue),
              SizedBox(
                width: size.width * 0.01,
              ),
              Expanded(
                child: SelectableText(
                    factura.fechaFactura.toString().substring(0, 10),
                    style: TextStyle(
                        color: Color.fromARGB(255, 3, 49, 87),
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cliente',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 175, 175, 175)),
                    ),
                    SelectableText(
                      factura.nombreCliente.toString(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RTN',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 175, 175, 175)),
                    ),
                    SelectableText(
                      factura.rtn.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CAI',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 175, 175, 175)),
                    ),
                    SelectableText(
                      factura.cai.toString(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Empleado',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 175, 175, 175)),
                    ),
                    SelectableText(
                      factura.nombreEmpleado.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MostrarFactura(
                            numeroFactura: factura.numeroFactura)));
              },
              child: Text('Abrir'))
        ],
      ));
}
