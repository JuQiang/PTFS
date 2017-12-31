//
//  Widget.h
//  PTFS
//
//  Created by Qiang Ju on 12/31/17.
//  Copyright © 2017 Qiang Ju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Position.h"
#import "TFSSize.h"
#import "Settings.h"
#import "SettingsVersion.h"

@interface Widget : NSObject
@property NSString* Id;
@property NSString* ArtifactId;
@property SettingsVersion* SettingsVersion;
@property Position* Position;
@property NSString* ContentUri;
@property NSString* TypeId;
@property NSString* LoadingImageUrl;
@property NSString* Url;
@property Boolean IsNameConfigurable;
@property TFSSize* Size;
@property NSString* ContributorId;
@property NSString* ConfigurationContributorId;
@property NSString* Name;
@property Boolean IsEnabled;
@property Settings* Settings;

+(NSMutableArray*) getListByDashboard:(NSString*) dbid;

@end
