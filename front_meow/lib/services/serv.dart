import 'dart:io';

class Http {
  static String url =
      "https://cookiebeco.roney.stein.nom.br/v1"; // colocar a url da api
  static String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImxmNDQ2NTRAZ21haWwuY29tIiwibmFtZWlkIjoiMTUiLCJuYmYiOjE3NjA2MTE3MjQsImV4cCI6MTc2MDY0NzcyNCwiaWF0IjoxNzYwNjExNzI0fQ.hvcoxXGDSQhqfKoG82tLYd2WrocczbLPPyUmwaS_Uk8";
  static Map<String, String> get headers => {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  };

  /*

  para chamar nas telas:

  const Http = Http(); // classe http para usar as rotas

  var usuarios = await Http.fetchUsuarios();

  // ou

  await Http.fetchUsuarios().then((value) {
    usuarios = value;
  });

  print(usuarios[0].nome);


  */
}
