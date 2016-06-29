//
//  UserInfoView.m
//  Louis-Voiturier
//
//  Created by François Juteau on 09/11/2015.
//  Copyright © 2015 Louis. All rights reserved.
//

#import "UserInfoView.h"
#import "Common.h"

@implementation UserInfoView


- (void)drawRect:(CGRect)rect
{
    /*******************************/
    /***** LIGNE DE SEPARATION *****/
    /*******************************/
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint startPoint = CGPointMake(1, 0);
    CGPoint endPoint = CGPointMake(1, self.frame.size.height);
    
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    
    [[UIColor grayColor] set];
    
    [path setLineWidth:0.5];
    [path stroke];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        
        /***************************/
        /***** CLIENT NAME *****/
        /**************************/
        _clientName = [[UILabel alloc] init];
        _clientName.font = [UIFont louisHeaderFont];
        _clientName.textColor = [UIColor louisTitleAndTextColor];
        _clientName.text = @"_clientName";
        
        [_clientName setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_clientName];
        
        
        /***************************/
        /***** CLIENT VEHICLE *****/
        /**************************/
        _clientVehicle = [[UILabel alloc] init];
        _clientVehicle.font = [UIFont louisLabelFont];
        _clientVehicle.textColor = [UIColor louisSubtitleColor];
        _clientVehicle.text = @"_clientVehicle";
        
        [_clientVehicle setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_clientVehicle];
        
        
        /***************************/
        /***** CALL LABEL *****/
        /**************************/
//        _callLabel = [[UILabel alloc] init];
//        _callLabel.font = [UIFont louisMediumLabel];
//        _callLabel.textColor = [UIColor louisSubtitleColor];
//        _callLabel.text = NSLocalizedString(@"Call-Button-Title", nil);
//        
//        [_callLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [self addSubview:_callLabel];
        
        
        _callButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_callButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_callButton setTitle:NSLocalizedString(@"Call-Button-Title", nil) forState:UIControlStateNormal];
        [_callButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_callButton];
        
        
        /***************************/
        /***** PHONE IMAGE VIeW *****/
        /**************************/
        _phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Phone"]];
        
        [_phoneImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_phoneImageView];
        
        
    }
    return self;
}


-(void)addInitialConstraints
{
    NSNumber *viewWidth = [NSNumber numberWithFloat:self.frame.size.width];
    NSNumber *viewHeight = [NSNumber numberWithFloat:self.frame.size.height];
    
    NSNumber *spacing = @10;
    
    NSNumber *phoneHeight = @18;
    NSNumber *phoneWidth = @18;
    
    
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_clientName, _clientVehicle, _callButton, _phoneImageView);
    
    NSDictionary *metrics = NSDictionaryOfVariableBindings(viewWidth, viewHeight, spacing, phoneHeight, phoneWidth);
    
    // Horizontale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-spacing-[_clientName]-spacing-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    // Horizontale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-spacing-[_clientVehicle]-spacing-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    // Horizontale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=spacing)-[_callButton]-spacing-[_phoneImageView(phoneWidth)]-spacing-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    // Verticale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-spacing-[_clientName]-[_clientVehicle]"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    // Verticale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_callButton(phoneHeight)]-spacing-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    // Verticale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_phoneImageView(phoneHeight)]-spacing-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
}

@end
