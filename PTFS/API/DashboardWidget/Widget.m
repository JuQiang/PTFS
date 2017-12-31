//
//  Widget.m
//  PTFS
//
//  Created by Qiang Ju on 12/31/17.
//  Copyright © 2017 Qiang Ju. All rights reserved.
//

#import "Widget.h"
#import "Helper.h"
#import "ColorRule.h"

@implementation Widget

+(NSMutableArray*) getListByDashboard:(NSString*) dburl{
    NSMutableArray* array = [NSMutableArray new];
    
    NSDictionary* dict = [Helper getHttpResponseByUrl:dburl];
    NSArray* widgets = [dict objectForKey:@"widgets"];
    for(int i=0;i<widgets.count;i++){
        NSDictionary* tmp = (NSDictionary*)widgets[i];
        
        Widget* widget = [Widget alloc];
        
        widget.Id = [tmp objectForKey:@"id"];
        widget.ArtifactId = [tmp objectForKey:@"artifactId"];
        widget.ContentUri = [tmp objectForKey:@"contentUri"];
        widget.TypeId = [tmp objectForKey:@"typeId"];
        widget.LoadingImageUrl = [tmp objectForKey:@"loadingImageUrl"];
        widget.Url = [tmp objectForKey:@"url"];
        widget.ContributorId = [tmp objectForKey:@"contributorId"];
        widget.ConfigurationContributorId = [tmp objectForKey:@"configurationContributorId"];
        widget.Name = [tmp objectForKey:@"name"];
        
        NSDictionary* sv =[tmp objectForKey:@"settingsVersion"];
        
        widget.SettingsVersion = [SettingsVersion alloc];
        if(sv!=[NSNull null]){
            widget.SettingsVersion.Major = [[sv objectForKey:@"major"] longValue];
            widget.SettingsVersion.Minor = [[sv objectForKey:@"minor"] longValue];
            widget.SettingsVersion.Patch = [[sv objectForKey:@"patch"] longValue];
        }
        
        widget.IsNameConfigurable = [[tmp objectForKey:@"isNameConfigurable"] boolValue];
        widget.IsEnabled = [[tmp objectForKey:@"isEnabled"] boolValue];
        
        NSDictionary* p =[tmp objectForKey:@"position"];
        widget.Position = [Position alloc];
        if(p!=[NSNull null])
            widget.Position.Row = [[p objectForKey:@"row"] longValue];
        widget.Position.Column = [[p objectForKey:@"column"] longValue];
        
        
        widget.Size = [TFSSize alloc];
        NSDictionary* size =[tmp objectForKey:@"size"];
        if(size!=[NSNull null]){
            widget.Size.RowSpan = [[size objectForKey:@"rowSpan"] longValue];
            widget.Size.ColumnSpan = [[size objectForKey:@"columnSpan"] longValue];
        }
        
        widget.Settings = [Settings alloc];
        if([tmp objectForKey:@"settings"]!=[NSNull null]){
            NSData* jd = [[tmp objectForKey:@"settings"] dataUsingEncoding:NSUTF8StringEncoding];
            NSError* err;
            NSDictionary * settings = [NSJSONSerialization JSONObjectWithData:jd options:NSJSONReadingMutableContainers error:&err];
            if(!err){
                
                widget.Settings.QueryId = [settings objectForKey:@"queryId"];
                widget.Settings.QueryName = [settings objectForKey:@"queryName"];
                
                NSArray* rules = [settings objectForKey:@"colorRules"];
                widget.Settings.ColorRuleList = [NSMutableArray new];
                if(rules!=[NSNull null]){
                    for(int j=0;j<rules.count;j++){
                        ColorRule* rule = [ColorRule alloc];
                        NSDictionary* ruledic = (NSDictionary*)rules[j];
                        rule.IsEnabled = [[ruledic objectForKey:@"isEnabled"] boolValue];
                        rule.BackgroundColor = [ruledic objectForKey:@"backgroundColor"];
                        rule.ThresholdCount = [[ruledic objectForKey:@"thresholdCount"] longValue];
                        rule.Operator = [ruledic objectForKey:@"operator"];
                        
                        [widget.Settings.ColorRuleList addObject:rule];
                    }
                }
            }
        }
        [array addObject:widget];
    }
    
    return array;
}

@end
