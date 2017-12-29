//
//  Helper.m
//  PTFS
//
//  Created by Qiang Ju on 12/27/17.
//  Copyright © 2017 Qiang Ju. All rights reserved.
//

#import "Helper.h"

@implementation Helper

static NSString* UserName;
static NSString* PassWord;
static NSString* Server;

+(NSString*) getUserName{
    return UserName;
}
+(void) setUserName:(NSString*) user{
    UserName = user;
}

+(NSString*) getPassWord{
    return PassWord;
}
+(void) setPassWord:(NSString*) pass{
    PassWord = pass;
}

+(NSString*) getServer{
    return Server;
}
+(void) setServer:(NSString*) server{
    Server = server;
}

+(void) Login:(NSString*)server username:(NSString*)user password:(NSString*)pass success:(void (^)(NSString* response))success failure:(void(^)(NSError* error))failure{

    
    Helper.UserName = user;
    Helper.PassWord = pass;
    Helper.Server = server;
    
    [Helper HttpGet:
            [NSString stringWithFormat:@"%@/_apis/process/processes?api-version=1.0",server]
            success:success
            failure:failure
     ];
    
}

+(void) HttpGet:(NSString*) url success:(void (^)(NSString* response))success failure:(void(^)(NSError* error))failure{
    NSURLSessionConfiguration* cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSString* mix = [NSString stringWithFormat:@"%@:%@",[Helper getUserName],[Helper getPassWord]];
    NSData* data = [mix dataUsingEncoding:NSUTF8StringEncoding];
    NSString* base64 = [data base64EncodedStringWithOptions:0];
    NSString* auth = [NSString stringWithFormat:@"Basic:%@",base64];
    
    cfg.HTTPAdditionalHeaders=@{@"Accept":@"application/json",@"Authorization":auth};
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:cfg];
    
    [[session
            dataTaskWithURL:[NSURL URLWithString:url]
            completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
                if(error == nil){
                    
                    success([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                    
                    
                }
                else{
                    failure(error);
                }
            }
   ] resume];
}

+(NSDictionary*) getHttpResponseByUrl:(NSString*)url{
    NSURL* nsurl = [[NSURL alloc] initWithString:url];
    
    NSURLResponse* response = [NSURLResponse new];
    NSError* error = [NSError new];
    
    NSString* authString = [NSString stringWithFormat:@"%@:%@",[Helper getUserName],[Helper getPassWord]];
    NSData* authData = [authString dataUsingEncoding:NSUTF8StringEncoding];
    NSString* base64 = [authData base64EncodedStringWithOptions:0];
    NSString* auth = [NSString stringWithFormat:@"Basic:%@",base64];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:nsurl];
    [request setValue:auth forHTTPHeaderField:@"Authorization"];
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSError* error2 = [NSError new];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error2];
    
}

@end
