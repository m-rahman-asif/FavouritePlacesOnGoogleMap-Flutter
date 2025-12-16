import 'package:favourite_places/image_input.dart';
import 'package:favourite_places/location_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "dart:io";
import 'package:favourite_places/blueprint.dart';


class AddPlaceScreen extends StatefulWidget 
{
  const AddPlaceScreen({super.key});
  @override
  State<AddPlaceScreen> createState() 
  {
    return _AddPlaceScreen();
  }
}
class _AddPlaceScreen  extends State<AddPlaceScreen>
{
  final titleController=TextEditingController();
  File? selectedImage;
  PlaceLocation? selectedLocation;


  void savePlace()
  {
    if(titleController.text.isEmpty || selectedImage==null ||  selectedLocation == null)
    {
      return;
    }
    Navigator.of(context).pop({'title':titleController.text, 'image':selectedImage, 'location': selectedLocation,});
  }

  @override
  void dispose()
  {
    titleController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add new place"),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
        children: [
          TextField(style: TextStyle(color: Theme.of(context).colorScheme.onBackground), decoration: InputDecoration(labelText: "Title"),
          controller: titleController
          ),
          SizedBox(height: 16,),
          ImageInput((image)
          {
            setState(() {
              selectedImage=image;
            });
            }),

            SizedBox(height: 16,),
            LocationInput((location) {
  selectedLocation = location;
}),
          SizedBox(height: 16,),
          ElevatedButton.icon(icon: Icon(Icons.add), onPressed: savePlace, label: Text("Add Place")),
        ],
      ),) ,
    );
  }
}