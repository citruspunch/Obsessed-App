const String apiUrl = 'https://fakestoreapi.com';
const String productsEndpoint = '/products';
const String productsUrl = '$apiUrl$productsEndpoint';
const int firstNonUsableItem = 4;
const int lastNonUsableItem = 14;
const String countriesApiUrl = 'https://countriesnow.space/api/v0.1/countries/capital';
const String citiesApiUrl = 'https://countriesnow.space/api/v0.1/countries';
bool validateEmail(String email) {
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  return emailRegex.hasMatch(email);
}
const int initialStock = 10;