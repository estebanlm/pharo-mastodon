"
I answer a timeline for a hashtag.

"
Class {
	#name : #MdnTimelineHashtag,
	#superclass : #MdnTimeline,
	#instVars : [
		'hashtag'
	],
	#category : #'Mastodon-Core'
}

{ #category : #'instance creation' }
MdnTimelineHashtag class >> login: aLogin hashtag: aString [
	^ self new 
		login: aLogin;
		hashtag: aString;
		yourself
]

{ #category : #accessing }
MdnTimelineHashtag >> hashtag [
	^ hashtag
]

{ #category : #accessing }
MdnTimelineHashtag >> hashtag: anObject [
	hashtag := anObject
]

{ #category : #private }
MdnTimelineHashtag >> url [
	^ self server urlApiTimelines / 'tag' / self hashtag
]
