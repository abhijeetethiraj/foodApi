class ApiResponse<T> {
  final T? data;
  final String? erroMessage;
  final bool isSuccess;

  ApiResponse.success(this.data) : isSuccess = true, erroMessage = null;

  ApiResponse.error(this.erroMessage) : isSuccess = false, data = null;
}
