import 'package:favourite_places/add_place.dart';
import 'package:favourite_places/blueprint.dart';
import 'package:favourite_places/places_list.dart';
import 'package:flutter/material.dart';
import "dart:io";
class PlacesScreen extends StatefulWidget 
{
  PlacesScreen ({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  final List<Place> favoritePlaces = [];

  @override
  Widget build (BuildContext context)
  {

    return Scaffold(
      appBar: AppBar(
        title: Text("My Places"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed:()async{
              final  newPlaceData=await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddPlaceScreen()));
              if (newPlaceData==null)
              {
                return;
              }
              final Map<String, dynamic> data=newPlaceData as Map<String, dynamic>; 

              setState(() {
                favoritePlaces.add(Place(data['title'] as String, data['image'] as File, data['location'] as PlaceLocation,));
              });
              
            }
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlacesList(favoritePlaces),
      ) ,
    );
  }
}