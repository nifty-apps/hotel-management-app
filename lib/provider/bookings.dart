import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_management/models/available_room.dart' as booking;
import 'package:hotel_management/models/booking.dart';
import 'package:hotel_management/models/booking_details.dart';
import 'package:hotel_management/models/customer.dart';
import 'package:hotel_management/models/room_booking.dart';
import 'package:hotel_management/util/app_constants.dart';
import 'package:hotel_management/utils/api_client.dart';

class BookingProvider extends ChangeNotifier {
  final Ref ref;
  BookingProvider(this.ref);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController discountController = TextEditingController(text: '0');
  TextEditingController advanceController = TextEditingController(text: '0');

  List<booking.Room> allRoom = [];
  DateTime? checkIn = DateTime.now();
  DateTime? checkOut = DateTime.now();
  int total = 0;
  String status = '';

  List<booking.AvailableRoom> _availableRooms = [];
  List<booking.AvailableRoom> get availableRooms => _availableRooms;

  List<Bookings> _bookingList = [];
  List<Bookings> get bookingList => _bookingList;

  List<CustomerInfo> _listOfCustomer = [];
  List<CustomerInfo> get listOfCustomer => _listOfCustomer;

  late BookingDetails _bookingDetails ;
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
  Future<bool> getAvailableRooms(
      {required DateTime fromDate, required DateTime toDate}) async {
    _isLoading = true;
    notifyListeners();
    final response = await ref.read(apiClientProvider).get(
        '${AppConstants.availableRooms}?fromDate=${fromDate.toUtc()}&toDate=${toDate.toUtc()}');
    if (response.statusCode == 200) {
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
      _bookingList = response.data['data']
          .map<Bookings>((booking) => Bookings.fromMap(booking))
          .toList();

      return _bookingList;
    }

    return null;
  }

  // Get Bookings List
  Future<List<Bookings>> getBookingsList({
    required DateTime checkinDate,
    required DateTime checkoutDate,
    required String status,
  }) async {
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
  Future<bool> getBookingDetails({required String id}) async {
    _isLoading = true;
    notifyListeners();
    final response = await ref
        .read(apiClientProvider)
        .get('${AppConstants.getBookingDetails}/$id');
    if (response.statusCode == 200) {
      _bookingDetails = BookingDetails.fromMap(response.data['data']);
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

// Update checkout date
  Future<bool> updateCheckoutDate(
      {required String id, required DateTime date}) async {
    print(date);
    final response = await ref.read(apiClientProvider).put(
      '${AppConstants.updateBookingInfo}/$id',
      data: {'checkOut': date.toUtc().toIso8601String()},
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  // get list of customer
  Future<bool> getListOfCustomer(String? phoneNumber) async {
    print(phoneNumber);
    _isLoading = true;
    notifyListeners();
    String url = AppConstants.getListOfCustomer;
    if (phoneNumber != '') {
      url = '${AppConstants.getListOfCustomer}?customerPhone=$phoneNumber';
    }
    final response = await ref.read(apiClientProvider).get(
          url,
        );
    if (response.statusCode == 200) {
      _listOfCustomer = response.data['data']
          .map<CustomerInfo>((customer) => CustomerInfo.fromMap(customer))
          .toList();
      _isLoading = false;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> getListOfCustomerBookings(String? phoneNumber) async {
    print('call API');
    _isLoading = true;
    notifyListeners();
    String url = AppConstants.getListOfCustomerBookings;
    if (phoneNumber != '') {
      url =
          '${AppConstants.getListOfCustomerBookings}?customerPhone=$phoneNumber';
    }
    final response = await ref.read(apiClientProvider).get(
          url,
        );
    if (response.statusCode == 200) {
      _listOfCustomer = response.data['data']
          .map<CustomerInfo>((customer) => CustomerInfo.fromMap(customer))
          .toList();
      _isLoading = false;
      notifyListeners();
      return true;
    }
    return false;
  }

  // check rooms availability
  Future<List<booking.Room>> checkRoomsAvailability(
      {required DateTime checkoutDate,
      required DateTime extendsCheckoutDate,
      required List<String> roomIds}) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await ref
          .read(apiClientProvider)
          .get(AppConstants.checkRooms, query: {
        'checkoutDate': checkoutDate.toUtc().toIso8601String(),
        'extendsCheckoutDate': extendsCheckoutDate.toUtc().toIso8601String(),
        'roomIds': roomIds,
      });
      if (response.statusCode == 200) {
        _isLoading = false;
        notifyListeners();
        final data = response.data['data']
            .map<booking.Room>((room) => booking.Room.fromMap(room))
            .toList();
        print(data);
        return data;
      } else if (response.statusCode == 404) {
        print(response.data['message']);
        _isLoading = false;
      }
      return [];
    } catch (error) {
      _isLoading = false;
      return [];
    }
  }
}

final bookingProvider =
    ChangeNotifierProvider<BookingProvider>((ref) => BookingProvider(ref));
