//
//  Photo.h
//  IHeartPhotos
//
//  Created by Wayne Pan on 6/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSManagedObject.h"


@interface Photo : NSManagedObject {
@private
}
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * thumbnailUrl;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * fullSizeUrl;
@property (nonatomic, retain) NSManagedObject * source;

@end
