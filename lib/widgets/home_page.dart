import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final albumesRef = FirebaseFirestore.instance.collection('albumesCV');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Albumes de rock'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: albumesRef.snapshots(),
        builder: ((BuildContext conext,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final query = snapshot.data;

          final listaAlbumes = query!.docs;

          return ListView.builder(
              itemCount: listaAlbumes.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text("Nombre de Album: "+listaAlbumes[index]['nombreAlbum']),
                    subtitle: Text("Nombre de la banda: "+ listaAlbumes[index]['nombreBanda']),
                    trailing: Text("Año: " + listaAlbumes[index]['anioLanzamiento']));
                    

              });
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addAlbum');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
