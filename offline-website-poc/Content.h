//
//  Content.h
//  offline-website-poc
//
//  Created by devfloater 4 on 2013-01-18.
//  Copyright (c) 2013 xtremelabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Content : NSObject
@property (nonatomic, strong) NSString* contentUrl;
@property (nonatomic, strong) NSString* contentName;
@property (nonatomic, strong) NSString* contentType;

- (BOOL)populateObjectFromJSON:(NSDictionary*)data;
@end
