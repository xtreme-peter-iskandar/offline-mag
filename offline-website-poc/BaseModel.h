//
//  BaseModel.h
//  frank_and_oak
//
//  Created by DX102 on 2012-11-05.
//  Copyright (c) 2012 Xtreme Labs Inc. All rights reserved.
//

@interface BaseModel : NSObject

- (BOOL)populateObjectFromJSON:(NSDictionary*)data;
- (BOOL)isValidObject;
- (BOOL)isStatusOK:(NSDictionary*)data;

@end
