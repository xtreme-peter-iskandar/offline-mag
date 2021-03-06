//
//  MagazineAPIManager.h
//  offline-website-poc
//
//  Created by devfloater 4 on 2013-01-18.
//  Copyright (c) 2013 xtremelabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "MagazineMetaData.h"
#import "Utility.h"

#define kMAGAZINE_DOWNLOADED @"MAGAZINE_DOWNLOADED"
#define kMAGAZINE_VERSION @"MAGAZINE_VERSION"
@protocol MagazineAPIManagerDelegate <NSObject>
@optional
- (void) magazineMetadataLoaded;
- (void) magazineMetadataFailedToLoad:(NSError*)error;
@end

@interface MagazineAPIManager : NSObject
+ (MagazineAPIManager*) sharedInstance;
@property (nonatomic, strong) MagazineMetaData* metadata;
@property (nonatomic, weak) id<MagazineAPIManagerDelegate> delegate;
-(void) retrieveMagazineMetadata;
- (BOOL)populateObjectFromJSON:(NSDictionary*)data;
- (BOOL) magazineDownloaded;
@end
