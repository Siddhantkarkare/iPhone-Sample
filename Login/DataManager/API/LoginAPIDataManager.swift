
import Foundation
import Alamofire
class LoginAPIDataManager: LoginAPIDataManagerInputProtocol
{
    var remoteRequestHandler: LoginAPIDataManagerOutputProtocol?
    init() {}
    //Login api call
    func Login(userNam:String,password:String) {
        let deviceID: String = UIDevice.current.identifierForVendor!.uuidString
        UserDefaults.standard.setValue(deviceID, forKey: "auth-deviceId")
        let prm:Parameters  = ["password":password,"deviceId": deviceID,"username":userNam]
        //calling custom core class for networking
        MasterWebService.sharedInstance.POST_webservice(Url: EndPoints.authLoginURL, prm: prm, background: false,completion: { _result,_statusCode in
            print(_result) as Any
            if _statusCode == 200{
                UserDefaults.standard.setValue(userNam, forKey: "userName")
            }
            self.remoteRequestHandler?.onLoginResponse(status:(_statusCode?.description)!)
        })
    }
    
    //Forgot api call
    func forgotApiCall(email:String){
        let prm:Parameters  = ["username":email]
        MasterWebService.sharedInstance.POST_webservice(Url: EndPoints.recoverPassURL, prm: prm, background: false,completion: { _result,_statusCode in
            self.remoteRequestHandler?.onForgotResponse(status:(_statusCode?.description)!)
        })
        
    }
}
