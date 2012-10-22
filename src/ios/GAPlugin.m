//
//  GAPlugin.m
//  GA
//
//  Created by Bob Easterday on 10/9/12.
//  Copyright (c) 2012 Adobe Systems, Inc. All rights reserved.
//

#import "GAPlugin.h"
#import "AppDelegate.h"

@implementation GAPlugin
- (void) initGA:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    NSString    *callbackId = [arguments pop];
    NSString    *accountID = [arguments objectAtIndex:0];
    NSInteger   dispatchPeriod = [[arguments objectAtIndex:1] intValue];

    [[GANTracker sharedTracker] startTrackerWithAccountID:accountID dispatchPeriod:dispatchPeriod delegate:self];
    inited = YES;
    
    [self successWithMessage:[NSString stringWithFormat:@"initGA: accountID = %@; Interval = %d seconds",accountID, dispatchPeriod] toID:callbackId];
}

-(void) exitGA: (NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    NSString    *callbackId = [arguments pop];

    if (inited)
		[[GANTracker sharedTracker] stopTracker];
	
    [self successWithMessage:@"exitGA" toID:callbackId];
}

- (void) trackEvent:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    NSString        *callbackId = [arguments pop];
    NSString        *category = [arguments objectAtIndex:0];
    NSString        *eventAction = [arguments objectAtIndex:1];
    NSString        *eventLabel = [arguments objectAtIndex:2];
    NSInteger       eventValue = [[arguments objectAtIndex:3] intValue];
    NSError         *error = nil;
   
    if (inited)
    {
        BOOL result = [[GANTracker sharedTracker] trackEvent:category action:eventAction label:eventLabel value:eventValue withError:&error];
        if (result)
            [self successWithMessage:[NSString stringWithFormat:@"trackEvent: category = %@; action = %@; label = %@; value = %d", category, eventAction, eventLabel, eventValue] toID:callbackId];
        else
            [self failWithMessage:@"trackEvent failed" toID:callbackId withError:error];
    }
    else
        [self failWithMessage:@"trackEvent failed - not initialized" toID:callbackId withError:nil];
}

- (void) trackPage:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    NSString            *callbackId = [arguments pop];
    NSString            *pageURL = [arguments objectAtIndex:0];

    if (inited)
    {
        NSError *error = nil;
        BOOL    result = [[GANTracker sharedTracker] trackPageview:pageURL withError:&error];
        
        if (result)
    		[self successWithMessage:[NSString stringWithFormat:@"trackPage: url = %@", pageURL] toID:callbackId];
        else
            [self failWithMessage:@"trackPage failed" toID:callbackId withError:error];
    }
    else
        [self failWithMessage:@"trackPage failed - not initialized" toID:callbackId withError:nil];
}

- (void) setVariable:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    NSString            *callbackId = [arguments pop];
    NSString            *key = [arguments objectAtIndex:0];
    NSString            *value = [arguments objectAtIndex:1];
    NSInteger           index = [[arguments objectAtIndex:2] intValue];
    
    if (inited)
    {
        NSError *error = nil;
        BOOL    result = [[GANTracker sharedTracker] setCustomVariableAtIndex:index name:key value:value withError:&error];
        
        if (result)
    		[self successWithMessage:[NSString stringWithFormat:@"setVariable: key = %@; value = %@; index = %d", key, value, index] toID:callbackId];
        else
            [self failWithMessage:@"setVariable failed" toID:callbackId withError:error];
    }
    else
        [self failWithMessage:@"setVariable failed - not initialized" toID:callbackId withError:nil];
}

-(void)successWithMessage:(NSString *)message toID:(NSString *)callbackID
{
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    
    [self writeJavascript:[commandResult toSuccessCallbackString:callbackID]];
}

-(void)failWithMessage:(NSString *)message toID:(NSString *)callbackID withError:(NSError *)error
{
    NSString        *errorMessage = (error) ? [NSString stringWithFormat:@"%@ - %@", message, [error localizedDescription]] : message;
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:errorMessage];
    
    [self writeJavascript:[commandResult toErrorCallbackString:callbackID]];
}

-(void)dealloc
{
    [[GANTracker sharedTracker] stopTracker];
    [super dealloc];
}

- (void)hitDispatched:(NSString *)hitString
{
    NSLog(@"hitDispatched: %@", hitString);
}

- (void)trackerDispatchDidComplete:(GANTracker *)tracker eventsDispatched:(NSUInteger)hitsDispatched eventsFailedDispatch:(NSUInteger)hitsFailedDispatch
{
    NSLog(@"trackerDispatchDidComplete: hitsDispatched = %u;  hitsFailedDispatch = %u", hitsDispatched, hitsFailedDispatch);
}

@end
