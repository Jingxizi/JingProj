//
//  main.m
//  JingProj
//
//  Created by 王佳仁 on 17/1/10.
//  Copyright © 2017年 王佳仁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [Bmob registerWithAppKey:@"e9a6b4cebd47e8c82c1da0de48373cf1"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
