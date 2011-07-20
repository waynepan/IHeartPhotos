//
//  FlickrConnections.h
//  IHeartPhotos
//
//  Created by Wayne Pan on 6/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FlickrConnections : NSObject {
  id callbackObject;
  SEL callbackSelector;

  NSMutableArray  *photoTitles;         // Titles of images
  NSMutableArray  *photoSmallImageData; // Image data (thumbnail)
  NSMutableArray  *photoURLsLargeImage; // URL to larger image 
}

- (void)getFlickrData:(id)object withSelector:(SEL)selector;

@property (retain) NSMutableArray *photoTitles;
@property (retain) NSMutableArray *photoSmallImageData;
@property (retain) NSMutableArray *photoURLsLargeImage;

@end
