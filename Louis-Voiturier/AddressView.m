//
//  AddressView.m
//  Louis-Voiturier
//
//  Created by François Juteau on 09/11/2015.
//  Copyright © 2015 Louis. All rights reserved.
//

#import "AddressView.h"
#import "Common.h"

@implementation AddressView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        /***************************/
        /***** ADRESS LABEL *****/
        /**************************/
        _adressLabel = [[UILabel alloc] init];
        _adressLabel.font = [UIFont louisHeaderFont];
        _adressLabel.textColor = [UIColor louisTitleAndTextColor];
        _adressLabel.text = @"_adressLabel";
        
        [_adressLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_adressLabel];
        
        
        /***************************/
        /***** ZIP CODE LABEL *****/
        /**************************/
        _zipCodeLabel = [[UILabel alloc] init];
        _zipCodeLabel.font = [UIFont louisLabelFont];
        _zipCodeLabel.textColor = [UIColor louisSubtitleColor];
        _zipCodeLabel.text = @"_zipCodeLabel";
        
        [_zipCodeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_zipCodeLabel];
        
        
        /***************************/
        /***** PLACE TITLE LABEL *****/
        /**************************/
        _placeTitleLabel = [[UILabel alloc] init];
        _placeTitleLabel.font = [UIFont louisMediumLabel];
        _placeTitleLabel.textColor = [UIColor louisSubtitleColor];
        _placeTitleLabel.text = NSLocalizedString(@"Place-Title-Label", nil);
        
        [_placeTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_placeTitleLabel];
        
        
        /***************************/
        /***** PLACE DESCRIPTION LABEL *****/
        /**************************/
        _placeDescriptionLabel = [[UILabel alloc] init];
        _placeDescriptionLabel.font = [UIFont louisHeaderFont];
        _placeDescriptionLabel.textColor = [UIColor louisTitleAndTextColor];
        _placeDescriptionLabel.text = @"_placeDescriptionLabel";
        
        [_placeDescriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_placeDescriptionLabel];
        
        
        /***************************/
        /***** INITERATY TITLE LABEL *****/
        /**************************/
//        _itineraryTitleLabel = [[UILabel alloc] init];
//        _itineraryTitleLabel.font = [UIFont louisMediumLabel];
//        _itineraryTitleLabel.textColor = [UIColor louisSubtitleColor];
//        _itineraryTitleLabel.text = NSLocalizedString(@"Itinerary-Title-Label", nil);
//
//        [_itineraryTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [self addSubview:_itineraryTitleLabel];
        
        _itineraryButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_itineraryButton setTitle:NSLocalizedString(@"Itinerary-Title-Label", nil) forState:UIControlStateNormal];
        [_itineraryButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_itineraryButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_itineraryButton];
        
        /***************************/
        /***** ITINERARY IMAGE VIEW *****/
        /**************************/
        _itineraryImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Itinerary"]];
        
        [_itineraryImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:_itineraryImageView];
        
        
    }
    return self;
}


-(void)addInitialConstraints
{
    NSNumber *viewWidth = [NSNumber numberWithFloat:self.frame.size.width];
    NSNumber *viewHeight = [NSNumber numberWithFloat:self.frame.size.height];
    
    NSNumber *spacing = @10;
    
    NSNumber *itineraryImageHeight = @18;
    NSNumber *itineraryImageWidth = @13;
    
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_adressLabel, _zipCodeLabel, _placeDescriptionLabel, _placeTitleLabel, _itineraryButton, _itineraryImageView);
    
    NSDictionary *metrics = NSDictionaryOfVariableBindings(viewWidth, viewHeight, spacing, itineraryImageWidth, itineraryImageHeight);
    
    // Horizontale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-spacing-[_adressLabel]-spacing-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    // Horizontale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-spacing-[_zipCodeLabel]-spacing-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    // Horizontale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-spacing-[_placeTitleLabel]"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    // Horizontale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-spacing-[_placeDescriptionLabel]"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    // Horizontale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_itineraryButton]-spacing-[_itineraryImageView(itineraryImageWidth)]-spacing-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    
    // Verticale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-spacing-[_adressLabel]-[_zipCodeLabel]"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    // Verticale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_placeTitleLabel]-[_placeDescriptionLabel]-spacing-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    // Verticale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_itineraryButton(itineraryImageHeight)]-spacing-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    // Verticale
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_itineraryImageView(itineraryImageHeight)]-spacing-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    
}


@end
