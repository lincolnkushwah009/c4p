part of values;

class StringConst {
  // API STRINGS
  static const String BASE_URL = "https://apis.care4parents.in/";

  static LABEL label = const LABEL();
  static SENTENCE sentence = const SENTENCE();
  static CommonButtons commonButtons = const CommonButtons();

  //strings
  static const String APP_NAME = "Care4parents";
  static const String APP_Home = "Home";
  // screen
  static const String PAYMENT = "Payment";
  static const String UPLOAD_REPORT = "Upload Report";
  static const String View_APPOINTMMENT = "View Appointment";
  static const String View_pdf = "Pdf View";
  static const String BOOK_APPOINTMENT_SCREEN = "Book Appointment";
  static const String Add_Care_Cash = "Add Care Cash";

  static const String APPOINTMENT_SCREEN = "Appointments";
  static const String ROOT_SCREEN = "Root Screen";
  static const String MENU = "Menus";
  static const String SETTING_SCREEN = "Settings";
  static const String PROFILE_SCREEN = "Profile";
  static const String Package = "Packages";
  static const String SUBSCRIPTION_SCREEN = "Subscriptions";
  static const String INVOICE = "Invoices";
  static const String ADD_SUBSCRIPTION_SCREEN = "Add Subscription";
  static const String ACTIVITY_REPORT_SCREEN = "Activities & Reports";
  static const String PRIVACY_POLICY_SCREEN = "Privacy Policy";
  static const String BOOK_SERVICE_SCREEN = "Book Service";
  static const String FAQ_SCREEN = "FAQ";
  static const String TEARMS_SCREEN = "Terms & Conditions";
  static const String SPECIALITIES_SCREEN = "Specialities";
  static const String MY_FAMILY = "My Family";
  static const String SERVICE_REQUESTS = "Service Request";
  static const String SERVICE_SCREEN = "Select Service";
  static const String MEMBER_SCREEN = "Select Member";

  // onboading screen
  static const String ONBOARDING_TITLE_1 = "Search Doctors";
  static const String ONBOARDING_TITLE_2 = "Book Appointment";
  static const String ONBOARDING_TITLE_3 = "Book Diagonostic";
  static const String REPORT_DETAIL = "Report Details";

  static const String ONBOARDING_DESC_1 = "Get list of best doctors nearby you";
  static const String ONBOARDING_DESC_2 =
      "Book an appointment with the right doctor";
  static const String ONBOARDING_DESC_3 = "Search and book diagonostic test";

  //welcome screen
  static const String WELCOME_TITLE = "Welcome!";
  static const String WELCOME_DESCRIPTION = "Select an option to continue";
  static const String WELCOME_OR = "OR";

  //welcome screen
  static const String USERTYPE_TITLE = "Why Choose?";
  // static const String USERTYPE_TITLE = "Banners";
  static const String USERTYPE_DESCRIPTION = "Select an option to continue";

  //Error messages
  static const String SWR = "Something went wrong";
  static const String CHECKNETWORK = "Check Network!";

  //labels

  //coomon

  //home screen

  //appointment screen
  static const UPCOMING_TAB = 'Upcoming';
  static const REQUESTED_TAB = 'Requested';
  static const PAST_TAB = 'Past';

  //activity& reports screen
  static const ACTIVITIES = 'Activities';
  static const PREVIOUS_REPORTS = 'Previous Reports';

  //menu screen
  static const String HOME = "Home";
  static const String DASHBOARD = "Dashboard";
  static const String MEMBER_PROFILE = "Member\'s Profile";
  static const String ACTIVITY_REPORT = "Activies & Reports";
  static const String VALUE_ADDED_SERVICE = "Value Added Servcies";
  static const String SUBSCRIPTIONS = "Subscriptions";
  static const String SETTINGS = "Settings";
  static const String FAQ = "FAQ";
  static const String CONACT_US = "Contact Us";
  static const String LOGOUT = "Logout";
  static const String OPEN_DRAWER = "Open Drawer";
  static const String MEDICINE = "Medicine";
  static const String IMMUNIZATION = "Immunization";
  static const String CONFERENCE = "Conference";
  //bottom tabs
  static const String APPOINTMENT = "Appointment";
  static const String REPORTS = "Reports";
  static const String RECORD_VITALS = "Record Vitals";
  static const String VIEW_REPORT = "View Report";
  static const String VIEW_INVOICE = "Invoice";
  static const String VIEW = "View";
  static const String Prescription = "Prescription";
}

class SENTENCE {
  const SENTENCE();
  String get PEAF => 'Please enter all field.';
  String get UPLOAD_FAILED => 'Upload failed. Try later.';
  String get APPOINTMENT_FAILED => 'Appointment failed. Try later.';
  String get LOG_IN => 'Login';
  String get FORGOT_PASSWORD => 'Forgot Password ?';
  String get FORGOT_PASSWORD_LABEL => 'Forgot Password';
  String get FACEBOOK => 'Facebook';
  String get GOOGLE => 'Google';
  String get NEW_HERE => 'New here ? ';
  String get CREATE_ACCOUNT => 'Create account';
  String get GYR => 'Get yourself registered';
  String get MAO => 'Member access only';

  String get ENTER_CODE => 'Enter code';
  String get OTP_CODE => '******';
  String get NEXT_LINE => '\n';
  String get DNRC => 'Did not receive the code? ';
  String get OTP_CODE_DESC =>
      'We have sent you an SMS on your mobile number with 4 digit verification code';
  String get NO_UP_APPOINTMETS =>
      'You have no sheduled appointments. Book one ?';
  String get NO_REQ_APPOINTMETS =>
      'You have no request appointments. Book one ?';
  String get NO_PAST_APPOINTMETS => 'You have no past appointments.';
  String get No_Immunization => 'No Immunization';
  String get No_Package => 'No Package';
  String get NO_UP_SERVICES => 'You have no sheduled services. Book one ?';
  String get NO_REQ_SERVICES => 'You have no request services. Book one ?';
  String get NO_PAST_SERVICES => 'You have no past services.';

  String get INVALID_EMAIL => 'Please enter valid email';
  String get EMPTY_EMAIL => 'Please enter email';

  String get EMPTY_OTP => 'Please enter otp';
  String get EMPTY_PASSWORD => 'Please enter password';
  String get LOGIN_FAILED => 'Login Failed';
  String get SIGNUP_FAILED => 'Signup Failed';
  String get EMPTY_MOBILE => 'Please enter mobile number';
  String get EMPTY_NAME => 'Please enter name';
  String get EMPTY_FILED => 'Please enter all field.';
  String get ERROR_MESSAGE => 'Some Error occured';
  String get MAIL_CHECK => 'Mail send successfully';
  String get ACCOUNT_SETTING => 'Account Settings';
  String get PROFILE => 'Profile';
  String get CHANGE_PASSWORD => 'Change Password';
  String get SUPPORT => 'Support';
  String get TERMS_CONDITIONS => 'Terms & Conditions';
  String get PRIVACY_POLICY => 'Privacy Policy';
  String get NOT_FOUND => 'Not found';
  String get No_Medicine => 'No Medicine';

  String get NOT_FOUND_P => 'No data found for selected period!';
  String get EMPTY_COUNTRY => 'Please enter country';
  String get EMPTY_ADDRESS => 'Please enter address';
  String get INVALID_PHONE_NUMBER => 'Please enter valid phone number';
  String get EMPTY_CURRENT_PASS => 'Please enter current password';
  String get EMPTY_NEW_PASS => 'Please enter new password';
  String get EMPTY_CONFIRM_PASS => 'Please enter confirm password';
  String get EAMD => 'Enter All Member\'s Detail';
  String get PEMN => 'Please enter member\'s name';
  String get PER => 'Please select relation';
  String get PEDOB => 'Please enter date of birth';
  String get PEG => 'Please select gender';
  String get EACD => 'Enter all then Contact Details';
  String get ECN => 'Please enter emergency contact no';
  String get ECP => 'Please enter emergency contact person name';
  String get PEA => 'Please enter address';
  String get PEE => 'Please enter email';
  String get PEPN => 'Please enter phone number';
  String get EVCN => 'Enter valid phone number';
  String get PEVE => 'Enter valid email id';
  String get SPFM => 'Select Package for the  member';
  String get ECC => 'Enter Coupon Code';
  String get PES => 'Please enter state';
  String get EVPC => 'Enter valid pincode';
  String get EPC => 'Please Enter pincode';
  String get PECC => 'Please Enter Coupon Code';
  String get BOOK_APPOINTMENT => 'Book Appointment';
  String get SELECT_DATE_TIME => 'Select Date And Time';
  String get NO_Activity => 'You have no activities';
  String get NO_Reports => 'You have no reports';
  String get NO_PAST_Reports => 'You have no past reports';

  String get Proceed_to_Pay => "Proceed to Pay";
}

class LABEL {
  const LABEL();
  String get SEARCH_REPORT => 'Search Report';
  String get ECG_Report => 'ECG Report';
  String get End_Date => 'End Date';
  String get Start_Date => 'Start Date';
  String get Systolic => 'Systolic';
  String get Diastrolic => 'Diastrolic';
  String get Fasting => 'Sugar Fasting';
  String get Random => 'Sugar Random';
  String get Bp => 'Sugar pp';
  String get SugarLevel => 'Sugar Level';
  String get REMARK => 'Remark (optional)';
  String get SERVICE => 'Service';
  String get EMAIL => 'Email';
  String get PASSWORD => 'Password';
  String get NAME => 'Name';
  String get MOBILE_NUMBER => 'Mobile number';
  String get PHONE_NUMBER => 'Phone number';
  String get CareCash => 'CareCash';

  String get CURRENT_COUNTRY => 'Current Country';
  String get CURRENT_ADDRESS => 'Current Address';
  String get CURRENT_PASSWORD => 'Current Password';
  String get NEW_PASSWORD => 'New Password';
  String get CONFIRM_PASSWORD => 'Confirm Password';
  String get FULL_NAME => 'Full Name';
  String get RELATION => 'Relation';
  String get DATE_OF_BIRTHDAY => 'Date of Birth';
  String get GENDER => 'Gender';
  String get AGE => 'Age';
  String get MEMBER_NAME => 'Member\'s Name';
  String get MEMBER_EMAIL => 'Member\'s Email';
  String get MEMBER_ADDRESS => 'Member\'s Address';
  String get MEMBER_PHONE => 'Member\'s Phone';
  String get EMERGENCY_CONTACT_PERSON => 'Emergency Contact Person';
  String get EMERGENCY_CONTACT_NO => 'Emergency contact No';
  String get ADDRESS => 'Address';
  String get PACKAGE_AMOUNT => 'Amount';
  String get STATUS => 'Status';
  String get ROUTE => 'Route';
  String get INTAKE => 'Intake';
  String get REMARKS => 'Remarks';

  String get PAY_NOW => 'Pay Now';
  String get AMOUNT => 'Amount';
  String get SUBSCRIPTION_DATE => 'Subscription Date';
  String get PACKAGE => 'Package:';
  String get duration => 'Duration:';
  String get TYPE => 'Type:';
  String get description => 'Description:';

  String get PINCODE => 'Pincode:';
  String get STATE => 'State:';
  String get SPECIALITIES => 'Specialities';
  String get SELECT_DATE => 'Select Date';
  String get SEARCH_SPECIALIST => 'Doctor, specialist, clinics';
  String get SEARCH_SERVICE => 'Search services';
  String get SEARCH_MEMBER => 'Search merber';
  String get Blood_Pressure => 'Blood Pressure';
  String get Blood_Sugar => 'Blood Sugar';
  String get SPO2 => 'SPO2';
  String get ECG => 'ECG';
  String get PAYMENT_LINK => 'Payment Link';
}

class CommonButtons {
  const CommonButtons();
  String get GOOGLE => 'Google';
  String get FABEBOOK => 'Facebook';
  // common buttons
  static const String UPLOAD = "File Upload";
  static const String RETRY = "Retry";
  static const String SAVE = "Save";
  static const String UPDATE = "Update";
  static const String DELETE = "Delete";
  // startup
  static const String NEXT = "Next";
  static const String CANCEL = "Cancel";
  static const String FINISH = "Finish";
  // welcome
  static const String LOGIN = "Login";
  static const String PURCHAGE_PLAN = "Purchage Plan";
  static const String BOOKSERVICE = "Book Service";
  static const String SOS = "SOS";
  static const String doctor_Appointment = "Doctor's Appointments";
  static const String SIGNUP = "Sign up";
  //user type
  static const String USER = "User";

  static const String CONTINUE = "Continue";

  static const String RECORD_VITAL = "Record Vitals";
  static const String SUBMIT = "Submit";
  static const String RESEND = "Re-send";
  static const String GET_A_CALL_NOW = "Get a call now";
  static const String NEW_APPOINTMET = "New Appointment";
  static const String NEW_SERVICE = "New Service";
  static const String BOOK = "BOOK";
  static const String SIGNOUT = "Sign out";
  static const String VERIFY = "Verify";
  static const String ADD_SUBSCRIPTION = "Add Subscription";
  static const String ADD_Carecash = "Add Care Cash";

  static const String ADD_FAMILY_MEMBER = "Add Family Member";
  static const String APPLY = "Apply";
  static const String PROCESSED_PAY = "Processed to Pay";
  static const String BACK = "BACK";
  static const String START = "START";
  static const String BOOK_SERVICE = "Book Service";
}
