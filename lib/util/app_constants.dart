class AppConstants {
  static const String APP_NAME = 'Hotel Management';
  static const int APP_VERSION = 1;
  // static const baseUrl = 'http://13.212.32.168/api';
  static const baseUrl = 'http://192.168.0.174:4001/api';
  static const registraionUrl = '$baseUrl/auth/registration';
  static const loginUrl = '$baseUrl/auth/login';
  static const sendOtp = '$baseUrl/auth/send-otp';
  static const verifyOtp = '$baseUrl/auth/verify-otp';
  static const hotelAddUrl = '$baseUrl/hotels';
  static const dashboardInfo = '$baseUrl/dashboard/info';
  static const addroomUrl = '$baseUrl';
  static const totalRoom = '$baseUrl/rooms';
  static const availableRooms = '$baseUrl/rooms/available';
  static const checkRooms = '$baseUrl/rooms/available/check';
  static const roomBooking = '$baseUrl/rooms/bookings';
  static const recenRoombookins = '$baseUrl/rooms/bookings/recent';
  static const getRoomBookings = '$baseUrl/rooms/bookings/checkin';
  static const todayBookingRooms = '$baseUrl/rooms/todays/bookings';
  static const updateRoomInfo = '$baseUrl/rooms';
  static const getRoomsReport = '$baseUrl/rooms/bookings/report';

  static const deleteRoom = '$baseUrl/rooms';
  static const getBookingDetails = '$baseUrl/rooms/bookings/details';
  static const updateBookingInfo = '$baseUrl/rooms/bookings';
  static const transaction = '$baseUrl/transactions';
  static const getRevenue = '$baseUrl/transactions/history';
  static const getListOfCustomer = '$baseUrl/rooms/bookings/customers';
  static const getListOfCustomerBookings =
      '$baseUrl/rooms/bookings/customer/list';

  static const roomTypeInfo = '$baseUrl/admin/room/searching/room_type/wise';
  static const searchRoom = '$baseUrl/admin/room/searching';
  static const collectionsReport = "$baseUrl/admin/report/collection";
  static const getRooms = '$baseUrl/admin/room/type_wise/available';
  static const adminProfile = '$baseUrl/admin/profile';
  static const user = '$baseUrl/users';
  static const roomType = '$baseUrl/room/type';
  static const updateHotelInfo = '$baseUrl/hotels';
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
