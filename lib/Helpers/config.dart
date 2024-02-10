class Config {
  //// Api /////
  ///روابط الapi
//  static String baseUrl = "http://188.212.124.95";
  static String baseUrl = "https://10.0.2.2:7282";
  static String loginApi = "/api/Registrations/login";
  static String registerApi = "/api/Registrations/Registration";
  static String getRegionsApi = '/api/Zones/GetRegions';
  static String getCentersByRegionIdApi = '/api/Zones/GetCenterByRegionCode/';
  static String getDistrictByCenterIdApi =
      '/api/Zones/GetDistrictByCenterCode/';
  static String getNationalities = "/api/Nationality";
  static String userProfile = "/api/Registrations/UserProfile";
}
