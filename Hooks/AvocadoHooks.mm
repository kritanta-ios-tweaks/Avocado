#include "SBHWidgetStackViewController.mm"

#include "substrate.h"

static __attribute__((constructor)) void AvocadoHookContstructor (int __unused argc, char __unused **argv, char __unused **envp)
{
    MSHookMessageEx(objc_getClass("SBHWidgetStackViewController"),
            @selector(viewWillLayoutSubviews),
            (IMP) &hooked_viewWillLayoutSubviews,
            (IMP *) &orig_viewWillLayoutSubviews);
    
    kWidgetServerDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"me.kritanta.avocado"];
}