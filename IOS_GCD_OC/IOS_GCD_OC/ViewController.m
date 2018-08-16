//
//  ViewController.m
//  IOS_GCD_Demo
//
//  Created by lidong on 2018/8/14.
//  Copyright © 2018年 macbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *allKindsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allKindsArray = @[@"sync + concurrent",@"async + concurrent",@"sync + serial",@"async + serial",@"sync + main", @"async + main", @"dispatch_barrier_async", @"dispatch_after", @"dispatch_apply", @"groupNotify", @"groupEnterAndLeave"];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.allKindsArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.textLabel.text = self.allKindsArray[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            [self sync_concurrent];
            break;
        case 1:
            [self async_concurrent];
            break;
        case 2:
            [self sync_serial];
            break;
        case 3:
            [self async_serial];
            break;
        case 4:
            [self sync_main];
            break;
        case 5:
            [self async_main];
            break;
        case 6:
            [self dispatch_barrier_async];
            break;
        case 7:
            [self dispatch_after];
            break;
        case 8:
            [self dispatch_apply];
            break;
        case 9:
            [self groupNotify];
            break;
        case 10:
            [self groupEnterAndLeave];
            break;
        default:
            break;
    }
    
}

/**
 *  同步执行 + 并发队列
 *  特点： 在当前线程中执行任务，不会开启新的线程，任务一个一个执行，
 */
- (void)sync_concurrent {
    
    NSLog(@"currentThread--%@", [NSThread currentThread]);
    NSLog(@"sync_concurrentThread---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("sync_concurrentThread", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"1---%@", [NSThread currentThread]);
            
        }
        
    });
    
    dispatch_sync(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"2---%@", [NSThread currentThread]);
            
        }
        
    });
    
    dispatch_sync(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"3---%@", [NSThread currentThread]);
            
        }
        
    });
    
    NSLog(@"sync_concurrentThread---end");
}

/**
 *  异步执行 + 并发队列
 *  特点： 可以开启多个线程，任务交替（同时）进行
 */

- (void)async_concurrent {
    
    NSLog(@"currentThread--%@", [NSThread currentThread]);
    NSLog(@"async_concurrentThread---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("async_concurrentThread", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"1---%@", [NSThread currentThread]);
            
        }
        
    });
    
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"2---%@", [NSThread currentThread]);
            
        }
        
    });
    
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"3---%@", [NSThread currentThread]);
            
        }
        
    });
    
    NSLog(@"async_concurrentThread---end");
    
}

/**
 *  同步 + 串行
 *  不会创建新的线程，就在当前线程执行任务，任务是一个一个执行。
 */
- (void)sync_serial {
    
    NSLog(@"currentThread--%@", [NSThread currentThread]);
    NSLog(@"sync_serialThread---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("sync_serialThread", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"1---%@", [NSThread currentThread]);
            
        }
        
    });
    
    dispatch_sync(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"2---%@", [NSThread currentThread]);
            
        }
        
    });
    
    dispatch_sync(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"3---%@", [NSThread currentThread]);
            
        }
        
    });
    
    NSLog(@"sync_setialThread---end");
    
}

/**
 *  异步 + 串行
 *  特点： 可以另起一个线程执行任务， 但是任务是一个一个执行的。
 */
- (void)async_serial {
    
    NSLog(@"currentThread--%@", [NSThread currentThread]);
    NSLog(@"async_serialThread---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("async_serialThread", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"1---%@", [NSThread currentThread]);
            
        }
        
    });
    
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"2---%@", [NSThread currentThread]);
            
        }
        
    });
    
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"3---%@", [NSThread currentThread]);
            
        }
        
    });
    
    NSLog(@"async_setialThread---end");
    
}

/**
 *  同步 + 主队列
 *  特点： 互相等待卡住不可行
 */
- (void)sync_main {
    
    NSLog(@"currentThread--%@", [NSThread currentThread]);
    NSLog(@"sync_mainThread---begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"1---%@", [NSThread currentThread]);
            
        }
        
    });
    
    dispatch_sync(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"2---%@", [NSThread currentThread]);
            
        }
        
    });
    
    dispatch_sync(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"3---%@", [NSThread currentThread]);
            
        }
        
    });
    
    NSLog(@"sync_mainThread---end");
    
}

/**
 *  异步 + 主队列
 *  特点： 不会开启新线程，执行完一个任务，再执行下一个任务
 */
- (void)async_main {
    
    // 使用 NSThread 的 detachNewThreadSelector 方法会创建线程，并自动启动线程执行
    [NSThread detachNewThreadSelector:@selector(sync_main) toTarget:self withObject:nil];
    
}

/**
 *  栅栏方法
 *  特点： 在执行完栅栏前面的操作之后，才执行栅栏操作，最后再执行栅栏后边的操作。
 */
- (void)dispatch_barrier_async {
    
    dispatch_queue_t queue = dispatch_queue_create("dispatch_barrier_async", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"1---%@", [NSThread currentThread]);
            
        }
        
    });
    
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"2---%@", [NSThread currentThread]);
            
        }
        
    });
    
    dispatch_barrier_async(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"3---%@", [NSThread currentThread]);
            
        }
        
    });
    
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"4---%@", [NSThread currentThread]);
            
        }
        
    });
    
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; i ++) {
            
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"5---%@", [NSThread currentThread]);
            
        }
        
    });
    
}

/**
 *  延迟执行
 */
- (void)dispatch_after {
    
    NSLog(@"currentThread--%@", [NSThread currentThread]);
    NSLog(@"dispatch_after---begin");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      
         NSLog(@"after---%@",[NSThread currentThread]);
        
    });
    
}

- (void)dispatch_apply {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSLog(@"dispatch_apply---begin");
    
    dispatch_apply(6, queue, ^(size_t index) {
      
        NSLog(@"%zd---%@",index, [NSThread currentThread]);
        
    });
    
    NSLog(@"dispatch_apply---end");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 队列组 dispatch_group_notify
 */
- (void)groupNotify {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");
    
    dispatch_group_t group =  dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步任务1、任务2都执行完毕后，回到主线程执行下边任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
        NSLog(@"group---end");
    });
}

/**
 * 队列组 dispatch_group_enter、dispatch_group_leave
 */
- (void)groupEnterAndLeave
{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程.
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
        NSLog(@"group---end");
    });
    
    //    // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    //    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    //
    //    NSLog(@"group---end");
}

- (UITableView *)tableView {
    
    if(!_tableView){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        
        _tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    
    return _tableView;
}

@end

