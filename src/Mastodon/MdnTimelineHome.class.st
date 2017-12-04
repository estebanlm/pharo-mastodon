"
I fill user's 'home' timeline.
"
Class {
	#name : #MdnTimelineHome,
	#superclass : #MdnTimeline,
	#category : #'Mastodon-Core'
}

{ #category : #private }
MdnTimelineHome >> url [
	^ self server urlApiTimelines / 'home'
]
