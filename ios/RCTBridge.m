//
//  RCTBridge.m
//  ReactNativeBase
//
//  Created by Dung Pham on 06/12/2022.
//

#import <React/RCTBridgeModule.h>
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(NFCModule, RCTEventEmitter)
RCT_EXTERN_METHOD(showNFC: (NSString *)url token:(NSString *)token language:(NSString *)language dateOfBirthYYMMDD:(NSString *)dateOfBirthYYMMDD dateOfExpireYYMMDD:(NSString *)dateOfExpireYYMMDD cardID:(NSString *)cardID isCheckBCA:(BOOL *)isCheckBCA resolve:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
@end
