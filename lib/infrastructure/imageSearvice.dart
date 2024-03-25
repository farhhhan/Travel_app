import 'package:image_picker/image_picker.dart';

class ImagePickerServices{
  final picker=ImagePicker();
  Future<XFile?> getimageFromCamera()async{
    final file=await picker.pickImage(source: ImageSource.camera);
    return file;
  }
  Future<XFile?> getimageFromGellary()async{
    final file=await picker.pickImage(source: ImageSource.gallery);
    return file;
  }
  Future< List<XFile>?> getMultiImagePciker()async{
    List<XFile> file=await picker.pickMultiImage();
    return file;
  }
}