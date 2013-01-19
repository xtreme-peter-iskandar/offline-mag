//
//  MainViewController.h
//  offline-website-poc
//
//  Created by devfloater 4 on 2013-01-18.
//  Copyright (c) 2013 xtremelabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagazineAPIManager.h"

@interface MainViewController : UIViewController<UIWebViewDelegate,MagazineAPIManagerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;



@end
