//
//  Team.m
//  PTFS
//
//  Created by Qiang Ju on 12/29/17.
//  Copyright © 2017 Qiang Ju. All rights reserved.
//

#import "Team.h"
#import "Helper.h"

@implementation Team

+(NSMutableArray*) getListByProjectID:(NSString*) prjID{
    NSMutableArray* array = [NSMutableArray new];
    
    NSDictionary* json = [Helper getHttpResponseByUrl:[NSString stringWithFormat:@"%@/_apis/projects/%@/teams?api-version=1.0",[Helper getServer],prjID]];
    
    int count = [(NSNumber*)[json objectForKey:@"count"] intValue];
    for(int i=0;i<count;i++){
        NSDictionary* dict = [json objectForKey:@"value"][i];
        Team* team = [Team alloc];
        
        team.Id = [dict objectForKey:@"id"];
        team.IdentityURL = [dict objectForKey:@"identityUrl"];
        team.Name = [dict objectForKey:@"name"];
        team.Description = [dict objectForKey:@"description"];
        team.URL = [dict objectForKey:@"url"];
        
        [array addObject:team];
    }
    return array;    
}

@end
