import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:soft_frontend/constans.dart';
import 'package:soft_frontend/providers/cliente.provider.dart';
import 'package:soft_frontend/providers/login.provider.dart';
import 'package:soft_frontend/providers/sucursal.provider.dart';
import 'package:soft_frontend/providers/talonarios.provider.dart';
import 'package:soft_frontend/providers/tipopago.provider.dart';

import 'package:soft_frontend/screens/arqueo/crearArqueo.screen.dart';
import 'package:soft_frontend/screens/cliente/todosLosClientes.screen.dart';
import 'package:soft_frontend/screens/empleado/crearEmpleado.screen.dart';
import 'package:soft_frontend/screens/generarFactura/escogerVenta.screen.dart';
import 'package:soft_frontend/screens/home/home.screen.dart';
import 'package:soft_frontend/screens/manipularFactura/manipularfactura.screen.dart';
import 'package:soft_frontend/screens/screens.dart';
import 'package:soft_frontend/screens/sucursal/sucursal.screen.dart';
import 'package:soft_frontend/screens/tipoPago/buscarTipoPago.screen.dart';
import 'package:soft_frontend/screens/rol/crearol.screen.dart';
import 'package:soft_frontend/screens/tipoproducto/tipoproducto.screen.dart';
import 'package:soft_frontend/screens/producto/producto.screen.dart';
import 'package:soft_frontend/screens/rol/gestionroles.screen.dart';
import 'package:soft_frontend/themes/themeapp.dart';

import 'providers/producto.provider.dart';
import 'providers/tipoproducto.provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductoProvider()),
        ChangeNotifierProvider(create: (_) => TipoProductoProvider()),
        ChangeNotifierProvider(create: (_) => TalonariosProvider()),
        ChangeNotifierProvider(create: (_) => SucursalProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => TipoPagoProvider()),
        ChangeNotifierProvider(create: (_) => ClienteProvider()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: snackbarKey,
        debugShowCheckedModeBanner: false,
        title: 'Soft',
        theme: themeDataApp(),
        initialRoute: 'login',
        routes: {
          'login': (_) => const Login(),
          'pantalla_principal': (_) => const PantallaPrincipal(),
          'index': (_) =>  HomePage(),
          'mantenimiento': (_) => const PantallaMantenimientoPrincipal(),
          'mantenimiento/clientes/crearcliente': (_) => CrearClientes(),
          '/venta/crear_cliente': (_) => CrearClientes(),
          'mantenimiento/clientes': (_) => const TodosLosClientes2(),
          'crear_empleado': (_) => crearEmpleados(),
          'traer_empleados': (_) => const TodosLosEmpleados2(),
          //'crearUsuarios': (_) => CrearUser(),
          'crearRol': (_) => CrearRol(),
          'gestionUsuarios': (_) => const MostrarUsuarios(),
          'ventas': (_) => const VentanaVenta(),
          'gestionRol': (_) => const MostrarRol(),
          //'buscar_cliente': (_) => BuscarClientes(),
          'ventas/facturas': (_) => ManipularFactura(),
          'mantenimiento/talonarios': (_) => TalonariosScreen(),
          'mantenimiento/sucursal': (_) => SucursalScreen(),
          'mantenimiento/tipopagos': (_) => BuscarTipoPago(),
          'traer_arqueo': (_) => const MostrarArqueos(),
          'crear_arqueo': (_) => const CrearArqueo(),
          'PrincipalVenta': (_) => PantallaPrincipalVenta(),
          'PrincipalGestion': (_) => PantallaGestionPrincipal(),
          'mantenimiento/productos/tipoproductos': (_) => PantallaTipoProducto(),
          'mantenimiento/productos': (_) => PantallaProducto(),
          'mostrar_ventas': (_) => EscogerVentaPrueb(),
        },
      ),
    );
  }
}
