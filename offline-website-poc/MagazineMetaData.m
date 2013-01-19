//
//  MagazineMetaData.m
//  offline-website-poc
//
//  Created by devfloater 4 on 2013-01-18.
//  Copyright (c) 2013 xtremelabs. All rights reserved.
//

#import "MagazineMetaData.h"

@implementation MagazineMetaData
- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}
- (BOOL)populateObjectFromJSON:(NSDictionary*)data{
    return YES;
}

@end
