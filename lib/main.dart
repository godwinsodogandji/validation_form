import 'package:flutter/material.dart';
import 'animated_elevated_button.dart';
import 'animated_text.dart';
import 'package:validation_form/home_screen.dart';
import 'animated_text_form_field.dart';
import 'my_custom_register.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Login';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        body: FutureBuilder<bool>(
          future: _loadBackgroundImage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text('Error loading background image'));
            } else {
              return const BackgroundImageWidget(appTitle: appTitle);
            }
          },
        ),
      ),
    );
  }

  Future<bool> _loadBackgroundImage() async {
    // Simuler le chargement de l'image de fond
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}

class BackgroundImageWidget extends StatelessWidget {
  final String appTitle;

  const BackgroundImageWidget({super.key, required this.appTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              '../assets/7e0a5b7a16087c190c4e5413a1b1ea69.jpg'), // Chemin vers votre image de fond
          fit: BoxFit.cover, // Ajuste l'image pour couvrir tout l'écran
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedText(text: appTitle, delay: 0),
            const SizedBox(height: 20),
            const MyCustomForm(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Register',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Définition d'un widget custom Form
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Récupérer les valeurs des champs
      String email = _emailController.text;
      String password = _passwordController.text;

      // Comparer les valeurs avec les données du tableau
      bool isValid = false;
      for (var person in persons) {
        if (person.email == email && person.password == password) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
          isValid = true;
          break;
        }
      }

      if (isValid) {
        // Afficher un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );
      } else {
        // Afficher un message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }

      // Vider les champs après la soumission
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 300, // Réduire la largeur du formulaire
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedTextFormField(
                  controller: _emailController,
                  labelText: 'Email',
                  delay: 2,
                  prefixIcon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                AnimatedTextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  labelText: 'Password',
                  delay: 4,
                  prefixIcon: Icons.lock,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                AnimatedElevatedButton(
                  onPressed: _submit,
                  delay: 6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Création d'une classe Person
class Person {
  final String email;
  final String password;

  // Constructeur
  Person({required this.email, required this.password});
}

// Créer une liste d'objets Person
List<Person> persons = [
  Person(email: 'toto@gmail.com', password: 'azerty'),
  Person(email: 'toto2@gmail.com', password: 'azerty2'),
];
