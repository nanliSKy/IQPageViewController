//
//  ViewController.m
//  IQPageViewController
//
//  Created by nanli on 2020/4/15.
//  Copyright © 2020 darchain. All rights reserved.
//

#import "ViewController.h"

#import "IQPageViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)pageController:(id)sender {
    [self.navigationController pushViewController:[IQPageViewController new] animated:YES];
}

@end
