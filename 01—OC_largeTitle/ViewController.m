//
//  ViewController.m
//  01—OC_largeTitle
//
//  Created by 易怀奇 on 2017/12/13.
//  Copyright © 2017年 易怀奇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
/**  */
@property(nonatomic,strong) UIButton *btn1;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    // 初始设置Large Title偏好为YES
    if (@available(iOS 11.0, *)) {
        [self.navigationController.navigationBar setPrefersLargeTitles:YES];
    } else {
        // Fallback on earlier versions
    }

//    添加左右按钮
    
    UIButton *btn2 = [[UIButton alloc] init];
    [btn2 setImage:[UIImage imageNamed:@"shousuo-2"] forState:UIControlStateNormal];
   
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.9, 57.5, 25, 25)];
    [btn1 setImage:[UIImage imageNamed:@"xiazai"] forState:UIControlStateNormal];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    [self.navigationController.navigationBar addSubview:btn1];
    self.btn1 = btn1;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 10.0, *)) {
        [self.tableView setRefreshControl:refreshControl];
    } else {
        // Fallback on earlier versions
    }
    
    if (@available(iOS 11.0, *)) {
        UISearchController *searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        self.navigationItem.searchController = searchController;
    } else {
        // Fallback on earlier versions
    }
    
    self.tableView.delegate=self;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSLog(@"scrollView.contentOffset.y:%f",scrollView.contentOffset.y);
//    status
    if (scrollView.contentOffset.y>=-20) {

//        bar
    }else if (scrollView.contentOffset.y>=-64&&scrollView.contentOffset.y<-20){
        
        if (@available(iOS 11.0, *)) {
            [self.navigationController.navigationBar setPrefersLargeTitles:NO];
        } else {
                // Fallback on earlier versions
        }
        
        self.btn1.frame = CGRectMake(self.view.frame.size.width * 0.9, 9.5, 25, 25);

//        largetitle
    }else if (scrollView.contentOffset.y>=-116&&scrollView.contentOffset.y<-64){
        if (@available(iOS 11.0, *)) {
            [self.navigationController.navigationBar setPrefersLargeTitles:YES];
        } else {
            // Fallback on earlier versions
        }

        CGRect tempREct = self.btn1.frame;
        tempREct.origin.y = -58.5-scrollView.contentOffset.y;
        self.btn1.frame = tempREct;
        self.navigationItem.leftBarButtonItem.customView.hidden = NO;
//        searchcontrol
    }else if (scrollView.contentOffset.y>=-168&&scrollView.contentOffset.y<-116){
        self.btn1.frame = CGRectMake(self.view.frame.size.width * 0.9, 57.5, 25, 25);
        self.navigationItem.leftBarButtonItem.customView.hidden = YES;

    }else if (scrollView.contentOffset.y<-168){
        CGRect tempREct = self.btn1.frame;
        tempREct.origin.y = -110.5-scrollView.contentOffset.y;
        self.btn1.frame = tempREct;
    }
}

- (void)beginRefresh:(UIRefreshControl *)control
{
    [control endRefreshing];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 设置Large Title偏好为NO。
    if (@available(iOS 11.0, *)) {
        [self.navigationController.navigationBar setPrefersLargeTitles:NO];
    } else {
        // Fallback on earlier versions
    }
}


@end
