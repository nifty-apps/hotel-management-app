class AppConstants {
  static const String APP_NAME = 'Hotel Management';
  static const int APP_VERSION = 1;
  // static const baseUrl = 'http://13.212.32.168/api';
  static const baseUrl = 'http://192.168.0.174:4001/api';
  static const registraionUrl = '$baseUrl/auth/registration';
  static const loginUrl = '$baseUrl/auth/login';
  static const hotelAddUrl = '$baseUrl/hotels';
  static const dashboardInfo = '$baseUrl/dashboard/info';
  static const addroomUrl = '$baseUrl';
  static const totalRoom = '$baseUrl/rooms';
  static const availableRooms = '$baseUrl/rooms/available';
  static const roomBooking = '$baseUrl/rooms/bookings';
  static const recenRoombookins = '$baseUrl/rooms/bookings/recent';
  static const getRoomBookings = '$baseUrl/rooms/bookings/checkin';
  static const todayBookingRooms = '$baseUrl/rooms/todays/bookings';
  static const updateRoomInfo = '$baseUrl/rooms';
  static const deleteRoom = '$baseUrl/rooms';
  static const getBookingDetails = '$baseUrl/rooms/bookings/details';
  static const updateBookingInfo = '$baseUrl/rooms/bookings';
  static const transaction = '$baseUrl/transactions';
  static const roomTypeInfo = '$baseUrl/admin/room/searching/room_type/wise';
  static const searchRoom = '$baseUrl/admin/room/searching';
  static const collectionsReport = "$baseUrl/admin/report/collection";
  static const paymentUpdate =
      '$baseUrl/admin/room/booking/update/payment_and_status';
  static const getRooms = '$baseUrl/admin/room/type_wise/available';
  static const adminProfile = '$baseUrl/admin/profile';
  static const employee = '$baseUrl/users';
  static const roomType = '$baseUrl/room/type';
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

enum PageType {
  checkin,
  checkout,
  confirm,
}
