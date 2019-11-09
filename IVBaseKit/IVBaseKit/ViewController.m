//
//  ViewController.m
//  IVBaseKit
//
//  Created by A$CE on 2019/11/9.
//  Copyright © 2019 Iwown. All rights reserved.
//

#import "ViewController.h"
#import "IVBaseKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *af = [AppInfo getAppVersion];
    NSLog(@"%@",af);
    // Do any additional setup after loading the view.
}


@end
