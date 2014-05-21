---
Title: "Reasons Why a Functional Programmer Might Embrace Go"
Date: "2014-05-21"
Description: "Why Go?"
Tags: ["functional programming", "go"]
---

I believe that functional programming as a paradigm brings a lot of really,
really important ideas to the table, but if I had to summarize the most
important reason to adopt a functional programming style it would be:
functional programming techniques encourage simplicity and an easier way to reason
about, develop, test, and maintain software.  Predicting the behavior of programs
is, I would argue, much easier when the program is designed in a functional way.

Go is an imperative, strongly-typed language.  It doesn't have any applicative
functional builtins (that means no `map`, `reduce`, or `filter`).  Go programs
can be pretty verbose as a result.  It doesn't have persistent or immutable
data structures (something that I find especially crucial today).  I won't lie;
I feel a little handicapped in some situations.

Why should a functional programmer consider using Go, after considering all of the
aforementioned downsides?

### **1. Standard tooling fosters simplicity**

Functional programs are easier to reason about, but the process of software
development doesn't stop at the creation and composition of functions.  We need
to manage tooling, libraries, infrastructure, and deployments.  Go makes all of
those aspects of *delivering* software easier.  Go has a rich, battle-tested
standard library.

My third-party dependencies in my Go programs are close to zero, and this is
encouraged and decided *best practice* within the community.  Less is more.

When writing a Clojure program, and I want to make an http request, I need to
make a decision: do I reach for `clj-http` or `http-kit`?  After that, I add my
choice to my `project.clj` and restart my REPL.  With Go, I `import net/http`
and that's it.  I don't need to make a decision, and neither does your team.

Deployments with Go are dead simple and speedy.  Compilation is lightning fast,
and my servers don't need dependencies.  Really, all you need is to `scp` your
binary.

### **2. Channels can be transformative pipelines**

Instead of threading data through composed functions, you can thread data
through channels and pipe output into downstream channels.  This is essentially
the goal of functional composition: manipulate data through an 'assembly line'
of functional transformations.  Instead, with Go, you can compose a
pipeline through a series of channels and transform your data.  It just requires
thinking about the situation a little differently.

### **3. Functions are first-class**

Yes, functions are first-class.  Go supports higher-order functions, so, yes,
you can take functions as parameters and return functions.  You can even return
multiple functions.  It also supports function literals and closures.  You can
define your own function types.  There's a lot to work with here.

### **4. Interfaces are really great**

Go interfaces support data-oriented thought: this function takes a *thing* (in
this case an interface) that can take and produce data of the expected types.
When you use interfaces, you mostly concern yourself with behavior.  Functional
programmers think in verbs, so interfaces can be an easy transition.

***

Go is not a functional language, nor does it support the common functional
applications.  However, the spirit of Go definitely nods in the direction of
the functional ideal:  simplicity and ease of reasoning.  Software development
doesn't stop at `:wq`, and I think you'll find that Go's idioms and standard
arsenal support the breadth of the development cycle.  Give it a try; I think
you'll find that a lot of situations can be solved easily with Go.
