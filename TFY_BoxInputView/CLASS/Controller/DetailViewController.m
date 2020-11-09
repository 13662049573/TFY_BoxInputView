//
//  DetailViewController.m
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import "DetailViewController.h"
#import "TFY_BoxInputITools.h"

@interface DetailViewController ()
TFY_PROPERTY_STRONG UIButton *backBtn,*addBtn,*removeBtn,*ifNeedSecurityBtn,*verifyBtn;
TFY_PROPERTY_STRONG UIImageView *bigLockImageView;
TFY_PROPERTY_STRONG UILabel *mainLabel,*subLabel,*descriptionLabel,*valueLabel;
TFY_PROPERTY_STRONG UIView *sepLineView;
TFY_PROPERTY_STRONG TFY_BoxInputView *boxInputView;

@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"backArrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popClick)];
    
    self.navigationItem.leftBarButtonItem = item;
    
    [self.view addSubview:self.bigLockImageView];
    self.bigLockImageView.tfy_RightSpace(0).tfy_TopSpace(TFY_kNavBarHeight()).tfy_WidthAuto().tfy_HeightAuto();
    
    [self.view addSubview:self.mainLabel];
    self.mainLabel.tfy_LeftSpace(30).tfy_TopSpace(TFY_kNavBarHeight()).tfy_RightSpace(30).tfy_Height(30);
    
    [self.view addSubview:self.sepLineView];
    self.sepLineView.tfy_LeftSpaceEqualView(self.mainLabel).tfy_TopSpaceToView(5, self.mainLabel).tfy_size(TFY_Width_W()/2, 2);
    
    [self.view addSubview:self.subLabel];
    self.subLabel.tfy_LeftSpaceEqualView(self.sepLineView).tfy_TopSpaceToView(0, self.sepLineView).tfy_RightSpaceEqualView(self.mainLabel).tfy_Height(30);
    
    [self.view addSubview:self.descriptionLabel];
    self.descriptionLabel.tfy_LeftSpaceEqualView(self.subLabel).tfy_TopSpaceToView(10, self.subLabel).tfy_RightSpaceEqualView(self.mainLabel).tfy_Height(30);
    
    [self.view addSubview:self.valueLabel];
    self.valueLabel.tfy_LeftSpaceEqualView(self.descriptionLabel).tfy_TopSpaceToView(5, self.descriptionLabel).tfy_RightSpaceEqualView(self.descriptionLabel).tfy_Height(30);
    
    [self.view addSubview:self.verifyBtn];
    self.verifyBtn.tfy_LeftSpace(60).tfy_TopSpaceToView(20, self.bigLockImageView).tfy_RightSpace(60).tfy_Height(54);
    
    [self.view addSubview:self.ifNeedSecurityBtn];
    self.ifNeedSecurityBtn.tfy_LeftSpaceEqualView(self.verifyBtn).tfy_TopSpaceToView(10, self.verifyBtn).tfy_size(40, 40);
    
    [self.view addSubview:self.removeBtn];
    self.removeBtn.tfy_RightSpaceEqualView(self.verifyBtn).tfy_TopSpaceEqualView(self.ifNeedSecurityBtn).tfy_size(40, 40);
    
    [self.view addSubview:self.addBtn];
    self.addBtn.tfy_RightSpaceToView(10, self.removeBtn).tfy_TopSpaceEqualView(self.removeBtn).tfy_size(40, 40);
}

-(void)popClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(UIImageView *)bigLockImageView{
    if (!_bigLockImageView) {
        _bigLockImageView = tfy_imageView();
        _bigLockImageView.tfy_imge(@"BigLock");
    }
    return _bigLockImageView;
}

-(UILabel *)mainLabel{
    if (!_mainLabel) {
        _mainLabel = tfy_label();
        _mainLabel.tfy_text(@"测试").tfy_textcolor(@"212121", 1).tfy_fontSize([UIFont boldSystemFontOfSize:20]).tfy_alignment(0);
    }
    return _mainLabel;
}

-(UIView *)sepLineView{
    if (!_sepLineView) {
        _sepLineView = tfy_view();
        _sepLineView.backgroundColor = [UIColor blueColor];
    }
    return _sepLineView;
}


-(UILabel *)subLabel{
    if (!_subLabel) {
        _subLabel = tfy_label();
        _subLabel.tfy_text(@"TFY_BoxInputView").tfy_textcolor(@"212121", 1).tfy_fontSize([UIFont systemFontOfSize:17]).tfy_alignment(0);
    }
    return _subLabel;
}

-(UILabel *)descriptionLabel{
    if (!_descriptionLabel) {
        _descriptionLabel = tfy_label();
        _descriptionLabel.tfy_text(@"您输入的验证码为").tfy_textcolor(@"FF546E", 1).tfy_fontSize([UIFont systemFontOfSize:20]).tfy_alignment(1);
    }
    return _descriptionLabel;
}

-(UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = tfy_label();
        _valueLabel.tfy_text(@"清空").tfy_textcolor(@"FF9A56", 1).tfy_fontSize([UIFont systemFontOfSize:24]).tfy_alignment(1);
    }
    return _valueLabel;
}

-(UIButton *)verifyBtn{
    if (!_verifyBtn) {
        _verifyBtn = tfy_button();
        _verifyBtn.tfy_title(@"清除", UIControlStateNormal, @"ffffff", UIControlStateNormal, [UIFont boldSystemFontOfSize:24]).tfy_cornerRadius(54/2).tfy_backgroundColor(color_master, 1).tfy_action(self,@selector(clearBtnEvent), UIControlEventTouchUpInside);
    }
    return _verifyBtn;
}

-(UIButton *)ifNeedSecurityBtn{
    if (!_ifNeedSecurityBtn) {
        _ifNeedSecurityBtn = tfy_button();
        _ifNeedSecurityBtn.tfy_image(@"eyeOpen", UIControlStateNormal).tfy_image(@"eyeClose", UIControlStateSelected).tfy_action(self, @selector(securityBtnEvent), UIControlEventTouchUpInside);
    }
    return _ifNeedSecurityBtn;
}

-(UIButton *)removeBtn{
    if (!_removeBtn) {
        _removeBtn = tfy_button();
        _removeBtn.tfy_image(@"cellRemove", UIControlStateNormal).tfy_action(self, @selector(removeEvent), UIControlEventTouchUpInside);
    }
    return _removeBtn;
}

-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = tfy_button();
        _addBtn.tfy_image(@"cellAdd", UIControlStateNormal).tfy_action(self, @selector(addEvent), UIControlEventTouchUpInside);
    }
    return _addBtn;
}

- (void)securityBtnEvent{
    self.boxInputView.ifNeedSecurity = !self.boxInputView.ifNeedSecurity;
    self.ifNeedSecurityBtn.selected = self.boxInputView.ifNeedSecurity;
}

- (void)addEvent{
    [self.boxInputView resetCodeLength:self.boxInputView.codeLength+1 beginEdit:YES];
}

- (void)removeEvent{
    if (self.boxInputView.codeLength > 0) {
        [self.boxInputView resetCodeLength:self.boxInputView.codeLength-1 beginEdit:YES];
    }
}

#pragma mark - Setter & Getter
- (void)setBoxInputModel:(TFY_BoxInputModel *)boxInputModel{
    _boxInputModel = boxInputModel;
    
    self.mainLabel.text = boxInputModel.name;
    
    switch (boxInputModel.type) {
        case TFY_BoxInputModelNormalType:
            {
                self.boxInputView = [self generateBoxInputView_normal];
            }
            break;
            
        case TFY_BoxInputModelPlaceholderType:
            {
                self.boxInputView = [self generateBoxInputView_placeholder];
            }
            break;
            
        case TFY_BoxInputModelCustomBoxType:
            {
                self.boxInputView = [self generateBoxInputView_customBox];
            }
            break;
            
        case TFY_BoxInputModelLineType:
            {
                self.boxInputView = [self generateBoxInputView_line];
            }
            break;
            
        case TFY_BoxInputModelSecretSymbolType:
            {
                self.boxInputView = [self generateBoxInputView_secretSymbol];
            }
            break;
            
        case TFY_BoxInputModelSecretImageType:
            {
                self.boxInputView = [self generateBoxInputView_secretImage];
            }
            break;
            
        case TFY_BoxInputModelSecretViewType:
            {
                self.boxInputView = [self generateBoxInputView_secretView];
            }
            break;
            
        default:
            {
                self.boxInputView = [self generateBoxInputView_normal];
            }
            break;
    }
    
    __weak __typeof(self)weakSelf = self;
    if (!self.boxInputView.textDidChangeblock) {
        self.boxInputView.textDidChangeblock = ^(NSString *text, BOOL isFinished) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if (text.length > 0) {
                strongSelf.valueLabel.text = text;
            }else{
                strongSelf.valueLabel.text = @"清空";
            }
        };
    }
    
    [self.view addSubview:self.boxInputView];
    self.boxInputView.tfy_LeftSpace(35).tfy_TopSpaceToView(10, self.valueLabel).tfy_RightSpace(35).tfy_Height(52);
    
}

#pragma mark - Normal
- (TFY_BoxInputView *)generateBoxInputView_normal{
    TFY_BoxInputView *boxInputView = [[TFY_BoxInputView alloc] initWithCodeLength:6];
    boxInputView.mainCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [boxInputView loadAndPrepareViewWithBeginEdit:YES];
    boxInputView.inputType = TFY_InputType_Number;
    boxInputView.inputType = TFY_InputType_Regex;
    boxInputView.customInputRegex = @"[^0-9]";
    
    if (@available(iOS 12.0, *)) {
        boxInputView.textContentType = UITextContentTypeOneTimeCode;
    }else if (@available(iOS 10.0, *)) {
        boxInputView.textContentType = @"one-time-code";
    }
    return boxInputView;
}

- (TFY_BoxInputView *)generateBoxInputView_placeholder{
    TFY_BoxInputCellProperty *cellProperty = [TFY_BoxInputCellProperty new];
    cellProperty.cellPlaceholderTextColor = [UIColor colorWithRed:114/255.0 green:116/255.0 blue:124/255.0 alpha:0.3];
    cellProperty.cellPlaceholderFont = [UIFont systemFontOfSize:20];
    
    TFY_BoxInputView *boxInputView = [[TFY_BoxInputView alloc] initWithCodeLength:6];
    boxInputView.mainCollectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    boxInputView.ifNeedCursor = NO;
    boxInputView.placeholderText = @"爱我就来支持";
    boxInputView.customCellProperty = cellProperty;
    [boxInputView loadAndPrepareViewWithBeginEdit:YES];
    return boxInputView;
}

#pragma mark - CustomBox
- (TFY_BoxInputView *)generateBoxInputView_customBox{
    TFY_BoxInputCellProperty *cellProperty = [TFY_BoxInputCellProperty new];
    cellProperty.cellBgColorNormal = color_FFECEC;
    cellProperty.cellBgColorSelected = [UIColor whiteColor];
    cellProperty.cellCursorColor = color_master;
    cellProperty.cellCursorWidth = 2;
    cellProperty.cellCursorHeight = 27;
    cellProperty.cornerRadius = 4;
    cellProperty.borderWidth = 0;
    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
    cellProperty.cellTextColor = color_master;
    cellProperty.configCellShadowBlock = ^(CALayer * _Nonnull layer) {
        layer.shadowColor = [color_master colorWithAlphaComponent:0.2].CGColor;
        layer.shadowOpacity = 1;
        layer.shadowOffset = CGSizeMake(0, 2);
        layer.shadowRadius = 4;
    };

    TFY_BoxInputView *boxInputView = [[TFY_BoxInputView alloc] initWithCodeLength:6];
    boxInputView.mainCollectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    boxInputView.boxFlowLayout.itemSize = CGSizeMake(52, 52);
    boxInputView.customCellProperty = cellProperty;
    [boxInputView loadAndPrepareViewWithBeginEdit:YES];

    return boxInputView;
}

#pragma mark - Line
- (TFY_BoxInputView *)generateBoxInputView_line{
    TFY_BoxInputCellProperty *cellProperty = [TFY_BoxInputCellProperty new];
    cellProperty.cellCursorColor = color_FFECEC;
    cellProperty.cellCursorWidth = 2;
    cellProperty.cellCursorHeight = 27;
    cellProperty.cornerRadius = 0;
    cellProperty.borderWidth = 0;
    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
    cellProperty.cellTextColor = color_master;
    cellProperty.showLine = YES;
    cellProperty.customLineViewBlock = ^TFY_LineView * _Nonnull{
        TFY_LineView *lineView = [TFY_LineView new];
        lineView.underlineColorNormal = [color_master colorWithAlphaComponent:0.3];
        lineView.underlineColorSelected = [color_master colorWithAlphaComponent:0.7];
        lineView.underlineColorFilled = color_master;
        lineView.frame = CGRectMake(0, 48, 50, 4);
        
        lineView.selectChangeBlock = ^(TFY_LineView * _Nonnull lineView, BOOL selected) {
            if (selected) {
                lineView.frame = CGRectMake(0, 48, 50, 6);
            } else {
                lineView.frame = CGRectMake(0, 48, 50, 4);
            }
        };
        return lineView;
    };

    TFY_BoxInputView *boxInputView = [[TFY_BoxInputView alloc] initWithCodeLength:6];
    boxInputView.mainCollectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    boxInputView.boxFlowLayout.itemSize = CGSizeMake(52, 52);
    boxInputView.customCellProperty = cellProperty;
    [boxInputView loadAndPrepareViewWithBeginEdit:YES];

    return boxInputView;
}

#pragma mark - SecretSymbol
- (TFY_BoxInputView *)generateBoxInputView_secretSymbol
{
    TFY_BoxInputCellProperty *cellProperty = [TFY_BoxInputCellProperty new];
    cellProperty.cellCursorColor = color_FFECEC;
    cellProperty.cellCursorWidth = 2;
    cellProperty.cellCursorHeight = 27;
    cellProperty.cornerRadius = 0;
    cellProperty.borderWidth = 0;
    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
    cellProperty.cellTextColor = color_master;
    cellProperty.showLine = YES;
    cellProperty.securitySymbol = @"☻";//need

    TFY_BoxInputView *boxInputView = [[TFY_BoxInputView alloc] initWithCodeLength:6];
    boxInputView.mainCollectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    boxInputView.ifNeedSecurity = YES;//need
    boxInputView.customCellProperty = cellProperty;
    [boxInputView loadAndPrepareViewWithBeginEdit:NO];
    
    __weak __typeof(self)weakSelf = self;
    boxInputView.textDidChangeblock = ^(NSString *text, BOOL isFinished) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (text.length > 0) {
            strongSelf.valueLabel.text = text;
        }else{
            strongSelf.valueLabel.text = @"清空";
        }
    };
    
    boxInputView.ifClearAllInBeginEditing = YES;
    [boxInputView reloadInputString:@"5678"];
    
    return boxInputView;
}

#pragma mark - SecretImage
- (TFY_BoxInputView *)generateBoxInputView_secretImage
{
    TFY_BoxInputCellProperty *cellProperty = [TFY_BoxInputCellProperty new];
    cellProperty.cellCursorColor = [UIColor redColor];
    cellProperty.cellCursorWidth = 2;
    cellProperty.cellCursorHeight = 27;
    cellProperty.cornerRadius = 0;
    cellProperty.borderWidth = 0;
    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
    cellProperty.cellTextColor = color_master;
    cellProperty.showLine = YES;
    cellProperty.securitySymbol = @"☃";//need
    

    TFY_BoxInputView *_boxInputView = [[TFY_BoxInputView alloc] initWithCodeLength:6];
    _boxInputView.mainCollectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _boxInputView.ifNeedSecurity = YES;//need
    _boxInputView.customCellProperty = cellProperty;
    [_boxInputView loadAndPrepareViewWithBeginEdit:YES];

    return _boxInputView;
}

#pragma mark - SecretView
- (TFY_BoxInputView *)generateBoxInputView_secretView
{
    TFY_BoxInputCellProperty *cellProperty = [TFY_BoxInputCellProperty new];
    cellProperty.cellCursorColor = color_FFECEC;
    cellProperty.cellCursorWidth = 2;
    cellProperty.cellCursorHeight = 27;
    cellProperty.cornerRadius = 0;
    cellProperty.borderWidth = 0;
    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
    cellProperty.cellTextColor = color_master;
    cellProperty.showLine = YES;
    cellProperty.securityType = TFY_BoxSecurityCustomViewType;//need
    
    TFY_BoxInputView *_boxInputView = [[TFY_BoxInputView alloc] initWithCodeLength:6];
    _boxInputView.mainCollectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _boxInputView.ifNeedSecurity = YES;//need
    _boxInputView.customCellProperty = cellProperty;
    [_boxInputView loadAndPrepareViewWithBeginEdit:YES];

    return _boxInputView;
}

#pragma mark - BtnEvent
- (void)clearBtnEvent
{
    [self.boxInputView clearAll];
}



@end
