//
//  MCUtils+Validator.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/7/7.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCUtils (Validator)

/// 有效性校验：身份证号码
/// @param idString 身份证号字符串
+ (BOOL)mk_validateIDCardNumber:(NSString *)idString;

/// 有效性校验：手机号码（考虑到运营商不定期新增号段，建议使用前更新谓词）
/// @param numString 手机号字符串
+ (BOOL)mk_validateCellphoneNumber:(NSString *)numString;

/// 格式校验：邮箱
/// @param email 邮箱字符串
+ (BOOL)mk_validateEmail:(NSString *)email;

/// 格式校验：字符串是否为空
/// @param string 待校验字符串
/// @param mTrim 是否去除空格和换行符
+ (BOOL)mk_validateEmpytOrNullRemindString:(NSString*)string trim:(BOOL)mTrim;

/// 格式校验：字符串是否仅包含数字
/// @param text 待校验字符串
+ (BOOL)mk_validateOnlyIntNumber:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
