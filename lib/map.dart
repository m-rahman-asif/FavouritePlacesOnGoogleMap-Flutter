import "package:favourite_places/blueprint.dart";
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
class MapScreen extends StatefulWidget
{
  const MapScreen({super.key, this.location=const PlaceLocation(37.422,-122.084,""), this.isSelecting=true});
  final PlaceLocation location;
  final bool isSelecting;
  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen>
{
  LatLng? pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting?"Pick your location":"Your location"),
        actions: [
          if(widget.isSelecting)
            IconButton(onPressed: (){
              Navigator.of(context).pop(pickedLocation);
            }, icon: Icon(Icons.save))
          
        ],
      ),
      body: GoogleMap(
        onTap: widget.isSelecting==false? null:(position){
          setState(() {
            pickedLocation=position;
          });
        },
        initialCameraPosition: CameraPosition(target: LatLng(widget.location.latitude, widget.location.longitude), zoom:16), markers: (pickedLocation==null && widget.isSelecting)? {}:{Marker(markerId: MarkerId('m1'), position: pickedLocation!=null? pickedLocation!: LatLng(widget.location.latitude, widget.location.longitude))}),
      
     );
  }

}

