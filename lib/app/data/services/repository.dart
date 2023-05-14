import 'package:dio/src/form_data.dart';

import '../../../core/enums/global_enums.dart';
import '../apis/api_endpoint.dart';
import '../providers/api_provider.dart';
import 'api_service.dart';
import 'prefrences.dart';

class Repository extends ApiProviders {
  var deviceId = Pref.readData(key: Pref.DEVICE_UNIQUE);

  @override
  Future uploadBaseApi(
      {required String endPoint,
      required Method method,
      required FormData map}) {
    throw UnimplementedError();
  }

  ///-------------------------Announcement Api---------------------///

  // Future<dynamic> requestAnnouncement({required String page}) async =>
  //     await tokenBaseApi(
  //             endPoint: AppUrl.ANNOUNCEMENT_API,
  //             method: Method.GET,
  //             map: {'page': page, 'is_active': "true", 'device_id': deviceId})
  //         .then((value) => value);

  ///-------------------------User Api-------------------------///
  Future<dynamic> requestLogin({required Map<String, dynamic> map}) async =>
      await commonApiCall(
              endPoint: AppUrl.LOGIN_URL, method: Method.POST, map: map)
          .then((value) => value);

  Future<dynamic> requestRegister({required Map<String, dynamic> map}) async =>
      await commonApiCall(
              endPoint: AppUrl.REGISTER_URL, method: Method.POST, map: map)
          .then((value) => value);

  Future<dynamic> getAllRoutes() async => await commonApiCall(
      endPoint: AppUrl.ALL_ROUTES_URL,
      method: Method.GET,
      map: {}).then((value) => value);

  /*
  body map
  {
    "fromlocation": "Dhaka",
    "tolocation": "Feni",
    "assign_date": "04/04/2023"
  }
  */
  Future<dynamic> getTripList({required Map<String, dynamic> map}) async =>
      await commonApiCall(
              endPoint: AppUrl.TRIP_LIST_URL, method: Method.GET, map: map)
          .then((value) => value);

  /*
  {
    "assign_trip_id": "5",
    "company_id": "1",
    "customer_id": "",
    "name": "",
    "gender": "",
    "phone": "",
    "email": "",
    "startpoint": "Dhaka",
    "endpoint": "Feni",
    "boarding_point": "TT.para2:00 AM",
    "dropping_point": "tangroad7:00 AM",
    "seats": ["C4"],
    "upper_seats": [],
    "unit_fair": "400",
    "total_fair": "400",
    "discount": "1",
    "service_charge": "0",
    "payment_amount": "400",
    "payment_method": "",
    "payment_status": "unpaid"
  }
  */
  Future<dynamic> createBooking({required Map<String, dynamic> map}) async =>
      await tokenBaseApi(
              endPoint: AppUrl.BOOKING_CREATE_URL,
              method: Method.POST,
              map: map)
          .then((value) => value);

  Future<dynamic> submitCustomerTicketSMS(
          {required String ticketNumber,
          required String email,
          required SubmitType submitFor}) async =>
      await tokenBaseApi(
              endPoint: submitFor == SubmitType.EMAIL_SMS
                  ? AppUrl.CUSTOMER_TICKET_SMS_URL
                  : submitFor == SubmitType.SHOW_MY_TICKET
                      ? AppUrl.SHOW_MY_TICKET_URL
                      : AppUrl.CANCEL_MY_TICKET_URL,
              method: Method.GET,
              map: {"ticket_no": ticketNumber, 'email': email})
          .then((value) => value);

  Future<dynamic> getSeatDetails(
          {required int tripId, String? seatNumber}) async =>
      await commonApiCall(
              endPoint: AppUrl.GET_SEAT_INFO_URL,
              method: Method.GET,
              map: {'assign_trip_id': tripId, 'seat_number': seatNumber ?? ""})
          .then((value) => value);

  Future<dynamic> tempSeatCheckedAndStore(
          {required int tripId,
          required String seatNumber,
          required BookedType bookedType, required bool shouldStore}) async =>
      await commonApiCall(
              endPoint: bookedType == BookedType.CHECKED
                  ? AppUrl.TEMPORARY_CHECK_BOOK_URL
                  : shouldStore ? AppUrl.TEMPORARY_BOOKED_URL : AppUrl.TEMPORARY_DELETE_URL,
              method: Method.POST,
              map: {"assign_trip_id": tripId, "seat_number": seatNumber})
          .then((value) => value);

        

  Future<dynamic> getTicketInformation({required int customerId}) async =>
      await tokenBaseApi(
          endPoint: AppUrl.BOOKING_LIST_URL,
          method: Method.GET,
          map: {"customer_id": customerId}).then((value) => value);
}
