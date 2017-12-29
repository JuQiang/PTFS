//
//  Helper.h
//  PTFS
//
//  Created by Qiang Ju on 12/27/17.
//  Copyright © 2017 Qiang Ju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

+(void) HttpGet:(NSString*) url success:(void (^)(NSString* response))success failure:(void(^)(NSError* error))failure;
+(void) Login:(NSString*)server username:(NSString*)user password:(NSString*)pass success:(void (^)(NSString* response))success failure:(void(^)(NSError* error))failure;

+ (NSString*) getUserName;
+(void) setUserName:(NSString*) user;
+ (NSString*) getPassWord;
+(void) setPassWord:(NSString*) pass;
+ (NSString*) getServer;
+(void) setServer:(NSString*) server;

+(NSDictionary*) getHttpResponseByUrl:(NSString*)url;

@end
