//
//  FlickrConnections.m
//  IHeartPhotos
//
//  Created by Wayne Pan on 6/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlickrConnections.h"
#import "SBJson.h"

@implementation FlickrConnections
NSString *const FlickrAPIKey = @"de680a4e3291151988a1767c24986f70";
@synthesize photoTitles;
@synthesize photoSmallImageData;
@synthesize photoURLsLargeImage;


- (id) init
{
  photoTitles = [[NSMutableArray alloc] init];
  photoSmallImageData = [[NSMutableArray alloc] init];
  photoURLsLargeImage = [[NSMutableArray alloc] init];
  
  return self;
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
  // Store incoming data into a string
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  
  // Create a dictionary from the JSON string
	NSDictionary *results = [jsonString JSONValue];
	
  // Build an array from the dictionary for easy access to each entry
	NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
  
  // Loop through each entry in the dictionary...
	for (NSDictionary *photo in photos)
  {
    // Get title of the image
		NSString *title = [photo objectForKey:@"title"];
    
    // Save the title to the photo titles array
		[photoTitles addObject:(title.length > 0 ? title : @"Untitled")];
		
    // Build the URL to where the image is stored (see the Flickr API)
    // In the format http://farmX.static.flickr.com/server/id/secret
    // Notice the "_s" which requests a "small" image 75 x 75 pixels
		NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];

    
    // The performance (scrolling) of the table will be much better if we
    // build an array of the image data here, and then add this data as
    // the cell.image value (see cellForRowAtIndexPath:)
		[photoSmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
    
    // Build and save the URL to the large image so we can zoom
    // in on the image if requested
		photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
		[photoURLsLargeImage addObject:[NSURL URLWithString:photoURLString]];        
  }

  [callbackObject performSelector:callbackSelector withObject:self];
}

- (void) getFlickrData:(id)object withSelector:(SEL)selector
{
  callbackObject = object;
  callbackSelector = selector;

	NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=%@&per_page=15&format=json&nojsoncallback=1", FlickrAPIKey];
  NSLog(urlString);
  NSURL *url = [NSURL URLWithString:urlString];
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
  
  NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

  [request release];
  [connection release];
}

- (void)dealloc 
{
	[photoTitles release];
	[photoSmallImageData release];
  [photoURLsLargeImage release];
  
	[super dealloc];
}

@end
