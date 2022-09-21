import 'dart:io';

import 'package:dio/dio.dart';

class SendData {

  // upload(File imageFile) async {
  //   // open a byteStream
  //   var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  //   // get file length
  //   var length = await imageFile.length();
  //
  //   // string to uri
  //   var uri = Uri.parse("https://127.0.0.1:5000");
  //
  //   // create multipart request
  //   var request = http.MultipartRequest("POST", uri);
  //
  //   // multipart that takes file
  //   var multipartFile = http.MultipartFile('file', stream, length,
  //       filename: basename(imageFile.path));
  //
  //   // add file to multipart
  //   request.files.add(multipartFile);
  //
  //   // send
  //   var response = await request.send();
  //   //print(response.statusCode);
  //
  //   // listen for response
  //   response.stream.transform(utf8.decoder).listen((value) {
  //     //print(value);
  //   });
  // }

  // sendSkinChest(String url, File image) async {
  //   try {
  //     var uploadRequest = http.MultipartRequest('POST', Uri.parse(url));
  //     await http.MultipartFile.fromPath('POST', image.path);
  //
  //     final streamedResponse = await uploadRequest.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //
  //     if (response.statusCode == 200) {
  //       //print('uploaded');
  //       return null;
  //     }
  //   } catch (error) {
  //     //print(error);
  //   }
  // }
  //
  // sendDiabetes(String url, String gender, int age, String weight,
  //     String polyuria, String alopecia, String polydipsia) async {
  //   try {
  //     var response = await http.post(Uri.parse(url), body: {
  //       'gender' : gender,
  //       'age' : age,
  //       'weight' : weight,
  //       'polyuria' : polyuria,
  //       'polydipsia' : polydipsia,
  //       'alopecia' : alopecia,
  //     });
  //     print(response.statusCode);
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  Future<String> dioUploadImage(File file, String type) async {
    String fileName = file.path.split('/').last;
    Response response;
    FormData formData = FormData.fromMap({
      //depend on which page
      'api': '/skin',
      "file":
      await MultipartFile.fromFile(file.path, filename:fileName),
    });
    try{
      response = await Dio().post('http://192.168.1.8/submit', data: formData);
      print(response.statusCode);
    }on DioError catch(err) {
      print(err);
    }

    return response.data['id'];
  }

  dioDiabetes() async{
    var response = await Dio().post(
      'http://192.168.1.8/submit',
      data: {
        "userId" : 2,
        "id" : 2,
        "title" : "sdgkmss",
        "body" : "polyuria",
      },
    );
    print(response.statusCode);
  }
}
