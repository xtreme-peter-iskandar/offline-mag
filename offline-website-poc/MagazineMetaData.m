//
//  MagazineMetaData.m
//  offline-website-poc
//
//  Created by devfloater 4 on 2013-01-18.
//  Copyright (c) 2013 xtremelabs. All rights reserved.
//

#import "MagazineMetaData.h"
#import "Page.h"
@implementation MagazineMetaData
- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}
- (BOOL)populateObjectFromJSON:(NSDictionary*)data{
    self.version = [data objectForKey:@"version"];
    NSArray* pagesArray = [data objectForKey:@"pages"];
    NSMutableArray* pages = [[NSMutableArray alloc] init];
    for (NSDictionary* pageDict in pagesArray) {
        Page* page = [[Page alloc] init];
        [page populateObjectFromJSON:pageDict];
        [pages addObject:page];
    }
    self.pages = pages;
    return YES;
}

@end
