import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = '8217E318-16C6-4E02-82E9-528CEF59986F';
const url = 'https://rest.coinapi.io/v1/exchangerate/';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'DOGE',
  'BNB',
];

class CoinData {
  Future fetchRateData(String selecetedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (var crypto in cryptoList) {
      http.Response response = await http.get(
        Uri.parse(
          '$url$crypto/$selecetedCurrency?apikey=$apiKey',
        ),
      );
      if (response.statusCode == 200) {
        dynamic prices = jsonDecode(response.body);
        double rate = prices['rate'];
        cryptoPrices[crypto] = rate.toStringAsFixed(2);
      } else {
        throw Exception('Problem fetching data : ${response.statusCode}');
      }
    }
    return cryptoPrices;
  }
}
