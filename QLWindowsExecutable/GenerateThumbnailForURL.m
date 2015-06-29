#import "QLWindowsExecutable-Swift.h"

/* -----------------------------------------------------------------------------
Generate a thumbnail for file

This function's job is to create thumbnail for designated file as fast as possible
----------------------------------------------------------------------------- */

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize)
{
    // To complete your generator please implement the function GenerateThumbnailForURL in GenerateThumbnailForURL.c

    return [ThumbnailGenerator generateThumbnailForURL:thisInterface thumbnail:thumbnail url:(__bridge NSURL * __nonnull)(url) contentTypeUTI:(__bridge NSString * __nonnull)(contentTypeUTI) options:(__bridge NSDictionary * __nonnull)(options) maxSize:maxSize];
}

void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail)
{
    // Not supported
}
