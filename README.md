# pharo-mastondon

a [Pharo](http://pharo.org) API for [mastodon](http://joinmastodon.org)

## Installation 
- You need Pharo 7.0

```Smalltalk
Metacello new 
  repository: 'github://estebanlm/pharo-mastodon/src';
  baseline: 'Mastodon';
  load.
```

## Examples

### Reading your timeline.

```Smalltalk
"Create a server"
server := MdnServer url: 'https://mastodon.social'.
"Login"
login := server loginUsername: 'username@mastodon.social' password: 'shhh'.
"ensure you have privileges enough, this will open a browser so you 
 can give 'pharo-mastodon-v1' app rights."
server application openAuthorizeFor: login.
"Read timeline 'home'"
login timelineHome next.
```

### Posting a status

```Smalltalk
"Create a server"
server := MdnServer url: 'https://mastodon.social'.
"Login"
login := server loginUsername: 'username@mastodon.social' password: 'shhh'.
"ensure you have privileges enough, this will open a browser so you 
 can give 'pharo-mastodon-v1' app rights."
server application openAuthorizeFor: login.
"Read timeline 'home'"
login postStatus: 'This is a test'.
```
