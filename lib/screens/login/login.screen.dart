// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soft_frontend/controllers/user.controller.dart';
import 'package:soft_frontend/providers/login.provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var usuarioController = TextEditingController();
  var passwordController = TextEditingController();
  bool _password = true;

  @override
  Widget build(context) {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Iniciar Sesión'),
          centerTitle: true,
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                padding: constraints.maxWidth < 500
                    ? const EdgeInsets.all(20)
                    : const EdgeInsets.all(30.0),
                color: const Color(0xffF3F3F3),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Iniciar sesión',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Por favor ingrese su usuario y contraseña para conocer su identidad.',
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff606060)),
                      ),
                      const SizedBox(height: 40),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 500,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Usuario',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  TextFormField(
                                    controller: usuarioController,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.account_circle_rounded,
                                          color: Colors.blue,
                                        ),
                                        border: UnderlineInputBorder(),
                                        hintText: 'usuario01'),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    'Contraseña',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    keyboardType: TextInputType.text,
                                    obscureText: _password,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.blue,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                              Icons.visibility_off_outlined),
                                          onPressed: () {
                                            setState(() {
                                              _password = !_password;
                                            });
                                          },
                                        ),
                                        border: UnderlineInputBorder(),
                                        hintText: 'usuario01'),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  TextButton(
                                    onPressed: null,
                                    child: Center(
                                      child: ElevatedButton(
                                          onPressed: () => loginController(
                                              usuarioController.text,
                                              passwordController.text,
                                              context),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Text('Continuar'),
                                          )),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (loginProvider.loading)
                Container(
                    color: Colors.black12,
                    height: double.infinity,
                    width: double.infinity,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        height: 90.0,
                        width: 90.0,
                        child: CircularProgressIndicator(
                        )),
                    ))
            ],
          );
        }));
  }
}
