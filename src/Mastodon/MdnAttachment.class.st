"
I represent an attachment added to a mastodon status.

https://github.com/tootsuite/documentation/blob/master/Using-the-API/API.md#attachment
"
Class {
	#name : #MdnAttachment,
	#superclass : #MdnEntity,
	#category : #'Mastodon-Core'
}

{ #category : #'accessing api' }
MdnAttachment >> id [
	"ID of the attachment"
	^ self jsonAt: 'id'
]

{ #category : #'accessing api' }
MdnAttachment >> meta [
	"'small' and 'original' containing: width, height, size, aspect"
	^ self jsonAt: 'meta'.
]

{ #category : #'accessing api' }
MdnAttachment >> previewUrl [
	"URL of the preview image"
	^ self jsonAt: 'preview_url'.
]

{ #category : #'accessing api' }
MdnAttachment >> remoteUrl [
	"For remote images, the remote URL of the original image"
	^ self jsonAt: 'remote_url'.
]

{ #category : #'accessing api' }
MdnAttachment >> textUrl [
	"Shorter URL for the image, for insertion into text (only present on local images)"
	^ self jsonAt: 'text_url'.
]

{ #category : #'accessing api' }
MdnAttachment >> type [
	"One of: 'image', 'video', 'gifv', 'unknown'"
	^ self jsonAt: 'type'.
]

{ #category : #'accessing api' }
MdnAttachment >> url [
	"URL of the locally hosted version of the image"
	^ self jsonAt: 'url'.
]
