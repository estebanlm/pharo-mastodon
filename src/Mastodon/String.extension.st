Extension { #name : #String }

{ #category : #'*Mastodon' }
String >> asMastodonPostStatus [
	^ MdnPostStatus new 
		status: self;
		yourself
]
