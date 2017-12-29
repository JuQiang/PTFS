//
//  Team.h
//  PTFS
//
//  Created by Qiang Ju on 12/29/17.
//  Copyright © 2017 Qiang Ju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject

@property NSString* Id;
@property NSString* Name;
@property NSString* URL;
@property NSString* Description;
@property NSString* IdentityURL;

+(NSMutableArray*) getListByProjectID:(NSString*) prjID;

@end
