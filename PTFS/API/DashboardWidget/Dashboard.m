//
//  Dashboard.m
//  PTFS
//
//  Created by Qiang Ju on 12/29/17.
//  Copyright © 2017 Qiang Ju. All rights reserved.
//

#import "Dashboard.h"
#import "helper.h"

@implementation Dashboard

+(NSMutableArray*) getListByProjectID:(NSString*) prjID TeamID:(NSString*) teamID{
    NSMutableArray* array = [NSMutableArray new];
    
    NSDictionary* json = [Helper getHttpResponseByUrl:[NSString stringWithFormat:@"%@/%@/%@/_apis/dashboard/dashboards/?api-version=3.0-preview.2",[Helper getServer],prjID,teamID]];
    
    int count = [(NSNumber*)[json objectForKey:@"count"] intValue];
    for(int i=0;i<count;i++){
        NSDictionary* dict = [json objectForKey:@"value"][i];
        Dashboard* db = [Dashboard alloc];
        
        db.Id = [dict objectForKey:@"id"];
        
        db.Name = [dict objectForKey:@"name"];
        
        [array addObject:db];
    }
    return array;
}
@end
