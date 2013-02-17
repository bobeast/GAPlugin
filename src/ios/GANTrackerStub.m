#import "GANTracker.h"

#if TARGET_IPHONE_SIMULATOR

@implementation GANTracker

+ (GANTracker *)sharedTracker
{
    return [[[GANTracker alloc] init] autorelease];
}

- (void)startTrackerWithAccountID:(NSString *)accountID
                   dispatchPeriod:(NSInteger)dispatchPeriod
                         delegate:(id<GANTrackerDelegate>)delegate
{
}

- (BOOL)setCustomVariableAtIndex:(NSUInteger)index
                            name:(NSString *)name
                           value:(NSString *)value
                           scope:(GANCVScope)scope
                       withError:(NSError **)error
{
    return YES;
}

- (BOOL)setCustomVariableAtIndex:(NSUInteger)index
                            name:(NSString *)name
                           value:(NSString *)value
                       withError:(NSError **)error
{
    return YES;
}

- (NSString *)getVisitorCustomVarAtIndex:(NSUInteger)index
{
    return nil;
}

- (BOOL)addTransaction:(NSString *)orderID
            totalPrice:(double)totalPrice
             storeName:(NSString *)storeName
              totalTax:(double)totalTax
          shippingCost:(double)shippingCost
             withError:(NSError **)error
{
    return YES;
}

- (BOOL)addItem:(NSString *)orderID
        itemSKU:(NSString *)itemSKU
      itemPrice:(double)itemPrice
      itemCount:(double)itemCount
       itemName:(NSString *)itemName
   itemCategory:(NSString *)itemCategory
      withError:(NSError **)error
{
    return YES;
}

- (BOOL)trackTransactions:(NSError **)error
{
    return YES;
}

- (BOOL)setReferrer:(NSString *)referrer
          withError:(NSError **)error
{
    return YES;
}

- (BOOL)clearTransactions:(NSError **)error
{
    return YES;
}

- (BOOL)dispatchSynchronous:(NSTimeInterval)timeout
{
    return YES;
}

- (void)stopTracker
{
}

- (BOOL)trackPageview:(NSString *)pageURL
            withError:(NSError **)error
{
    return YES;
}

- (BOOL)trackEvent:(NSString *)category
            action:(NSString *)action
             label:(NSString *)label
             value:(NSInteger)value
         withError:(NSError **)error
{
    return YES;
}

- (BOOL)dispatch
{
    return YES;
}

@end

#endif