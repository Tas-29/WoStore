class API {
  static final String serverUrl = "http://193.161.193.99:61401";
  // static final String serverUrl = "http://192.168.0.104:3001";
  static final String getOtp = "$serverUrl/customer/otp";
  static final String register = "$serverUrl/customer/register";
  static final String login = "$serverUrl/customer/login";
  static final String getImage = "$serverUrl/get-image?name=";
  static final String getCategories = "$serverUrl/category/get-active-category";
  static final String getProductsByCategory = "$serverUrl/product/get-product";
  static final String getAllDeals = "$serverUrl/deal/get-all-deals";
  static final String createOrder = "$serverUrl/order/create-order";
  static final String updatePayment = "$serverUrl/order/order-success";
  static final String getOrders = "$serverUrl/order/get-orders";
}