//
//  DataManager+User.m
//  WebServiceInterface
//
//  Created by François Juteau on 28/09/2015.
//  Copyright © 2015 François Juteau. All rights reserved.
//

#import "DataManager+User.h"
#import "KeychainWrapper.h"
#import "HTTPResponseHandler.h"

@implementation DataManager (User)

+(void)signInWithUsername:(NSString *)username
              andPassword:(NSString *)password
               completion:(dataPostCompletion)completionBlock
{
    DataManager *dataManager = [DataManager sharedInstance];
    
    [[NetworkManager sharedInstance] postRequestWithData:nil
                                                  forKey:@"login"
                                             forUsername:username andPassword:password
                                   withCompletionHandler:^(NSData *data, NSHTTPURLResponse *httpResponse, NSError *error)
                                    {
                                        if (!error)
                                        {
                                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                            
                                            dataManager.user = [[User alloc] initWithDictionary:dic];
                                //            NSLog(@"USER : %@", dataManager.user.description);
                                            
                                            NSLog(@"USER DIC : %@", dic);
                                            
                                        }
                                        completionBlock(dataManager.user, httpResponse, error);
                                    }];
}


- (NSDictionary *)userCredentials
{
    KeychainWrapper *MyKeychainWrapper =[[KeychainWrapper alloc]init];
    
    //login auto apres avoir récupéré login et password qui se trouvent dans la keychain
    NSString *username = [MyKeychainWrapper myObjectForKey:(__bridge id)kSecAttrAccount];
    NSString *password = [MyKeychainWrapper myObjectForKey:(__bridge id)kSecValueData];
    
    return @{@"username":username, @"password":password};
}


#pragma mark - GETTERS

+(User *)user
{
    return [DataManager sharedInstance].user;
}


@end
