Extension { #name : #String }

{ #category : #'*Mastodon' }
String >> mastodonPostStatus [
	^ MdnPostStatus new 
		status: self;
		yourself
]
