//
//  ImageManager.m
//  Louis
//
//  Created by François Juteau on 19/10/2015.
//  Copyright © 2015 Louis. All rights reserved.
//

#import "ImageManager.h"
#import "NetworkManager.h"

@implementation ImageManager

+(void)getImageFromUrlPath:(NSString *)urlPath withCompletion:(cacheImageCompletion)compblock
{
    [[NetworkManager sharedInstance] httpDownloadMethod:@"GET"
                                            withPicture:urlPath
                                                 forKey:@""
                                            forUsername:@""
                                            andPassword:@""
                                    withCompletionBlock:^(NSData *data, NSHTTPURLResponse *httpResponse, NSError *error)
    {
        if (data)
        {
            UIImage *image = [UIImage imageWithData:data];
            
            compblock(image);
        }
        else
        {
            NSLog(@"IMAGE MANAGER : NO DATA : error : %@", error.debugDescription);
            
        }
    }];
}



@end
