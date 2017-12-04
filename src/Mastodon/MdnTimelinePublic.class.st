"
I fill user's 'public' timeline.
"
Class {
	#name : #MdnTimelinePublic,
	#superclass : #MdnTimeline,
	#category : #'Mastodon-Core'
}

{ #category : #private }
MdnTimelinePublic >> url [
	^ self server urlApiTimelines / 'public'
]
