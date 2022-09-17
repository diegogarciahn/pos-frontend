import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_frontend/controllers/cliente.controller.dart';
import 'package:soft_frontend/providers/cliente.provider.dart';
import 'package:soft_frontend/screens/cliente/components/cabeceralistclientes.component.dart';
import 'package:soft_frontend/services/cliente.service.dart';
import '../../models/cliente.model.dart';
import 'components/tableitemlistclientes.component.dart';

class TodosLosClientes2 extends StatefulWidget {
  const TodosLosClientes2({Key? key}) : super(key: key);

  @override
  State<TodosLosClientes2> createState() => _TodosLosClientes2State();
}

class _TodosLosClientes2State extends State<TodosLosClientes2> {
  List<TodoslosCliente> listaClientes = [];

  @override
  void initState() {
    traerClientesController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ClienteProvider clienteProvider = Provider.of<ClienteProvider>(context);
    Size size = MediaQuery.of(context).size;
    // var buscadorcontroller = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Clientes'),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.01, vertical: 8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.maybePop(context).then((value) {
                    if (!value) {
                      Navigator.popAndPushNamed(context, 'mantenimiento');
                    }
                  });
                },
                child: const Text(
                  'Regresar',
                  textAlign: TextAlign.center,
                ),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary
                ),
              ),
            ),
          ],
        ),
        body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context,
                                  'mantenimiento/clientes/crearcliente');
                            },
                            child: const Text(
                              'Crear Cliente',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    cabeceraTableClientes(context),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: ListView.separated(
                            itemBuilder: (_, i) => item(clienteProvider.getlistClientes[i], context),
                            itemCount: clienteProvider.getlistClientes.length,
                            separatorBuilder: (_, i) => const Divider(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }

  void buscarCliente(String query) {
    final sugerencia = listaClientes.where((listaClientes) {
      final nombre = listaClientes.nombreCliente.toLowerCase();
      final input = query.toLowerCase();
      return nombre.contains(input);
    }).toList();

    listaClientes = sugerencia;
    setState(() {});
  }
}
