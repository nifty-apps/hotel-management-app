class AppConstants {
  static const String APP_NAME = 'Hotel Management';
  static const int APP_VERSION = 1;
  // static const baseUrl = 'http://13.212.32.168/api';
  static const baseUrl = 'http://192.168.0.175:4001/api';
  static const registraionUrl = '$baseUrl/auth/registration';
  static const loginUrl = '$baseUrl/auth/login';
  static const hotelAddUrl = '$baseUrl/hotels';
  static const dashboardInfo = '$baseUrl/dashboard/info';
  static const addroomUrl = '$baseUrl';
  static const totalRoom = '$baseUrl/rooms';
  static const roomBooking = '$baseUrl/rooms';
  static const recentBookingRooms = '$baseUrl/rooms/recent/bookings';
  static const todayBookingRooms = '$baseUrl/rooms/todays/bookings';
  static const updateRoomInfo = '$baseUrl/rooms';
  static const deleteRoom = '$baseUrl/rooms';
  static const roomTypeInfo = '$baseUrl/admin/room/searching/room_type/wise';
  // static const roomBooking = '$baseUrl/admin/room/booking/store';
  static const searchRoom = '$baseUrl/admin/room/searching';
  static const collectionsReport = "$baseUrl/admin/report/collection";
  static const transaction = '$baseUrl/admin/report/transaction';
  static const paymentUpdate =
      '$baseUrl/admin/room/booking/update/payment_and_status';
  static const getRooms = '$baseUrl/admin/room/type_wise/available';
  static const getBookingDetails = '$baseUrl/admin/room/single/booking/list';
  static const bookingUpdate = '$baseUrl/admin/room/booking/update';
  static const adminProfile = '$baseUrl/admin/profile';
  static const employee = '$baseUrl/users';

  // final Map<String, String> roomTypes = {
  //   'single': 'Single',
  //   'doubleDulux': 'Double Delux',
  // };
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
