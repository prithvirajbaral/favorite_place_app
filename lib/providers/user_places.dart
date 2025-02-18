import 'dart:io';

import 'package:favorite_place_app/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image) {
    final newPlace = Place(title: title, image: image);
    state = [newPlace, ...state];
  }
}


final userPlacesProvider = StateNotifierProvider<UserPlacesNotifier, List<Place>>((ref) => UserPlacesNotifier());



// storing the picked image locally



// Import necessary packages
// import 'dart:io'; // For handling file operations (e.g., image file handling)
// import 'package:flutter_riverpod/flutter_riverpod.dart'; // For Riverpod state management
// import 'package:path_provider/path_provider.dart' as syspaths; // For getting app-specific directories on the device
// import 'package:path/path.dart' as path; // For handling file paths

// import 'package:favorite_places/models/place.dart'; // Import the 'Place' model for creating Place objects

// // The UserPlacesNotifier class is a state notifier that manages the list of places
// // It extends StateNotifier<List<Place>> where List<Place> represents the current state of places.
// class UserPlacesNotifier extends StateNotifier<List<Place>> {
//   // Constructor that initializes the state as an empty list of places.
//   UserPlacesNotifier() : super(const []);

//   // Function to add a new place to the list
//   void addPlace(String title, File image, PlaceLocation location) async {
//     // Get the directory where the app can store files (documents directory)
//     final appDir = await syspaths.getApplicationDocumentsDirectory();

//     // Get the filename of the image (using path.basename to extract the filename)
//     final filename = path.basename(image.path);

//     // Copy the image to the app's document directory with the same filename
//     final copiedImage = await image.copy('${appDir.path}/$filename');

//     // Create a new Place object with the provided title, the copied image file, and the location
//     final newPlace = Place(title: title, image: copiedImage, location: location);

//     // Update the state by adding the new place at the beginning of the list
//     // The spread operator `...` allows adding the newPlace to the beginning of the current state.
//     state = [newPlace, ...state];
//   }
// }

// // Riverpod provider that exposes the UserPlacesNotifier
// // StateNotifierProvider allows you to create a provider for a state that can be mutated
// // It takes two generic parameters: the type of notifier and the type of state (in this case, List<Place>)
// final userPlacesProvider =
//     StateNotifierProvider<UserPlacesNotifier, List<Place>>(
//   // The provider creates an instance of UserPlacesNotifier
//   (ref) => UserPlacesNotifier(),
// );



//Database stored

// import 'dart:io';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:path_provider/path_provider.dart' as syspaths;
// import 'package:path/path.dart' as path;
// import 'package:sqflite/sqflite.dart' as sql;
// import 'package:sqflite/sqlite_api.dart';

// import 'package:favorite_places/models/place.dart';

// Future<Database> _getDatabase() async {
//   final dbPath = await sql.getDatabasesPath();
//   final db = await sql.openDatabase(
//     path.join(dbPath, 'places.db'),
//     onCreate: (db, version) {
//       return db.execute(
//           'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
//     },
//     version: 1,
//   );
//   return db;
// }

// class UserPlacesNotifier extends StateNotifier<List<Place>> {
//   UserPlacesNotifier() : super(const []);

//   Future<void> loadPlaces() async {
//     final db = await _getDatabase();
//     final data = await db.query('user_places');
//     final places = data
//         .map(
//           (row) => Place(
//             id: row['id'] as String,
//             title: row['title'] as String,
//             image: File(row['image'] as String),
//             location: PlaceLocation(
//               latitude: row['lat'] as double,
//               longitude: row['lng'] as double,
//               address: row['address'] as String,
//             ),
//           ),
//         )
//         .toList();

//     state = places;
//   }

//   void addPlace(String title, File image, PlaceLocation location) async {
//     final appDir = await syspaths.getApplicationDocumentsDirectory();
//     final filename = path.basename(image.path);
//     final copiedImage = await image.copy('${appDir.path}/$filename');

//     final newPlace =
//         Place(title: title, image: copiedImage, location: location);

//     final db = await _getDatabase();
//     db.insert('user_places', {
//       'id': newPlace.id,
//       'title': newPlace.title,
//       'image': newPlace.image.path,
//       'lat': newPlace.location.latitude,
//       'lng': newPlace.location.longitude,
//       'address': newPlace.location.address,
//     });

//     state = [newPlace, ...state];
//   }
// }

// final userPlacesProvider =
//     StateNotifierProvider<UserPlacesNotifier, List<Place>>(
//   (ref) => UserPlacesNotifier(),
// );
