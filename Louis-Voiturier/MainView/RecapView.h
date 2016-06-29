//
//  RecapView.h
//  Louis-Voiturier
//
//  Created by François Juteau on 09/11/2015.
//  Copyright © 2015 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressView.h"
#import "UserInfoView.h"

@interface RecapView : UIView

/********************/
/***** PROPERTIES *****/
/********************/

@property (nonatomic, strong) AddressView *addressView;
@property (nonatomic, strong) UserInfoView *userInfoView;


/********************/
/***** METHODS *****/
/********************/

-(void)addInitialConstraints;

@end
