//
//  ViewController.m
//  cleverpush-topics-example
//
//  Created by Marius Gebhardt on 19/01/2021.
//

#import "ViewController.h"
#import <CleverPush/CleverPush.h>

NSString *const CLEVERPUSH_CHANNEL_LIVE = @"qbZrw5TcGeM7oAfED";
NSString *const CLEVERPUSH_CHANNEL_STAGE = @"FEzupZ9yvMNTHqAPu";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // normally we would init in AppDelegate, this is just for having everything in one file.
    [CleverPush initWithLaunchOptions:nil channelId:CLEVERPUSH_CHANNEL_LIVE handleNotificationOpened:nil handleSubscribed:^(NSString *subscriptionId) {
        [self handleSubscribed:subscriptionId];
    } autoRegister:YES];
}


- (IBAction)switchEnvBtnTap:(id)sender {
    self.envLabel.text = @"Env: Stage";
    self.statusLabel.text = @"Subscribed: ...";
    [CleverPush initWithLaunchOptions:nil channelId:CLEVERPUSH_CHANNEL_STAGE handleSubscribed:^(NSString *subscriptionId) {
        [self handleSubscribed:subscriptionId];
    } autoRegister:YES];
}

- (IBAction)switchEnvBackBtnTap:(id)sender {
    self.envLabel.text = @"Env: Live";
    self.statusLabel.text = @"Subscribed: ...";
    [CleverPush initWithLaunchOptions:nil channelId:CLEVERPUSH_CHANNEL_LIVE handleSubscribed:^(NSString *subscriptionId) {
        [self handleSubscribed:subscriptionId];
    } autoRegister:YES];
}

- (IBAction)showTopicsBtnTap:(id)sender {
    [CleverPush showTopicsDialog];
}

- (void)handleSubscribed:(NSString*)sid {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.statusLabel.text = [NSString stringWithFormat:@"Subscribed: %@", sid];
    });
}

@end
