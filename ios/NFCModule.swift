//
//  NFCModule.swift
//  ReactNativeBase
//
//  Created by Dung Pham on 06/12/2022.
//

import Foundation
import UIKit
import AVFoundation
import NFCReader


var NFC_READY_TO_SCAN = "";
var NFC_AUTHENTICATING = "";
var NFC_READING_DATA = "";
var NFC_SUCCESSFUL = "";
var NFC_ERROR = ""

@objc(NFCModule)
class NFCModule: RCTEventEmitter {
  
  
  
  @available(iOS 13, *)
  @objc
  func showNFC(_ url: String, token: String, language: String, dateOfBirthYYMMDD: String, dateOfExpireYYMMDD: String, cardID: String, isCheckBCA: Bool, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) {
    
    let nfc = NFCManager(dateOfBirthYYMMDD: dateOfBirthYYMMDD,
                              dateOfExpireYYMMDD: dateOfExpireYYMMDD,
                              cardID: cardID,
                              isCheckBCA: isCheckBCA)
    nfc.setDomainURL(url)
    nfc.setToken(token)
    nfc.setLanguage(language)
    if(language == "vi"){
      NFC_READY_TO_SCAN = "Sẵn sàng quét";
      NFC_READING_DATA = "Đang đọc dữ liệu";
      NFC_SUCCESSFUL = "Thành công";
      NFC_ERROR = "Có lỗi xảy ra";
    }else{
      NFC_READY_TO_SCAN = "READY_TO_SCAN";
      NFC_READING_DATA = "READING_DATA";
      NFC_SUCCESSFUL = "SUCCESSFUL";
      NFC_ERROR = "ERROR";
    }
    
    nfc.scanPassport()
    
    nfc.delegate = self
  }
  
  override func supportedEvents() -> [String]! {
      return ["NFCNotAvailable", "NFCSuccess", "NFCFail", "VerifySuccess", "VerifyFail"]
    }

}


@available(iOS 13, *)
extension NFCModule: NFCDelegate {
  func NFCSuccess() {

  }
  
//  func NFCSuccess(model: NFCReader.NFCPassportModel) {
//    sendEvent(withName: "NFCSuccess", body: ["data": model])
//  }
  
  func NFCNotAvaiable() {
    sendEvent(withName: "NFCNotAvailable", body: [])
  }
  
  func NFCMessageDisplay(_ messages: NFCReader.NFCViewDisplayMessage) -> String {
    
    switch messages {
             case .requestPresentPassport:
      return  NFC_READY_TO_SCAN;
             case .authenticatingWithPassport(_):
      return   "";
             case .readingDataGroupProgress( _, _):
      return  NFC_READING_DATA;
             case .successfulRead:
      return  NFC_SUCCESSFUL;
    case .error(_):
      return  NFC_ERROR;
    @unknown default:
      return ""
    }
  }
  
  func NFCFail(_ error: NFCReader.NFCPassportReaderError) {
    DispatchQueue.main.async {
      self.sendEvent(withName: "NFCFail", body: ["data":error])
      
    }
  }
  
  func VerifySuccess(jsonData: NFCReader.JSON) {
    let data = jsonData.rawString()
        sendEvent(withName: "VerifySuccess", body: ["data": data])
  }
  
  func VerifyFail(_ error: NFCReader.AFError) {
    sendEvent(withName: "VerifyFail", body: ["data": error])
  }
 
  

//  func NFCNotAvaiable() {
//    sendEvent(withName: "NFCNotAvailable", body: [])
//  }
//
//  func NFCMessageDisplay(_ messages: NFCViewDisplayMessage) -> String {
//
//         switch messages {
//            case .requestPresentPassport:
//                 return  ""
//            case .authenticatingWithPassport(_):
//                 return  ""
//            case .readingDataGroupProgress( _, _):
//                 return  ""
//            case .successfulRead:
//                 return  ""
//         case .error(_):
//                 return  ""
//
//  }
//
//
//
//  func NFCFail(_ error: NFCReader.NFCPassportReaderError) {
//      // Handle in main queue
//    DispatchQueue.main.async {
//      self.sendEvent(withName: "NFCFail", body: [])
//    }
//  }
//
//  func VerifySuccess(jsonData: NFCReader.JSON) {
//    let data = jsonData.rawString()
//    sendEvent(withName: "VerifySuccess", body: ["data": data])
//  }
//
//  func VerifyFail(_ error: NFCReader.AFError) {
//    sendEvent(withName: "VerifyFail", body: ["data": error])
//  }
  
//  func NFCSuccess(model: NFCReader.NFCPassportModel) {
//    sendEvent(withName: "NFCSuccess", body: ["data": model])
//  }
//
//  func NFCFail(_ error: NFCReader.NFCPassportReaderError) {
//    sendEvent(withName: "NFCFail", body: ["data": error])
//  }
//
//  func VerifySuccess(jsonData: NFCReader.JSON) {
//    let data = jsonData.rawString()
//    sendEvent(withName: "VerifySuccess", body: data)
//  }
//
//  func VerifyFail(_ error: NFCReader.AFError) {
//    sendEvent(withName: "VerifyFail", body: ["data": error])
//  }
}


