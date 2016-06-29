//
//  DataManager+User.h
//  WebServiceInterface
//
//  Created by François Juteau on 28/09/2015.
//  Copyright © 2015 François Juteau. All rights reserved.
//

#import "DataManager.h"
//#import <Stripe/Stripe.h>


@interface DataManager (User)

+(void)signInWithUsername:(NSString *)username
              andPassword:(NSString *)password
               completion:(dataPostCompletion)completionBlock;

- (NSDictionary *)userCredentials;

#pragma mark - GETTERS

+(User *)user;


@end
