//
//  UserInfoView.h
//  Louis-Voiturier
//
//  Created by François Juteau on 09/11/2015.
//  Copyright © 2015 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoView : UIView

/********************/
/***** PROPERTIES *****/
/********************/

@property (nonatomic, strong) UILabel *clientName;
@property (nonatomic, strong) UILabel *clientVehicle;
//@property (nonatomic, strong) UILabel *callLabel;
@property (nonatomic, strong) UIImageView *phoneImageView;
@property (nonatomic, strong) UIButton *callButton;


/********************/
/***** METHODS *****/
/********************/

-(void)addInitialConstraints;

@end
