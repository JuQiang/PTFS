//
//  Dashboard.m
//  PTFS
//
//  Created by Qiang Ju on 12/29/17.
//  Copyright © 2017 Qiang Ju. All rights reserved.
//

#import "Dashboard.h"
#import "helper.h"
#import "team.h"
#import "Project.h"

@implementation Dashboard

+(NSMutableArray*) getListByProjectID:(NSString*) prjID TeamID:(NSString*) teamID{
    NSMutableArray* array = [NSMutableArray new];
    
    NSDictionary* json = [Helper getHttpResponseByUrl:[NSString stringWithFormat:@"%@/%@/_apis/dashboard/groups/%@?apiversion=2.0",[Helper getServer],prjID,teamID]];
    
    NSArray* entries = [json objectForKey:@"dashboardEntries"];
    for(int i=0;i<entries.count;i++){
        NSDictionary* dict = entries[i];
        Dashboard* db = [Dashboard alloc];
        
        db.Id = [dict objectForKey:@"id"];
        db.Position = [[dict objectForKey:@"position"] longValue];
        db.RefreshInterval = [[dict objectForKey:@"refreshInterval"] longValue];
        db.URL = [dict objectForKey:@"url"];
        db.Name = [dict objectForKey:@"name"];
        
        [array addObject:db];
    }
    return array;
}

+(NSMutableArray*) getFormalListByProjectID:(NSString*) prjID{
    NSMutableArray* array = [NSMutableArray new];
    NSMutableArray* teamlist = [Team getListByProjectID:prjID];
    for(int j=0;j<teamlist.count;j++){
        
        NSMutableArray* dblist = [Dashboard getListByProjectID:prjID TeamID:((Team*)teamlist[j]).Id];
        for(int k=0;k<dblist.count;k++){
            if([((Dashboard*)dblist[k]).Name isEqualToString:@"概述"])continue;
            
            [array addObject:dblist[k]];
        }
    }
    
    return array;
}
@end
