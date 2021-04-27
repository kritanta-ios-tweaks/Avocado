//
// Created by Kritanta on 1/12/21.
//

@import Foundation;
#include "AVCWidget.h"

@class SBHWidget;

#ifndef AVOCADO_AVCWIDGETSERVER_H
#define AVOCADO_AVCWIDGETSERVER_H

@interface AVCWidgetServer : NSObject

+ (instancetype)sharedInstance;
- (instancetype)initWithDomain:(NSString *)domain;

- (AVCWidget *)widgetForSpringboardWidget:(SBHWidget *)widget;
- (void)registerWidget:(AVCWidget *)widget forUpdatesEvery:(float)seconds;
- (AVCWidget *)buildWidgetForIdentifier:(NSString *)identifier;

@property (nonatomic, strong, readonly) NSUserDefaults *store;
@property (nonatomic, strong, readwrite) NSMutableDictionary *activeWidgets;
@property (nonatomic, strong, readwrite) NSMutableArray *updateQueue;

@end

#endif // AVOCADO_AVCWIDGETSERVER_H
