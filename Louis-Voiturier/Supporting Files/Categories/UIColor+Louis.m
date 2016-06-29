//
//  UIColor+Louis.m
//  Louis
//
//  Created by Thibault Le Cornec on 14/09/2015.
//  Copyright (c) 2015 Louis. All rights reserved.
//

#import "UIColor+Louis.h"

@implementation UIColor (Louis)


// ===== Global ===== //

+ (instancetype)louisHeaderColor       { return [UIColor louisWhiteColor]; }

+ (instancetype)louisWhiteColor        { return [UIColor whiteColor]; }

+ (instancetype)louisBackgroundApp     { return [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1]; }

+ (instancetype)louisMainColor         { return [UIColor colorWithRed:0.58 green:0.13 blue:0.35 alpha:1]; }

+ (instancetype)louisTitleAndTextColor { return [UIColor blackColor]; }

+ (instancetype)louisSubtitleColor     { return [UIColor colorWithRed:0.36 green:0.36 blue:0.36 alpha:1]; }

+ (instancetype)louisLabelColor        { return [UIColor colorWithRed:0.55 green:0.55 blue:0.55 alpha:1]; }

+ (instancetype)louisPlaceholderColor  { return [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1]; }

+ (instancetype)louisConfirmColor      { return [UIColor colorWithRed:2./255. green:136./255. blue:15./255. alpha:1.]; }

+ (instancetype)louisAnthracite        { return [UIColor colorWithRed:74./255. green:74./255. blue:74./255. alpha:1.];}


// ===== Buttons Colors ===== //

// ----- Main ----- //
+ (instancetype)buttonMainDisabledBackgroundColor { return [UIColor colorWithRed:0.74 green:0.61 blue:0.67 alpha:1]; }

+ (instancetype)buttonMainEnabledBackgroundColor  { return [UIColor louisMainColor]; }

+ (instancetype)buttonMainSelectedBackgroundColor { return [UIColor colorWithRed:0.47 green:0.07 blue:0.27 alpha:1]; }

+ (instancetype)buttonMainTintColor               { return [UIColor louisWhiteColor]; }

// ----- Alt ----- //
+ (instancetype)buttonAltTintColor       { return [UIColor louisSubtitleColor]; }

+ (instancetype)buttonAltBackgroundColor { return [UIColor louisWhiteColor]; }

+ (instancetype)buttonAltBorderColor     { return [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1]; }



@end
