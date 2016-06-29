//
//  AddressView.h
//  Louis-Voiturier
//
//  Created by François Juteau on 09/11/2015.
//  Copyright © 2015 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressView : UIView

/**********************/
/***** PROPERTIES *****/
/**********************/

@property (nonatomic, strong) UILabel *adressLabel;
@property (nonatomic, strong) UILabel *zipCodeLabel;
@property (nonatomic, strong) UILabel *placeTitleLabel;
@property (nonatomic, strong) UILabel *placeDescriptionLabel;
//@property (nonatomic, strong) UILabel *itineraryTitleLabel;
@property (nonatomic, strong) UIImageView *itineraryImageView;
@property (nonatomic, strong) UIButton *itineraryButton;


/*******************/
/***** METHODS *****/
/*******************/

-(void)addInitialConstraints;

@end
