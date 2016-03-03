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

-(void)getDragonFlightsWithPredicate:(NSPredicate *)predicate completion:(FlightsServiceCompletion)completion;
-(void)getExchangeRateFromCurrency:(NSString*)fromCurrency toCurrency:(NSString*)toCurrency completion:(CurrencyServiceCompletion)completion;
- (void)downloadImageFromUrl:(NSString*)url completion:(void(^)(UIImage *image))completion;

@end
