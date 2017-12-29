//
//  ProjectEntity.m
//  PTFS
//
//  Created by Qiang Ju on 12/28/17.
//  Copyright © 2017 Qiang Ju. All rights reserved.
//

#import "Project.h"
#import "Helper.h"

@implementation Project

+(NSMutableArray*) getList{
    NSMutableArray* array = [NSMutableArray new];
    
    NSDictionary* json = [Helper getHttpResponseByUrl:[NSString stringWithFormat:@"%@/_apis/projects?api-version=2.0",[Helper getServer]]];
    
    int count = [(NSNumber*)[json objectForKey:@"count"] intValue];
    for(int i=0;i<count;i++){
        NSDictionary* dict = [json objectForKey:@"value"][i];
        Project* prj = [Project alloc];
        
        prj.Id = [dict objectForKey:@"id"];
        prj.Revision = [[dict objectForKey:@"revision"] longValue];
        prj.State = [dict objectForKey:@"state"];
        prj.Name = [dict objectForKey:@"name"];
        prj.Description = [dict objectForKey:@"description"];
        prj.URL = [dict objectForKey:@"url"];
        
        [array addObject:prj];
    }
    return array;
}

@end
