import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';

class CloudinaryApi {
  static Future<CloudinaryResponse> upload(PickedFile image) async {
    String uploadPreset = "fwssbryh";
    String cloudName = "dtdmudf6z";

    try {
      final cloudinary = CloudinaryPublic(cloudName, uploadPreset);
      CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path,
              resourceType: CloudinaryResourceType.Image));
      return response;
    } on CloudinaryException {
      rethrow;
    }
  }
}