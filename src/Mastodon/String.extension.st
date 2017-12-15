Extension { #name : #String }

{ #category : #'*Mastodon' }
String >> asMastodonPostStatus [
	^ MdnPostStatus content: self
]
