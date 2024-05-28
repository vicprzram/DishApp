import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../utilities/Utilities.dart';

class RecipeManagement {
  static void pushRecipe(Recipe recipe) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    String? user = recipe.user;
    String fileURL = "";
    final refStorage = FirebaseStorage.instance.ref("images/$time-$user");
    CollectionReference users = FirebaseFirestore.instance.collection('recipes');

    try{
      await refStorage.putFile(recipe.image);
      fileURL = await refStorage.getDownloadURL() as String;

      await users.add({
        'user': user,
        'image': fileURL,
        'title': recipe.title,
        'description': recipe.description,
        'time': recipe.time,
        'timer': recipe.timer,
        'diners': recipe.diners,
        'ingredients': recipe.ingredients,
        'steps': recipe.steps
      });
    } on FirebaseException catch(e){
      print(e);
    }
  }
}