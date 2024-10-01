import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../contact.dart';
import 'api_endpoints.dart';
import 'http_client.dart';

class CommonApiService {
  CommonApiService._privateConstructor();

  static final CommonApiService _apiServiceInstance = CommonApiService._privateConstructor();

  factory CommonApiService() {
    return _apiServiceInstance;
  }

  final HttpClient _httpClient = HttpClient();

  Future<http.Response> login(Map<dynamic, dynamic> loginReqBody) async {
    return _httpClient.postRequest(ApiEndpoints.login, body: loginReqBody);
  }
  Future<http.Response> microsoftLogin(Map<dynamic, dynamic> loginReqBody) async {
    return _httpClient.postRequest(ApiEndpoints.microsoftLogin, body: loginReqBody);
  }

  Future<http.Response> fetchContacts() async {
    return _httpClient.getRequest(ApiEndpoints.contacts);
  }

  Future<http.Response> createContact(Map<dynamic, dynamic> contactReqBody) async {
    return _httpClient.postRequest(ApiEndpoints.contacts,body: contactReqBody);
  }

  Future<http.Response> updateContact(id,Map<dynamic, dynamic> contactReqBody) async {
    return _httpClient.putRequest('${ApiEndpoints.contacts}$id/',body: contactReqBody);
  }

  Future<http.Response> deleteContact(int id) async {
    return _httpClient.deleteRequest('${ApiEndpoints.contacts}$id/');
  }

// Future<http.Response> getConclusionValue(String bearerToken) async {
//   return _httpClient.getRequest(ApiEndpoints.conclusion);
// }
//
// Future<http.Response> onboarding(Map<dynamic, dynamic> onboardingReqBody) async {
//   return _httpClient.putRequest(ApiEndpoints.onboarding, body: onboardingReqBody);
// }
//
// Future<http.Response> editProfile(Map<dynamic, dynamic> profileReqBody) async {
//   return _httpClient.putRequestWithoutLoader(ApiEndpoints.editProfile,body: profileReqBody);
// }
//
// Future<http.Response> getProfile(String bearerToken) async{
//   return _httpClient.getRequest(ApiEndpoints.getProfile);
// }
//
// Future<http.Response> getDailyConsumption(String bearerToken) async{
//   return _httpClient.getRequest(ApiEndpoints.getDailyConsumption);
// }
//
// Future<http.Response> dailyConsumption(Map<dynamic, dynamic> dailyConsumptionReqBody) async {
//   return _httpClient.postRequest(ApiEndpoints.dailyConsumption, body: dailyConsumptionReqBody);
// }
//
// Future<http.Response> generalDetail(Map<dynamic, dynamic> generalDetailReqBody) async {
//   return _httpClient.putRequestWithoutLoader(ApiEndpoints.generalDetail,body: generalDetailReqBody);
// }
//
// Future<http.Response> remainderDetail(Map<dynamic, dynamic> remainderDetailReqBody) async {
//   return _httpClient.putRequestWithoutLoader(ApiEndpoints.remainderDetail,body: remainderDetailReqBody);
// }
//
//
//
//
// Future<http.Response> terminateAccount(Map<dynamic, dynamic> profileReqBody, id) async {
//   return _httpClient.putRequest('${ApiEndpoints.terminateAccount}$id/terminate-account',body: profileReqBody);
// }
}
