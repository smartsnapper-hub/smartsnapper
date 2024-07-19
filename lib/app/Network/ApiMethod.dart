
import 'ApiUrl.dart';

class ApiMethods {
  static String apiRegistry() {
    return AppUrl.apiRegistry;
  }

  static String aliasData() {
    return AppUrl.baseUrl + AppUrl.aliasData;
  }

  static String aliasData2() {
    return AppUrl.baseUrl + AppUrl.aliasData2;
  }

  static String testingServer() {
    return AppUrl.baseUrl;
  }

  static String recordAudio() {
    return AppUrl.baseUrl + AppUrl.recordAudio;
  }

  static String takeSnap() {
    return AppUrl.baseUrl + AppUrl.takeSnap;
  }
  static String takePhoto() {
    return AppUrl.baseUrl + AppUrl.takePhoto;
  }
  static String videoWithout() {
    return AppUrl.baseUrl + AppUrl.sendVideoWithout;
  }
  static String videoWith() {
    return AppUrl.baseUrl + AppUrl.sendVideoWith;
  }
  static String screenWithAudio() {
    return AppUrl.baseUrl + AppUrl.screenWithAudio;
  }

  static String screenWithoutAudio() {
    return AppUrl.baseUrl + AppUrl.screenWithoutAudio;
  }

  static String geoSnap() {
    return AppUrl.baseUrl + AppUrl.geoSnap;
  }

  static String signUp() {
    return AppUrl.baseUrl + AppUrl.signUp;
  }
  static String loginUser() {
    return AppUrl.baseUrl + AppUrl.login;
  }
  static String updateProfileOfUser() {
    return AppUrl.baseUrl + AppUrl.updateProfile;
  }

  static String getProfileOfUser() {
    return AppUrl.baseUrl + AppUrl.getProfile;
  }
  static String getAllAlias() {
    return AppUrl.baseUrl + AppUrl.getAllAlias;
  }
  static String updateAvatar() {
    return AppUrl.baseUrl + AppUrl.updateAvatar;
  }
  static String getManualSnap() {
    return AppUrl.sendManualSnap;
  }
  static String submitSnapReport() {
    return AppUrl.baseUrl + AppUrl.submitSnapReport;
  }
  //Header
  static Map<String, String> XformHeader() {
    return {
      'X-User': 'customer',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  }

  

  static Map<String, String> XUserHeader() {
    return {
      'X-User': 'customer',
    };
  }

  static Map<String, String> JsonHeader() {
    return {
      'X-User': 'customer',
      'Content-Type': 'application/json; charset=UTF-8'
    };
  }

  static Map<String, String> JsonAcceptHeader() {
    return {
      'X-User': 'customer',
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  }
}
