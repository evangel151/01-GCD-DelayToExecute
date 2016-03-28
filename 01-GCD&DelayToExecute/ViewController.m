//
//  ViewController.m
//  01-GCD&DelayToExecute
//
//  Created by  a on 16/3/27.
//  Copyright © 2016年 eva. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"___开始点击——————");
    
    
    [self delay3];
    
    
    
    // NSLog(@"----下载图片————————");
}

// 基本不会使用
- (void)delay1 {
    // 1. 使用sleep 来进行延迟执行 (可以达成延迟执行的效果，但是会卡住线程，不推荐适用)
    [NSThread sleepForTimeInterval:3.0];
}

// 常用
- (void)delay2 {
    // 2. (较为常用)一旦定制好延迟任务后，就不会卡住当前进程 (调用该方法的线程是主线程)
    // 但更多的还是应该采用GCD或者NSOperation 来执行
    [self performSelector:@selector(run:) withObject:@"123" afterDelay:3.0];
}

// 可以根据传入的队列，决定是回调主线程或者开辟新线程
- (void)delay3 {
    // 3. 使用GCD进行延迟执行延迟操作
    // * 默认是将任务添加到主线程中执行，如果将 dispatch_get_main_queue() 改成全局并发队列，那么after语法可以自动判断并开辟新线程进行延迟执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"--------使用GCD进行延迟执行，%@", [NSThread currentThread]);
    });

}

- (void)run:(NSString *)str {
    NSLog(@"%s----%@", __func__, str);
}

@end
