//
//  UITextView+TFY_Chain.m
//  TFY_Category
//
//  Created by 田风有 on 2019/7/26.
//  Copyright © 2019 恋机科技. All rights reserved.
//

#import "UITextView+TFY_Chain.h"
#import <objc/runtime.h>

#define WSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

CG_INLINE void TextView_ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

@interface UITextView ()
/**限制文本*/
@property (nonatomic , strong)UILabel *tfy_textNumLabel;

@end

@implementation UITextView (TFY_Chain)

+ (void)load {
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       TextView_ReplaceMethod([self class], @selector(layoutSubviews), @selector(tfy_layoutSubviews));
   });
}

- (void)tfy_layoutSubviews {
    [self updateLabel];
}

/**
 *  文本输入
 */
-(UITextView *(^)(NSString *))tfy_text{
    WSelf(myself);
    return ^(NSString *title_str){
        myself.text = title_str;
        return myself;
    };
}
/**
 *  文本颜色
 */
-(UITextView *(^)(id))tfy_textcolor{
    WSelf(myself);
    return ^(id color_str){
        if ([color_str isKindOfClass:[NSString class]]) {
            myself.textColor = [self btncolorWithHexString:color_str alpha:1];
        }
        if ([color_str isKindOfClass:[UIColor class]]) {
            myself.textColor = color_str;
        }
        
        return myself;
    };
}
/**
 *  文本大小
 */
-(UITextView *(^)(UIFont *))tfy_font{
    WSelf(myself);
    return ^(UIFont *font){
        myself.font = font;
        return myself;
    };
}

/**
 *  按钮 title_str 文本文字 color_str 文字颜色  font文字大小
 */
-(UITextView *(^)(NSString *,id,UIFont *))tfy_title{
    WSelf(myself);
    return ^(NSString *title_str,id color_str,UIFont *font){
        myself.text = title_str;
        if ([color_str isKindOfClass:[NSString class]]) {
            myself.textColor = [self btncolorWithHexString:color_str alpha:1];
        }
        if ([color_str isKindOfClass:[UIColor class]]) {
            myself.textColor = color_str;
        }
        myself.font = font;
        return myself;
    };
}
/**
 *  按钮  HexString 背景颜色 alpha 背景透明度
 */
-(UITextView *(^)(id))tfy_backgroundColor{
    WSelf(myself);
    return ^(id color){
        if ([color isKindOfClass:[NSString class]]) {
            myself.backgroundColor = [self btncolorWithHexString:color alpha:1];
        }
        if ([color isKindOfClass:[UIColor class]]) {
            myself.backgroundColor = color;
        }
        return myself;
    };
}
/**
 *  按钮  alignment 0 左 1 中 2 右
 */
-(UITextView *(^)(NSInteger))tfy_alAlignment{
    WSelf(myself);
    return ^(NSInteger alignment){
        switch (alignment) {
            case 0:
                myself.textAlignment = NSTextAlignmentLeft;
                break;
            case 1:
                myself.textAlignment =NSTextAlignmentCenter;
                break;
            case 2:
                myself.textAlignment =NSTextAlignmentRight;
                break;
        }
        return myself;
    };
}
/**
 *  添加四边框和color 颜色  borderWidth 宽度
 */
-(UITextView *(^)(CGFloat, id))tfy_borders{
    WSelf(myself);
    return ^(CGFloat borderWidth, id color){
        myself.layer.borderWidth = borderWidth;
        if ([color isKindOfClass:[NSString class]]) {
            myself.layer.borderColor = [self btncolorWithHexString:color alpha:1].CGColor;
        }
        if ([color isKindOfClass:[UIColor class]]) {
            myself.layer.borderColor = [(UIColor *)color CGColor];
        }
        return myself;
    };
}
/**
 *  添加四边 color_str阴影颜色  shadowRadius阴影半径
 */
-(UITextView *(^)(id, CGFloat))tfy_bordersShadow{
    WSelf(myself);
    return ^(id color, CGFloat shadowRadius){
        // 阴影颜色
        if ([color isKindOfClass:[NSString class]]) {
            myself.layer.shadowColor =  [self btncolorWithHexString:color alpha:1].CGColor;
        }
        if ([color isKindOfClass:[UIColor class]]) {
            myself.layer.shadowColor =  [(UIColor *)color CGColor];
        }
        // 阴影偏移，默认(0, -3)
        myself.layer.shadowOffset = CGSizeMake(0,0);
        // 阴影透明度，默认0
        myself.layer.shadowOpacity = 0.5;
        // 阴影半径，默认3
        myself.layer.shadowRadius = shadowRadius;
        
        return myself;
    };
}

/**
 *  按钮  cornerRadius 圆角
 */
-(UITextView *(^)(CGFloat))tfy_cornerRadius{
    WSelf(myself);
    return ^(CGFloat cornerRadius){
        myself.layer.cornerRadius = cornerRadius;
        return myself;
    };
}
/**
 *  按钮  image_str 图片字符串
 */
-(UITextView *(^)(bool))tfy_editable{
    WSelf(myself);
    return ^(bool editable){
        myself.editable = editable;
        return myself;
    };
}
/**
 * 编辑框中的内容密码显示
 */
-(UITextView *(^)(bool))tfy_secureTextEntry{
    WSelf(myself);
    return ^(bool secure){
        myself.secureTextEntry = secure;
        return myself;
    };
}

/**
 *  自定义键盘  inputView 自定义输入区域
 */
-(UITextView *(^)(UIView *))tfy_inputView{
    WSelf(myself);
    return ^(UIView *inputView){
        myself.inputView =  inputView;
        return myself;
    };
}
/**
 *  自定义键盘 /键盘上加view
 */
-(UITextView *(^)(UIView *))tfy_inputAccessoryView{
    WSelf(myself);
    return ^(UIView *inputAccessoryView){
        myself.inputAccessoryView = inputAccessoryView;
        return myself;
    };
}

/**
 *  设置键盘类型
 */
-(UITextView *(^)(UIKeyboardType))tfy_keyboardType{
    WSelf(myself);
    return ^(UIKeyboardType tpye){
        myself.keyboardType = tpye;
        return myself;
    };
}
/**
 *  设置键盘上返回键的类型
 */
-(UITextView *(^)(UIReturnKeyType))tfy_returnKeyType{
    WSelf(myself);
    return ^(UIReturnKeyType returnKeyType){
        myself.returnKeyType = returnKeyType;
        return myself;
    };
}
/**
 *  设置键盘的视觉样式
 */
-(UITextView *(^)(UIKeyboardAppearance))tfy_keyboardAppearance{
    WSelf(myself);
    return ^(UIKeyboardAppearance keyboardAppearance){
        myself.keyboardAppearance = keyboardAppearance;
        return myself;
    };
}
/**
 *  设置是否启动自动提醒更新功能
 */
-(UITextView *(^)(bool))tfy_autocorrectionType{
    WSelf(myself);
    return ^(bool autocorrection){
        myself.autocorrectionType = autocorrection;
        return myself;
    };
}
/**
 *   自动适应高度
 */
-(UITextView *(^)(UIViewAutoresizing))tfy_autoresizingMask{
    WSelf(myself);
    return ^(UIViewAutoresizing autoresizingMask){
        myself.autoresizingMask = autoresizingMask;
        return myself;
    };
}
/**
 *   是否滑动
 */
-(UITextView *(^)(bool))tfy_scrollEnabled{
    WSelf(myself);
    return ^(bool scroll){
        myself.scrollEnabled = scroll;
        return myself;
    };
}
/**
 *  默认为NO,清除之前输入的文本
 */
-(UITextView *(^)(bool))tfy_clearsOnInsertion{
    WSelf(myself);
    return ^(bool clears){
        myself.clearsOnInsertion = clears;
        return myself;
    };
}

/**
 *  添加自定义键盘需要开启 设置YES
 */
-(UITextView *(^)(bool))tfy_enablesReturnKeyAutomatically{
    WSelf(myself);
    return ^(bool automatically){
        myself.enablesReturnKeyAutomatically = automatically;
        return myself;
    };
}

/**
 *  中文输入法上下跳动问题 设置NO
 */
-(UITextView *(^)(bool))tfy_allowsNonContiguousLayout{
    WSelf(myself);
    return ^(bool allows){
        myself.layoutManager.allowsNonContiguousLayout = allows;
        return myself;
    };
}

/**
 * 添加指定的View
 */
-(UITextView *(^)(UIView *))tfy_addToSuperView{
    WSelf(myself);
    return ^(UIView *view){
        [view addSubview:myself];
        return myself;
    };
}

/**
 *  scrollsToTop是UIScrollView的一个属性，主要用于点击设备的状态栏时，是scrollsToTop == YES的控件滚动返回至顶部。
 */
-(UITextView *(^)(bool))tfy_scrollsToTop{
    WSelf(myself);
    return ^(bool scrolls){
        myself.scrollsToTop = scrolls;
        return myself;
    };
}

/**
 *  高度自适应 解决方案
 */
-(UITextView *(^)(UIEdgeInsets,CGFloat))tfy_textContainerInset{
    WSelf(myself);
    return ^(UIEdgeInsets textContainerInset,CGFloat lineFragmentPadding){
        myself.textContainerInset = textContainerInset;
        myself.textContainer.lineFragmentPadding = lineFragmentPadding;
        return myself;
    };
}

- (void)setTfy_limitNum:(NSInteger)tfy_limitNum {
    NSNumber *number = [NSNumber numberWithInteger:tfy_limitNum];
    objc_setAssociatedObject(self, &@selector(tfy_limitNum), number, OBJC_ASSOCIATION_RETAIN);
}

- (NSInteger )tfy_limitNum {
    NSNumber *number = objc_getAssociatedObject(self, &@selector(tfy_limitNum));
    return number.integerValue;
}

- (void)setTfy_placeholder:(NSString *)tfy_placeholder {
    objc_setAssociatedObject(self, &@selector(tfy_placeholder), tfy_placeholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.tfy_placeholderLabel.text = tfy_placeholder;
}

- (NSString *)tfy_placeholder {
    return objc_getAssociatedObject(self, &@selector(tfy_placeholder));
}

- (void)setTfy_placeholderLabel:(UILabel *)tfy_placeholderLabel {
    objc_setAssociatedObject(self, &@selector(tfy_placeholderLabel), tfy_placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 是否需要调整字体
- (BOOL)needAdjustFont {
    return [objc_getAssociatedObject(self, &@selector(needAdjustFont)) boolValue];
}

- (void)setNeedAdjustFont:(BOOL)needAdjustFont {
    objc_setAssociatedObject(self, &@selector(needAdjustFont), @(needAdjustFont), OBJC_ASSOCIATION_ASSIGN);
}

- (UILabel *)tfy_placeholderLabel {
    UILabel *label = objc_getAssociatedObject(self, &@selector(tfy_placeholderLabel));
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        label.textColor = UIColor.lightGrayColor;
        objc_setAssociatedObject(self,  &@selector(tfy_placeholderLabel), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        //添加通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tfy_textViewDidChange) name:UITextViewTextDidChangeNotification object:nil];
        //监听font的变化
        [self addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
    }
    return label;
}

- (UILabel *)tfy_textNumLabel {
    UILabel *label = objc_getAssociatedObject(self, &@selector(tfy_textNumLabel));
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
        objc_setAssociatedObject(self,  &@selector(tfy_textNumLabel), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return label;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"font"]){
        self.needAdjustFont = YES;
        [self tfy_textViewDidChange];
    }
}

- (void)tfy_textViewDidChange {
    self.tfy_placeholderLabel.hidden = self.hasText;
    
    if (self.tfy_limitNum > 0) {
        self.tfy_textNumLabel.hidden = !self.hasText;
        UITextRange *selectedRange = [self markedTextRange];
        // 获取高亮部分 中文联想
        UITextPosition *posi = [self positionFromPosition:selectedRange.start offset:0];
        // 如果在变化中是高亮部分在变，就不要计算字符
        if (selectedRange && posi) {
            return;
        }
        // 是否需要更新字体（NO 采用默认字体大小）
        if (self.needAdjustFont) {
            self.tfy_placeholderLabel.font = self.font;
            self.needAdjustFont = NO;
        }
        // 实际总长度
        NSInteger realLength = self.text.length;
        NSRange selection = self.selectedRange;
//        NSString *headText = [self.text substringToIndex:selection.location];   // 光标前的文本
        NSString *tailText = [self.text substringFromIndex:selection.location]; // 光标后的文本
        NSInteger restLength = self.tfy_limitNum - tailText.length;             // 光标前允许输入的最大数量

        if (realLength > self.tfy_limitNum) {
            // 解决半个emoji 定位到index位置时，返回在此位置的完整字符的range
            NSRange range = [self.text rangeOfComposedCharacterSequenceAtIndex:restLength];
            NSString *subHeadText = [self.text substringToIndex:range.location];
            
            // NSString *subHeadText = [headText substringToIndex:restLength];
            self.text = [subHeadText stringByAppendingString:tailText];
            [self setSelectedRange:NSMakeRange(restLength, 0)];
            // 解决粘贴过多之后，撤销粘贴 崩溃问题 —— 不会出现弹框
            [self.undoManager removeAllActions];
        }
        self.tfy_textNumLabel.text = [NSString stringWithFormat:@"%lu/%ld", (unsigned long)self.text.length, (long)self.tfy_limitNum];
    } else {
        self.tfy_textNumLabel.hidden = self.hasText;
    }
}

- (void)updateLabel{
    if (self.text.length>0) {
        [self.tfy_placeholderLabel removeFromSuperview];
    }
    if (self.tfy_limitNum==0) {
        [self.tfy_textNumLabel removeFromSuperview];
    }
    //显示label
    [self insertSubview:self.tfy_placeholderLabel atIndex:0];
    
    NSArray *subsArr = self.subviews;
    for (UIView *view in subsArr) {
        if ([view isKindOfClass:NSClassFromString(@"_UIScrollViewScrollIndicator")]) {
            [self insertSubview:self.tfy_textNumLabel aboveSubview:view];
        }
    }
    CGFloat lineFragmentPadding =  self.textContainer.lineFragmentPadding;  //边距
    UIEdgeInsets contentInset = self.textContainerInset;
    //设置label frame
    CGFloat labelX = lineFragmentPadding + contentInset.left;
    CGFloat labelY = contentInset.top;
    CGFloat labelW = CGRectGetWidth(self.bounds) - contentInset.right - labelX;
    CGFloat labelH = [self.tfy_placeholderLabel sizeThatFits:CGSizeMake(labelW, MAXFLOAT)].height;
    self.tfy_placeholderLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    CGFloat textH = [self sizeThatFits:CGSizeMake(labelW, MAXFLOAT)].height;
    CGFloat labelnumberH = CGRectGetHeight(self.bounds) - contentInset.bottom-10;
    if (textH >= labelnumberH && self.tfy_limitNum > 0) {
        self.scrollEnabled = NO;
    }
    self.tfy_textNumLabel.frame = CGRectMake(labelX, labelnumberH, labelW-labelX, 15);
}

-(UIColor *)btncolorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r                       截取的range = (0,2)
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;//     截取的range = (2,2)
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;//     截取的range = (4,2)
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;//将字符串十六进制两位数字转为十进制整数
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}
@end
