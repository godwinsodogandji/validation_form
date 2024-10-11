import 'package:flutter/material.dart';
import 'animated_elevated_button.dart';
import 'animated_text.dart';
import 'animated_text_form_field.dart';

import 'main.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _loadBackgroundImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error loading background image'));
          } else {
            return const BackgroundImageWidget(appTitle: 'Register');
          }
        },
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
            const MyCustomRegisterForm(),
          ],
        ),
      ),
    );
  }
}

// Définition d'un widget custom Form
class MyCustomRegisterForm extends StatefulWidget {
  const MyCustomRegisterForm({super.key});

  @override
  MyCustomRegisterFormState createState() {
    return MyCustomRegisterFormState();
  }
}

class MyCustomRegisterFormState extends State<MyCustomRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Récupérer les valeurs des champs
      String email = _emailController.text;
      String password = _passwordController.text;
      String confirmPassword = _confirmPasswordController.text;

      // Vérifier si les mots de passe correspondent
      if (password == confirmPassword) {
        // Enregistrer les nouvelles informations de l'utilisateur
        persons.add(Person(email: email, password: password));

        // Afficher un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful')),
        );

        // Vider les champs après la soumission
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();

        // Naviguer vers la page de connexion
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
        );
      } else {
        // Afficher un message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
      }
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
                const SizedBox(height: 16.0),
                AnimatedTextFormField(
                  obscureText: true,
                  controller: _confirmPasswordController,
                  labelText: 'Confirm Password',
                  delay: 6,
                  prefixIcon: Icons.lock,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez confirmer votre password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                AnimatedElevatedButton(
                  onPressed: _submit,
                  delay: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
