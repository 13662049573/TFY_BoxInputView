//
//  ViewController.m
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import "ViewController.h"
#import "TFY_ListVCCell.h"
#import "TFY_BoxInputModel.h"
#import "DetailViewController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *mainTableView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"TFY_BoxInputView";
    
    [self generateDataArr];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView tfy_AutoSize:0 top:0 right:0 bottom:0];
}

- (void)generateDataArr
{
    _dataArr = [NSMutableArray new];
    TFY_BoxInputModel *model;
    
    model = [TFY_BoxInputModel new];
    model.name = @"正常的";
    model.imageName = @"demoImg_Normal";
    model.type = TFY_BoxInputModelNormalType;
    [_dataArr addObject:model];
    
    model = [TFY_BoxInputModel new];
    model.name = @"占位符";
    model.imageName = @"demoImg_Placeholder";
    model.type = TFY_BoxInputModelPlaceholderType;
    [_dataArr addObject:model];
    
    model = [TFY_BoxInputModel new];
    model.name = @"定制的输入框";
    model.imageName = @"demoImg_CustomBox";
    model.type = TFY_BoxInputModelCustomBoxType;
    [_dataArr addObject:model];
    
    model = [TFY_BoxInputModel new];
    model.name = @"下部线条";
    model.imageName = @"demoImg_Line";
    model.type = TFY_BoxInputModelLineType;
    [_dataArr addObject:model];
    
    model = [TFY_BoxInputModel new];
    model.name = @"秘密输入";
    model.imageName = @"demoImg_SecretSymbol";
    model.type = TFY_BoxInputModelSecretSymbolType;
    [_dataArr addObject:model];
    
    model = [TFY_BoxInputModel new];
    model.name = @"定制图片";
    model.imageName = @"demoImg_SecretImage";
    model.type = TFY_BoxInputModelSecretImageType;
    [_dataArr addObject:model];
    
    model = [TFY_BoxInputModel new];
    model.name = @"定制View";
    model.imageName = @"demoImg_SecretView";
    model.type = TFY_BoxInputModelSecretViewType;
    [_dataArr addObject:model];
}

-(UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 157;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    TFY_ListVCCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[TFY_ListVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    TFY_BoxInputModel *model = _dataArr[indexPath.row];
    [cell loadDataWithModel:model];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TFY_BoxInputModel *model = _dataArr[indexPath.row];
    DetailViewController *destinationVC = [DetailViewController new];
    destinationVC.boxInputModel = model;
    [self.navigationController pushViewController:destinationVC animated:YES];
}


@end
