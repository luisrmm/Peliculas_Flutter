import 'package:app_peliculas/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../widgets/Input_decoration.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        //Aqui se agrega el cuadro azul
        child: Stack(
          children: [
            boxBlue(size),
            iconPerson(),
            //Aqui se agregara el formulario.
            loginForm(context)
          ],
        ),
      ),
    );
  }

  SingleChildScrollView loginForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //Espacio entre el primer widget y el segundo.
          SizedBox(height: 300),
          //Box de inicio de sesion
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            //height: 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(0, 5))
                ]),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text('Inicio de Sesión',
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 30),
                Container(
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          autocorrect: false,
                          decoration: InputDecorations.inputDecoration(
                              hintText: 'ejemplo12',
                              labelText: 'Usuario',
                              icon: Icon(Icons.person),
                              ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          autocorrect: false,
                          decoration: InputDecorations.inputDecoration(
                              hintText: '******',
                              labelText: 'Contraseña',
                              icon: Icon(Icons.lock_outlined)),
                        ),
                        SizedBox(height: 30),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          disabledColor: Colors.grey,
                          color: AppColors.secondaryColor,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                            child: Text(
                              'Iniciar Sesión',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 50),
          Text('¿Aún no tiene una cuenta? Regístrate',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  SafeArea iconPerson() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        child: Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

  Container boxBlue(Size size) {
    return Container(
      color: AppColors.primaryColor,
      width: double.infinity,
      height: size.height * 0.4,
    );
  }
}
