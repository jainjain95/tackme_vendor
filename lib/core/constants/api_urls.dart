
const BASE_URL =
    "https://j76xbbtfcb.ap-southeast-2.awsapprunner.com";
        // "https://plnpdqzb-5050.inc1.devtunnels.ms";
      
// https://j76xbbtfcb.ap-southeast-2.awsapprunner.com
const LOGIN_OTP = BASE_URL + "/vendor/login";
const VERIFY_OTP = BASE_URL + "/vendor/verify-otp";
const VERIFY_UPDATE_NUMBER_OTP = BASE_URL + "/vendor/updated-number/";
const SIGNUP = BASE_URL + "/vendor/signup-vendor";
const company_INFO = BASE_URL + "/vendor/add-company-info/";
const NEW_NUMBER_OTP = BASE_URL + "/vendor/check-updated-number/";
const UPDATE_ALL_USER_DATA = BASE_URL + "/vendor/update-vendor-profile/";
const GET_BUSINESS_CATEGORY = BASE_URL + "/vendor/get-category-for-vendor";

const GET_SECHDULE = BASE_URL + "/vendor/get-vendor-schedule";
const ADD_SECHDULE = BASE_URL + "/vendor/add-vendor-schedule";
const DELETE_SECHDULE = BASE_URL + "/vendor/delete-schedule/";
const UPDATE_SCHEDULE = BASE_URL + "/vendor/update-schedule/";

const GET_STOP = BASE_URL+ "/vendor/get-vendor-stop";
const ADD_STOP = BASE_URL+ "/vendor/add-vendor-stop";
const CHECKIN_STOP = BASE_URL+ "/vendor/check-in/";


const GET_ROUTE = BASE_URL+ "/vendor/get-vendor-routes/";
const Add_ROUTE_URL = BASE_URL+ "/vendor/add-vendor-route";
const UPDATE_ROUTE = BASE_URL+ "/vendor/update-route/";
const START_ROUTE = BASE_URL+ "/vendor/start-route/";
const ONGOING_ROUTE = BASE_URL+ "/vendor/get-unfinished-route/";
const END_ONGOING_ROUTE = BASE_URL+ "/vendor/end-route/";


const GET_PERSON = BASE_URL+ "/vendor/get-vendor-details/";

const GET_COMPANY_DETAIL = BASE_URL+ "/vendor/get-vendor-Company-Info/";

const NOTIFICATION = BASE_URL+ "/vendor/notify-vendor/";

const PROFILE_IMAGE_URL = BASE_URL+ "/vendor/update-profile-image/";


const GET_PENDING_REQ = BASE_URL+ "/vendor/get-pending-request/";
const GET_APPROVED_REQ = BASE_URL+ "/vendor/get-approved-request/";
const UPDATE_REQ = BASE_URL+ "/vendor/update-request/";
const REJECT_REQ = BASE_URL+ "/vendor/reject-request/";


String GET_DELETE_SCHEDULR_URL(String schId, String isdelete) {
  String a =isdelete.toString();
  return DELETE_SECHDULE+schId+"?isDeleted="+a;
}

String GET_UPDATE_SCHEDULE_URL(String schId) {
  return UPDATE_SCHEDULE+schId;
}

String GET_USER_SCHEDULE(String uid) {
  return GET_SECHDULE + "/"+ uid;
}

String GET_STOP_URL(String uid) {
  return GET_STOP + "/" + uid;
}

String ADD_COMPANY_INFO_URL(String uid) {
  return  company_INFO+uid;
} 

String GET_ROUTE_URL(String uid) {
  return  GET_ROUTE+uid;
}

String GET_PERSON_DETAIL_URL(String uid) {
  return  GET_PERSON+uid;
}

String GET_COMPANY_DETAIL_URL(String uid) {
  return  GET_COMPANY_DETAIL+uid;
}

String GET_NOTIFICATION_URL(String uid, bool noti) {
  String a = noti.toString();
  return  NOTIFICATION+uid+"?notification="+a;
}

String UPLOAD_PROFILE_IMAGE_URL(String uid) {
  return  PROFILE_IMAGE_URL+uid;
}

String NEW_NUMBER_OTP_URL(String uid) {
  return  NEW_NUMBER_OTP+uid;
}

String VERIFY_UPDATE_NUMBER_OTP_URL(String uid) {
  return  VERIFY_UPDATE_NUMBER_OTP+uid;
}

String UPDATE_ALL_USER_DATA_URL(String uid) {
  return  UPDATE_ALL_USER_DATA+uid;
}


String GET_PENDING_REQ_URL(String uid) {
  return  GET_PENDING_REQ+uid;
}

String GET_APPROVED_REQ_URL(String uid) {
  return  GET_APPROVED_REQ+uid;
}

String UPDATE_REQ_REQ_URL(String uid) {
  return  UPDATE_REQ+uid;
}

String REJECT_REQ_URL(String reqId) {
  return  REJECT_REQ+reqId;
}

String START_ROUTE_URL(String routeId) {
  return  START_ROUTE+routeId;
}

String CHECKIN_STOP_URL(String routeId) {
  return  CHECKIN_STOP+routeId;
}

String ONGOING_ROUTE_URL(String uId) {
  return  ONGOING_ROUTE+uId;
}

String END_ONGOING_ROUTE_URL(String ongoingRouteId) {
  return  END_ONGOING_ROUTE+ongoingRouteId+"?isCompleted=true";
}


String UPDATE_ROUTE_URL(String routeId) {
  return  UPDATE_ROUTE+routeId;
}
