//
//  Utility.m
//  offline-website-poc
//
//  Created by DX 116 on 2013-01-19.
//  Copyright (c) 2013 xtremelabs. All rights reserved.
//

#import "Utility.h"

@implementation Utility
+(void) createDirectory:(NSString*)path{
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
         NSLog(@"directory: %@ created", path);
    }else{
        NSLog(@"directory: %@ exists", path);
    }
}
@end
