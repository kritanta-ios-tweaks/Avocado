//
// Created by Kritanta on 1/12/21.
//
#import "Hooks.h"
#import "SBHWidgetStackViewController.h"
#import "AVCWidgetServer.h"

static void (*orig_viewWillLayoutSubviews) (SBHWidgetStackViewController *, SEL);
static void hooked_viewWillLayoutSubviews (SBHWidgetStackViewController *, SEL);

static void hooked_viewWillLayoutSubviews (SBHWidgetStackViewController *self, SEL _cmd)
{
    orig_viewWillLayoutSubviews(self, _cmd);
    // Some extensions dont have this. battery one is an example.
    if (![self.activeWidget respondsToSelector:@selector(extensionBundleIdentifier)])
        return;

    [kWidgetServerDefaults setInteger:(NSInteger)self.containerView.layer.cornerRadius forKey:@"AVCWRadius"];

    // Ask the widget server if we have a widget to place here
    // It'll return 'nil' if not.
    AVCWidget *avcWidget = [[AVCWidgetServer sharedInstance] widgetForSpringboardWidget:self.activeWidget];

    if (avcWidget)
    {
        // Store a copy of apple's widget so we can do stuff with it later.
        avcWidget.sbWidgetView = self.containerView;

        // Steal the frame from the widget guts we're about to hide
        avcWidget.view.frame = self.containerView.frame;
        // Tell our widget to rebuild itself using the new frame
        [avcWidget constructView];

        // Add our view to the apple widget's container
        [self.view addSubview:avcWidget.view];

        self.containerView.alpha = 0;
    }

}