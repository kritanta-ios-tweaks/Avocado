//
// Created by Kritanta on 1/12/21.
//

@import UIKit;

#ifndef AVOCADO_AVCWIDGET_H
#define AVOCADO_AVCWIDGET_H

#define kTintedImageNamed(name) [[[UIImage systemImageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] imageWithTintColor:[UIColor whiteColor]]

@interface AVCWidget : NSObject
@property (nonatomic, strong, readwrite) UIView *view;
@property (nonatomic, strong, readwrite) UIView *sbWidgetView;
+ (void)registerClassForIdentifier:(NSString *)identifier;
+ (instancetype)build;
- (instancetype)init;
- (void)constructView;
- (void)update;
- (void)fadeOldWidgetIn;
- (void)fadeAVCWidgetIn;
@end

#endif // AVOCADO_AVCWIDGET_H
