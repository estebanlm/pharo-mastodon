Class {
	#name : #MdnPostMedia,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'reference'
	],
	#category : #'Mastodon-Core'
}

{ #category : #accessing }
MdnPostMedia >> fileName [
	^ fileName
]

{ #category : #accessing }
MdnPostMedia >> fileName: anObject [
	fileName := anObject
]

{ #category : #accessing }
MdnPostMedia >> reference [
	^ reference
]

{ #category : #accessing }
MdnPostMedia >> reference: anObject [
	reference := anObject
]

{ #category : #'as yet unclassified' }
MdnPostMedia >> upload [
	
]
