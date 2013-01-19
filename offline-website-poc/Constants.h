//
//  Constants.h
//  offline-website-poc
//
//  Created by devfloater 4 on 2013-01-18.
//  Copyright (c) 2013 xtremelabs. All rights reserved.
//

#ifndef offline_website_poc_Constants_h
#define offline_website_poc_Constants_h

typedef void(^SuccessBlock)(void);
typedef void(^SuccessBlockDict)(NSDictionary* dict);
typedef void(^FailureBlock)(int code, NSString* message);
typedef void(^CompletionBlock)(BOOL success, NSString* message);

#endif
