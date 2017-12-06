"
I represent a mastodon tag.

https://github.com/tootsuite/documentation/blob/master/Using-the-API/API.md#tag
"
Class {
	#name : #MdnTag,
	#superclass : #MdnEntity,
	#category : #'Mastodon-Core'
}

{ #category : #'accessing api' }
MdnTag >> name [
	"The hashtag, not including the preceding #"
	^ self jsonAt: 'name'
]

{ #category : #'accessing api' }
MdnTag >> url [
	"The URL of the hashtag"
	^ self jsonAt: 'url'
]
