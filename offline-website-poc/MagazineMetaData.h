//
//  MagazineMetaData.h
//  offline-website-poc
//
//  Created by devfloater 4 on 2013-01-18.
//  Copyright (c) 2013 xtremelabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface MagazineMetaData : NSObject
@property (nonatomic, strong) NSArray* pages;

- (BOOL)populateObjectFromJSON:(NSDictionary*)data;
@end
