//
// Created by Kritanta on 1/12/21.
//

#import "AVCWidget.h"


@implementation AVCWidget
{

}

+ (void)registerClassForIdentifier:(NSString *)identifier
{
    [[[NSUserDefaults alloc] initWithSuiteName:@"me.kritanta.avocado"] setObject:NSStringFromClass([self class]) forKey:identifier];
}

+ (instancetype)build
{
    return [(AVCWidget *)[[self class] alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.view = [[UIView alloc] initWithFrame:self.sbWidgetView.frame];
    }
    return self;
}

- (void)constructView
{
    [[self.view subviews]
            makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)update
{

}

- (void)fadeOldWidgetIn
{
    self.sbWidgetView.alpha = 0;
    [self.view.superview addSubview:self.sbWidgetView];
    [UIView animateWithDuration:0.5
                     animations:
                             ^
                             {
                                self.sbWidgetView.alpha = 1;
                                self.view.alpha = 0;
                             }
                     completion:^(BOOL finished)
                     {
                        self.view.userInteractionEnabled = NO;
                     }];
}

- (void)fadeAVCWidgetIn
{
    [UIView animateWithDuration:0.5
                     animations:
                             ^
                             {
                                 self.sbWidgetView.alpha = 0;
                                 self.view.alpha = 1;
                             }
                     completion:^(BOOL finished)
                     {
                         [self.sbWidgetView removeFromSuperview];
                     }];
}


@end
