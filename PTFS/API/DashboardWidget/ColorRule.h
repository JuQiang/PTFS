//
//  ColorRule.h
//  PTFS
//
//  Created by Qiang Ju on 12/31/17.
//  Copyright © 2017 Qiang Ju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorRule : NSObject
@property Boolean IsEnabled;
@property NSString* BackgroundColor;
@property long ThresholdCount;
@property NSString* Operator;
@end
