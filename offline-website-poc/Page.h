//
//  Page.h
//  offline-website-poc
//
//  Created by devfloater 4 on 2013-01-18.
//  Copyright (c) 2013 xtremelabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Page : NSObject
/*
 "page_id":0,
 "page_name":"letter",
 "html_file_url":""*/
@property (nonatomic, strong) NSNumber* pageId;
@property (nonatomic, strong) NSString* pageName;
@property (nonatomic, strong) NSString* htmlFileUrl;
@property (nonatomic, strong) NSString* htmlFileName;
@property (nonatomic, strong) NSArray* contentUrls;
- (BOOL)populateObjectFromJSON:(NSDictionary*)data;
@end
