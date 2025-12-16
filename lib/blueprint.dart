import "package:uuid/uuid.dart";
import "dart:io";
final uuid=Uuid();

class Place
{
    Place(this.title, this.image, this.location): id=uuid.v4();
    final String id;
    final String title;
    final File image;
    final PlaceLocation location;
}

class PlaceLocation
{
    const PlaceLocation(this.latitude, this.longitude, this.address);
    final double latitude;
     final double longitude;
     final String address;

}