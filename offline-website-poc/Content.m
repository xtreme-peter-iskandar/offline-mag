//
//  Content.m
//  offline-website-poc
//
//  Created by devfloater 4 on 2013-01-18.
//  Copyright (c) 2013 xtremelabs. All rights reserved.
//

#import "Content.h"

@implementation Content
- (BOOL)populateObjectFromJSON:(NSDictionary*)data{
    
    self.contentName = [data objectForKey:@"name"];
    self.contentType = [data objectForKey:@"type"];
    self.contentUrl = [data objectForKey:@"url"];
    return YES;
}
@end
