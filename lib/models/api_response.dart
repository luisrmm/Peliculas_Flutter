class ApiResponse {
  // _data will hold any response converted into 
  // its own object. For example user.
  var _data = new Object();
  // _apiError will hold the error object

  Object get Data => _data;
  set Data(Object data) => _data = data;
}