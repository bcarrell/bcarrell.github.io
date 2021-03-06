---
Title: "A Brief Primer on Functional Thinking"
Date: "2014-01-12"
Description: "Functional Thinking for Beginners"
Tags: ["functional programming", "beginners"]
---

Learning functional programming can be a daunting task.  On your quest for
enlightenment, you're likely to be bombarded with a slew of new, unfamiliar
terms like *currying* and *higher-order functions* and *partial application*
and *referential transparency*.  The first thing you should know about
functional programming is that it has a very simple, intuitive definition,
and that most of these new, scary words can be regarded as techniques to
achieve the goal of functional programming, but they do not define what
functional programming is.  The primary characteristic
of functional code is simply this:

> Functional code is code which does not modify or rely upon the surrounding
> environment.  That is, **purely functional code is code without side-effects**.
> Functional thinking requires the programmer to regard side-effects as poison and take as
> many steps as possible to minimize it.

In practice, most codebases that regard themselves as functional contain
side-effecting functions.  Side effects are everywhere: database connections
or file reading and writing.  But functional code seeks to minimize that and
employs a lot of techniques you may have read about to achieve that: maps,
reductions, composability, referential transparency, and many more.

Functional thinking prefers you to consider your data in an *elemental* way.

Instead of...

<figure>
<figcaption>... mutating an Array</figcaption>
{{% highlight javascript %}}
var myArray = ['learning', 'functional', 'code'];

for (var i = 0; i < myArray.length; i++) {
  myArray[i] = myArray[i].toUpperCase();
}
{{% /highlight %}}
</figure>

Prefer this...

<figure>
<figcaption>... mapping over an Array</figcaption>
{{% highlight javascript %}}
var upcaseify = function(s) {
    return String.prototype.toUpperCase.call(s);
  },
  myArray;

myArray = ['learning', 'functional', 'code'].map(upcaseify);
{{% /highlight %}}
</figure>

See the difference?

In the first example, we're muddying our thoughts of the problem.
We're distracting our primitive monkey brains with secondary concepts like
managing indices or lengths of the array when really all we want to do is take
a *collection* of things and do *something* to each one.  As long as we can
perform an operation to one thing, we can perform that operation on many things
that fit the same criteria.  We don't care about the size of the collection or
any other properties about it, because we framed our thought at the elemental
level.

Of course, the example above yields a lot of other benefits that might not
immediately jump at you.  The map example demonstrates immutability.  The
looping construct modifies each element in the existing instance of the array.
The map function creates a new array and replaces the existing array with an
entirely new one.  This has a lot of very important benefits that you will
discover later.

Gaining the benefits of functional programming doesn't require you to `rm -rf`
your entire codebase and start over.  Instead, start small.  Use `map` instead
of looping constructs.  Write small functions that you can build larger
systems with.  When you need an aggregate over a collection, don't create a
`sum` variable and add to it, use a reduction.  Think with values, group those
values into logical collections, and apply functions across those values by
thinking in an elemental way.  Think with data.

