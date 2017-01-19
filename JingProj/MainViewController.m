//
//  MainViewController.m
//  JingProj
//
//  Created by 王佳仁 on 17/1/17.
//  Copyright © 2017年 王佳仁. All rights reserved.
//

#import "MainViewController.h"
#import <BmobSDK/Bmob.h>
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>

@interface MainViewController ()<NSURLSessionDelegate>
{
    int count,titleNumber;
}

//@property (nonatomic, strong) NSArray<NSArray<MBExample *> *> *examples;
// Atomic, because it may be cancelled from main thread, flag is read on a background thread
@property (atomic, assign) BOOL canceled;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    count=0;
    titleNumber=0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)readAct:(id)sender {
    NSLog(@"read");
//    BmobQuery *query = [BmobQuery queryWithClassName:@"Test"];
//    [query orderByDescending:@"updatedAt"];
//    query.limit = 5;
//    query.skip=count;
//    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        count+=array.count;
//        NSString *ad=NSStringFromClass([array[0] class]);
//        NSLog(@"%@",ad);
//        
//        
//        for (BmobObject *obj in array) {
//            count+=array.count;
//            NSLog(@"%@",obj);
//        }
//    }];
}

- (IBAction)writeAct:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Set some text to show the initial status.
    hud.label.text = NSLocalizedString(@"Preparing...", @"HUD preparing title");
    // Will look best, if we set a minimum size.
    hud.minSize = CGSizeMake(150.f, 100.f);
    
    [self doSomeNetworkWorkWithProgress];

    
    
//    titleNumber++;
//    BmobObject *obj = [[BmobObject alloc] initWithClassName:@"Test"];
//    
//    [obj setObject:[NSString stringWithFormat:@"标题%d",titleNumber] forKey:@"title"];
//    [obj setObject:@"联系方式" forKey:@"phone"];
//    [obj setObject:@"描述" forKey:@"describe"];
//    
//    [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//        if (!error) {
//            NSLog(@"提交成功");
//        }else{
//            NSLog(@"%@",error);
//        }
//        
//    }];
}

- (void)doSomeNetworkWorkWithProgress {
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    NSURL *URL = [NSURL URLWithString:@"https://support.apple.com/library/APPLE/APPLECARE_ALLGEOS/HT1425/sample_iPod.m4v.zip"];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:URL];
    [task resume];
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    // Do something with the data at location...
    
    // Update the UI on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
        UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        hud.customView = imageView;
        hud.mode = MBProgressHUDModeCustomView;
        hud.label.text = NSLocalizedString(@"Completed", @"HUD completed title");
        [hud hideAnimated:YES afterDelay:3.f];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    float progress = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
    
    // Update the UI on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
        hud.mode = MBProgressHUDModeDeterminate;
        hud.progress = progress;
    });
}



@end




