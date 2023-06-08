class AppUrl {
  /// auth urls
  static String LOGIN_URL = "/company-login";
  static String REGISTER_URL = "/customer-registration";
  static String LOGOUT_URL = "/customer-logout";

  static String ALL_ROUTES_URL = "/routes/list";
  static String TRIP_LIST_URL = "/supervisor/booking/trip-list";
  static String BOOKING_CREATE_URL(id) => "/supervisor/booking/create/${id}";
  static String BOOKING_CREATE_URL2(id) => "/supervisor/booking/store/${id}";
  static String STANDUP_BOOKING_CREATE_URL(id) =>
      "/company/ticket/${id}/standup/create";
  static String QUICK_CREATE_URL(id) => "/supervisor/booking/create-quick/$id";


  static String CUSTOMER_TICKET_SMS_URL = "/customer-ticket-sms";
  static String SHOW_MY_TICKET_URL = "/customer-ticket";
  static String CANCEL_MY_TICKET_URL = "/customer-booking-cancel";

  static String GET_SEAT_INFO_URL = "/find/assign-trip";
  static String TEMPORARY_CHECK_BOOK_URL = "/booking/temp-booked-checked";
  static String TEMPORARY_BOOKED_URL = "/booking/temp-booked-store";
  static String TEMPORARY_DELETE_URL = "booking/temp-booked-delete";

  static String BOOKING_LIST_URL = "/customer-booking-information";
}
