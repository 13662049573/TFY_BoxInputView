//
//  TFY_BoxInputView.h
//  TFY_BoxInputView
//
//  Created by tiandengyou on 2020/6/16.
//  Copyright © 2020 田风有. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFY_BoxFlowLayout.h"
#import "TFY_BoxInputCellProperty.h"
#import "TFY_BoxInputCell.h"

@class TFY_BoxInputView;

typedef NS_ENUM(NSInteger, TFY_TextEditStatus) {
    TFY_TextEditStatus_Idle,
    TFY_TextEditStatus_BeginEdit,
    TFY_TextEditStatus_EndEdit,
};

typedef NS_ENUM(NSInteger, TFY_InputType) {
    /// 数字
    TFY_InputType_Number,
    /// 普通（不作任何处理）
    TFY_InputType_Normal,
    /// 自定义正则（此时需要设置customInputRegex）
    TFY_InputType_Regex,
};

typedef void(^TextDidChangeblock)(NSString * _Nullable text, BOOL isFinished);
typedef void(^TextEditStatusChangeblock)(TFY_TextEditStatus editStatus);

NS_ASSUME_NONNULL_BEGIN

@interface TFY_BoxInputView : UIView
/**
 是否需要光标 ifNeedCursor default: YES
 */
@property (assign, nonatomic) BOOL ifNeedCursor;

/**
 验证码长度 codeLength default: 4
 */
@property (nonatomic, assign, readonly) NSInteger codeLength; //If you want to set codeLength, please use `- (instancetype)initWithCodeLength:(NSInteger)codeLength, or - (void)resetCodeLength:(NSInteger)codeLength beginEdit:(BOOL)beginEdit` in TFY_BoxInputView.

/**
 是否开启密文模式 描述：你可以在任何时候修改该属性，并且已经存在的文字会自动刷新。 ifNeedSecurity default: NO
 */
@property (assign, nonatomic) BOOL ifNeedSecurity;

/**
 显示密文的延时时间 securityDelay default: 0.3
 */
@property (assign, nonatomic) CGFloat securityDelay;

/**
 键盘类型 keyBoardType default: UIKeyboardTypeNumberPad
 */
@property (assign, nonatomic) UIKeyboardType keyBoardType;

/**
 输入样式 inputType default: TFY_InputType_Number
 */
@property (assign, nonatomic) TFY_InputType inputType;

/**
自定义正则匹配输入内容 customInputRegex default: @"" 当inputType == TFY_InputType_Regex时才会生效
*/
@property (copy, nonatomic) NSString * _Nullable customInputRegex;

/**
 textContentType 描述: 你可以设置为 'nil' 或者 'UITextContentTypeOneTimeCode' 来自动获取短信验证码 default: nil
 */
@property (null_unspecified,nonatomic,copy) UITextContentType textContentType NS_AVAILABLE_IOS(10_0);

/**
 占位字符填充值 说明：在对应的输入框没有内容时，会显示该值。 默认：nil
 */
@property (strong, nonatomic) NSString  * _Nullable placeholderText;

/**
 弹出键盘时，是否清空所有输入 只有在输入的字数等于codeLength时，生效 default: NO
 */
@property (assign, nonatomic) BOOL ifClearAllInBeginEditing;


@property (copy, nonatomic) TextDidChangeblock _Nullable textDidChangeblock;
@property (copy, nonatomic) TextEditStatusChangeblock _Nullable textEditStatusChangeblock;
@property (strong, nonatomic) TFY_BoxFlowLayout * _Nullable boxFlowLayout;
@property (strong, nonatomic) TFY_BoxInputCellProperty * _Nullable customCellProperty;
@property (strong, nonatomic, readonly) NSString  * _Nullable textValue;
@property (strong, nonatomic) UIView * _Nullable inputAccessoryView;

/**
 装载数据和准备界面 beginEdit: 自动开启编辑模式 default: YES
 */
- (void)loadAndPrepareView;
- (void)loadAndPrepareViewWithBeginEdit:(BOOL)beginEdit;

/**
 重载输入的数据（用来设置预设数据）
 */
- (void)reloadInputString:(NSString *_Nullable)value;

/**
 清空输入 beginEdit: 自动开启编辑模式 default: YES
 */
- (void)clearAll;
- (void)clearAllWithBeginEdit:(BOOL)beginEdit;

- (UICollectionView *_Nullable)mainCollectionView;

// 快速设置
- (void)quickSetSecuritySymbol:(NSString *_Nullable)securitySymbol;

// 你可以在继承的子类中调用父类方法
- (void)initDefaultValue;

// 你可以在继承的子类中重写父类方法
- (UICollectionViewCell *_Nullable)customCollectionView:(UICollectionView *_Nullable)collectionView cellForItemAtIndexPath:(NSIndexPath *_Nullable)indexPath;

// code Length 调整
- (void)resetCodeLength:(NSInteger)codeLength beginEdit:(BOOL)beginEdit;

// Init
- (instancetype _Nullable )initWithCodeLength:(NSInteger)codeLength;
@end

NS_ASSUME_NONNULL_END
