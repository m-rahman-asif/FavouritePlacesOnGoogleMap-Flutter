import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; 

class ImageInput extends StatefulWidget
{
  const ImageInput (this.onPickImage, {super.key});
  final void Function(File image)  onPickImage;
  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}
class _ImageInputState extends State<ImageInput>
{
  File? selectedImage;
  void takePicture() async{
    final pickedImage=await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 600);
          if (pickedImage==null)
            {
              return;
            }
            final imagefile=File(pickedImage.path);
            setState(() {
              selectedImage=imagefile;
            });   
            widget.onPickImage(imagefile);
  }
  
  @override
  Widget build(BuildContext context) {
    
    Widget content=TextButton.icon(onPressed: takePicture, 
        label: Text("Take Picture"), icon: Icon(Icons.camera));
    if (selectedImage!=null)
    {
      content=GestureDetector(onTap: takePicture, child: Image.file(selectedImage!, fit: BoxFit.cover, height:double.infinity, width: double.infinity));
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary.withOpacity(0.2))
      ),
      height: 250, width: double.infinity, alignment: Alignment.center,
      child: content
      );     
  }
}