//
//  IHeartPhotosAppDelegate.h
//  IHeartPhotos
//
//  Created by Wayne Pan on 6/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IHeartPhotosViewController;

@interface IHeartPhotosAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet IHeartPhotosViewController *viewController;

@end
