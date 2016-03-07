//
//  WebService.h
//  DragonRides
//
//  Created by Boris Chirino on 01/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "BaseService.h"
@class UIImage;
@interface WebService : BaseService

+(id)shared;


/**
 *  Get all flights that meet predicate parameter condition, predicate may be nil
 *
 *  @param predicate  predicate to use against the http call
 *  @param completion completion block used to parse response
 */
-(void)getDragonFlightsWithPredicate:(NSPredicate *)predicate completion:(FlightsServiceCompletion)completion;




/**
 *  Retrieve currency exchange rate
 *
 *  @param fromCurrency origin currency
 *  @param toCurrency   destiny currency
 *  @param completion   this block contain the exchange rate as NSNumber instance.
 */
-(void)getExchangeRateFromCurrency:(NSString*)fromCurrency toCurrency:(NSString*)toCurrency completion:(CurrencyServiceCompletion)completion;




/**
 *  Async download of image
 *
 *  @param url        the url of the image
 *  @param completion in this completion block the image is returned
 */
- (void)downloadImageFromUrl:(NSString*)url completion:(void(^)(UIImage *image))completion;

@end
