import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [
              Color(0xff1453A5),
              Color(0xff1C92D9),
              Color(0xff46C0F2),
              Color(0xff46C0F2),
              Color(0xff1C92D9),
              Color(0xff144BBE)
            ])),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'EL FUTURO DEL PAIS ESTA EN TUS MANOS',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w700, 
                        fontSize: size.width *0.02
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: size.height * 0.9,
                  width: size.width *0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))

                  ),
                  margin: EdgeInsets.only(right: size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Bienvenido', style: GoogleFonts.poppins())],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
