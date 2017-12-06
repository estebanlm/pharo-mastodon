"
I represent a mastodon instance.

https://github.com/tootsuite/documentation/blob/master/Using-the-API/API.md#instance
"
Class {
	#name : #MdnInstance,
	#superclass : #MdnEntity,
	#category : #'Mastodon-Core'
}

{ #category : #'accessing api' }
MdnInstance >> description [
	"A description for the instance"
	^ self jsonAt: 'description'
]

{ #category : #'accessing api' }
MdnInstance >> email [
	"An email address which can be used to contact the instance administrator"
	^ self jsonAt: 'email'
]

{ #category : #'accessing api' }
MdnInstance >> title [
	"The instance's title"
	^ self jsonAt: 'title'

]

{ #category : #'accessing api' }
MdnInstance >> uri [
	"URI of the current instance"
	^ self jsonAt: 'uri'
]

{ #category : #'accessing api' }
MdnInstance >> urls [
	"streaming_api"
	^ self jsonAt: 'urls'
]

{ #category : #'accessing api' }
MdnInstance >> version [
	"The Mastodon version used by instance."
	^ self jsonAt: 'version'
]
