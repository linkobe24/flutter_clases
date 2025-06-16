import 'dart:io';

import 'package:favourite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, "places.db"),
      onCreate: (db, version) {
    return db.execute(
        "CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL,  lng REAL, address TEXT)");
  }, version: 1);

  return db;
}

class UserPlacesNotificer extends StateNotifier<List<Place>> {
  UserPlacesNotificer() : super(const []); // estado inicial - no es mutable

  Future<void> loadPlaces() async {
    final db = await getDatabase();
    final data = await db.query("user_places");
    final places = data
        .map(
          (row) => Place(
            id: row["id"] as String,
            title: row["title"] as String,
            image: File(row["image"] as String),
            location: PlaceLocation(
                latitude: row["lat"] as double,
                longitude: row["lng"] as double,
                address: row["address"] as String),
          ),
        )
        .toList();
    state = places;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    //  por defecto la imagen se almacena en un lugar donde los datos
    // se eliminan para ahorrar memoria

    // obtener el path donde pueda guardar datos
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    // extrae el nombre del archivo
    final filename = path.basename(image.path);
    // copia la imagen a la carpeta interna
    final copiedImage = await image.copy("${appDir.path}/$filename");

    final newPlace = Place(
      title: title,
      image: copiedImage,
      location: location,
    );

    final db = await getDatabase();

    db.insert("user_places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "lat": newPlace.location.latitude,
      "lng": newPlace.location.longitude,
      "address": newPlace.location.address
    });

    state = [newPlace, ...state]; //state es proporcionado por StateNotifier
  }

  void deletePlace(Place place) async {
    final db = await getDatabase();

    // borrar imagen
    final imageFile = File(place.image.path);
    if (await imageFile.exists()) {
      await imageFile.delete();
    }

    await db.delete(
      "user_places",
      where: "id = ?",
      whereArgs: [place.id],
    );

    state = state.where((p) => p.id != place.id).toList();
  }
}

// para leer y escuchar el estado gestionado por UserPlacesNotifier
final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotificer, List<Place>>(
        (ref) => UserPlacesNotificer());
