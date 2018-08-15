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
    
    self.allKindsArray = @[@"sync + concurrent",@"async + concurrent",@"sync + serial",@"async + serial",@"sync + main", @"async + main"];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

