//
//  MainViewController.m
//  JingProj
//
//  Created by 王佳仁 on 17/1/17.
//  Copyright © 2017年 王佳仁. All rights reserved.
//

#import "MainViewController.h"
#import <BmobSDK/Bmob.h>


@interface MainViewController ()
{
    int count,titleNumber;
}

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
    BmobQuery *query = [BmobQuery queryWithClassName:@"Test"];
    [query orderByDescending:@"updatedAt"];
    query.limit = 5;
    query.skip=count;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        count+=array.count;
        NSString *ad=NSStringFromClass([array[0] class]);
        NSLog(@"%@",ad);
        
        
        for (BmobObject *obj in array) {
            count+=array.count;
            NSLog(@"%@",obj);
        }
    }];
}

- (IBAction)writeAct:(id)sender {
    titleNumber++;
    BmobObject *obj = [[BmobObject alloc] initWithClassName:@"Test"];
    
    [obj setObject:[NSString stringWithFormat:@"标题%d",titleNumber] forKey:@"title"];
    [obj setObject:@"联系方式" forKey:@"phone"];
    [obj setObject:@"描述" forKey:@"describe"];
    
    [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (!error) {
            NSLog(@"提交成功");
        }else{
            NSLog(@"%@",error);
        }
        
    }];
}
@end
