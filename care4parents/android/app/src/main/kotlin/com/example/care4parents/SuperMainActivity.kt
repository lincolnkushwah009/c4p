package com.pinkshastra.care4parents_app;


import android.annotation.SuppressLint
import android.content.Context
import android.os.BatteryManager
import android.os.Build.VERSION_CODES
import android.os.Environment
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import com.agatsa.sanketlife.callbacks.*
import com.agatsa.sanketlife.development.*
import com.loopj.android.http.AsyncHttpClient
import com.loopj.android.http.JsonHttpResponseHandler
import com.loopj.android.http.MySSLSocketFactory
import com.loopj.android.http.RequestParams
import cz.msebera.android.httpclient.Header
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.github.rybalkinsd.kohttp.dsl.async.httpPostAsync
import io.github.rybalkinsd.kohttp.ext.url
import kotlinx.coroutines.Deferred
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import okhttp3.Response
import org.json.JSONObject
import java.io.File
import java.io.FileNotFoundException
import java.security.KeyStore
import java.time.LocalDateTime

class SuperMainActivity: FlutterActivity() {

  private val SECRET_ID = "5a3b4c16b4a56b000132f5d5cee1924a6b0c41d0b732b6cd0bdcbf10"
  private val CLIENT_ID = "5a3b4c16b4a56b000132f5d58f6434c5358549f19ac4faac9e2523aa"

  private val CHANNEL = "com.agatsa.sanketlife/ecg"

  private var Result_Msg = "Pending"  

  private var MemberMobile = "0000000000"
  
  private val Authorization = "Bearer "

  //private var FileUploadURL = "http://192.168.1.11:8080/upload"
  //private var FileUploadURL = "http://192.168.1.6:1337/document/upload"
  
  private val FileUploadURL = "https://apis.care4parents.in/document/upload"

  //private var MemberMeasuresURL = "http://192.168.1.6:1337/member-measures"
  private val MemberMeasuresURL = "https://apis.care4parents.in/member-measures"

  @RequiresApi(VERSION_CODES.O)
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
        // Note: this method is invoked on the main thread.
        
          var membermobile: String = readSP("flutter.membermobile")
          var membername: String = readSP("flutter.membername")
          var memberage: String = readSP("flutter.memberage")
          var membergender: String = readSP("flutter.membergender")
          var token: String = readSP("flutter.token")
          token = Authorization + token
          println("SharedPreferences membermobile | $membermobile")
          println("SharedPreferences membername  | $membername")
          println("SharedPreferences memberage | $memberage")
          println("SharedPreferences membergender | $membergender")
          println("SharedPreferences token | $token")
        println("SharedPreferences Done | " + call.method) 
        if(call.method == "registerDevice") {
          println("call.method | 1" + call.method)
          Toast.makeText(applicationContext, "registerDevice", Toast.LENGTH_LONG).show()
          val initiateEcg = InitiateEcg()
          try {
            initiateEcg.registerDevice(applicationContext, CLIENT_ID, object : RegisterDeviceResponse {
              override fun onSuccess(success: String) {
                Toast.makeText(applicationContext, "registerDevice Success", Toast.LENGTH_SHORT).show()
                Toast.makeText(applicationContext, success, Toast.LENGTH_LONG).show()
                
                //println(getString(R.string.msg_device_registration_successfull))
                
                Result_Msg = success

                try {
                  GlobalScope.launch{
                    createSP("flutter." + call.method, Result_Msg)
                    println("SharedPreferences Empty Done | " + call.method) 
                  }
                } catch(e: Exception) {
                    println("Exception in SharedPreferences | " + call.method) 
                    println(e.message)
                }

                println(call.method + " -- Stored -- " + Result_Msg) 
              }

              override fun onError(errors: Errors) {
                Toast.makeText(applicationContext, "registerDevice Errors: " + errors.errorMsg, Toast.LENGTH_LONG).show()
                Result_Msg = errors.errorMsg
              }
            })
          } catch(e: Exception) {
              println("Exception | registerDevice") 
              println(e.message)
          }
        }

        if(call.method == "takeEcg") {
            var membermobile: String = readSP("flutter.membermobile")

            println("call.method | 2" + call.method +  membermobile)
//            println("SharedPreferences membermobile | $membermobile")
          Toast.makeText(applicationContext, "takeEcg L1", Toast.LENGTH_LONG).show()
          val initiateEcg = InitiateEcg()
          initiateEcg.takeEcg(applicationContext, SECRET_ID, false, 1, object : ResponseCallback {
            override fun onSuccess(success: Success) {
              Toast.makeText(applicationContext, "takeEcg L1 Success - " + success.successMsg, Toast.LENGTH_LONG).show()
              Result_Msg = success.successMsg
            }

            override fun onError(errors: Errors) {
              Toast.makeText(applicationContext, "takeEcg Errors: " + errors.errorMsg, Toast.LENGTH_LONG).show()
              Result_Msg = errors.errorMsg
            }
          })
        }

        if(call.method == "takeEcg2") {
          println("call.method | 3" + call.method)
          Toast.makeText(applicationContext, "takeEcg L2", Toast.LENGTH_LONG).show()
          val initiateEcg = InitiateEcg()
          initiateEcg.takeEcg(applicationContext, SECRET_ID, false, 8, object : ResponseCallback {
            @RequiresApi(VERSION_CODES.O)
            override fun onSuccess(success: Success) {
              println("onSuccess | takeEcg L2 Success") 
              Toast.makeText(applicationContext, "takeEcg L2 Success - " + success.successMsg, Toast.LENGTH_LONG).show()
              Result_Msg = success.successMsg

              println("takeEcg2 -- result -- $Result_Msg") 
              try {
                  MemberMobile = readSP("flutter.membermobile")
                  var _membername: String = readSP("flutter.membername")
                  var _memberage: String = readSP("flutter.memberage")
                  var _membergender: String = readSP("flutter.membergender")
                  var _token: String = readSP("flutter.token")
                  _token = Authorization + _token
                  println("UserDetails | $_membername -- $_memberage -- $_membergender -- $_token") 
                  GlobalScope.launch{
                    createPDF(MemberMobile, _token, UserDetails(_membername, _memberage, _membergender))
                    println("createPDF Method Done | " + call.method) 
                  }
              } catch(e: Exception) {
                  println("Exception - createPDF | " + call.method) 
                  println(e.message)
              }              

              // try {
              //     MemberMobile = readSP("flutter.membermobile")
              //     var _token: String = readSP("flutter.token")
              //     _token = Authorization + _token

              //     println("takeEcg2 -- _token -- $_token")

              //     fileUploadECG(MemberMobile, _token, "/storage/emulated/0/DCIM/sanket/06-11-2020_13_49_30.pdf")
              //     println("fileUploadECG Done | testing takeEcg2") 
              // } catch(e: Exception) {
              //     println("Exception in fileUploadECG | testing takeEcg2") 
              //     println(e.message)
              // }
            }

            override fun onError(errors: Errors) {
              println("onError | takeEcg L2 Errors") 
              Toast.makeText(applicationContext, "takeEcg L2 Errors: " + errors.errorMsg, Toast.LENGTH_LONG).show()
              Result_Msg = errors.errorMsg
            }
          })
        }

        if(call.method == "takeTemperature") {
          println("call.method | 4" + call.method)

          try {
            GlobalScope.launch{
              createSP("flutter." + call.method, "")
              println("SharedPreferences Empty Done | " + call.method) 
            }
          } catch(e: Exception) {
              println("Exception in SharedPreferences | " + call.method) 
              println(e.message)
          }

          val initiateVitals = InitiateVitals()
          initiateVitals.takeTemperature(applicationContext, false, SECRET_ID, object : TemperatureResponseCallback {
            @RequiresApi(VERSION_CODES.O)
            override fun onSuccess(success: Success, tempConfig: TempConfig) {
              Toast.makeText(applicationContext, "Temperature Success", Toast.LENGTH_SHORT).show()
              Toast.makeText(applicationContext, tempConfig.temperature.toString(), Toast.LENGTH_LONG).show()

              Result_Msg = tempConfig.temperature.toString()

              println("Result_Msg | $Result_Msg | " + call.method)
              try {
                GlobalScope.launch{
                  createSP("flutter." + call.method, Result_Msg)
                  println("SharedPreferences Done | " + call.method) 
                }
              } catch(e: Exception) {
                  println("Exception in SharedPreferences | " + call.method) 
                  println(e.message)
              }

              println(call.method + " -- Stored -- " + Result_Msg) 
              println("Calling Post API | " + call.method) 

              try {
                MemberMobile = readSP("flutter.membermobile")
                var _token: String = readSP("flutter.token")
                _token = Authorization + _token
                GlobalScope.launch{
                  sendMeasure(MemberMobile, "temprature", Result_Msg, _token)
                  println("Post API Done") 
                }
              } catch(e: Exception) {
                  println("Exception in Post API | " + call.method) 
                  println(e.message)
              }
            }

            override fun onError(errors: Errors) {
              Toast.makeText(applicationContext, "Temperature Errors: " + errors.errorMsg, Toast.LENGTH_LONG).show()
              Result_Msg = errors.errorMsg
            }
          })
        }

        if(call.method == "takeBP") {
          println("call.method | 5" + call.method)
          try {
            GlobalScope.launch{
              createSP("flutter." + call.method, "")
              println("SharedPreferences Empty Done | " + call.method) 
            }
          } catch(e: Exception) {
              println("Exception in SharedPreferences | " + call.method) 
              println(e.message)
          }

          val initiateVitals = InitiateVitals()
          initiateVitals.takeBP(applicationContext, false, SECRET_ID, object : BPResponseCallback {
            override fun onSuccess(success: Success, bpConfig: BPConfig) {
              Toast.makeText(applicationContext, "Blood Pressure Success", Toast.LENGTH_LONG).show()
              Toast.makeText(applicationContext, "{ Systolic :" + bpConfig.systolic.toString() + ", Diastolic :" + bpConfig.diastolic.toString() + "}", Toast.LENGTH_LONG).show()
              
              Result_Msg = "Systolic: " + bpConfig.systolic.toString() + ", Diastolic: " + bpConfig.diastolic.toString()

              println("Result_Msg | $Result_Msg | " + call.method)
              try {
                GlobalScope.launch{
                  createSP("flutter." + call.method, Result_Msg)
                  println("SharedPreferences Done | " + call.method) 
                }
              } catch(e: Exception) {
                println("Exception in SharedPreferences | " + call.method) 
                println(e.message)
              }

              println(call.method + " -- Stored -- " + Result_Msg) 
              println("Calling Post API | " + call.method) 
              
              try {
                MemberMobile = readSP("flutter.membermobile")
                var _token: String = readSP("flutter.token")
                _token = Authorization + _token
                GlobalScope.launch{
                  sendMeasure(MemberMobile, "bp", Result_Msg, _token)
                  println("Post API Done") 
                }
              } catch(e: Exception) {
                println("Exception in Post API | " + call.method) 
                println(e.message)
              }
            }

            override fun onError(errors: Errors) {
              Toast.makeText(applicationContext, "Blood Pressure Errors: " + errors.errorMsg, Toast.LENGTH_LONG).show()
              Result_Msg = errors.errorMsg
            }
          })
        }

        if(call.method == "takeSpo2") {
         println("call.method | 6" + call.method)
      
          try {
            GlobalScope.launch{
              createSP("flutter." + call.method, "")
              println("SharedPreferences Empty Done | Spo2")  
            }
          } catch(e: Exception) {
              println("Exception in SharedPreferences | takeSpo2") 
              println(e.message)
          }

          val initiateVitals = InitiateVitals()
          initiateVitals.takeSpo2(applicationContext, false, SECRET_ID, object : Spo2ResponseCallback {
            override fun onSuccess(success: Success, spo2Config: Spo2Config) {
              Toast.makeText(applicationContext, "Spo2 Success", Toast.LENGTH_LONG).show()
              //Toast.makeText(applicationContext, success.successMsg, Toast.LENGTH_LONG).show()
              
              Result_Msg = spo2Config.spo2.toString()
              println("Result_Msg | $Result_Msg | " + call.method)
              try {
                GlobalScope.launch{
                  createSP("flutter." + call.method, Result_Msg)
                  println("SharedPreferences Done | " + call.method) 
                }
              } catch(e: Exception) {
                  println("Exception in SharedPreferences | " + call.method) 
                  println(e.message)
              }

              println(call.method + " -- Stored -- " + Result_Msg)                 
              println("Calling Post API | " + call.method) 

              try {
                MemberMobile = readSP("flutter.membermobile")
                var _token: String = readSP("flutter.token")
                _token = Authorization + _token
                GlobalScope.launch{
                  sendMeasure(MemberMobile, "spo2", Result_Msg, _token)
                  println("Post API Done") 
                }
              } catch(e: Exception) {
                  println("Exception in Post API | " + call.method) 
                  println(e.message)
              }
            }

            override fun onError(errors: Errors) {
              Toast.makeText(applicationContext, "Spo2 Errors: " + errors.errorMsg, Toast.LENGTH_LONG).show()
              Result_Msg = errors.errorMsg
            }
          })
        }

        if (call.method == "appointment") {
          println("call.method | 7" + call.method)   

          try {
              var membermobile: String = readSP("flutter.membermobile")
              var membername: String = readSP("flutter.membername")
              var memberage: String = readSP("flutter.memberage")
              var membergender: String = readSP("flutter.membergender")
              var token: String = readSP("flutter.token")
              token = Authorization + token
              println("SharedPreferences membermobile | $membermobile")
              println("SharedPreferences membername  | $membername")
              println("SharedPreferences memberage | $memberage")
              println("SharedPreferences membergender | $membergender")
              println("SharedPreferences token | $token")
              println("SharedPreferences Done | " + call.method) 
          } catch(e: Exception) {
              println("Exception in SharedPreferences | " + call.method) 
              println(e.message)
          }

          // try {
          //     fileUploadECG(MemberMobile, token, "/storage/emulated/0/DCIM/sanket/06-11-2020_13_49_30.pdf")
          //     println("fileUploadECG Done") 
          // } catch(e: Exception) {
          //     println("Exception in fileUploadECG | makePDF") 
          //     println(e.message)
          // }
        } 

        if (call.method == "getBatteryLevel") {
          val batteryLevel = getBatteryLevel()
  
          if (batteryLevel != -1) {
            result.success(batteryLevel)
          } else {
            result.error("UNAVAILABLE", "Battery level not available.", null)
          }
        }            
        else {
          //result.notImplemented()
        }

      result.success(Result_Msg)
    }
  }

  @RequiresApi(VERSION_CODES.LOLLIPOP)
  private fun getBatteryLevel(): Int {
    val batteryLevel: Int
      val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
      batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)

      return batteryLevel
  }

  @RequiresApi(VERSION_CODES.O)
  suspend fun createPDF(mobile: String, token: String, userDetails: UserDetails) {
    println("createPDF")     
    val initiateEcg = InitiateEcg()
    initiateEcg.saveEcgData(applicationContext, SECRET_ID, object : SaveEcgCallBack {
      @RequiresApi(VERSION_CODES.O)
      override fun onSuccess(success: Success, ecgConfig: EcgConfig) {

        println(success.successMsg) 
        println(ecgConfig.getFileUrl()) 

        Result_Msg = success.successMsg

        try {
          GlobalScope.launch{
            makePDF(mobile, token, ecgConfig, userDetails)
            println("makePDF method done") 
          }
        } catch(e: Exception) {
            println("Exception in calling makePDF") 
            println(e.message)
        }          
      }

      override fun onError(errors: Errors) {
        println("onError - Exception | createPDF") 
        println(errors.errorMsg)
      }
    })
  }

  @RequiresApi(VERSION_CODES.O)
  suspend fun makePDF(mobile: String, token: String, ecgConfig: EcgConfig, userDetails: UserDetails){
    println("makePDF") 
    val initiateEcg = InitiateEcg()
    initiateEcg.makeEcgReport(applicationContext, userDetails, true, SECRET_ID, ecgConfig, object : PdfCallback {
        override fun onPdfAvailable(ecgConfig: EcgConfig) {
          println("makePDF - onPdfAvailable") 
          println(ecgConfig.getFileUrl()) 

          try {
              //fileUploadECG(mobile, token, "/storage/emulated/0/DCIM/sanket/06-11-2020_13_49_30.pdf")
              fileUploadECG(mobile, token, ecgConfig.getFileUrl())
              println("fileUploadECG Done") 
          } catch(e: Exception) {
              println("Exception in fileUploadECG | makePDF") 
              println(e.message)
          }

          // try {
          //   GlobalScope.launch{
          //     fileUploadECG(mobile, token, "/storage/emulated/0/DCIM/sanket/06-11-2020_13_49_30.pdf")
          //     //fileUploadECG(mobile, token, ecgConfig.getFileUrl())
          //     println("fileUploadECG Done") 
          //   }
          // } catch(e: Exception) {
          //     println("Exception in fileUploadECG | makePDF") 
          //     println(e.message)
          // }
        }

        override fun onError(errors: Errors) {
          println("onError - Exception | makePDF") 
          println(errors.errorMsg)
        }
    });
  }

  @RequiresApi(VERSION_CODES.O)
  suspend fun sendEcgMeasure(mobile: String, token: String, ecgfiles: JSONObject): Response? {
    try{
      println("sendEcgMeasure token -- $mobile")
      val response: Deferred<Response> = httpPostAsync {
          url(MemberMeasuresURL)
          header { "Authorization" to token }
          body {
              form {
                  "mobile" to mobile
                  "device" to "android"
                  "type" to "ecg"
                  "ecgfiles" to ecgfiles
                  "measureOn" to LocalDateTime.now()
              }
          }
      }
      return response.await() 
    } 
    catch(e: Exception) {
      println("Exception sendEcgMeasure at data | Post") 
      println(e.message)
    }
    return null 
  }

  @RequiresApi(VERSION_CODES.O)
  suspend fun sendMeasure(mobile: String, type: String, value: String, token: String): Response? {
    try{
      println("sendMeasure tokensendMe -- $mobile --- time ---- "+LocalDateTime.now())
      val response: Deferred<Response> = httpPostAsync {
          url(MemberMeasuresURL)
          header { "Authorization" to token }
          body {
              form {
                  "mobile" to mobile
                  "device" to "android"
                  "type" to type
                  "value" to value
                  "measureOn" to LocalDateTime.now()
              }
          }
      }
      return response.await() 
    } 
    catch(e: Exception) {
      println("Exception sendMeasure at data | Post") 
      println(e.message)
    }
    return null 
  }

  // @RequiresApi(VERSION_CODES.O)
  // suspend fun fileUploadECG(mobile: String, token: String, filePath: String){
  fun fileUploadECG(mobile: String, token: String, filePath: String){
    println("Uploading pdf file at Server URL | $FileUploadURL | $filePath | $token")
    try 
      {
        val ecgFile = File(filePath)
        println("ecgFile") 
        val params = RequestParams()
        println("params")                   
        try {
          params.put("document", ecgFile)
          //params.put("file", ecgFile)
        } catch(e: FileNotFoundException) {
          println("Exception FileNotFoundException") 
          println(e.message)
        }
        println("params.put - ECG_Report") 

        val client = AsyncHttpClient()
        
        val trustStore = KeyStore.getInstance(KeyStore.getDefaultType())
        trustStore.load(null, null)
        val sf = MySSLSocketFactory(trustStore)
        sf.hostnameVerifier = MySSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER
        
        client.setSSLSocketFactory(sf)
        println("client.setSSLSocketFactory") 

        client.addHeader("Authorization", token)
        
        client.setTimeout(60000)
        client.post(FileUploadURL, params , object : JsonHttpResponseHandler() {

            override fun onStart() {
                println("params.put - ECG_Report - Upload - onStart") 
            }

            @RequiresApi(VERSION_CODES.O)
            override fun onSuccess(statusCode: Int, headers: Array<out Header>?, response: JSONObject?) {
              println("params.put - ECG_Report - Upload - onSuccess") 
              println(response.toString())
              
              try {
                GlobalScope.launch{
                  if (response != null) {
                    sendEcgMeasure(mobile, token, response)
                  }
                  println("ECG | Post API Done") 
                }
              } catch(e: Exception) {
                println("Exception in Post API | ECG") 
                println(e.message)
              }

              var docurl: String? = response?.getString("docurl")
              if (docurl != null && docurl.isNotEmpty()) {
                println("docurl -- $docurl")
                try {
                  GlobalScope.launch{
                    createSP("flutter.takeEcg2", docurl)
                    println("SharedPreferences Done | takeEcg2")
                  }
                } catch(e: Exception) {
                    println("Exception in SharedPreferences | fileUploadECG - takeEcg2")
                    println(e.message)
                }
              }
              
              val dirPath = Environment.DIRECTORY_DCIM + "/sanket"
              if(dirPath.isNotEmpty()){
                println("File to Remove Directory Path | $dirPath") 
                val dir = File(dirPath)
                //dir.deleteRecursively()
              }
            }
            
            //if(ecgFile.exists()) ecgFile.delete();

            override fun onFailure(statusCode: Int, headers: Array<out Header>?, e: Throwable?, errorResponse: JSONObject?) {
              println("params.put - ECG_Report - Upload - onFailure") 
              println(errorResponse.toString())
            }
        })

      } catch(e: Exception) {
          println("Exception | fileUploadECG") 
          println(e.message)
      }
      
      println("ECG_Report PDF file Uploading DONE") 
  }

  @RequiresApi(VERSION_CODES.O)
  suspend fun createSP(key: String, value:String) {
    println("createSP")
    println("$key -- $value")
    try{
      val sp = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
      val editor = sp.edit()
      editor.putString(key, value)
      editor.apply()
      //editor.commit()
    } 
    catch(e: Exception) {
      println("Exception Create | SharedPreferences") 
      println(e.message)
    }
  }

  @SuppressLint("CommitPrefEdits")
  fun readSP(key: String): String{
    println("readSP -- $key")
    var value: String = ""
    try{
      val sp = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE);
      value = sp.getString(key, "").toString()
    } 
    catch(e: Exception) {
      println("Exception readSP | SharedPreferences") 
      println(e.message)
    }
    return value
  }

  @SuppressLint("CommitPrefEdits")
  fun readIntSP(key: String): Int{
    println("readIntSP -- $key")
    var value: Int = 0
    try{
      val sp = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
      value = sp.getInt(key, 0)
      println("readIntSP -- $key -- $value")
    } 
    catch(e: Exception) {
      println("Exception readIntSP | SharedPreferences") 
      println(e.message)
    }
    return value
  }
}
