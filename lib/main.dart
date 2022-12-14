import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:soft_frontend/constans.dart';
import 'package:soft_frontend/providers/cliente.provider.dart';
import 'package:soft_frontend/providers/empleado.provider.dart';
import 'package:soft_frontend/providers/login.provider.dart';
import 'package:soft_frontend/providers/sucursal.provider.dart';
import 'package:soft_frontend/providers/talonarios.provider.dart';
import 'package:soft_frontend/providers/tipopago.provider.dart';

import 'package:soft_frontend/screens/arqueo/crearArqueo.screen.dart';
import 'package:soft_frontend/screens/cliente/todosLosClientes.screen.dart';
import 'package:soft_frontend/screens/empleado/crearEmpleado.screen.dart';
import 'package:soft_frontend/screens/generarFactura/escogerVenta.screen.dart';
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
import 'screens/pantallaPrincipalGestios/PrincipalGestionUsuarios.screen.dart';

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
        ChangeNotifierProvider(create: (_) => EmpleadoProvider()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: snackbarKey,
        debugShowCheckedModeBanner: false,
        title: 'Soft',
        theme: themeDataApp(),
        initialRoute: 'login',
        routes: {
          'login': (_) => const Login(),
          'inicio': (_) => const PantallaPrincipal(),
          // M??dulo de arqueo
          'traer_arqueo': (_) => const MostrarArqueos(),
          'crear_arqueo': (_) => const CrearArqueo(),
          // M??dulo de Mantenimiento
          'mantenimiento': (_) => const PantallaMantenimientoPrincipal(),
          'mantenimiento/clientes/crearcliente': (_) => CrearClientes(),
          'mantenimiento/clientes': (_) => const TodosLosClientes2(),
          'mantenimiento/talonarios': (_) => TalonariosScreen(),
          'mantenimiento/sucursal': (_) => SucursalScreen(),
          'mantenimiento/tipopagos': (_) => BuscarTipoPago(),
          'mantenimiento/productos/tipoproductos': (_) => PantallaTipoProducto(),
          'mantenimiento/productos': (_) => PantallaProducto(),
          //'buscar_cliente': (_) => BuscarClientes(),
          // M??dulo de ventas:
          'PrincipalVenta': (_) => PantallaPrincipalVenta(),
          'ventas': (_) => const VentanaVenta(),
          'venta/crearcliente': (_) => CrearClientes(),
          'ventas/facturas': (_) => ManipularFactura(),
          'mostrar_ventas': (_) => EscogerVentaPrueb(),
          // M??dulo Gesti??n de usuarios
          'gestionusuarios': (_) => PantallaGestionPrincipal(),
          'gestionusuarios/empleados/crearempleado': (_) => CrearEmpleadosScreen(),
          'gestionusuarios/empleados': (_) => const TodosLosEmpleados2(),
          'gestionusuarios/usuarios': (_) => const MostrarUsuarios(),
          'crearRol': (_) => CrearRol(),
          'gestionusuarios/roles': (_) => const MostrarRol(),
          //'crearUsuarios': (_) => CrearUser(),
        },
      ),
    );
  }
}
