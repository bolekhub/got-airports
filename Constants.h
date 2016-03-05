//
//  Constants.h
//  DragonRides
//
//  Created by Boris Chirino on 04/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

extern  NSString *kPickerChangeNotification;
extern  NSString *kExchangeRateValue;


typedef NS_ENUM(NSUInteger, TAGIDENTIFIER) {
    TAGIDENTIFIER_NAMETXTFIELD,
    TAGIDENTIFIER_SURNAMETXTFIELD,
    TAGIDENTIFIER_CURRENCYTXTFIELD,
    TAGIDENTIFIER_DOBTXTFIELD
};

#endif /* Constants_h */
