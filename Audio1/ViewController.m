//
//  ViewController.m
//  Audio1
//
//  Created by yumeng tang on 2018/6/29.
//  Copyright © 2018年 yumeng tang. All rights reserved.
//

#import "ViewController.h"
#define kCellID @"cellid"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) NSArray *vcArray;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.titleArray = @[
                        @"读取Audio MetaData",
                        @"Samplle",
                        @"CAStreamFormatTestViewController",
                        @"Core Audio Services"
                        ];
    self.vcArray = @[
                     @"ListViewController",
                     @"DIYSamplesViewController",
                     @"CAStreamFormatTestViewController",
                     @"AudioServiceViewController"
                     ];
    
    self.tableView  = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    [self.view addSubview:self.tableView];
    
//    [self printFileMetaData];
}




#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *clzname = [self.vcArray objectAtIndex:indexPath.row];
    UIViewController *vc =  [[NSClassFromString(clzname) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (!cell) {
//        cell = [[UITableViewCell  alloc] ini]
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
    }
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    return cell;
}

@end
