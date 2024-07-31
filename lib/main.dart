import 'package:flutter/material.dart'; // Importa el paquete Flutter Material Design
import 'dart:math'; // Importa el paquete Dart Math para generar números aleatorios
import 'package:http/http.dart'
    as http; // Importa el paquete HTTP para realizar solicitudes HTTP
import 'dart:convert'; // Importa el paquete Dart Convert para trabajar con JSON

void main() {
  runApp(MyApp()); // Inicia la aplicación llamando a MyApp
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil App', // Título de la aplicación
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema de la aplicación
      ),
      home: UserProfileScreen(), // Establece la pantalla principal
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() =>
      _UserProfileScreenState(); // Crea el estado para la pantalla
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Map<String, dynamic>?
      userData; // Variable para almacenar los datos del usuario
  bool isLoading = true; // Indicador de carga

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Llama a la función para obtener los datos del usuario al iniciar el estado
  }

  Future<void> fetchUserData() async {
    setState(() {
      isLoading = true; // Muestra el indicador de carga
    });

    final int userId = Random().nextInt(10) +
        1; // Genera un ID de usuario aleatorio entre 1 y 10
    final String url =
        'https://jsonplaceholder.typicode.com/users/$userId'; // URL de la API con el ID de usuario

    try {
      final response =
          await http.get(Uri.parse(url)); // Realiza la solicitud HTTP GET

      if (response.statusCode == 200) {
        userData = json.decode(response.body); // Decodifica la respuesta JSON
        setState(() {
          isLoading = false; // Oculta el indicador de carga
        });
      } else {
        throw Exception(
            'Failed to load user data'); // Lanza una excepción si falla la solicitud
      }
    } catch (error) {
      print(
          'Error fetching user data: $error'); // Imprime el error en la consola
      setState(() {
        isLoading = false; // Oculta el indicador de carga en caso de error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Perfil de Usuario - App final by Julio Danieri'), // Título de la barra de la aplicación
      ),
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Muestra un indicador de carga mientras se obtienen los datos
          : userData != null
              ? Padding(
                  padding: const EdgeInsets.all(
                      16.0), // Espaciado alrededor del contenido
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Alinea el contenido al inicio
                    children: <Widget>[
                      Text(
                        'Nombre: ${userData!['name']}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold), // Estilo del texto
                      ),
                      SizedBox(height: 8), // Espaciado entre elementos
                      Text(
                        'Usuario: ${userData!['username']}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Email: ${userData!['email']}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Teléfono: ${userData!['phone']}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Sitio Web: ${userData!['website']}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Dirección:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '  Calle: ${userData!['address']['street']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '  Suite: ${userData!['address']['suite']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '  Ciudad: ${userData!['address']['city']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '  Código Postal: ${userData!['address']['zipcode']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Compañía:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '  Nombre: ${userData!['company']['name']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '  Lema: ${userData!['company']['catchPhrase']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '  BS: ${userData!['company']['bs']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text(
                      'Error al cargar los datos del usuario')), // Muestra un mensaje de error si no se cargan los datos
    );
  }
}
