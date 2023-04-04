import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/available_room.dart' as booking;
import 'package:hotel_management/models/booking.dart';
import 'package:hotel_management/models/booking_details.dart';
import 'package:hotel_management/models/room_booking.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';

class BookingProvider extends ChangeNotifier {
  final Ref ref;
  BookingProvider(this.ref);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController advanceController = TextEditingController();
  List<booking.Room> allRoom = [];
  DateTime? checkIn = DateTime.now();
  DateTime? checkOut = DateTime.now();
  int total = 0;
  String status = '';

  List<booking.AvailableRoom> _availableRooms = [];
  List<booking.AvailableRoom> get availableRooms => _availableRooms;

  List<Bookings> _bookingList = [];
  List<Bookings> get bookingList => _bookingList;

  late BookingDetails _bookingDetails;
  BookingDetails get bookingDetails => _bookingDetails;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // Booking
  Future<String?> roomBooking(
      RoomBooking bookingInfo, BuildContext context) async {
    final response = await ref.read(apiClientProvider).post(
          AppConstants.roomBooking,
          data: bookingInfo.toMap(),
        );
    if (response.statusCode == 201) {
      final String bookingId = response.data['data']['_id'];
      return bookingId;
    }
    return null;
  }

  // Get Available Rooms
  Future<bool> getAvailableRooms(String fromDate, String toDate) async {
    _isLoading = true;
    notifyListeners();
    final response = await ref.read(apiClientProvider).get(
        '${AppConstants.availableRooms}?fromDate=$fromDate&toDate=$toDate');
    if (response.statusCode == 200) {
      print(response.data['data']);
      _availableRooms = response.data['data']
          .map<booking.AvailableRoom>(
              (room) => booking.AvailableRoom.fromMap(room))
          .toList();
      _isLoading = false;
      notifyListeners();
      return true;
    }
    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Get Recent Bookings List
  Future<List<Bookings>?> getRecentBookings() async {
    final response =
        await ref.read(apiClientProvider).get(AppConstants.recenRoombookins);
    if (response.statusCode == 200) {
      _isLoading = false;
      print(response.data['data']);
      _bookingList = response.data['data']
          .map<Bookings>((booking) => Bookings.fromMap(booking))
          .toList();

      return _bookingList;
    }

    return null;
  }

  // Get Bookings List
  Future<List<Bookings>> getBookingsList(
    DateTime checkinDate,
    DateTime checkoutDate,
    String status,
  ) async {
    print(checkinDate);
    print(checkoutDate);
    print(status);
    _isLoading = true;
    notifyListeners();
    final response = await ref.read(apiClientProvider).get(
        "${AppConstants.getRoomBookings}?checkInDate=$checkinDate&checkOutDate=$checkoutDate&status=$status");
    if (response.statusCode == 200) {
      _bookingList = response.data['data']
          .map<Bookings>((booking) => Bookings.fromMap(booking))
          .toList();
      _isLoading = false;
      notifyListeners();
      return _bookingList;
    }
    _isLoading = false;
    notifyListeners();
    return [];
  }

  // Get Booking Details
  Future<bool> getBookingDetails(String id) async {
    _isLoading = true;
    notifyListeners();
    final response = await ref
        .read(apiClientProvider)
        .get('${AppConstants.getBookingDetails}/$id');
    if (response.statusCode == 200) {
      _bookingDetails = BookingDetails.fromMap(response.data['data']);
      print(_bookingDetails);
      _isLoading = false;
      notifyListeners();
      return true;
    }
    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Update Booking Status
  Future<bool> updateBookingStatus(
      {required String id, required String status}) async {
    final response = await ref.read(apiClientProvider).put(
      '${AppConstants.updateBookingInfo}/$id',
      data: {'status': status},
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  // Update payment status
  Future<bool> updatePaymentStatus(
      {required String id, required String status}) async {
    final response = await ref.read(apiClientProvider).put(
      '${AppConstants.updateBookingInfo}/$id',
      data: {'paymentStatus': status},
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}

final bookingProvider =
    ChangeNotifierProvider<BookingProvider>((ref) => BookingProvider(ref));
