//
// Created by Kritanta on 1/12/21.
//

#import <objc/runtime.h>
#import "AVCWidgetServer.h"
#import "Hooks/SBHWidgetStackViewController.h"

@implementation AVCWidgetServer
{

@private
    NSUserDefaults *_store;
    NSMutableDictionary *_activeWidgets;
    NSMutableArray *_updateQueue;
}

static NSString *desc;

@synthesize store = _store;
@synthesize activeWidgets = _activeWidgets;
@synthesize updateQueue = _updateQueue;

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        _sharedInstance = [[self alloc] initWithDomain:@"me.kritanta.avacado"];
    });

    return _sharedInstance;
}

- (instancetype)initWithDomain:(NSString *)domain
{
    self = [super init];

    if (self)
    {
        desc = @"";
        _activeWidgets = [NSMutableDictionary new];
        _updateQueue = [NSMutableArray new];
        _store = [[NSUserDefaults alloc] initWithSuiteName:domain];
    }

    return self;
}

- (AVCWidget *)widgetForSpringboardWidget:(SBHWidget *)widget
{
    // Springboard generates a unique ID for each widget instance
    // We use this to keep duplicate widgets seperated.
    // it works well.
    NSString *uid = widget.uniqueIdentifier;

    if (!_activeWidgets[uid])
        _activeWidgets[uid] = [self buildWidgetForIdentifier:widget.extensionBundleIdentifier];

    return _activeWidgets[uid];
}

- (AVCWidget *)buildWidgetForIdentifier:(NSString *)identifier
{
    NSString *className = [_store stringForKey:identifier];
    if (className)
    {
        return [NSClassFromString(className) build];
    }
    return nil;
}

- (void)registerWidget:(AVCWidget *)widget forUpdatesEvery:(float)seconds
{
    // I am going to eventually add a much smarter update timer here
    // for now, this method will use some less efficient code.

    [NSTimer scheduledTimerWithTimeInterval:seconds target:widget selector:@selector(update) userInfo:nil repeats:YES];
}

@end


/*
 * Now, we set up our own widgets
 * external tweaks adding their own do this exact same thing.
 * */
static __attribute__((constructor)) void AvocadoWidgetServerContsructor (int __unused argc, char __unused **argv, char __unused **envp)
{
    [AVCWidgetServer sharedInstance];
}
