Server: https://apis.care4parents.in/ 
API Login:-----------------
	URL: 
		auth/local
	Body:
		{ identifier: email, password: password }
	
	Method:
		POST
API Register:-----------------
	URL: 
		auth/local/register
	Body:
		{
		  name: this.form.controls['name'].value,
		  email: this.form.controls['email'].value,
		  password: this.form.controls['password'].value,
		  username: this.form.controls['email'].value,
		}
	Method:
		POST
API Social Login:-----------------
	URL: 
		auth/local/sociallogin
	Body:
		"user object" receive in response from Social sites
	Method:
		POST
	Google: 
	
		provider: 
			406285061861-1uak6qdvv1m07mgr5giue8vviieesv12.apps.googleusercontent.com
	
	Facebook: 
	
		provider: 
			352333262818377

API Forgot Password:-----------------

	
	URL: 
		auth/forgot-password
	
	Body:
		{
		  email: this.form.controls['email'].value,
		}
	
	Method:
		POST




API Reset Password:-----------------

	
	URL: 
		auth/password-confirmation
	
	Param:
		{
		  code: code ,
		}
	
	Method:
		GET




API Change Password:-----------------

	
	URL: 
		users
		
	BODY:
		{
			password: [password, [Validators.required]],
			confirm_password: [confirm_password, [Validators.required, Validators.minLength(6)]],
		}
	
	Method:
		PUT
	eg:	users/123
API Email Confirm:-----------------
	URL: 
		auth/email-confirmation
	
	Param:
		{
		  confirmation: code ,
		}
	
	Method:
		GET

API User Profile:-----------------

	
	URL: 
		users/me
	
	Param:
		{
		  
		}
	
	Method:
		GET
		
		
		
		
API Update User Profile:-----------------

	
	URL: 
		users
	
	Body:
		{
			email: [email, [Validators.required, Validators.email]],
			phone_number: [ phone_number, [Validators.minLength(10), Validators.maxLength(10)]],
			country: [country, [Validators.required]],
			address: [address, [Validators.required]],
		}
	
	Method:
		PUT

	
	eg:	users/123


--- ------------------------------------------------------
--- Configurations ---------------------------------------
--- ------------------------------------------------------

if (environment.env == 'production') {
  CONFIG = {
    razorpay: {
      keyId: 'rzp_live_Nziy7PfwObIHmV',
      keySecret: 'RgXMdd8O0HftURxBIjfQhq5t',
    },
    googleClientId: '406285061861-sm7gk9vpuksivl6v7hjcllmnv1jtnf9v.apps.googleusercontent.com',
    facebookClientId: '352333262818377',
  }
} else {
  CONFIG = {
    razorpay: {
      keyId: 'rzp_test_hj8cqXKB4DJ7Nb',
      keySecret: '1ReQ5gUCnwoBoP4ybYNr64xO',
    },
    googleClientId: '406285061861-sm7gk9vpuksivl6v7hjcllmnv1jtnf9v.apps.googleusercontent.com',
    facebookClientId: '352333262818377',
  }
}



--- ------------------------------------------------------
--- Support APIs ---------------------------------------
--- ------------------------------------------------------

		
--- API Packages

	
	URL: 
		/packages
	
	Param:
	{
		q: {
			limit: 25,
			page: 1,
			short: ['index', 'ASC'],
			dquery: {},
		} ,
	}

	%7B%22limit%22:25,%22page%22:1,%22short%22:%5B%22index%22,%22ASC%22%5D,%22dquery%22:%7B%7D%7D
	
	Method:
		GET



--- API Coupon

	
	URL: 
		/promocodes/validate
	
	Body:
		{
			code: this.couponInput.value,
			amount: this.selectedPackagePrice,
			package_id: this.selectedPackageId,
		}
	
	Method:
		POST	


	Response:
		
			this.discountAmount = result.amount
            this.apiCouponData = result.coupon



--- -----------------------------------------------------------------
--- Call APIs in the same Order for Adding member --
--- -----------------------------------------------------------------


-- API Add Member
	
	URL:
	/family-members
	
	BODY = {
	  name: member['name'].value,
      relation: member['relation'].value,
      dob: member['dob'].value,
      gender: member['gender'].value,
	  user_id: User.id,
	  email: member['email'].value,
      address: member['address'].value,
      phone: member['phone'].value,
      emergency_country_code: member['emergency_country_code'].value,
      emergency_contact_no: member['emergency_contact_no'].value,
      emergency_contact_person: member['emergency_contact_person'].value,
	}
	
	Method:
		POST
-- API createMapping		

	URL:
	/user-family-mappings

	BODY = {
      user_id: User.id,
      family_member_id: member.id,
    }
	
	Method:
		POST



--- API orders

	URL:
	/orders
	
	BODY = {
		  pincode: controls['pincode'].value,
		  package: controls['package_id'].value,
		  quantity: 1,
		  name: controls['name'].value,
		  user: User.id,
		  order_datetime: this.getCurrentDateSQLFormat(0),
		  phone: member['phone'].value,
		  state: controls['state'].value,
		  status: 'PENDING',
		  address: controls['address'].value,
		  family_member: this.memberId,
		  amount: this.selectedPackagePrice,
	}
		if (this.apiCouponData) {
		  BODY['promocode_name'] = this.apiCouponData['name']
		  BODY['discount_amount'] = this.discountAmount
		  BODY['amount'] = this.discountAmount
			? this.selectedPackagePrice - this.discountAmount
			: this.selectedPackagePrice
		  BODY['promocode_id'] = this.apiCouponData['id']
		}
		BODY['status'] = parseFloat(BODY['amount']) > 0 ? 'PENDING' : 'COMPLETED'
	
	
	Method:
		POST

--- ----------------------------------------------------------------------------

--- When payment required, then call the razorpay module with the other remaining apis below 

--- ----------------------------------------------------------------------------

--- Razorpay Payment Gateway

	RAZORPAY_OPTIONS = {
      key: CONFIG.razorpay.keyId,
      amount: response.data.amount * 100,
      name: 'care4parent.in',
      description: 'Buy package',
      image: 'https://www.care4parents.in/images/logo.svg',
      prefill: {
        name: '',
        email: User.email,
        contact: User.phone_number,
        method: '',
      },
      modal: {},
      theme: {
        color: '#52c3bc',
      },
    } 

	RAZORPAY_OPTIONS['handler'] = this.razorPaySuccessHandler.bind(this)
    let razorpay = new Razorpay(RAZORPAY_OPTIONS)
    this.order_id = response.data.id
    razorpay.open()
	
	Response - razorPaySuccessHandler:
	
		Call API updateOrderAndPackage
	
	
--- API updatePackageForUser
	
	URL:	
	/orders/32			-- Order ID
	
	BODY = {
      status: 'COMPLETED',
    }
	
	Method:
		PUT
		
	Response:
		
		Call updatePackageForUser
	
--- ----------------------------------------------------------------------------

--- When payment "not" required, then proceed the below APIs call in same order

--- ----------------------------------------------------------------------------		


--- API updatePackageForUser
	
	URL:
	/user-package-mappings
	
	BODY = {
      family_member: this.memberId,
      start_date: this.getCurrentDateSQLFormat(0),   //2021-03-19 14:33:00
      end_time: this.getCurrentDateSQLFormat(1),	//2022-03-19 14:33:00
      package: controls['package_id'].value,
      order: this.order_id,
      status: true,
    }
	
	Method:
	POST
	
	
	
	
--- API updateUser
	
	URL:
	/family-members/123
		
	BODY = {
      user_package_mapping: mapping_id,
    }
	
	Method:
	PUT
	
	
	
--- API createServiceMapping

	URL:
	/member-service-mappings/dynamic
	
	BODY = {
      package: controls['package_id'].value,
      family_member_id: member_id,
      kid_name: User.name,
      kid_phone: User.phone_number,
      member_name: member['name'].value,
      member_phone: member['phone'].value,
    }
	
	Method:
	POST


	//TODO: start

	https://apis.care4parents.in/family-members/otp
	16:22
	phone:6261958843
	New
	16:22
	phone:6261958843
	otp:1234
	16:22
	https://apis.care4parents.in/family-members/otpverify

	//TODO: end

--- API GetMember
	
	URL:
		/user-family-mappings
	
	Param:
		{
		  q: {
			  limit: 25,
			  page: 1,
			  short: ['created_at', 'DESC'],
			  dquery: {user_id: User.id},
		  } ,
		}
	
	Method:
		GET
		
		
--- API GetMemberDetails
	
	URL:
		/user-family-mappings
	
	Param:
		{
		  q: {
			  limit: 1,
			  page: 1,
			  short: ['created_at', 'DESC'],
			  dquery: {user_id: User.id, family_member_id: this.member_id},
		  } ,
		}
	
	Method:
		GET

coupon code>>  TEST_SONU_50
 100% percent discount work on Gold Annual 9000 Plan

TEST_SONU_50
50% discount, work on all the packages
TEST_SONU_100
100% discount, work on Gold Annual 9000 Plan only

	Project-> Care4Parents
1. Add Members -DONE issue with payment.
    Design Time-> Done 
    Api integration Time-> without payment and coupon flow is done. 1 day for with payment and coupon.
    Requirement -> Coupon code required.

2. Record vitals tab 
    Design Time-> 2 days minimum + depend on existing UI of that part.
    Api integration Time-> depends on SDK - approx. 1 week.
    Requirement -> 
3. Members profile - DONE
    Design Time-> 1 day
    Api integration Time->  1 day
    Requirement -> Api required.

4. Appointments tab
    Design Time-> 2 days
    Api integration Time-> 2 day
    Requirement -> Api required.
5. Login & SignUp
    Design Time-> done
    Api integration Time-> 3 day (fb & google & record vital login)
    Requirement -> For Google Login - GoogleService-Info.plist and google-service.json file 
6. Activities & Reports
    Design Time-> Depends on UI
    Api integration Time-> Depends on UI
    Requirement -> There is no UI for Activity and report Add and View given, Also api are required.
7. Dashboard
    Design Time-> 3 day
    Api integration Time-> 1 day
    Requirement -> Api required. 
8. Settings
    Design Time-> Done + Image picker changes left
    Api integration Time-> Api changes for image upload - 1 day.
    Requirement -> Api changes
9. Terms, Privacy, FAQ
    Design Time-> 1 days
    Api integration Time-> 1 day
    Requirement -> Api required


<!-- https://github.com/Mukul139/Ecommerce -->

<!-- I/Timeline(29087): Timeline: Activity_launch_request time:10866142 intent:Intent { cmp=com.example.care4parents/com.razorpay.CheckoutActivity (has extras) }
W/ActivityThread(29087): handleWindowVisibility: no activity for token android.os.BinderProxy@8d0753d
D/com.razorpay.checkout(29087): No permission for reading SMS
D/com.razorpay.checkout(29087): CheckoutActivity onCreate called
E/com.razorpay.checkout(29087): Error reading options!
E/com.razorpay.checkout(29087): org.json.JSONException: No value for send_sms_hash
E/com.razorpay.checkout(29087):         at org.json.JSONObject.get(JSONObject.java:392)
E/com.razorpay.checkout(29087):         at org.json.JSONObject.getBoolean(JSONObject.java:413)
E/com.razorpay.checkout(29087):         at com.razorpay.CheckoutOptions.shouldSendHashForSms(CheckoutOptions.java:36)
E/com.razorpay.checkout(29087):         at com.razorpay.CheckoutPresenterImpl.setOptions(CheckoutPresenterImpl.java:181)
E/com.razorpay.checkout(29087):         at com.razorpay.BaseCheckoutActivity.onCreate(BaseCheckoutActivity.java:103)
E/com.razorpay.checkout(29087):         at com.razorpay.BaseCheckoutOtpelfActivity.onCreate(BaseCheckoutOtpelfActivity.java:23)
E/com.razorpay.checkout(29087):         at com.razorpay.CheckoutActivity.onCreate(CheckoutActivity.java:8)
E/com.razorpay.checkout(29087):         at android.app.Activity.performCreate(Activity.java:7224)
E/com.razorpay.checkout(29087):         at android.app.Activity.performCreate(Activity.java:7213)
E/com.razorpay.checkout(29087):         at android.app.Instrumentation.callActivityOnCreate(Instrumentation.java:1272)
E/com.razorpay.checkout(29087):         at android.app.ActivityThread.performLaunchActivity(ActivityThread.java:2926)
E/com.razorpay.checkout(29087):         at android.app.ActivityThread.handleLaunchActivity(ActivityThread.java:3081)
E/com.razorpay.checkout(29087):         at android.app.servertransaction.LaunchActivityItem.execute(LaunchActivityItem.java:78)
E/com.razorpay.checkout(29087):         at android.app.servertransaction.TransactionExecutor.executeCallbacks(TransactionExecutor.java:108)
E/com.razorpay.checkout(29087):         at android.app.servertransaction.TransactionExecutor.execute(TransactionExecutor.java:68)
E/com.razorpay.checkout(29087):         at android.app.ActivityThread$H.handleMessage(ActivityThread.java:1831)
E/com.razorpay.checkout(29087):         at android.os.Handler.dispatchMessage(Handler.java:106)
E/com.razorpay.checkout(29087):         at android.os.Looper.loop(Looper.java:201)
E/com.razorpay.checkout(29087):         at android.app.ActivityThread.main(ActivityThread.java:6810)
E/com.razorpay.checkout(29087):         at java.lang.reflect.Method.invoke(Native Method)
E/com.razorpay.checkout(29087):         at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:547)
E/com.razorpay.checkout(29087):         at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:873)
W/System.err(29087): org.json.JSONException: No value for send_sms_hash
W/System.err(29087):    at org.json.JSONObject.get(JSONObject.java:392)
W/System.err(29087):    at org.json.JSONObject.getBoolean(JSONObject.java:413)
W/System.err(29087):    at com.razorpay.CheckoutOptions.shouldSendHashForSms(CheckoutOptions.java:36)
W/System.err(29087):    at com.razorpay.CheckoutPresenterImpl.setOptions(CheckoutPresenterImpl.java:181)
W/System.err(29087):    at com.razorpay.BaseCheckoutActivity.onCreate(BaseCheckoutActivity.java:103)
W/System.err(29087):    at com.razorpay.BaseCheckoutOtpelfActivity.onCreate(BaseCheckoutOtpelfActivity.java:23)
W/System.err(29087):    at com.razorpay.CheckoutActivity.onCreate(CheckoutActivity.java:8)
W/System.err(29087):    at android.app.Activity.performCreate(Activity.java:7224)
W/System.err(29087):    at android.app.Activity.performCreate(Activity.java:7213)
W/System.err(29087):    at android.app.Instrumentation.callActivityOnCreate(Instrumentation.java:1272)
W/System.err(29087):    at android.app.ActivityThread.performLaunchActivity(ActivityThread.java:2926)
W/System.err(29087):    at android.app.ActivityThread.handleLaunchActivity(ActivityThread.java:3081)
W/System.err(29087):    at android.app.servertransaction.LaunchActivityItem.execute(LaunchActivityItem.java:78)
W/System.err(29087):    at android.app.servertransaction.TransactionExecutor.executeCallbacks(TransactionExecutor.java:108)
W/System.err(29087):    at android.app.servertransaction.TransactionExecutor.execute(TransactionExecutor.java:68)
W/System.err(29087):    at android.app.ActivityThread$H.handleMessage(ActivityThread.java:1831)
W/System.err(29087):    at android.os.Handler.dispatchMessage(Handler.java:106)
W/System.err(29087):    at android.os.Looper.loop(Looper.java:201)
W/System.err(29087):    at android.app.ActivityThread.main(ActivityThread.java:6810)
W/System.err(29087):    at java.lang.reflect.Method.invoke(Native Method)
W/System.err(29087):    at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:547)
W/System.err(29087):    at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:873)
I/WebViewFactory(29087): Loading com.android.chrome version 86.0.4240.198 (code 424019823)
I/cr_LibraryLoader(29087): Loaded native library version number "86.0.4240.198"
I/cr_CachingUmaRecorder(29087): Flushed 5 samples from 5 histograms.
W/le.care4parent(29087): Accessing hidden method Landroid/content/Context;->bindServiceAsUser(Landroid/content/Intent;Landroid/content/ServiceConnection;ILandroid/os/Handler;Landroid/os/UserHandle;)Z (light greylist, reflection)
D/EgretLoader(29087): EgretLoader(Context context)
D/EgretLoader(29087): The context is not activity
D/com.razorpay.checkout(29087): {"key":"NTZmNWIwNGZhODc1MmUyY2YxOTM5NmM0","events":[],"context":{"mode":"live","device":{"manufacturer":"Xiaomi","model":"Redmi Note 5 Pro","name":"whyred","type":"phone","version":"Android9","Xiaomi":"Xiaomi","Redmi Note 5 Pro":"Redmi Note 5 Pro","device_size":"1080w X 2030h","device_resolution":"1080x2030x440"},"sdk":{"version":"1.6.6","type":"checkout"},"network":{"bluetooth":false,"carrier":"Jio 4G","cellular":true,"cellular_network_type":"4G","wifi":false,"carrier_network":"Jio 4G","network_type":4,"is_roming":false},"screen":{"density":2.75,"width":1080,"height":2030},"locale":"en-IN","timezone":"Asia\/Kolkata","user_agent":"Dalvik\/2.1.0 (Linux; U; Android 9; Redmi Note 5 Pro MIUI\/V11.0.5.0.PEIMIXM)","webview_user_agent":"Mozilla\/5.0 (Linux; Android 9; Redmi Note 5 Pro Build\/PKQ1.180904.001; wv) AppleWebKit\/537.36 (KHTML, like Gecko) Version\/4.0 Chrome\/86.0.4240.198 Mobile Safari\/537.36"}}
D/com.razorpay.checkout(29087): Modified Url: https://api.razorpay.com/v1/checkout/public?version=1.6.6&library=checkoutjs&platform=android
W/System.err(29087): java.lang.NullPointerException: Attempt to invoke virtual method 'int java.lang.String.length()' on a null object reference
W/System.err(29087):    at org.json.JSONTokener.nextCleanInternal(JSONTokener.java:116)
W/System.err(29087):    at org.json.JSONTokener.nextValue(JSONTokener.java:94)
W/System.err(29087):    at org.json.JSONObject.<init>(JSONObject.java:159)
W/System.err(29087):    at org.json.JSONObject.<init>(JSONObject.java:176)
W/System.err(29087):    at com.razorpay.CheckoutPresenterImpl.setOptions(CheckoutPresenterImpl.java:193)
W/System.err(29087):    at com.razorpay.BaseCheckoutActivity.onCreate(BaseCheckoutActivity.java:103)
W/System.err(29087):    at com.razorpay.BaseCheckoutOtpelfActivity.onCreate(BaseCheckoutOtpelfActivity.java:23)
W/System.err(29087):    at com.razorpay.CheckoutActivity.onCreate(CheckoutActivity.java:8)
W/System.err(29087):    at android.app.Activity.performCreate(Activity.java:7224)
W/System.err(29087):    at android.app.Activity.performCreate(Activity.java:7213)
W/System.err(29087):    at android.app.Instrumentation.callActivityOnCreate(Instrumentation.java:1272)
W/System.err(29087):    at android.app.ActivityThread.performLaunchActivity(ActivityThread.java:2926)
W/System.err(29087):    at android.app.ActivityThread.handleLaunchActivity(ActivityThread.java:3081)
W/System.err(29087):    at android.app.servertransaction.LaunchActivityItem.execute(LaunchActivityItem.java:78)
W/System.err(29087):    at android.app.servertransaction.TransactionExecutor.executeCallbacks(TransactionExecutor.java:108)
W/System.err(29087):    at android.app.servertransaction.TransactionExecutor.execute(TransactionExecutor.java:68)
W/System.err(29087):    at android.app.ActivityThread$H.handleMessage(ActivityThread.java:1831)
W/System.err(29087):    at android.os.Handler.dispatchMessage(Handler.java:106)
W/System.err(29087):    at android.os.Looper.loop(Looper.java:201)
W/System.err(29087):    at android.app.ActivityThread.main(ActivityThread.java:6810)
W/System.err(29087):    at java.lang.reflect.Method.invoke(Native Method)
W/System.err(29087):    at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:547)
W/System.err(29087):    at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:873)
D/EgretLoader(29087): EgretLoader(Context context)
D/EgretLoader(29087): The context is not activity
D/EgretLoader(29087): EgretLoader(Context context)
D/EgretLoader(29087): The context is not activity
D/com.razorpay.checkout(29087): OTPElf Constructor
D/com.razorpay.checkout(29087): No permission for reading SMS
D/com.razorpay.checkout(29087): OTPElf Constructor
D/com.razorpay.checkout(29087): No permission for reading SMS
I/DpmTcmClient(29087): RegisterTcmMonitor from: com.android.okhttp.TcmIdleTimerMonitor
W/le.care4parent(29087): Accessing hidden method Landroid/media/AudioManager;->getOutputLatency(I)I (light greylist, reflection)
W/cr_media(29087): Requires BLUETOOTH permission
D/com.razorpay.checkout(29087): NOT FULLSCREEN
D/EgretLoader(29087): EgretLoader(Context context)
D/EgretLoader(29087): The context is not activity
W/System.err(29087): java.lang.SecurityException: MODE_WORLD_READABLE no longer supported
W/System.err(29087):    at android.app.ContextImpl.checkMode(ContextImpl.java:2509)
W/System.err(29087):    at android.app.ContextImpl.getSharedPreferences(ContextImpl.java:424)
W/System.err(29087):    at android.app.ContextImpl.getSharedPreferences(ContextImpl.java:414)
W/System.err(29087):    at android.content.ContextWrapper.getSharedPreferences(ContextWrapper.java:184)
W/System.err(29087):    at com.razorpay.SharedPreferenceUtil.getPublicPrefs(SharedPreferenceUtil.java:63)
W/System.err(29087):    at com.razorpay.CardSaving.getDeviceToken(CardSaving.java:265)
W/System.err(29087):    at com.razorpay.CardSaving.fetchDeviceTokenFromOtherAppsIfRequired(CardSaving.java:167)
W/System.err(29087):    at com.razorpay.CheckoutPresenterImpl.handleCardSaving(CheckoutPresenterImpl.java:370)
W/System.err(29087):    at com.razorpay.BaseCheckoutActivity.onCreate(BaseCheckoutActivity.java:149)
W/System.err(29087):    at com.razorpay.BaseCheckoutOtpelfActivity.onCreate(BaseCheckoutOtpelfActivity.java:23)
W/System.err(29087):    at com.razorpay.CheckoutActivity.onCreate(CheckoutActivity.java:8)
W/System.err(29087):    at android.app.Activity.performCreate(Activity.java:7224)
W/System.err(29087):    at android.app.Activity.performCreate(Activity.java:7213)
W/System.err(29087):    at android.app.Instrumentation.callActivityOnCreate(Instrumentation.java:1272)
W/System.err(29087):    at android.app.ActivityThread.performLaunchActivity(ActivityThread.java:2926)
W/System.err(29087):    at android.app.ActivityThread.handleLaunchActivity(ActivityThread.java:3081)
W/System.err(29087):    at android.app.servertransaction.LaunchActivityItem.execute(LaunchActivityItem.java:78)
W/System.err(29087):    at android.app.servertransaction.TransactionExecutor.executeCallbacks(TransactionExecutor.java:108)
W/System.err(29087):    at android.app.servertransaction.TransactionExecutor.execute(TransactionExecutor.java:68)
W/System.err(29087):    at android.app.ActivityThread$H.handleMessage(ActivityThread.java:1831)
W/System.err(29087):    at android.os.Handler.dispatchMessage(Handler.java:106)
W/System.err(29087):    at android.os.Looper.loop(Looper.java:201)
W/System.err(29087):    at android.app.ActivityThread.main(ActivityThread.java:6810)
W/System.err(29087):    at java.lang.reflect.Method.invoke(Native Method)
W/System.err(29087):    at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:547)
W/System.err(29087):    at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:873)
W/Activity(29087): Slow Operation: Activity com.example.care4parents/com.razorpay.CheckoutActivity onCreate took 501ms
W/ContentCatcher(29087): Failed to notify a WebView
W/ContentCatcher(29087): Failed to notify a WebView
D/com.razorpay.checkout(29087): RzpAssist onPageStarted: https://api.razorpay.com/v1/checkout/public?version=1.6.6&library=checkoutjs&platform=android
D/com.razorpay.checkout(29087): Updating OTPElf
D/com.razorpay.checkout(29087): Updating OTPElf
E/com.razorpay.checkout(29087): Error reading options!
E/com.razorpay.checkout(29087): org.json.JSONException: No value for send_sms_hash
E/com.razorpay.checkout(29087):         at org.json.JSONObject.get(JSONObject.java:392)
E/com.razorpay.checkout(29087):         at org.json.JSONObject.getBoolean(JSONObject.java:413)
E/com.razorpay.checkout(29087):         at com.razorpay.CheckoutOptions.shouldSendHashForSms(CheckoutOptions.java:36)
E/com.razorpay.checkout(29087):         at com.razorpay.CheckoutPresenterImpl.getOptionsForHandleMessage(CheckoutPresenterImpl.java:802)
E/com.razorpay.checkout(29087):         at com.razorpay.CheckoutPresenterImpl.getHandleMessageFormattedString(CheckoutPresenterImpl.java:829)
E/com.razorpay.checkout(29087):         at com.razorpay.CheckoutPresenterImpl.access$300(CheckoutPresenterImpl.java:49)
E/com.razorpay.checkout(29087):         at com.razorpay.CheckoutPresenterImpl$7.run(CheckoutPresenterImpl.java:741)
E/com.razorpay.checkout(29087):         at android.app.Activity.runOnUiThread(Activity.java:6347)
E/com.razorpay.checkout(29087):         at com.razorpay.CheckoutPresenterImpl.onLoad(CheckoutPresenterImpl.java:738)
E/com.razorpay.checkout(29087):         at com.razorpay.CheckoutBridge$1.secure(CheckoutBridge.java:26)
E/com.razorpay.checkout(29087):         at com.razorpay.CheckoutPresenterImpl.executeWebViewCallback(CheckoutPresenterImpl.java:1221)
E/com.razorpay.checkout(29087):         at com.razorpay.CheckoutPresenterImpl.access$700(CheckoutPresenterImpl.java:49)
E/com.razorpay.checkout(29087):         at com.razorpay.CheckoutPresenterImpl$17.run(CheckoutPresenterImpl.java:1207)
E/com.razorpay.checkout(29087):         at android.os.Handler.handleCallback(Handler.java:873)
E/com.razorpay.checkout(29087):         at android.os.Handler.dispatchMessage(Handler.java:99)
E/com.razorpay.checkout(29087):         at android.os.Looper.loop(Looper.java:201)
E/com.razorpay.checkout(29087):         at android.app.ActivityThread.main(ActivityThread.java:6810)
E/com.razorpay.checkout(29087):         at java.lang.reflect.Method.invoke(Native Method)
E/com.razorpay.checkout(29087):         at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:547)
E/com.razorpay.checkout(29087):         at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:873)
W/System.err(29087): org.json.JSONException: No value for send_sms_hash
W/System.err(29087):    at org.json.JSONObject.get(JSONObject.java:392)
W/System.err(29087):    at org.json.JSONObject.getBoolean(JSONObject.java:413)
W/System.err(29087):    at com.razorpay.CheckoutOptions.shouldSendHashForSms(CheckoutOptions.java:36)
W/System.err(29087):    at com.razorpay.CheckoutPresenterImpl.getOptionsForHandleMessage(CheckoutPresenterImpl.java:802)
W/System.err(29087):    at com.razorpay.CheckoutPresenterImpl.getHandleMessageFormattedString(CheckoutPresenterImpl.java:829)
W/System.err(29087):    at com.razorpay.CheckoutPresenterImpl.access$300(CheckoutPresenterImpl.java:49)
W/System.err(29087):    at com.razorpay.CheckoutPresenterImpl$7.run(CheckoutPresenterImpl.java:741)
W/System.err(29087):    at android.app.Activity.runOnUiThread(Activity.java:6347)
W/System.err(29087):    at com.razorpay.CheckoutPresenterImpl.onLoad(CheckoutPresenterImpl.java:738)
W/System.err(29087):    at com.razorpay.CheckoutBridge$1.secure(CheckoutBridge.java:26)
W/System.err(29087):    at com.razorpay.CheckoutPresenterImpl.executeWebViewCallback(CheckoutPresenterImpl.java:1221)
W/System.err(29087):    at com.razorpay.CheckoutPresenterImpl.access$700(CheckoutPresenterImpl.java:49)
W/System.err(29087):    at com.razorpay.CheckoutPresenterImpl$17.run(CheckoutPresenterImpl.java:1207)
W/System.err(29087):    at android.os.Handler.handleCallback(Handler.java:873)
W/System.err(29087):    at android.os.Handler.dispatchMessage(Handler.java:99)
W/System.err(29087):    at android.os.Looper.loop(Looper.java:201)
W/System.err(29087):    at android.app.ActivityThread.main(ActivityThread.java:6810)
W/System.err(29087):    at java.lang.reflect.Method.invoke(Native Method)
W/System.err(29087):    at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:547)
W/System.err(29087):    at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:873)
D/AppSignatureHelper(29087): pkg: com.example.care4parents -- hash: ShXbo8sCi+P
D/skia    (29087): --- Failed to create image decoder with message 'unimplemented'
D/com.razorpay.checkout(29087): Checkout loaded in 1.48 sec.
D/com.razorpay.checkout(29087): not magic
E/com.razorpay.checkout(29087): Webview JS Error: Uncaught SyntaxError: Invalid or unexpected token
I/chromium(29087): [INFO:CONSOLE(1)] "Uncaught SyntaxError: Invalid or unexpected token", source: https://api.razorpay.com/v1/checkout/public?version=1.6.6&library=checkoutjs&platform=android (1)
W/System.err(29087): javax.crypto.BadPaddingException: error:1e000065:Cipher functions:OPENSSL_internal:BAD_DECRYPT
W/System.err(29087):    at com.android.org.conscrypt.NativeCrypto.EVP_CipherFinal_ex(Native Method)
W/System.err(29087):    at com.android.org.conscrypt.OpenSSLCipher$EVP_CIPHER.doFinalInternal(OpenSSLCipher.java:596)
W/System.err(29087):    at com.android.org.conscrypt.OpenSSLCipher.engineDoFinal(OpenSSLCipher.java:363)
W/System.err(29087):    at javax.crypto.Cipher.doFinal(Cipher.java:2055)
W/System.err(29087):    at com.razorpay.CryptLib.encryptDecrypt(CryptLib.java:176)
W/System.err(29087):    at com.razorpay.CryptLib.decrypt(CryptLib.java:269)
W/System.err(29087):    at com.razorpay.BaseUtils.decryptFile(BaseUtils.java:719)
W/System.err(29087):    at com.razorpay.OtpElfData$2.run(OtpElfData.java:55)
W/System.err(29087):    at com.razorpay.Owl.onPostExecute(Owl.java:137)
W/System.err(29087):    at com.razorpay.Owl.onPostExecute(Owl.java:23)
W/System.err(29087):    at android.os.AsyncTask.finish(AsyncTask.java:695)
W/System.err(29087):    at android.os.AsyncTask.access$600(AsyncTask.java:180)
W/System.err(29087):    at android.os.AsyncTask$InternalHandler.handleMessage(AsyncTask.java:712)
W/System.err(29087):    at android.os.Handler.dispatchMessage(Handler.java:106)
W/System.err(29087):    at android.os.Looper.loop(Looper.java:201)
W/System.err(29087):    at android.app.ActivityThread.main(ActivityThread.java:6810)
W/System.err(29087):    at java.lang.reflect.Method.invoke(Native Method)
W/System.err(29087):    at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:547)
W/System.err(29087):    at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:873)
D/com.razorpay.checkout(29087): Unable to decrypt file, error:1e000065:Cipher functions:OPENSSL_internal:BAD_DECRYPT
W/System.err(29087): javax.crypto.BadPaddingException: error:1e000065:Cipher functions:OPENSSL_internal:BAD_DECRYPT
W/System.err(29087):    at com.android.org.conscrypt.NativeCrypto.EVP_CipherFinal_ex(Native Method)
W/System.err(29087):    at com.android.org.conscrypt.OpenSSLCipher$EVP_CIPHER.doFinalInternal(OpenSSLCipher.java:596)
W/System.err(29087):    at com.android.org.conscrypt.OpenSSLCipher.engineDoFinal(OpenSSLCipher.java:363)
W/System.err(29087):    at javax.crypto.Cipher.doFinal(Cipher.java:2055)
W/System.err(29087):    at com.razorpay.CryptLib.encryptDecrypt(CryptLib.java:176)
W/System.err(29087):    at com.razorpay.CryptLib.decrypt(CryptLib.java:269)
W/System.err(29087):    at com.razorpay.BaseUtils.decryptFile(BaseUtils.java:719)
W/System.err(29087):    at com.razorpay.OtpElfData$2.run(OtpElfData.java:55)
W/System.err(29087):    at com.razorpay.Owl.onPostExecute(Owl.java:137)
W/System.err(29087):    at com.razorpay.Owl.onPostExecute(Owl.java:23)
W/System.err(29087):    at android.os.AsyncTask.finish(AsyncTask.java:695)
W/System.err(29087):    at android.os.AsyncTask.access$600(AsyncTask.java:180)
W/System.err(29087):    at android.os.AsyncTask$InternalHandler.handleMessage(AsyncTask.java:712)
W/System.err(29087):    at android.os.Handler.dispatchMessage(Handler.java:106)
W/System.err(29087):    at android.os.Looper.loop(Looper.java:201)
W/System.err(29087):    at android.app.ActivityThread.main(ActivityThread.java:6810)
W/System.err(29087):    at java.lang.reflect.Method.invoke(Native Method)
W/System.err(29087):    at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:547)
W/System.err(29087):    at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:873)
D/com.razorpay.checkout(29087): Unable to decrypt file, error:1e000065:Cipher functions:OPENSSL_internal:BAD_DECRYPT
W/System.err(29087): javax.crypto.BadPaddingException: error:1e000065:Cipher functions:OPENSSL_internal:BAD_DECRYPT
W/System.err(29087):    at com.android.org.conscrypt.NativeCrypto.EVP_CipherFinal_ex(Native Method)
W/System.err(29087):    at com.android.org.conscrypt.OpenSSLCipher$EVP_CIPHER.doFinalInternal(OpenSSLCipher.java:596)
W/System.err(29087):    at com.android.org.conscrypt.OpenSSLCipher.engineDoFinal(OpenSSLCipher.java:363)
W/System.err(29087):    at javax.crypto.Cipher.doFinal(Cipher.java:2055)
W/System.err(29087):    at com.razorpay.CryptLib.encryptDecrypt(CryptLib.java:176)
W/System.err(29087):    at com.razorpay.CryptLib.decrypt(CryptLib.java:269)
W/System.err(29087):    at com.razorpay.BaseUtils.decryptFile(BaseUtils.java:719)
W/System.err(29087):    at com.razorpay.MagicData$2.run(MagicData.java:41)
W/System.err(29087):    at com.razorpay.Owl.onPostExecute(Owl.java:137)
W/System.err(29087):    at com.razorpay.Owl.onPostExecute(Owl.java:23)
W/System.err(29087):    at android.os.AsyncTask.finish(AsyncTask.java:695)
W/System.err(29087):    at android.os.AsyncTask.access$600(AsyncTask.java:180)
W/System.err(29087):    at android.os.AsyncTask$InternalHandler.handleMessage(AsyncTask.java:712)
W/System.err(29087):    at android.os.Handler.dispatchMessage(Handler.java:106)
W/System.err(29087):    at android.os.Looper.loop(Looper.java:201)
W/System.err(29087):    at android.app.ActivityThread.main(ActivityThread.java:6810)
W/System.err(29087):    at java.lang.reflect.Method.invoke(Native Method)
W/System.err(29087):    at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:547)
W/System.err(29087):    at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:873)
D/com.razorpay.checkout(29087): Unable to decrypt file, error:1e000065:Cipher functions:OPENSSL_internal:BAD_DECRYPT
E/com.razorpay.checkout(29087): Webview JS Error: Uncaught TypeError: window.getDeviceDetails is not a function
I/chromium(29087): [INFO:CONSOLE(1)] "Uncaught TypeError: window.getDeviceDetails is not a function", source: https://api.razorpay.com/v1/checkout/public?version=1.6.6&library=checkoutjs&platform=android (1)
I/Choreographer(29087): Skipped 35 frames!  The application may be doing too much work on its main thread.
W/Looper  (29087): Slow Looper main: doFrame is 589ms late because of 1 msg, msg 1 took 602ms (late=1ms h=android.view.Choreographer$FrameHandler c=android.view.Choreographer$FrameDisplayEventReceiver) -->

Please find APIs for FAQs, Privacy Policy, Terms, Mobile Landing Page Banners & Why choose 

--- API FAQs

URL:
/app-read-page

Body:
{
page_name: 'faqs',
}

Method:
POST



--- API Terms

URL:
/app-read-page

Body:
{
page_name: 'terms',
}

Method:
POST


--- API Privacy Policy

URL:
/app-read-page

Body:
{
page_name: 'privacypolicy',
}

Method:
POST


--- API Mobile landing page banners & why choose

URL:
/app-read-page

Body:
{
page_name: 'banners',
}

Method:
POST


Physician
Cardiology
Nephrology
Gastroenterology
Neurology
ENT
EYE
Orthopedics
Surgery
Urology
Neuro surgery
Skin
Psychiatrist
Gynaecology
Dietician
Other
\

this.listOfOption = [
     { label: 'Physiotherapy', value: 'Physiotherapy' },
     { label: 'Home Care', value: 'Home Care' },
     { label: 'Investigations-sample collection', value: 'Investigations-sample collection' },
     { label: 'Vaccination', value: 'Vaccination' },
     { label: 'X-Ray at home ', value: 'X-Ray at home ' },
     { label: 'ECG', value: 'ECG' },
     { label: 'Order Medicines', value: 'Order Medicines' },
     { label: 'Other', value: 'Other' },
   ]

   /bookservice
service: ['', [Validators.required]],
     patientId: ['', [Validators.required]],
     bookingdate: [''],
     time: [''],
     user_id: ['', [Validators.required]],
     email: ['', [Validators.required, Validators.email]],
     phone: ['', [Validators.required, Validators.minLength(10), Validators.maxLength(10)]],
     remarks: [''],
BODY['timerange'] = BODY.time
BODY.bookingdate = year + '-' + month + '-' + day
     BODY.startbookingdate = year + '-' + month + '-' + day + ' ' + arr[0]
     BODY.endbookingdate = year + '-' + month + '-' + day + ' ' + arr[1]
-- -------------------------------------------
Appointment:


createForm() {
   this.formContactInfo = this.fb.group({
     speciality: ['', [Validators.required]],
     patientId: ['', [Validators.required]],
     user_id: ['', [Validators.required]],
     appointDate: [''],
     time: [''],
     email: ['', [Validators.required, Validators.email]],
     phone: ['', [Validators.required, Validators.minLength(10), Validators.maxLength(10)]],
     remarks: [''],
   })
 }
BODY['timerange'] = BODY.time
BODY.appointDate = year + '-' + month + '-' + day
       BODY.startappointdate = year + '-' + month + '-' + day + ' ' + arr[0]
       BODY.endappointdate = year + '-' + month + '-' + day + ' ' + arr[1]
: '/appointment
https://apis.care4parents.in/listappointment
https://apis.care4parents.in/listbookservice

body: any = {
   limit: 25,
   page: 1,
   short: ['created_at', 'DESC'],
   user_id: 0,
   tab: 0,
   tdate: '',
   searchKey: '',
 }
post
: profile image:

'/document/userprofile'
POST
body:{"file":item.file as any}
'Content-Type': 'multipart/form-data'
https://apis.care4parents.in/viewdrprescription/37


Please find attached screenshots of some issues which are self-explanatory.

1. Appointment screen some fields are missing like Phone and Remark
2. Service Request bottom bar with record vital section missing
3. When I choose the Profile section it starts with an error      

As discussed with Sonu earlier but Still, I am getting the website feel on many sections like Banners load, member's menu etc. (Try to load required things prior to the screens)  


 implementation 'com.facebook.android:facebook-login:[8.1)'

 <string name="facebook_app_id">352333262818377</string>
<string name="fb_login_protocol_scheme">fb352333262818377</string>

    <meta-data android:name="com.facebook.sdk.ApplicationId" android:value="@string/facebook_app_id"/>
    <activity android:name="com.facebook.react.devsupport.DevSettingsActivity"/>

352333262818377


access_token: "ya29.a0AfH6SMAHSRVevAgq35IEn-e9XfrFfu7Y0LCxcisEtVYKqfCN83A97pqG57lbXMNraTPbIo98odxNvZCv0NtsaEVwKWcMn7za4UPsgUDlX401sg3B3aU7eJMl6862D_Fqt20d-4V17IcH_-rTw2NBvjcH4h3E"
expires_in: 3598
id_token: "eyJhbGciOiJSUzI1NiIsImtpZCI6ImQzZmZiYjhhZGUwMWJiNGZhMmYyNWNmYjEwOGNjZWI4ODM0MDZkYWMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiNDA2Mjg1MDYxODYxLTF1YWs2cWR2djFtMDdtZ3I1Z2l1ZTh2dmlpZWVzdjEyLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiNDA2Mjg1MDYxODYxLTF1YWs2cWR2djFtMDdtZ3I1Z2l1ZTh2dmlpZWVzdjEyLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTE2NjM4NjMyMDQyOTA4ODk2MjMwIiwiZW1haWwiOiJwcml5YWphaW44Mjk2QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiei03UVFWR3lSaWxWV0xXamY0R1VIUSIsIm5hbWUiOiJQcml5YSBKYWluIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hLS9BT2gxNEdqclU5YmcyOHVvbERDOGRfemtXbUdpM29IOE83OEtDbUFzcWxhdnZBPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IlByaXlhIiwiZmFtaWx5X25hbWUiOiJKYWluIiwibG9jYWxlIjoiZW4iLCJpYXQiOjE2MjEzOTY3NjksImV4cCI6MTYyMTQwMDM2OSwianRpIjoiZjYwNWQzNjllN2Y2ZDc4YjI3MjkyYTY3YTFiNzFhNjMzMzdmYjQyZiJ9.RQM2EhLXIwiVOVIa955OIs5zUTmVcMH0katz-snlaJ6gkr-pROtPsojlKO57z-dlpoBSEvwxRFU2kFA4bBaCS20uSVeyQdOmHmnrZm-kksVVTJqwp8mu3Hb-i0ZI7Prp6Nw2EppsAvRXvMUgAlUJcLHdkgi8xhQsBjAdbLsIGqkwsp9LBpbx7zuAXRljP-RIxDvTD1j_Gn2F8-oKdDymXDUyBLCUa4AQxFfQy66W3TcPoI8AI8V9IassQkAvfzmMnyEjLDURYOYIJMgdVeyaP0svNj9i8F3toY33Ks-1R8rFJ_vl5_sp2v5CXdEd2wpJqovhzzpqhHiDTpXIhDD0hg"
login_hint: "AJDLj6KX4GKaVE-L1dmZ20PpI-EIgilvHdKkQZaBcrP7a0oI1NBHrTNLQgmjuANmtAswsJwGmyUAUYOBsywaYVmDfguVXrCVucz2pWNvn39fZKXwABWkxLk"
scope: "email profile https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile openid"
session_state: {extraQueryParams: {authuser: "2"}}
token_type: "Bearer"


PFA App icon

On Wed, 19 May 2021 at 04:13, Vipul Kansal <vipul@pinkshastra.com> wrote:
Dashboard:

BP:
Request URL: http://localhost:1337/member-measures/type
Method: POST
body: {mobile: "7838734118", type: "bp", startdate: "", enddate: "", datetype: ""}


spo2:

Request URL: http://localhost:1337/member-measures/type
Method: POST
body: {mobile: "7838734118", type: "spo2", startdate: "", enddate: "", datetype: ""}


sugar:

Request URL: http://localhost:1337/member-measures/type
Method: POST
body: {mobile: "7838734118", type: "sugar", startdate: "", enddate: "", datetype: ""}


ecg:

Request URL: http://localhost:1337/member-measures/type
Method: POST
body: {mobile: "7838734118", type: "ecg"}



With Filter: (Date format) and use the same in other vital types

{mobile: "7838734118", type: "bp", startdate: "2021-05-13 00:01", enddate: "2021-05-21 23:59",…}


Reports:
Request URL: http://localhost:1337/member-service-mappings?q={limit:6,page:1,short:[schedule_date,DESC],dquery:{family_member:99,type:[Lab,Radiology]}}
invoice >> Request URL: https://apis.care4parents.in/invoices?q={%22limit%22:25,%22page%22:1,%22short%22:[%22created_at%22,%22DESC%22],%22dquery%22:{%22user%22:75}}
previous reports>> Request URL:
https://apis.care4parents.in/member-reports?q={%22limit%22:6,%22page%22:1,%22short%22:[%22created_at%22,%22DESC%22],%22dquery%22:{%22family_member_id%22:%22103%22}}
activities>>> Request URL:
https://apis.care4parents.in/member-service-mappings?q={%22limit%22:6,%22page%22:1,%22short%22:[%22schedule_date%22,%22DESC%22],%22dquery%22:{%22family_member%22:%22103%22}}

eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjc1LCJyb2xlIjoxLCJlbWFpbCI6IndlYkBwaW5rc2hhc3RyYS5jb20iLCJ1c2VybmFtZSI6IkM0UC1kZW1vIiwiaWF0IjoxNjI3MDA1ODEyLCJleHAiOjE2MzQ3ODE4MTJ9.9IJIWKw9UGDVdu7yJSSZwxxfHaFqWkDFpak2UyBX8sY