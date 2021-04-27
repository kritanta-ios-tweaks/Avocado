//
// Created by Kritanta on 1/12/21.
//

@import UIKit;

#ifndef AVOCADO_SBHWIDGETSTACKVIEWCONTROLLER_H
#define AVOCADO_SBHWIDGETSTACKVIEWCONTROLLER_H

@interface SBHWidget : NSObject
@property (nonatomic, readwrite, strong) NSString *uniqueIdentifier;
@property (nonatomic, readwrite, strong) NSString *extensionBundleIdentifier;
@end

@interface SBHWidgetStackViewController : UIViewController

@property (nonatomic, readwrite, strong) SBHWidget *activeWidget;

@property (nonatomic, readwrite, strong) UIView *containerView;

@end


#endif // AVOCADO_SBHWIDGETSTACKVIEWCONTROLLER_H