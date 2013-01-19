//
//  Page.m
//  offline-website-poc
//
//  Created by devfloater 4 on 2013-01-18.
//  Copyright (c) 2013 xtremelabs. All rights reserved.
//

#import "Page.h"
#import "Content.h"
@implementation Page

- (BOOL)populateObjectFromJSON:(NSDictionary*)data{
    self.pageId = [data objectForKey:@"page_id"];
    self.pageName = [data objectForKey:@"page_name"];
    self.htmlFileUrl = [data objectForKey:@"html_file_url"];
    self.htmlFileName = [data objectForKey:@"html_file_name"];
    NSArray* content = [data objectForKey:@"content"];
    NSMutableArray* contentArray = [NSMutableArray arrayWithCapacity:[content count]];
    for (NSDictionary* contentDic in content) {
        Content* contentObj = [[Content alloc] init];
        [contentObj populateObjectFromJSON:contentDic];
        [contentArray addObject:contentObj];
    }
    self.contentUrls = contentArray;
    return YES;
}
@end
