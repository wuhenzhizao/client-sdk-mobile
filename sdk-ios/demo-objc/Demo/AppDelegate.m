//
//  AppDelegate.m
//  Demo
//
//  Created by sebo on 2022/5/13.
//

#import "AppDelegate.h"
#import "FeatureProbe-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *urlStr = @"https://featureprobe.io/server";
    // NSString *urlStr = @"http://server_ip:4007"; // for local docker
    
    FpUrl *url = [[[FpUrlBuilder alloc] initWithRemoteUrl: urlStr] build];
    FpUser *user = [[FpUser alloc] initWithKey:@"unique_user_key"];
    [user withKey:@"city" value:@"1"];
    FpConfig *config = [[FpConfig alloc] initWithRemoteUrl: url
                                              clientSdkKey:@"client-1b31633671aa8be967697091b72d23da6bf858a7"
                                           refreshInterval: 10
                                             waitFirstResp: true];
    
    FeatureProbe *fp = [[FeatureProbe alloc] initWithConfig:config user:user];
    FpBoolDetail *detail = [fp boolDetailWithKey:@"header_skin" defaultValue: false];
    NSLog(@"value is %d, reason is %@", detail.value, detail.reason);
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
