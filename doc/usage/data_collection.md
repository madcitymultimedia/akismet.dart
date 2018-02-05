# Data collection
Akismet is very heavily dependent on the quality of the data included in API calls.

## The comment's content
The `Comment` class provides information about the content of a comment.

```
new Comment(Author author, {
  String content = '',
  DateTime date,
  Uri permalink,
  DateTime postModified,
  Uri referrer,
  String type = ''
})
```

!!! tip
    The more data you send Akismet about each comment, the greater the accuracy.
    You should provide as much information as you can about the comment and its author.

## The comment's author
The `Author` class provides information about the author of a comment.

```
new Author(String ipAddress, String userAgent, {
  String email = '',
  String name = '',
  String role = '',
  Uri url
})
```

## The comment's type
Akismet works with almost any kind of user-submitted web content: blog comments, forum posts, blog posts, contact forms and so on. The characteristics of spam tend to vary across those type – comment spam is quite different from forum spam. So it's important to give some context by telling Akismet what type of messages you're asking to check. That's what the `Comment#type` value is for.

The API will accept an arbitrary string. It's best if you use a meaningful symbolic name. The `CommentType` class provides values for common types of web-based content:

- `CommentType.blogPost` : blog posts.
- `CommentType.comment` : for blog comment forms and replies to forum posts.
- `CommentType.contactForm` : contact forms, inquiry forms and the like.
- `CommentType.forumPost` : new top-level forum posts.
- `CommentType.pingback` / `CommentType.trackback` : pingbacks and trackbacks respectively.
- `CommentType.tweet` : Twitter messages.

!!! tip "That's not an exhaustive list"
    If you need to check messages that don't fit one of those categories, it's best to use a different `Comment#type` value. It's especially important not to default to `CommentType.comment` for messages that are fundamentally different from blog comments – if you do that, you can expect to see mixed results. It's better to be too specific than too ambiguous.
