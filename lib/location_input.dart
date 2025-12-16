import "package:favourite_places/blueprint.dart";
import "package:favourite_places/map.dart";
import 'package:flutter/material.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:location/location.dart";
import "package:http/http.dart" as http;
import "dart:convert";
class LocationInput extends StatefulWidget
{
  const LocationInput(this.onSelectLocation, {super.key});
   final void Function(PlaceLocation location) onSelectLocation;
  @override
  State<LocationInput> createState() {
    
    return _LocationInputState();
  }
}
class _LocationInputState extends State<LocationInput>
{
  PlaceLocation? pickedLocation;
  var isGettingLocation=false;
  String get locationImage{
    if(pickedLocation==null)
    {
      return ''; 
    }
    final lat=pickedLocation!.latitude;
    final lng =pickedLocation!.longitude;
    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:AS%7C$lat,$lng&key=YOUR_API_KEY";
  }

  void getCurrentLocation () async
  {
    
   
    Location location = Location();

bool serviceEnabled;
PermissionStatus permissionGranted;
LocationData locationData;

serviceEnabled = await location.serviceEnabled();
if (!serviceEnabled) {
  serviceEnabled = await location.requestService();
  if (!serviceEnabled) {
    return;
  }
}

permissionGranted = await location.hasPermission();
if (permissionGranted == PermissionStatus.denied) {
  permissionGranted = await location.requestPermission();
  if (permissionGranted != PermissionStatus.granted) {
    return;
  }
}
setState(() {
       isGettingLocation=true;
    });

locationData = await location.getLocation();
final lat=locationData.latitude;
final lng=locationData.longitude;

if(lat==null || lng==null)
{
  return;
}
savePlace(lat, lng);

  }

  Future<void> savePlace(double lat, double lng) async
  {
    final url=Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=YOUR_API_KEY");
final response=await http.get(url);
final resData=json.decode(response.body);
final address=resData['results'][0]["formatted_address"];

final loc = PlaceLocation(lat, lng, address);

setState(() {
  pickedLocation = loc;
  isGettingLocation = false;
});

widget.onSelectLocation(loc);
  }


  void selectOnMap() async
  {
    final pickedLocation= await Navigator.of(context).push<LatLng>(MaterialPageRoute(builder: (ctx)=>MapScreen()));
    if(pickedLocation==null)
    {
      return;
    }
    savePlace(pickedLocation.latitude, pickedLocation.longitude);

  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent=Text("No Loaction Chosen", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color:Theme.of(context).colorScheme.onBackground),);

    if(pickedLocation!=null)
    {
      previewContent=Image.network(locationImage, fit: BoxFit.cover, width: double.infinity,height:double.infinity);
    }
    if(isGettingLocation)
    {
      previewContent=const CircularProgressIndicator();
    }

    return Column(children: [
      Container(
        height: 170,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
        border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary.withOpacity(0.2))
      ),
      child: previewContent
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(icon: const Icon(Icons.location_on), onPressed: getCurrentLocation, label: Text("Get Current Location")),
          TextButton.icon(icon: const Icon(Icons.map), onPressed: selectOnMap, label: Text("Select on map"))
        ],
      )
    ],);
  }
}