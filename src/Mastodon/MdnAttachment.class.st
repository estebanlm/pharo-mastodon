"
I represent an attachment added to a mastodon status.

https://github.com/tootsuite/documentation/blob/master/Using-the-API/API.md#attachment
"
Class {
	#name : #MdnAttachment,
	#superclass : #MdnEntity,
	#category : #'Mastodon-Core'
}

{ #category : #'as yet unclassified' }
MdnAttachment >> id [
	^ self jsonAt: 'id'
]
