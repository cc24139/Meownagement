import 'dart:io';

class Http {
  static String url =
      "https://cookiebeco.roney.stein.nom.br/v1"; // colocar a url da api
  static String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJvbmV5LnN0ZWluQGdtYWlsLmNvbSIsIm5hbWVpZCI6IjExIiwibmJmIjoxNzYwMDExNTY4LCJleHAiOjE3NjAwNDc1NjgsImlhdCI6MTc2MDAxMTU2OH0.Eq4UDg5jBaOYO3Js-i4j5ilStXVtjW-ty-fU5nQekM8";
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
