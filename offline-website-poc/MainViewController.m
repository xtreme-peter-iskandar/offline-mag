//
//  MainViewController.m
//  offline-website-poc
//
//  Created by devfloater 4 on 2013-01-18.
//  Copyright (c) 2013 xtremelabs. All rights reserved.
//

#import "MainViewController.h"
#import "Page.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.swipeView = [[SwipeView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
//        [self.swipeView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [self.swipeView setDataSource:self];
        [self.swipeView setDelegate:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
       NSLog(@"delegate set");
    [self.view addSubview:self.swipeView];
//    if(self.queueToDisplay){
//        [self displayMagazine];
//    }
    NSLog(@"view did load");

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"requesting: %@",request);
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

- (void) displayMagazine:(NSString*)filename webView:(UIWebView*)webView{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    BOOL isDir = NO;
    NSError *error;
    
    if (! [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDir] && isDir == NO) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    
    
    
    NSString *path_to_file = [cachePath stringByAppendingPathComponent:filename];
    if([[NSFileManager defaultManager] fileExistsAtPath:path_to_file]){
        NSLog(@"file exists");
    }
    NSURL *targetURL = [NSURL fileURLWithPath:path_to_file];
    NSLog(@"target: %@", targetURL );
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [webView loadRequest:request];
//    [webView reload];

}

#pragma mark -MagazineDelegate
- (void) magazineMetadataLoaded{
    NSLog(@"MagazineLoaded");
    [self.swipeView reloadData];
//    [self displayMagazine];
}
- (void) magazineMetadataFailedToLoad:(NSError*)error{
    NSLog(@"MagazineFailedLoaded");
}

#pragma mark - swipeviewdata
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView{
    return [[MagazineAPIManager sharedInstance].metadata.pages count];
}
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
     Page* page = (Page*)[[MagazineAPIManager sharedInstance].metadata.pages objectAtIndex:index];
    if(view == nil){
        NSLog(@"view nil");
        UIScrollView *scrollView = nil;
        UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
        
        if ([webView  respondsToSelector:@selector(scrollView)]) { //iOS 5+
            scrollView = webView.scrollView;
        }
        
        scrollView.scrollEnabled = NO;
        scrollView.bounces = NO;
        scrollView.backgroundColor=[UIColor clearColor];
        [self displayMagazine:page.htmlFileName webView:webView];
        return webView;
    }
    else{
      NSLog(@"view not nill");
        NSLog(@"%@",[view class]);
        [self displayMagazine:page.htmlFileName webView:(UIWebView*)view];
        return view;
    }
       
    
    
    
   
//    [self.mainWebView setDelegate:self];

}
@end
