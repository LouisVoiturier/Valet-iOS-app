//
//  RecapView.m
//  Louis-Voiturier
//
//  Created by François Juteau on 09/11/2015.
//  Copyright © 2015 Louis. All rights reserved.
//

#import "RecapView.h"

@implementation RecapView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        
        // Corner Radius
        self.layer.cornerRadius = 3.f;
        
        
        // Ajout d'une ombre
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowRadius = 2;
        self.layer.shadowOpacity = 0.25;
        
        
        /***********************/
        /***** ADRESS VIEW *****/
        /***********************/
        _addressView = [[AddressView alloc] init];
        
        [_addressView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_addressView];
        
        
        /***************************/
        /***** USER INFO VIEW *****/
        /**************************/
        _userInfoView = [[UserInfoView alloc] init];
        
        [_userInfoView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_userInfoView];
        
        
    }
    return self;
}


-(void)addInitialConstraints
{
    NSNumber *viewWidth = [NSNumber numberWithFloat:self.frame.size.width];
    NSNumber *viewHeight = [NSNumber numberWithFloat:self.frame.size.height];
    
    NSNumber *userInfoWidth = @220;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_addressView, _userInfoView);
    
    NSDictionary *metrics = NSDictionaryOfVariableBindings(viewWidth, viewHeight, userInfoWidth);
    
    // Horizontale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_addressView][_userInfoView(userInfoWidth)]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    // Verticale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_addressView]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    // Verticale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_userInfoView]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    [_addressView addInitialConstraints];
    [_userInfoView addInitialConstraints];
}

@end
