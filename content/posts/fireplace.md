---
Title: "vim-fireplace + reloaded"
Date: "2014-06-24"
Description: "Techniques for vim-fireplace"
Tags: ["functional programming", "clojure", "vim"]
---

It's no secret that most Clojure developers use Emacs.  It's a Lisp machine;
no one can argue that.  I've been tempted by the much-lauded Emacs+Evil combination.
But I'm on team vim, and programming Clojure in 2014 with vim-fireplace is awesome.

Just as awesome is Stuart Sierra's [Reloaded](http://www.google.com) workflow and
its smarter `require` logic.  The workflow also integrates perfectly with his
[Component](https://github.com/stuartsierra/component) library.  It turns into
a pretty seamless experience where you can reload code freely without incurring
the startup penalty of the JVM.

### A Crash Course on Reloaded/Component

Start with a `:profiles` key in your `project.clj`, like so:

<figure>
<figcaption>project.clj</figcaption>
{{% highlight clojure %}}
:profiles {:dev {:dependencies [[org.clojure/tools.namespace "0.2.4"]]
                  :source-paths ["dev"]}}
{{% /highlight %}}
</figure>

Since you added a `dev` source-path in that configuration, include a `user.clj`
file within that directory.  This file will support your fancy new
Reloaded/Component workflow by including a bunch of functions automatically at REPL startup.

<figure>
<figcaption>dev/user.clj</figcaption>
{{% highlight clojure %}}
(ns user
  (:require [com.stuartsierra.component :as component]
            [clojure.tools.namespace.repl :refer [refresh refresh-all]]
            [yourproject.system :refer [dev-system]]))

(def system nil)

(defn init
  "Constructs the current development system."
  []
  (alter-var-root #'system
                  (constantly (dev-system {:port 8080}))))

(defn start
  "Starts the current development system."
  []
  (alter-var-root #'system component/start))

(defn stop
  "Shuts down and destroys the current development system."
  []
  (alter-var-root #'system
                  (fn [s] (when s (component/stop s)))))

(defn go
  "Initializes the current development system and starts it running."
  []
  (init)
  (start))

(defn reset []
  (stop)
  (refresh :after 'user/go))
{{% /highlight %}}
</figure>

This is pretty vanilla stuff, leveraging Component and Reloaded.  The important
part is that we `require` a system from our project.  For simplicity, let's
assume the system is a single webserver component, but in normal cases you'd want to
weave together various components (database, cache, etc.).

Here's our system:

<figure>
<figcaption>system.clj</figcaption>
{{% highlight clojure %}}
(defn dev-system [{:keys [port]}]
  (component/system-map
    :webserver (server/new-webserver port)))
{{% /highlight %}}
</figure>

And here's our webserver component, using `http-kit`:

<figure>
<figcaption>webserver.clj</figcaption>
{{% highlight clojure %}}
(defrecord Webserver [port handler]
  component/Lifecycle
  (start [component]
    (println ";; Starting http-kit webserver...")
    (assoc component :server (http/run-server handler {:port port})))
  (stop [component]
    (when-let [server (:server component)]
      (println ";; Stopping server in 100ms...")
      (server :timeout 100))))

(defn new-webserver
  ([port] (new-webserver port #'app))
  ([port handler] (Webserver. port handler)))
{{% /highlight %}}
</figure>

Now that we have everything tied together, we can simply do `(go)` at our REPL
to kick the whole thing off.  When we want to safely reload our code, we can
do `(reset)`, which is essentially a supreme version of `(require ... :reload)`.

### What about vim?

`vim-fireplace` comes with support for the traditional code reload method by using the motion `cpr`, but
[this is very brittle](https://github.com/clojure/tools.namespace#reloading-code-motivation), and now
we have all of this awesome Reloaded/Component stuff set up, so let's tie it together with some secret sauce.

First, a helper function, because you'll probably need this a lot:

<figure>
<figcaption>.vimrc</figcaption>
{{% highlight clojure %}}
function SendToREPL(sexp)
  call fireplace#session_eval(a:sexp)
endfunction
{{% /highlight %}}
</figure>

If your vim session is connected to your nrepl session, you can provide `SendToREPL()`
with any Clojure forms to evaluate them.  If you're not connected, you'll see
a message like `No live REPL connection`, in which case you can just `:Connect`
to it.

Now you can start binding forms to various keybinds of your choosing:

<figure>
<figcaption>.vimrc</figcaption>
{{% highlight clojure %}}
nnoremap <Leader>fr :call SendToREPL('(user/reset)')<CR>
nnoremap <Leader>fg :call SendToREPL('(user/go)')<CR>
nnoremap <Leader>fs :call SendToREPL('(user/stop)')<CR>
{{% /highlight %}}
</figure>

Those are the immediate ones I find useful in this situation, but you may think of others.
