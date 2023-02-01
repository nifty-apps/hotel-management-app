class AppConstants {
  static const String APP_NAME = 'Hotel Management';
  static const int APP_VERSION = 1;
  static const baseUrl = 'http://192.168.0.174:4000/api';
  static const registraionUrl = '$baseUrl/auth/registration';
  static const loginUrl = '$baseUrl/auth/login';
  static const roomTypeInfo = '$baseUrl/admin/room/searching/room_type/wise';
  static const totalRoom = '$baseUrl/api/v1/admin/room/list';
  static const roomBooking = '$baseUrl/admin/room/booking/store';
  static const searchRoom = '$baseUrl/admin/room/searching';
  static const collectionsReport = "$baseUrl/admin/report/collection";
  static const transaction = '$baseUrl/admin/report/transaction';
  static const paymentUpdate =
      '$baseUrl/admin/room/booking/update/payment_and_status';
  static const getRooms = '$baseUrl/admin/room/type_wise/available';
  static const getBookingDetails = '$baseUrl/admin/room/single/booking/list';
  static const bookingUpdate = '$baseUrl/admin/room/booking/update';
  static const adminProfile = '$baseUrl/admin/profile';
}
