//
//  BaseService.m
//  DragonRides
//
//  Created by Boris Chirino on 01/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "BaseService.h"

@interface BaseService ()

@end

@implementation BaseService

+(NSString *)flightStringUrl{
    return @"http://odigeo-testios.herokuapp.com";
}

+(NSString *)xchangeStringUrl{
    return @"http://jarvisstark.herokuapp.com/currency";
}

@end
