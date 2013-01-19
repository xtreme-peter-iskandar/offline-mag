//
//  MagazineAPIManager.m
//  offline-website-poc
//
//  Created by devfloater 4 on 2013-01-18.
//  Copyright (c) 2013 xtremelabs. All rights reserved.
//

#import "MagazineAPIManager.h"
#import "AFJSONRequestOperation.h"
#import "Page.h"
#import "Content.h"

static MagazineAPIManager *instance;

@implementation MagazineAPIManager


+ (MagazineAPIManager *)sharedInstance {
    if (instance) {
        return instance;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MagazineAPIManager alloc] init];
    });
    return instance;
}

- (NSString*)getEncodeURL:(NSString*) str {
    NSString *encoded =[str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    encoded = [encoded stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encoded;
}

- (NSURL*) getMetadataURL{
    NSURL *URL = [[NSURL alloc] initWithString:[self getEncodeURL:@"http://apiutils.xtremelabs.com/public/uploads/theedit.json"]];
    return URL;
}

- (NSMutableURLRequest*)getMutableURLRequest:(NSURL*)url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    //        [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    //    });
    return request;
}

-(void) retrieveMagazineMetadata{
    NSURL *shopListUrl = [self getMetadataURL];
    NSMutableURLRequest *request = [self getMutableURLRequest:shopListUrl];
    
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {

        NSDictionary* responseDict = (NSDictionary*)JSON;
        [self populateObjectFromJSON:responseDict];

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        for (Page* page in self.metadata.pages) {

            [self downloadHtmlFile:page path:documentsDirectory];
            for (Content* content in page.contentUrls) {
                [self downloadFile:content directory:documentsDirectory];
            }

        }
        [self setMagazineDownload:YES];
        if (_delegate && [_delegate respondsToSelector:@selector(magazineMetadataLoaded)]) {
            [_delegate magazineMetadataLoaded];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (_delegate && [_delegate respondsToSelector:@selector(magazineMetadataFailedToLoad:)]) {
            [_delegate magazineMetadataFailedToLoad:error];
        }
    }];
    [op start];
}

- (void) downloadFile:(Content*) content directory:(NSString*) path{
     NSString  *filePath = [NSString stringWithFormat:@"%@/%@", path,content.contentName];
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSURL  *contenturlurl = [NSURL URLWithString:content.contentUrl];
        NSData *contenturlData = [NSData dataWithContentsOfURL:contenturlurl];
        if ( contenturlData )
        {
            [contenturlData writeToFile:filePath atomically:YES];
        }
    }
    
    
    
}

- (void) downloadHtmlFile: (Page*) page path:(NSString*) path{
    NSString  *filePath = [NSString stringWithFormat:@"%@/%@", path,page.htmlFileName];
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
       NSString *stringURL = page.htmlFileUrl;
       NSURL  *url = [NSURL URLWithString:stringURL];
       NSData *urlData = [NSData dataWithContentsOfURL:url];
       if ( urlData )
       {
           [urlData writeToFile:filePath atomically:YES];
       }
    }
}

- (void) setMagazineDownload:(BOOL)isDownloaded{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:[NSNumber numberWithBool:isDownloaded] forKey:@"MAGAZINE_DOWNLOADED"];
    [ud synchronize];
}

- (BOOL) magazineDownloaded{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [[ud objectForKey:@"MAGAZINE_DOWNLOADED"] boolValue];
//    [ud setObject:[NSNumber numberWithBool:isDownloaded] forKey:@"MAGAZINE_DOWNLOADED"];
    
}
- (BOOL)populateObjectFromJSON:(NSDictionary*)data{
    
    self.metadata = [[MagazineMetaData alloc] init];
    NSArray* pagesArray = [data objectForKey:@"pages"];
    NSMutableArray* pages = [[NSMutableArray alloc] init];
    for (NSDictionary* pageDict in pagesArray) {
        Page* page = [[Page alloc] init];
        [page populateObjectFromJSON:pageDict];
        [pages addObject:page];
    }
    self.metadata.pages = pages;
    
    return YES;
}
@end
