/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "ABI34_0_0RCTModalHostViewController.h"

#import "ABI34_0_0RCTLog.h"
#import "ABI34_0_0RCTModalHostView.h"

@implementation ABI34_0_0RCTModalHostViewController
{
  CGRect _lastViewFrame;
#if !TARGET_OS_TV
  UIStatusBarStyle _preferredStatusBarStyle;
  BOOL _preferredStatusBarHidden;
#endif
}

- (instancetype)init
{
  if (!(self = [super init])) {
    return nil;
  }

#if !TARGET_OS_TV
  _preferredStatusBarStyle = [ABI34_0_0RCTSharedApplication() statusBarStyle];
  _preferredStatusBarHidden = [ABI34_0_0RCTSharedApplication() isStatusBarHidden];
#endif

  return self;
}

- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];

  if (self.boundsDidChangeBlock && !CGRectEqualToRect(_lastViewFrame, self.view.frame)) {
    self.boundsDidChangeBlock(self.view.bounds);
    _lastViewFrame = self.view.frame;
  }
}

#if !TARGET_OS_TV
- (UIStatusBarStyle)preferredStatusBarStyle
{
  return _preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden
{
  return _preferredStatusBarHidden;
}

#if ABI34_0_0RCT_DEV
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  UIInterfaceOrientationMask appSupportedOrientationsMask = [ABI34_0_0RCTSharedApplication() supportedInterfaceOrientationsForWindow:[ABI34_0_0RCTSharedApplication() keyWindow]];
  if (!(_supportedInterfaceOrientations & appSupportedOrientationsMask)) {
    ABI34_0_0RCTLogError(@"Modal was presented with 0x%x orientations mask but the application only supports 0x%x."
                @"Add more interface orientations to your app's Info.plist to fix this."
                @"NOTE: This will crash in non-dev mode.",
                (unsigned)_supportedInterfaceOrientations,
                (unsigned)appSupportedOrientationsMask);
    return UIInterfaceOrientationMaskAll;
  }

  return _supportedInterfaceOrientations;
}
#endif // ABI34_0_0RCT_DEV
#endif // !TARGET_OS_TV


@end
