//
//  ProjectEntity.h
//  PTFS
//
//  Created by Qiang Ju on 12/28/17.
//  Copyright © 2017 Qiang Ju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject

@property NSString* Id;
@property NSString* Name;
@property NSString* Description;
@property NSString* URL;
@property NSString* State;
@property long Revision;

+(NSMutableArray*) getList;

@end
