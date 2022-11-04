class ApiConstants{
  static const baseUrl = "https://www.kayak.com";
  static const endPoint = "/h/mobileapis/directory/airlines";
  static const aPiBase = "$baseUrl$endPoint";

  static String imageUrl(String logoUrl)=> '$baseUrl$logoUrl';




}