//
//  Dashboard.h
//  PTFS
//
//  Created by Qiang Ju on 12/29/17.
//  Copyright © 2017 Qiang Ju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dashboard : NSObject
@property NSString* Id;
@property NSString* Name;
@property long RefreshInterval;
@property NSString* URL;
@property long Position;

+(NSMutableArray*) getListByProjectID:(NSString*) prjID TeamID:(NSString*) teamID;
+(NSMutableArray*) getFormalListByProjectID:(NSString*) prjID;
@end
