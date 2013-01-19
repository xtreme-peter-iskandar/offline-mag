//
//  BaseModel.m
//  frank_and_oak
//
//  Created by DX102 on 2012-11-05.
//  Copyright (c) 2012 Xtreme Labs Inc. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (BOOL)populateObjectFromJSON:(NSDictionary*)data {
    return NO;
}

- (BOOL)isValidObject {
    return NO;
}

- (BOOL)isStatusOK:(NSDictionary *)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSString *status = [data objectForKey:@"status"];
        if ([status isKindOfClass:[NSString class]] && [status isEqualToString:@"success"]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)getJSONRepresentation {
    return @"";
}

@end
