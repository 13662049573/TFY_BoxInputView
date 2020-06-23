//
//  TFY_BoxInputView.m
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import "TFY_BoxInputView.h"
#import "TFY_BoxTextField.h"

typedef NS_ENUM(NSInteger, TFY_BoxTextChangeType) {
    TFY_BoxTextChangeType_NoChange,
    TFY_BoxTextChangeType_Insert,
    TFY_BoxTextChangeType_Delete,
};

@interface TFY_BoxInputView ()<UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate>
@property (nonatomic, assign) NSInteger codeLength;
@property (nonatomic, strong) UITapGestureRecognizer *tapGR;
@property (nonatomic, strong) TFY_BoxTextField *textView;
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSMutableArray <NSString *> *valueArr;
@property (nonatomic, strong) NSMutableArray <TFY_BoxInputCellProperty *> *cellPropertyArr;
@property (nonatomic, assign) NSInteger oldLength;
@property (nonatomic, assign) BOOL ifNeedBeginEdit;
@end

@implementation TFY_BoxInputView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaultValue];
        [self addNotificationObserver];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self initDefaultValue];
        [self addNotificationObserver];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initDefaultValue];
        [self addNotificationObserver];
    }
    return self;
}

- (instancetype _Nullable )initWithCodeLength:(NSInteger)codeLength{
    self = [super init];
    if (self) {
        [self initDefaultValue];
        [self addNotificationObserver];
        self.codeLength = codeLength;
    }
    return self;
}

- (void)dealloc{
    [self removeNotificationObserver];
}

#pragma mark - Notification Observer
- (void)addNotificationObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)removeNotificationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationWillResignActive:(NSNotification *)notification{
    // 触发home按下，光标动画移除
}

- (void)applicationDidBecomeActive:(NSNotification *)notification{
    // 重新进来后响应，光标动画重新开始
    [self reloadAllCell];
}

#pragma mark - You can inherit
- (void)initDefaultValue{
    _oldLength = 0;
    self.ifNeedSecurity = NO;
    self.securityDelay = 0.3;
    self.codeLength = 6;
    self.ifNeedCursor = YES;
    self.keyBoardType = UIKeyboardTypeNumberPad;
    self.inputType = TFY_InputType_Number;
    self.customInputRegex = @"";
    self.backgroundColor = [UIColor clearColor];
    _valueArr = [NSMutableArray new];
    _ifNeedBeginEdit = NO;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.mainCollectionView.frame = self.bounds;
}

#pragma mark - LoadAndPrepareView
- (void)loadAndPrepareView{
    [self loadAndPrepareViewWithBeginEdit:YES];
}

- (void)loadAndPrepareViewWithBeginEdit:(BOOL)beginEdit{
    if (_codeLength<=0) {return;}
    [self generateCellPropertyArr];
    
    // mainCollectionView
    if (!self.mainCollectionView || ![self.subviews containsObject:self.mainCollectionView]) {
        [self addSubview:self.mainCollectionView];
        self.mainCollectionView.frame = self.bounds;
    }
    // textView
    if (!self.textView || ![self.subviews containsObject:self.textView]) {
        [self addSubview:self.textView];
        self.textView.frame = CGRectMake(40, 0, 0, 0);
    }
    // tap
    if (self.tapGR.view != self) {
        [self addGestureRecognizer:self.tapGR];
    }
    if (![self.textView.text isEqualToString:self.customCellProperty.originValue]) {
        self.textView.text = self.customCellProperty.originValue;
        [self textDidChange:self.textView];
    }
    if (beginEdit) {
        [self beginEdit];
    }
}

- (void)generateCellPropertyArr{
    [self.cellPropertyArr removeAllObjects];
    for (int i = 0; i < self.codeLength; i++) {
        [self.cellPropertyArr addObject:[self.customCellProperty copy]];
    }
}

#pragma mark - code Length 调整
- (void)resetCodeLength:(NSInteger)codeLength beginEdit:(BOOL)beginEdit{
    if (codeLength<=0) {return;}
    self.codeLength = codeLength;
    [self generateCellPropertyArr];
    [self clearAllWithBeginEdit:beginEdit];
}

#pragma mark - Reload Input View
- (void)reloadInputString:(NSString *_Nullable)value{
    if (![self.textView.text isEqualToString:value]) {
        self.textView.text = value;
        [self baseTextDidChange:self.textView manualInvoke:YES];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _ifNeedBeginEdit = YES;
    if (self.ifClearAllInBeginEditing && self.textValue.length == self.codeLength) {
        [self clearAll];
    }
    if (self.textEditStatusChangeblock) {
        self.textEditStatusChangeblock(TFY_TextEditStatus_BeginEdit);
    }
    [self reloadAllCell];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _ifNeedBeginEdit = NO;
    if (self.textEditStatusChangeblock) {
        self.textEditStatusChangeblock(TFY_TextEditStatus_EndEdit);
    }
    [self reloadAllCell];
}

#pragma mark - TextViewEdit
- (void)beginEdit{
    if (![self.textView isFirstResponder]) {
        [self.textView becomeFirstResponder];
    }
}

- (void)endEdit{
    if ([self.textView isFirstResponder]) {
        [self.textView resignFirstResponder];
    }
}

- (void)clearAll{
    [self clearAllWithBeginEdit:YES];
}

- (void)clearAllWithBeginEdit:(BOOL)beginEdit{
    _oldLength = 0;
    [_valueArr removeAllObjects];
    self.textView.text = @"";
    [self allSecurityClose];
    [self reloadAllCell];
    [self triggerBlock];
    
    if (beginEdit) {
        [self beginEdit];
    }
}

#pragma mark - UITextFieldDidChange
- (void)textDidChange:(UITextField *)textField {
    [self baseTextDidChange:textField manualInvoke:NO];
}

/**
 * 过滤输入内容
*/
- (NSString *)filterInputContent:(NSString *)inputStr {
    
    NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:inputStr];
    if (self.inputType == TFY_InputType_Number) {
        /// 纯数字
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^0-9]" options:0 error:nil];
        [regex replaceMatchesInString:mutableStr options:0 range:NSMakeRange(0, [mutableStr length]) withTemplate:@""];
    } else if (self.inputType == TFY_InputType_Normal) {
        /// 不处理
        nil;
    } else if (self.inputType == TFY_InputType_Regex) {
        /// 自定义正则
        if (self.customInputRegex.length > 0) {
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:self.customInputRegex options:0 error:nil];
            [regex replaceMatchesInString:mutableStr options:0 range:NSMakeRange(0, [mutableStr length]) withTemplate:@""];
        }
    }
    return [mutableStr copy];
}

/**
 * textDidChange基操作
 * manualInvoke：是否为手动调用
 */
- (void)baseTextDidChange:(UITextField *)textField manualInvoke:(BOOL)manualInvoke  {
    
    __weak typeof(self) weakSelf = self;
    NSString *verStr = textField.text;
    
    //有空格去掉空格
    verStr = [verStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    verStr = [self filterInputContent:verStr];
    
    if (verStr.length >= _codeLength) {
        verStr = [verStr substringToIndex:_codeLength];
        [self endEdit];
    }
    textField.text = verStr;
    
    // 判断删除/增加
    TFY_BoxTextChangeType boxTextChangeType = TFY_BoxTextChangeType_NoChange;
    if (verStr.length > _oldLength) {
        boxTextChangeType = TFY_BoxTextChangeType_Insert;
    }else if (verStr.length < _oldLength){
        boxTextChangeType = TFY_BoxTextChangeType_Delete;
    }
    
    // _valueArr
    if (boxTextChangeType == TFY_BoxTextChangeType_Delete) {
        [self setSecurityShow:NO index:_valueArr.count-1];
        [_valueArr removeLastObject];
        
    }else if (boxTextChangeType == TFY_BoxTextChangeType_Insert){
        if (verStr.length > 0) {
            if (_valueArr.count > 0) {
                [self replaceValueArrToAsteriskWithIndex:_valueArr.count - 1 needEqualToCount:NO];
            }
            [_valueArr removeAllObjects];
            
            [verStr enumerateSubstringsInRange:NSMakeRange(0, verStr.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                [strongSelf.valueArr addObject:substring];
            }];
            
            if (self.ifNeedSecurity) {
                if (manualInvoke) {
                    // 处理所有秘文
                    [self delaySecurityProcessAll];
                }else {
                    // 只处理最后一个秘文
                    [self delaySecurityProcessLastOne];
                }
            }
        }
    }
    [self reloadAllCell];
    
    _oldLength = verStr.length;
    
    if (boxTextChangeType != TFY_BoxTextChangeType_NoChange) {
        [self triggerBlock];
    }
}

#pragma mark - Control security show
- (void)setSecurityShow:(BOOL)isShow index:(NSInteger)index{
    if (index < 0) {return;}
    TFY_BoxInputCellProperty *cellProperty = self.cellPropertyArr[index];
    cellProperty.ifShowSecurity = isShow;
}

- (void)allSecurityClose{
    [self.cellPropertyArr enumerateObjectsUsingBlock:^(TFY_BoxInputCellProperty * _Nonnull cellProperty, NSUInteger idx, BOOL * _Nonnull stop) {
        if (cellProperty.ifShowSecurity == YES) {
            cellProperty.ifShowSecurity = NO;
        }
    }];
}

- (void)allSecurityOpen{
    [self.cellPropertyArr enumerateObjectsUsingBlock:^(TFY_BoxInputCellProperty * _Nonnull cellProperty, NSUInteger idx, BOOL * _Nonnull stop) {
        if (cellProperty.ifShowSecurity == NO) {
            cellProperty.ifShowSecurity = YES;
        }
    }];
}


#pragma mark - Trigger block
- (void)triggerBlock{
    if (self.textDidChangeblock) {
        BOOL isFinished = self.valueArr.count == self.codeLength ? YES : NO;
        self.textDidChangeblock(self.textView.text, isFinished);
    }
}

#pragma mark - Asterisk 替换密文
/**
 * 替换密文
 * needEqualToCount：是否只替换最后一个
 */
- (void)replaceValueArrToAsteriskWithIndex:(NSInteger)index needEqualToCount:(BOOL)needEqualToCount{
    if (!self.ifNeedSecurity) {return;}
    if (needEqualToCount && index != self.valueArr.count - 1) {return;}
    [self setSecurityShow:YES index:index];
}

#pragma mark 延时替换最后一个密文
- (void)delaySecurityProcessLastOne{
    __weak __typeof(self)weakSelf = self;
    [self delayAfter:self.securityDelay dealBlock:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.valueArr.count > 0) {
            [strongSelf replaceValueArrToAsteriskWithIndex:strongSelf.valueArr.count-1 needEqualToCount:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf reloadAllCell];
            });
        }
    }];
}

#pragma mark 延时替换所有一个密文
- (void)delaySecurityProcessAll{
    __weak __typeof(self)weakSelf = self;
    [self.valueArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf replaceValueArrToAsteriskWithIndex:idx needEqualToCount:NO];
    }];
    [self reloadAllCell];
}

#pragma mark - DelayBlock
- (void)delayAfter:(CGFloat)delayTime dealBlock:(void (^)(void))dealBlock{
    dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime *NSEC_PER_SEC));
    dispatch_after(timer, dispatch_get_main_queue(), ^{
        if (dealBlock) {
            dealBlock();
        }
    });
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.codeLength;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    id tempCell = [self customCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    if ([tempCell isKindOfClass:[TFY_BoxInputCell class]]) {
        
        TFY_BoxInputCell *cell = (TFY_BoxInputCell *)tempCell;
        cell.ifNeedCursor = self.ifNeedCursor;
        
        // CellProperty
        TFY_BoxInputCellProperty *cellProperty = self.cellPropertyArr[indexPath.row];
        cellProperty.index = indexPath.row;
        
        NSString *currentPlaceholderStr = nil;
        if (self.placeholderText.length > indexPath.row) {
            currentPlaceholderStr = [self.placeholderText substringWithRange:NSMakeRange(indexPath.row, 1)];
            cellProperty.cellPlaceholderText = currentPlaceholderStr;
        }
        
        // setOriginValue
        NSUInteger focusIndex = self.valueArr.count;
        if (self.valueArr.count > 0 && indexPath.row <= focusIndex - 1) {
            [cellProperty setMyOriginValue:self.valueArr[indexPath.row]];
        }else{
            [cellProperty setMyOriginValue:@""];
        }
        cell.boxInputCellProperty = cellProperty;
        
        if (self.ifNeedBeginEdit) {
            cell.selected = indexPath.row == focusIndex ? YES : NO;
        }else{
            cell.selected = NO;
        }
    }
    return tempCell;
}

- (void)reloadAllCell{
    [self.mainCollectionView reloadData];

    NSUInteger focusIndex = self.valueArr.count;
    /// 最后一个
    if (focusIndex == self.codeLength) {
        [self.mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:focusIndex - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    } else {
        [self.mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:focusIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

#pragma mark - Qiuck set
- (void)quickSetSecuritySymbol:(NSString *)securitySymbol{
    if (securitySymbol.length != 1) {
        securitySymbol = @"✱";
    }
    self.customCellProperty.securitySymbol = securitySymbol;
}

#pragma mark - You can rewrite
- (UICollectionViewCell *)customCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TFY_BoxInputCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TFY_BoxInputCellID forIndexPath:indexPath];
    return cell;
}

#pragma mark - Setter & Getter
- (UITapGestureRecognizer *)tapGR{
    if (!_tapGR) {
        _tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginEdit)];
    }
    return _tapGR;
}

- (UICollectionView *)mainCollectionView{
    if (!_mainCollectionView) {
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.boxFlowLayout];
        _mainCollectionView.showsHorizontalScrollIndicator = NO;
        _mainCollectionView.backgroundColor = [UIColor clearColor];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.layer.masksToBounds = YES;
        _mainCollectionView.clipsToBounds = YES;
        [_mainCollectionView registerClass:[TFY_BoxInputCell class] forCellWithReuseIdentifier:TFY_BoxInputCellID];
    }
    return _mainCollectionView;
}

- (TFY_BoxFlowLayout *)boxFlowLayout{
    if (!_boxFlowLayout) {
        _boxFlowLayout = [TFY_BoxFlowLayout new];
        _boxFlowLayout.itemSize = CGSizeMake(42, 47);
    }
    return _boxFlowLayout;
}

- (void)setCodeLength:(NSInteger)codeLength{
    _codeLength = codeLength;
    self.boxFlowLayout.itemNum = codeLength;
}

- (void)setKeyBoardType:(UIKeyboardType)keyBoardType{
    _keyBoardType = keyBoardType;
    self.textView.keyboardType = keyBoardType;
}

- (TFY_BoxTextField *)textView{
    if (!_textView) {
        _textView = [TFY_BoxTextField new];
        _textView.delegate = self;
        [_textView addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textView;
}

- (void)setTextContentType:(UITextContentType)textContentType{
    _textContentType = textContentType;
    _textView.textContentType = textContentType;
}

- (TFY_BoxInputCellProperty *)customCellProperty{
    if (!_customCellProperty) {
        _customCellProperty = [TFY_BoxInputCellProperty new];
    }
    return _customCellProperty;
}

- (NSMutableArray <TFY_BoxInputCellProperty *> *)cellPropertyArr{
    if (!_cellPropertyArr) {
        _cellPropertyArr = [NSMutableArray new];
    }
    return _cellPropertyArr;
}

- (NSString *)textValue{
    return _textView.text;
}

@synthesize inputAccessoryView = _inputAccessoryView;

- (void)setInputAccessoryView:(UIView *)inputAccessoryView{
    _inputAccessoryView = inputAccessoryView;
    self.textView.inputAccessoryView = _inputAccessoryView;
}

- (UIView *)inputAccessoryView{
    return _inputAccessoryView;
}

- (void)setIfNeedSecurity:(BOOL)ifNeedSecurity{
    _ifNeedSecurity = ifNeedSecurity;
    
    if (ifNeedSecurity == YES) {
        [self allSecurityOpen];
    }else{
        [self allSecurityClose];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadAllCell];
    });
}


@end
