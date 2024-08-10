import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddAlbumPage extends StatefulWidget {
  const AddAlbumPage({super.key});

  @override
  State<AddAlbumPage> createState() => _AddAlbumPageState();
}

class _AddAlbumPageState extends State<AddAlbumPage> {
  final TextEditingController nombreAlbumController = TextEditingController();
  final TextEditingController nombreBandaController = TextEditingController();

  final firestore = FirebaseFirestore.instance;

  final TextEditingController anioLanzamientoController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Añadir album'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomInput(
                controller: nombreAlbumController,
                label: "Nombre de album",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }

                  return null;
                },
              ),
              CustomInput(
                  controller: nombreBandaController,
                  label: "Nombre de banda",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El nombre es obligatorio';
                    }

                    return null;
                  }),
              CustomInput(
                  controller: anioLanzamientoController,
                  label: "Año de lanzamiento",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El nombre es obligatorio';
                    }

                    return null;
                  }),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      final albumDeRock = {
                        'nombreAlbum': nombreAlbumController.text,
                        'nombreBanda': nombreBandaController.text,
                        'anioLanzamiento': anioLanzamientoController.text,
                        'votos': 0
                      };

                      firestore.collection('albumesCV').add(albumDeRock);

                      Navigator.pop(context);
                    },
                    child: Text('subir a votacion')),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.controller,
    required this.label,
    this.icon = Icons.person,
    this.obscureText = false,
    this.maxLength = 20,
    this.errorText,
    this.keyboardType = TextInputType.text,
    required this.validator,
  });

  final String label;
  final IconData icon;
  final bool obscureText;
  final int maxLength;
  final String? errorText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: 'Ingrese su $label',
        // prefix: Icon(Icons.person),
        // error: Icon(Icons.error),
        // errorText: errorText,
        //? InkResponse, Inkwel, GestureDetector => proporcionan interactividad con
        //? cualquier widget que no tenga posibilidad de detectar eventos
        suffix: InkResponse(
          splashColor: Colors.teal[50],
          // muestra un efecto de Ripple
          onTap: () {
            print('Mostrar contraseña');
          },
          child: const Icon(
            Icons.remove_red_eye,
          ),
        ),
        //  como hago para darle funcionalidad?
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        icon: Icon(icon),
        label: Text(label),
      ),
      maxLength: maxLength,
      // maxLines: 3, // Textarea
    );
  }
}
