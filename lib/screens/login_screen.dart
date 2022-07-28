import 'package:app_peliculas/constants/app_colors.dart';
import 'package:app_peliculas/models/login.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/Input_decoration.dart';
import 'package:app_peliculas/services/login_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Login _apiResponse = new Login();
  final _formLogin = GlobalKey<FormState>();

  String username;

  String password;

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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formLogin,
                    child: Column(
                      children: [
                        TextFormField(
                          key: Key("_username"),
                          maxLength: 15,
                          autocorrect: false,
                          decoration: InputDecorations.inputDecoration(
                              hintText: 'ejemplo12',
                              labelText: 'Usuario',
                              icon: Icon(Icons.person)),
                          onSaved: (value) {
                            username = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el usuario';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          obscureText: true,
                          autocorrect: false,
                          decoration: InputDecorations.inputDecoration(
                              hintText: '******',
                              labelText: 'Contraseña',
                              icon: Icon(Icons.lock_outlined)),
                          onSaved: (value) {
                            password = value;
                          },
                          validator: (value) {
                            String validationPattern =
                                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$!%*?&])[A-Za-zd$@$!%*?&].{5,}';
                            RegExp regExp = new RegExp(validationPattern);
                            return regExp.hasMatch(value ?? '')
                                ? null
                                : 'La contraseña debe contener: A, a, 1, @';
                          },
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
                          onPressed: () {
                            _handleSubmitted();
                            //Navigator.pushReplacementNamed(context, 'home');
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 50),
          InkWell(
            child: Text("¿Aún no tienes una cuenta? Regístrate",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: _launchURL,
          )
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

//Metodo que hace el login
  void _handleSubmitted() async {
    final FormState form = _formLogin.currentState;
    if (form.validate() == null) {
      Fluttertoast.showToast(
          msg: "Error llene el formulario correctamente", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.CENTER, // location
          timeInSecForIosWeb: 1 // duration
          );
    } else {
      form.save();
      final response = await LoginService.authLogin(username, password);
      if (response == null) {
      } else {
        _saveAndRedirectToHome(response.userName);
        LoginService.errorLoginByUser.removeWhere((element) => element.toString().contains(username));
      }
    }
  }

  void _saveAndRedirectToHome(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userName", userName);
    Navigator.pushNamedAndRemoveUntil(
        context, 'home', ModalRoute.withName('home'));
  }

  _launchURL() async {
    const urlSingIn = 'https://cinemark-f9c14.web.app/sign-in';
    var url = Uri.parse(urlSingIn);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
